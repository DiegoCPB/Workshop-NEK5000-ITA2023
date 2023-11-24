####################################################################
# Writes the coordinates (x,y) of a set of interpolating grid points
#   Input: `../inputs_phill_pp.in`
#   Output: `../../pp_Nek/DATA/int_pos`
####################################################################
#
import sys
import struct
import numpy as np
sys.path.append('./')
from interface import read_pp_inputs

class point:
    """class defining point variables"""
    def __init__(self,ldim):
        self.pos = np.zeros((ldim))

class pset:
    """class containing data of the point collection"""
    def __init__(self,ldim,npoints):
        self.ldim = ldim
        self.npoints = npoints
        self.pset = [point(ldim) for il in range(npoints)]

def set_pnt_pos(data,il,lpos):
    """set position of the single point"""
    lptn = data.pset[il]
    data_pos = getattr(lptn,'pos')
    for jl in range(data.ldim):
            data_pos[jl] =  lpos[jl]

def write_int_pos(fpath,fname,wdsize,emode,data):
    """ write point positions to the file"""
    # open file
    outfile = open(fpath+fname, 'wb')

    # word size
    if (wdsize == 4):
        realtype = 'f'
    elif (wdsize == 8):
        realtype = 'd'

    # header
    header = '#iv1 %1i %1i %10i ' %(wdsize,data.ldim,data.npoints)
    header = header.ljust(32)
    outfile.write(header.encode('utf-8'))

    # write tag (to specify endianness)
    #etagb = struct.pack(emode+'f', 6.54321)
    #outfile.write(etagb)
    outfile.write(struct.pack(emode+'f', 6.54321))

    #write point positions
    for il in range(data.npoints):
        lptn = data.pset[il]
        data_pos = getattr(lptn,'pos')
        outfile.write(struct.pack(emode+data.ldim*realtype, *data_pos))

#    
if __name__ == "__main__":
    # initialise variables
    fpath = '../../pp_Nek/DATA/'
    fname = 'int_pos'
    wdsize = 8
    # little endian
    emode = '<'
    # big endian
    #emode = '<'

    # post-processing parameters
    params=read_pp_inputs('../inputs_cyl3d_pp.in')
    d = params['d']
    h = params['h']
    Lx = params['Lx']

    # vertical lines
    # number of points in a line
    npvrt = params['npvrt']
    # horizontal line positions
    xpvrt = params['xpvrt']
    # line number
    nlvrt = xpvrt.size

    # allocate space
    ldim = 2
    npoints = npvrt*nlvrt
    data = pset(ldim,npoints)
    print('Allocated {0} points'.format(npoints))

    # initialise point positions
    lpos = np.zeros(data.ldim)

    # start counting points
    npoints = 0
    # vertical lines
    # point distribution
    ptdst = np.linspace(0.0,1.0,npvrt)
    # max and min vertical line positions
    ymax = h/4
    ymin = -h/4
    for il in range(nlvrt):
        # x coordinate
        lpos[0] = xpvrt[il]
        for jl in range(npvrt):
            lpos[1] = ymin + (ymax-ymin)*ptdst[jl]
            set_pnt_pos(data,npoints,lpos)
            npoints = npoints +1

    # write points to the file
    write_int_pos(fpath,fname,wdsize,emode,data)

###########################################################
# Post-processing of the 2D statistics of the 3D cylinder
#########################################################
# Diego C. P. Blanco, diegodcpb@ita.br

# Adapted from Post-processing of the 2D statistics of the Periodic-hill
# Saleh Rezaeiravesh, salehr@kth.se
# Daniele Massaro, dmassaro@kth.se
#----------------------------------------------------------

import sys
import numpy as np
import matplotlib.pyplot as plt
sys.path.append("./modules/")
from reader_int_fld import read_int_fld
from interface import dbMaker,read_pp_inputs
import turbStats
import plotter

#1. Set the path to the directory at which `int_fld` is located
data_path="../pp_Nek/DATA/"

#2. Read the `int_fld`
data = read_int_fld(data_path+'int_fld')
# print(data.__dict__.keys())   #list of the keys

#3. Read the post-processing input parameters
params=read_pp_inputs('./inputs_cyl3d_pp.in')

#4. Construct databases (dictionaries) from the data read from 'int_fld'
#   The data contain 'stats' & 'derivative' fields and the coordinates of the interpolation points.
nx=len(params['xpvrt'])
ny=params['npvrt']
dbProfs_in,dbWall_in=dbMaker(data,nx,ny)

#5. Compute mean, rms, and budget terms at the interpolation points 
#   (profiles and points on the bottom wall)
if params['nu'] < 0:
    nu=1/(-params['nu'])
else:
    nu=params['nu']
rho=params['rho']
dbProfs=turbStats.comp(dbProfs_in,nu,rho)   #profiles at different streamwise locations

#6. Plot post-processed profiles
#   To see a complete set of qoiName: 
#print('Available Quantities:',dbProfs.keys())
plotter.profiles_xpvrt(dbProfs,qoiName='TKE',zoomFactor=10)
plotter.profiles_xpvrt(dbProfs,qoiName='U',zoomFactor=1)
plotter.profiles_xpvrt(dbProfs,qoiName='V',zoomFactor=1)
plotter.profiles_xpvrt(dbProfs,qoiName='W',zoomFactor=1)
plotter.profiles_xpvrt(dbProfs,qoiName='uv',zoomFactor=10)
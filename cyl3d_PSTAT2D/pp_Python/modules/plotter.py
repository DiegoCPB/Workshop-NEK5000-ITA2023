###################################################################################
# A set of plotters for post-processing the 2D statistics of the 3D cylinder case
###################################################################################
# Adapted by Diego C. P. Blanco, diegodcpb@ita.br
# Originally authored by Saleh Rezaeiravesh, salehr@kth.se
#----------------------------------------------------------------------------------

import sys
import numpy as np
import matplotlib.pyplot as plt
sys.path.append("./")
from interface import read_pp_inputs

def profiles_xpvrt(dbProfs,qoiName,zoomFactor=1.):
    """
    Plot the profiles of different time-averaged quantities at 'xpvrt' streamwise locations.
    Each profile covers the distance between the two walls.

    Args:
       `dbProfs`: dictionary of the post-processed statistics
       `qoiName`: key of the quantity whose profile is plotted
       `zoomFactor`: float, factor by which the profiles are magnified for better visibility
    """
    #check if the qoiName is valid
    if qoiName not in dbProfs.keys():
       print('Available Quantities:',dbProfs.keys())
       raise KeyError("%s is not a valid quantity!" %qoiName) 

    nx=dbProfs['x'].shape[0]  #number of streamwise locations at which profiles are extracted
    
    #plot
    plt.figure(figsize=(12,5))
    for i in range(nx):
        plt.plot(dbProfs['x'][i,:]+zoomFactor*dbProfs[qoiName][i,:],dbProfs['y'][i,:])
        plt.plot(dbProfs['x'][i,:],dbProfs['y'][i,:],'--k',alpha=0.2)

    plt.xlabel(r'$x$',fontsize=17)
    plt.ylabel(r'$y$',fontsize=17)
    if zoomFactor==1:
       plt.title('Profiles of %s' %qoiName,fontsize=15)
    else:   
       plt.title('Profiles of %s multiplied by %g' %(qoiName,zoomFactor),fontsize=15)

    #Read post-processing input parameters
    params=read_pp_inputs('./inputs_cyl3d_pp.in')
    xticks_=params['xpvrt']
    plt.xticks(ticks=xticks_,fontsize=16)
    plt.xticks(fontsize=16)
    plt.yticks(fontsize=16)
    plt.show()

def profiles_wall(dbWall,qoiName,zoomFactor=1.):
    """
    Plot the profiles of different time-averaged quantities at 'npwall' points adjacent 
    to a part of the lower wall.

    Args:
       `dbWall`: dictionary of the post-processed statistics
       `qoiName`: key of the quantity whose profile is plotted
       `zoomFactor`: float, factor by which the profiles are magnified for better visibility
    """
    #check if the qoiName is valid
    if qoiName not in dbWall.keys():
       print('Available Quantities:',dbWall.keys())
       raise KeyError("%s is not a valid quantity!" %qoiName)

    #plot
    plt.figure(figsize=(12,5))
    plt.plot(dbWall['x'],dbWall[qoiName])
    plt.xlabel('x',fontsize=16)
    plt.ylabel(qoiName,fontsize=16)
    plt.title('Data at y=%g' %dbWall['y'][0])
    plt.xticks(fontsize=16)
    plt.yticks(fontsize=16)
    plt.grid(alpha=0.3)
    plt.show()

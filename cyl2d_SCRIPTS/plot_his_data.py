#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Nov 24 18:47:22 2023

@author: Diego C. P. Blanco, diegodcpb@ita.br
"""

# This script plots the velocity and pressure data computed 
# at the probe points defined in the .his file

import matplotlib.pyplot as plt

filename = "../cyl2d/cyl2d.his"

with open(filename,'r') as hisfile:
    lines = hisfile.readlines()
    npts = int(lines[0])
    xpos = []
    ypos = []
    t = [ [] for i in range(npts) ]
    u = [ [] for i in range(npts) ]
    v = [ [] for i in range(npts) ]
    p = [ [] for i in range(npts) ]
    for i in range(1,len(lines),npts):
        for j in range(npts):
            val = lines[i+j].split()
            if i == 1:
                xpos.append(float(val[0]))
                ypos.append(float(val[1]))
            else:
                t[j].append(float(val[0]))
                u[j].append(float(val[1]))
                v[j].append(float(val[2]))
                p[j].append(float(val[3]))

for i in range(npts):
    plt.figure()
    plt.title(r'Point $(x,y)=({},{})$'.format(xpos[i],ypos[i]))
    plt.plot(t[i],u[i],label=r'$u$')
    plt.plot(t[i],v[i],label=r'$v$')
    plt.plot(t[i],p[i],label=r'$p$')
    plt.legend()
    plt.show()        
        

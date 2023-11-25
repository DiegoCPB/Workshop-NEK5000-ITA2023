#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Nov 24 18:48:16 2023

@author: Diego C. P. Blanco, diegodcpb@ita.br
"""

# This script plots the lift and drag coefficients computed 
# for the 2D cylinder and collected from the output file of 
# the simulation

import matplotlib.pyplot as plt
import numpy as np

filename = "../cyl2d/cyl2d.out"

with open(filename,'r') as outfile:
    lines = outfile.readlines()
    t = []
    Cl = []
    Cd = []
    for i in range(len(lines)):
        words = lines[i].split()
        try:
            if words[-1] == '1dragx':
                t.append(float(words[1]))
                Cd.append(float(words[2]))
            elif words[-1] == '1dragy': 
                Cl.append(float(words[2]))
        except:
            pass

plt.figure()
plt.plot(t,Cl,label=r'$C_l$')
plt.plot(t,Cd,label=r'$C_d$')
plt.legend()
plt.show()  
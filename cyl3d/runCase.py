#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Jan 26 15:17:40 2023

@author: diego2

This script is responsible for running the NEK5000 case
"""

import sys
import os
from os import listdir
from os import path
import subprocess as sp

# -----------------------------------------------------------------------------
# I/O
CASENAME = 'cyl2d'
OUTNAME = CASENAME
MPI_RANKS = 4
# -----------------------------------------------------------------------------

def getNEKpath():
    """
    Get NEK's path from makenek file
    """
    try:
        with open('makenek', 'r') as file:
            lines = file.readlines()
            for line in lines:
                if 'NEK_SOURCE_ROOT=' in line:
                    NEK_PATH = line.split('"')[1].strip()
                    break
    except:
        print('Error searching for NEK_SOURCE_ROOT in makenek file.')
        sys.exit(0)
    print("NEK_SOURCE_ROOT: "+NEK_PATH)
    return NEK_PATH

def compileNEK():
    print('Compiling NEK case... Check build.log file.')
    print('')
    # '>/dev/null 2>&1' silences the output of the command 
    cmd = ['./makenek',CASENAME]
    try:
        sp.check_call(cmd)
        print('')
        print('Case compiled successfully!')
    except sp.CalledProcessError as e:
        clean()
        raise e

def callNEKMPI():
    """
    Calls nekmpi binary
    """
    nek_path = getNEKpath()
    outfile = CASENAME + '.out'
    cmd = ['sh','-c','{}/bin/nekmpi {} {} 2>&1 | tee {}'.format(nek_path,CASENAME,str(MPI_RANKS),outfile)]
    print("Running NEK case... Check %s file." %(outfile))
    try:
        sp.check_call(cmd)
        print('')
        print('Case ran successfully')
    except sp.CalledProcessError as e:
        clean()
        raise e

def runVISNEK(name = CASENAME):
    """
    Runs visnek command from NEK's bin folder.
    """
    nek_path = getNEKpath()
    print('')
    print('Running visnek...')
    os.system(nek_path+'/bin/visnek '+ name)

def runChecks():
    """
    Function that does all prechecks before calling NEK
    """
    makenek = 'makenek'

    # List files in directory
    print("CASENAME: "+CASENAME)
    mypath = path.dirname(path.abspath(__file__))
    dirfiles = [f for f in listdir(mypath) if path.isfile(path.join(mypath, f))]
    
    # Check makenek file existance
    if makenek not in dirfiles:
        print('Check makenek file.')
        sys.exit(0)

def clean():
    print('')
    print('Cleaning case...')
    os.system('./makenek clean')

if __name__ == "__main__":
    runChecks()
    compileNEK()
    callNEKMPI()
    runVISNEK(OUTNAME)
    
    
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            


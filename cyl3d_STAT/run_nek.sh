#!/bin/bash
#
#SBATCH -t 10000:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=24
#SBATCH --cpus-per-task=1
#SBATCH --exclusive
#SBATCH --mail-type=ALL
#SBATCH --mail-user=diego2@kth.se 
#SBATCH --output=job.%J.out
#SBATCH -J cyl3D_STAT

# Run this commands
TOTAL_TASKS=$((SLURM_JOB_NUM_NODES * SLURM_NTASKS_PER_NODE))
nekmpi cyl3D $TOTAL_TASKS
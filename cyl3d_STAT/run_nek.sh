#!/bin/bash
#
#SBATCH -t 10000:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --cpus-per-task=1
#SBATCH --exclusive
#SBATCH --mail-type=ALL
#SBATCH --mail-user=diego2@kth.se 
#SBATCH --output=job.%J.out
#SBATCH -J cyl3d_STAT

# Run this commands
TOTAL_TASKS=$((SLURM_JOB_NUM_NODES * SLURM_NTASKS_PER_NODE))
$HOME/Apps/KTH_Framework/Nek5000/bin/nekmpi cyl3d $TOTAL_TASKS
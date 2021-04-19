#!/bin/bash
#
#SBATCH --job-name=job_%j
#SBATCH --partition=gpu
#SBATCH --gres=gpu:v100:1
#SBATCH --time=00:10:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2G
#SBATCH --output=job_output_%j.out
#SBATCH --error=job_output_%j.err

srun singularity exec --nv -B /scratch/fantine:/scratch/fantine ml_framework_latest.sif gpustat
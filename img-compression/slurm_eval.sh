#!/bin/bash
#SBATCH --ntasks=1                          # Number of tasks (see below)
#SBATCH --nodes=1                           # Ensure that all cores are on one machine
#SBATCH --partition=cpu-short              # Partition to submit to
#SBATCH --cpus-per-task=2                   # specify cpu per task otherwise 8 per task
#SBATCH --mem=16G                           # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH --output=./runs/slurm_%j.out          # File to which STDOUT will be written
#SBATCH --error=./runs/slurm_%j.err           # File to which STDERR will be written
#SBATCH --mail-type=END                     # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=zhenzhong.xiao@uni-tuebingen.de  # Email to which notifications will be sent
#SBATCH --time=0-01:00            # Runtime in D-HH:MM

set -o errexit

pwd

echo "JOB DATA"
scontrol show job=$SLURM_JOB_ID

echo "node:"
hostname

echo "RUN Script"
python post_process.py ./runs/slurm_%j/checkpoints bls2017_vae-num_filters=256_256_256-filter_dims=9_5_5-sampling_rates=4_2_2-learned_prior=False-likelihood_variance=0.001-last_step=2000000 ./CIFAR-10/val_imgs.npy './CIFAR-10/test_data/*.png'

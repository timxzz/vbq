#!/bin/bash
#SBATCH --ntasks=1                          # Number of tasks (see below)
#SBATCH --nodes=1                           # Ensure that all cores are on one machine
#SBATCH --partition=gpu-2080ti              # Partition to submit to
#SBATCH --gres=gpu:1                        # requesting n gpus
#SBATCH --cpus-per-task=1                   # specify cpu per task otherwise 8 per task
#SBATCH --mem=16G                           # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH --output=./runs/slurm_%j.out          # File to which STDOUT will be written
#SBATCH --error=./runs/slurm_%j.err           # File to which STDERR will be written
#SBATCH --mail-type=END                     # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=zhenzhong.xiao@uni-tuebingen.de  # Email to which notifications will be sent

set -o errexit

pwd

echo "JOB DATA"
scontrol show job=$SLURM_JOB_ID

echo "node:"
hostname

echo "RUN Script"
python bls2017_vae.py --verbose --seed 0 --checkpoint_dir ./runs/slurm_%j/checkpoints --train_glob './CIFAR-10/train_data/*.png' --batchsize 64 --patchsize 32 --last_step 2000000 --preprocess_threads 4 --log_dir ./runs/slurm_%j/tf_logs --save_checkpoint_secs 10800 --likelihood_variance 0.001 --num_filters 256 256 256 --filter_dims 9 5 5 --sampling_rates 4 2 2

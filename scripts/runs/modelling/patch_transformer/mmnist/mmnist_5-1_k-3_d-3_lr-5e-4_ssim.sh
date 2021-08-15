#!/bin/bash
#SBATCH --qos short
#SBATCH -N 1
#SBATCH -c 4
#SBATCH -t 2-00:00
#SBATCH --mem 20G
#SBATCH -p res-gpu-small
#SBATCH --job-name pt_mmnist_5-1_k-3_d-3_lr-5e-4_ssim 
#SBATCH --gres gpu:1
#SBATCH -o ../../../../../.results/pt_mmnist_5-1_k-3_d-3_lr-5e-4_ssim.out
cd ../../../../..
source python_venvs/vm/bin/activate
export MASTER_PORT=10014
export PYTHONBREAKPOINT=ipdb.set_trace
# Pretrain
python VM_train.py \
    --dataset simulations \
    --dataset_path data/moving_mnist/1_2_3 \
    --split_condition tv_ratio:8-1-1 \
    --bsz 64 \
    --val_bsz 100 \
    --num_workers 1 \
    --in_no 5 \
    --out_no 1 \
    --depth 3 \
    --krnl_size 3 \
    --padding 1 \
    --device 0 \
    --lr 5e-4 \
    --epoch 150 \
    --n_gifs 20 \
    --jobname pt_mmnist_5-1_k-3_d-3_lr-5e-4_ssim \
    --loss ssim \
    --reduction mean \
    --img_type greyscale \
    --model PatchTrans \
    --shuffle \
    --wandb

#!/bin/bash
#SBATCH --qos short
#SBATCH -N 1
#SBATCH -c 4
#SBATCH -t 2-00:00
#SBATCH --mem 12G
#SBATCH -p res-gpu-small
#SBATCH --job-name 2dBouncingMG-y-masked-pt-sl1-mean 
#SBATCH --gres gpu:1
#SBATCH -o ../../../../../.results/2dBouncingMG-y-masked-pt-sl1-mean.out
cd ../../../../..
source python_venvs/vm/bin/activate
export PYTHONBREAKPOINT=ipdb.set_trace
# Pretrain
python VM_train.py \
    --dataset simulations \
    --dataset_path data/2dBouncing/2dMultiGrav-Y_regen/raw_masked \
    --split_condition tv_ratio:4-1 \
    --bsz 64 \
    --val_bsz 64 \
    --num_workers 4 \
    --in_no 5 \
    --out_no 1 \
    --device 0 \
    --epoch 75 \
    --n_gifs 20 \
    --jobname 2dBouncingMG-y-masked-pt-sl1-mean \
    --loss sl1 \
    --reduction mean \
    --img_type greyscale \
    --model pixel_transformer \
    --shuffle \
    --wandb \
    --d_model 4096 \
    --n_layers 6 \
    --nhead 8 \
    --dim_feedforward 16384 \
    --dropout 0.1 \
    --pixel_regression_layer \
    --norm_layer layer_norm

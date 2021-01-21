#!/bin/bash
#SBATCH -p part0
#SBATCH --job-name p_hudsonseg_pretrain_sl1 
#SBATCH --ntasks 6
#SBATCH --gres gpu:1
#SBATCH -o ../../../../.results/wntrbtm_hudsonseg_pretrain_sl1.out
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd ../../../..
source python_venvs/vm/bin/activate

# Pretrain
python VM_train.py \
    --dataset from_raw \
    --dataset_path data/hudson_true_3d_default \
    --bsz 16 \
    --val_bsz 100 \
    --in_no 5 \
    --out_no 1 \
    --depth 3 \
    --split_condition tv_ratio:4-1 \
    --device 0 \
    --epoch 1 \
    --early_stopping 100 \
    --jobname wntrbtm_hudsonseg_pretrain_sl1 \
    --loss smooth_l1 \
    --reduction mean \
    --img_type greyscale \
    --model UpDown2D \
    --reduce \
    --shuffle \
    --visdom \
    --save

# Segmentation task
python VM_train.py \
    --dataset from_raw \
    --segmentation \
    --dataset_path data/hudson_true_3d_default \
    --bsz 16 \
    --val_bsz 100 \
    --in_no 1 \
    --model_in_no 5 \
    --out_no 1 \
    --depth 3 \
    --split_condition tv_ratio:4-1 \
    --device 0 \
    --epoch 300 \
    --early_stopping 100 \
    --jobname wntrbtm_hudsonseg_pretrain_sl1 \
    --loss smooth_l1 \
    --reduction mean \
    --img_type greyscale \
    --model UpDown2D \
    --reduce \
    --shuffle \
    --visdom \
    --save \
    --model_path .results/wntrbtm_hudsonseg_pretrain_sl1/model.pth



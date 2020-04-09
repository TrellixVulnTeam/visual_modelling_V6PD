#!/bin/bash
#SBATCH --partition=part0
#SBATCH --job-name=MSE_d3_mean
#SBATCH --ntasks=6
#SBATCH --gres=gpu:1
#SBATCH -o /home/crhf63/cnn_visual_modelling/.results/MSE_d3_mean.out
cd /home/crhf63/cnn_visual_modelling/scripts
source /home/crhf63/kable_management/python_venvs/vm/bin/activate
python ../main.py \
    --dataset_path /home/crhf63/kable_management/data/visual_modelling/dataset_v1.0/11_dset.pickle \
    --repo_rootdir /home/crhf63/cnn_visual_modelling \
    --bsz 32 \
    --val_bsz 100 \
    --in_no 10 \
    --out_no 1 \
    --depth 3 \
    --train_ratio 0.8 \
    --device 0 \
    --epoch 30 \
    --early_stopping 3 \
    --log_freq 600 \
    --jobname vm_mk0_MSE_d3_mean \
    --loss MSE \
    --reduction mean \
    --save \
    --shuffle \
    --visdom \
    --reduce 

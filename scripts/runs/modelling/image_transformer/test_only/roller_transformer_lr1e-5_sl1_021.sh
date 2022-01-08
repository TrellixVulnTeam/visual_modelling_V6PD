#!/bin/bash
#SBATCH --qos short
#SBATCH -N 1
#SBATCH -c 4
#SBATCH -t 2-00:00
#SBATCH --mem 28G
#SBATCH -p res-gpu-small
#SBATCH --job-name roller_transformer_lr1e-5_sl1_021 
#SBATCH --gres gpu:1 
#SBATCH -o ../../../../../.results/roller_transformer_lr1e-5_sl1_021.out
cd ../../../../..
source python_venvs/vm/bin/activate
export PYTHONBREAKPOINT=ipdb.set_trace
python VM_train.py \
    --disable_preload \
    --test_only_model_path 'IT/roller_transformer_lr1e-5_sl1_021-epoch=138.ckpt' \
    --dataset simulations \
    --dataset_path data/myphysicslab/RollerFlight_10000_bigger \
    --jobname roller_transformer_lr1e-5_sl1_021 \
    --split_condition tv_ratio:8-1-1 \
    --bsz 64 \
    --val_bsz 64 \
    --num_workers 1 \
    --in_no 5 \
    --out_no 1 \
    --device 0 \
    --epoch 500 \
    --early_stopping 10 \
    --n_gifs -1 \
    --reduction mean \
    --img_type greyscale \
    --shuffle \
    --model image_transformer \
    --dataset_mode consecutive \
    --d_model 4096 \
    --n_layers 2 \
    --nhead 4 \
    --dim_feedforward 4096 \
    --dropout 0.0 \
    --pixel_regression_layers 1 \
    --norm_layer layer_norm \
    --optimiser radam \
    --output_activation hardsigmoid \
    --pos_encoder add \
    --mask \
    --feedback_training_iters 10 \
    --sequence_loss_factor 0.2 \
    --loss sl1 \
    --lr 1e-5 \

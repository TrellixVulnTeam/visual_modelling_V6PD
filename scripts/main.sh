#!/bin/bash
source /home/jumperkables/kable_management/python_venvs/vm/bin/activate
python /home/jumperkables/cnn_visual_modelling/main.py \
    --bsz 32 \
    --val_bsz 100 \
    --in_no 5 \
    --out_no 1 \
    --shuffle \
    --train_ratio 0.8 \
    --dataset_path /home/jumperkables/kable_management/data/visual_modelling/dataset_v1.0/6_dset.pickle
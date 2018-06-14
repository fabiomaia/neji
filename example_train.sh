#! /bin/bash

./nejiTrain.sh -if BC2 \
              -c example/train/sentences -a example/train/annotations \
              -f example/train/bw_o2_windows.config  \
              -m genetag_lite_model -o example/train/

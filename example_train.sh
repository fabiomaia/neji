#! /bin/bash

./nejiTrain.sh -if BC2 \
              -c example/train/sentences -a example/train/annotations \
              -f example/train/model.config  \
              -m genetag_lite_model -o example/train/

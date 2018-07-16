#! /bin/bash

rm -rf ./chemdner/enumerated_suffix_prefix/

./nejiTrain.sh -if BC2 \
               -c chemdner/training.abstracts.bc2 \
               -a chemdner/training.annotations.bc2 \
               -f chemdner/model_enum_disabled.config \
               -m enumerated_suffix_prefix \
               -o chemdner/ \
               -t 4

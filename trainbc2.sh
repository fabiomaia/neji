#! /bin/bash

./nejiTrain.sh -if BC2 \
			   -c chemdner/training.abstracts.bc2 \
			   -a chemdner/training.annotations.bc2 \
			   -f chemdner/model.config \
			   -m enumerated_suffix_prefix.model \
			   -o chemdner \
               -t 4

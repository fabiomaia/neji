#! /bin/bash

rm -rf ./chemdner/annotate/out/ && mkdir -p ./chemdner/annotate/out/

./neji.sh -i chemdner/annotate/in/ -if RAW \
          -o chemdner/annotate/out/ -of BC2 \
          -m chemdner/enumerated_suffix_prefix/ \
          -noids

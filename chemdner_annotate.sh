#! /bin/bash

rm -rf ./chemdner/annotate/out/
mkdir -p ./chemdner/annotate/out/

./neji.sh -i chemdner/annotate/in/ -if RAW \
          -o chemdner/annotate/out/ -of JSON \
          -m chemdner/enumerated_suffix_prefix/ \
          -t 4

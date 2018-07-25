#! /bin/bash

set -euo pipefail

model_versions=( "v9" )

for v in "${model_versions[@]}"
do
    echo "================================================"
    echo "| Model $v                                     |"
    echo "================================================"
    ./chemdner_setup.sh
    ./chemdner_train.sh $v
    ./chemdner_annotate.sh $v
    ./chemdner_eval.sh $v
done


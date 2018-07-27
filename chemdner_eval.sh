#! /bin/bash

model_version="$1"
if [ -z $model_version ]; then
    echo "Please specify the version of the model which you want to train (e.g. v0, v1, etc) "
    exit
fi

rm -f "./chemdner_corpus/development.predictions.txt"
echo "[$model_version] Preparing real annotations into the expected format..."
while IFS=$'\t' read -r field1 field2 field3 field4 field5 field6; do
    echo -e "$field1\t$field2:$field3:$field4" >> "./chemdner_corpus/development.predictions.txt"
done < ./chemdner_corpus/development.annotations.txt

rm -f "./chemdner_results/$model_version.txt"; mkdir -p ./chemdner_results
echo "[$model_version] Evaluating..."
bc-evaluate -l "./chemdner_results/predictions_$model_version.txt" "./chemdner_corpus/development.predictions.txt" > "./chemdner_results/scores_$model_version.txt"

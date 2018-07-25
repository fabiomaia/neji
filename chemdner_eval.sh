#! /bin/bash

model_version="$1"
if [ -z $model_version ]; then
    echo "Please specify the version of the model which you want to train (e.g. v0, v1, etc) "
    exit
fi

rm "./chemdner_corpus/development.predictions.txt"
echo "[$model_version] Preparing real annotations into the expected format..." && sleep 1
while IFS=$'\t' read -r field1 field2 field3 field4 field5 field6; do
    echo $field1
    echo -e "$field1\t$field2:$field3:$field4" >> "./chemdner_corpus/development.predictions.txt"
done < ./chemdner_corpus/development.annotations.txt

rm "./chemdner_results/$model_version.txt" && mkdir -p ./chemdner_results
echo "[$model_version] Evaluating..." && sleep 1
bc-evaluate -l "./chemdner_corpus/predictions_$model_version.txt" "./chemdner_corpus/development.predictions.txt" > "./chemdner_results/$model_version.txt"

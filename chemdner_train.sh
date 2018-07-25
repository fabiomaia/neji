#! /bin/bash

model_version="$1"
if [ -z $model_version ]; then
    echo "Please specify the version of the model which you want to train (e.g. v0, v1, etc) "
    exit
fi

rm -rf "./chemdner_corpus/train/" && mkdir -p "./chemdner_corpus/train/"
echo "[$model_version] Converting training.abstracts.txt to A1..." && sleep 1
while IFS=$'\t' read -r field1 field2 field3; do
    echo $field1
    echo -e "$field2" >> "./chemdner_corpus/train/$field1"T".txt"
    echo -e "$field3" >> "./chemdner_corpus/train/$field1"A".txt"
done < ./chemdner_corpus/training.abstracts.txt

echo "[$model_version] Converting training.annotations.txt to A1..." && sleep 1
while IFS=$'\t' read -r field1 field2 field3 field4 field5 field6; do
    echo $field1
    echo -e "TX\tCHEM\t$field3 $field4\t$field5" >> "./chemdner_corpus/train/$field1$field2.a1"
done < ./chemdner_corpus/training.annotations.txt

rm -rf "./chemdner_models/$model_version" && mkdir -p ./chemdner_models
echo "[$model_version] Training..." && sleep 1
./nejiTrain.sh -if A1 \
               -c "./chemdner_corpus/train/" \
               -f "./chemdner_configs/$model_version.config" \
               -m $model_version \
               -o ./chemdner_models \
               -t 3

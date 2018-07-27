#! /bin/bash

model_version="$1"
if [ -z $model_version ]; then
    echo "Please specify the version of the model which you want to annotate (e.g. v0, v1, etc) "
    exit
fi

rm -rf "./chemdner_corpus/annotate/in/"; mkdir -p "./chemdner_corpus/annotate/in/"
echo "[$model_version] Preparing annotation input..."
while IFS=$'\t' read -r field1 field2 field3; do
    echo -e "$field2" > "./chemdner_corpus/annotate/in/"$field1"T.txt"
    echo -e "$field3" > "./chemdner_corpus/annotate/in/"$field1"A.txt"
done < ./chemdner_corpus/development.abstracts.txt

rm -rf "./chemdner_corpus/annotate/out/"; mkdir -p "./chemdner_corpus/annotate/out/"
echo "[$model_version] Annotating..."
./neji.sh -i ./chemdner_corpus/annotate/in/ -if RAW \
          -o ./chemdner_corpus/annotate/out/ -of A1 \
          -m ./chemdner_models/$model_version/ \
          -noids

rm -f "./chemdner_results/predictions_$model_version.txt"
echo "[$model_version] Building single prediction file..."
for filename in $(find ./chemdner_corpus/annotate/out/ -type f -not -empty); do
    id=$(basename $filename | cut -d'.' -f1 | head -c -2)
    sentence_type=${filename: -4 : 1}

    while IFS=$'\t' read -r field1 field2 field3; do
        startidx=$(echo $field2 | cut -d " " -f2)
        endidx=$(echo $field2 | cut -d " " -f3)
        echo -e "$id\t$sentence_type:$startidx:$endidx" >> "./chemdner_results/predictions_$model_version.txt"
        read
    done < "$filename"
done

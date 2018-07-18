#! /bin/bash

echo "Preparing annotation input..." && sleep 1
rm -rf "./chemdner_corpus/annotate/in/" && mkdir -p "./chemdner_corpus/annotate/in/"
while IFS=$'\t' read -r field1 field2 field3; do
    echo $field1
    echo -e "$field2" > "./chemdner_corpus/annotate/in/"$field1"T.txt"
    echo -e "$field3" > "./chemdner_corpus/annotate/in/"$field1"A.txt"
done < ./chemdner_corpus/development.abstracts.txt

echo "Annotating..." && sleep 1
rm -rf "./chemdner_corpus/annotate/out/" && mkdir -p "./chemdner_corpus/annotate/out/"
./neji.sh -i chemdner_corpus/annotate/in/ -if RAW \
          -o chemdner_corpus/annotate/out/ -of A1 \
          -m enumerated_suffix_prefix/ \
          -noids

echo "Building single prediction file..." && sleep 1
rm "./chemdner_corpus/predictions.txt"
for filename in $(find ./chemdner_corpus/annotate/out/ -type f -not -empty); do
    echo $filename
    id=$(basename $filename | cut -d'.' -f1 | head -c -2)
    sentence_type=${filename: -4 : 1}

    while IFS=$'\t' read -r field1 field2 field3; do
        startidx=$(echo $field2 | cut -d " " -f2)
        endidx=$(echo $field2 | cut -d " " -f3)
        echo -e "$id\t$sentence_type:$startidx:$endidx" >> ./chemdner_corpus/predictions.txt
        read
    done < "$filename"
done

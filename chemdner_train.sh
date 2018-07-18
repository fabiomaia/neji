#! /bin/bash

echo "Converting training.abstracts.txt from TSV to BC2..." && sleep 1
rm "./chemdner_corpus/training.abstracts.bc2"
while IFS=$'\t' read -r field1 field2 field3; do
    echo $field1
    echo -e "$field1"T" $field2" >> "./chemdner_corpus/training.abstracts.bc2"
    echo -e "$field1"A" $field3" >> "./chemdner_corpus/training.abstracts.bc2"
done < ./chemdner_corpus/training.abstracts.txt

echo "Converting training.annotations.txt from TSV to BC2..." && sleep 1
rm "./chemdner_corpus/training.annotations.bc2"
while IFS=$'\t' read -r field1 field2 field3 field4 field5 field6; do
    echo $field1
    echo -e "$field1$field2|$field3 $field4|$field5" >> "./chemdner_corpus/training.annotations.bc2"
done < ./chemdner_corpus/training.annotations.txt

echo "Training..." && sleep 1
rm -rf ./enumerated_suffix_prefix/
./nejiTrain.sh -if BC2 \
               -c chemdner_corpus/training.abstracts.bc2 \
               -a chemdner_corpus/training.annotations.bc2 \
               -f model.config \
               -m enumerated_suffix_prefix \
               -o ./ \
               -t 4

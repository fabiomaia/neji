#! /bin/bash

rm -rf "./chemdner_corpus/train/" && mkdir -p "./chemdner_corpus/train/"
echo "Converting training.abstracts.txt to A1..." && sleep 1
while IFS=$'\t' read -r field1 field2 field3; do
    echo $field1
    echo -e "$field2" >> "./chemdner_corpus/train/$field1"T".txt"
    echo -e "$field3" >> "./chemdner_corpus/train/$field1"A".txt"
done < ./chemdner_corpus/training.abstracts.txt

while IFS=$'\t' read -r field1 field2 field3 field4 field5 field6; do
    echo $field1
    echo -e "TX\t$field6\t$field3 $field4\t$field5" >> "./chemdner_corpus/train/$field1$field2.a1"
done < ./chemdner_corpus/training.annotations.txt

sed -i "s/NO CLASS/NOCLASS/g" ./chemdner_corpus/train/*.a1

rm -rf ./enumerated_suffix_prefix/
echo "Training..." && sleep 1
./nejiTrain.sh -if A1 \
               -c ./chemdner_corpus/train/ \
               -f model.config \
               -m enumerated_suffix_prefix \
               -o ./ \
               -t 3

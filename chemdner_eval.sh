#! /bin/bash

rm "./chemdner_corpus/development.predictions.txt"
echo "Preparing real annotations into the expected format..." && sleep 1
while IFS=$'\t' read -r field1 field2 field3 field4 field5 field6; do
    echo $field1
    echo -e "$field1\t$field2:$field3:$field4" >> "./chemdner_corpus/development.predictions.txt"
done < ./chemdner_corpus/development.annotations.txt

echo "Evaluating..." && sleep 1
bc-evaluate -l "./chemdner_corpus/predictions.txt" "./chemdner_corpus/development.predictions.txt"

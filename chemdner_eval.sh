#!/bin/bash

echo "Building prediction file..." && sleep 1
rm "./chemdner/enumprefix_prediction.txt"
for filename in ./chemdner/annotate/out/*.bc2; do
    if [ -s "$filename" ]; then
        sentence_type=${filename: -5 : 1}
        id=$(echo $filename | cut -d'/' -f5  | cut -d'.' -f1 | head -c -2)
        while IFS="|" read -r field1 field2 field3; do
            offsets=${field2// /:}
            echo -e "$id\t$sentence_type:$offsets" >> ./chemdner/enumprefix_prediction.txt
        done < "$filename"
    fi
done

echo "Evaluating..." && sleep 1
bc-evaluate -l "./chemdner/enumprefix_prediction.txt" "./chemdner/development.predictions.txt"

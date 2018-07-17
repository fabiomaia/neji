#! /bin/bash

echo "Annotating corpus..." && sleep 1
rm -rf "./chemdner/annotate/out/" && mkdir -p "./chemdner/annotate/out/"
./neji.sh -i chemdner/annotate/in/ -if RAW \
          -o chemdner/annotate/out/ -of A1 \
          -m chemdner/enumerated_suffix_prefix/ \
          -noids

echo "Building prediction file..." && sleep 1
rm "./chemdner/predictions.txt"
for filename in $(find ./chemdner/annotate/out/ -not -empty); do
    echo $filename
    id=$(basename $filename | cut -d'.' -f1 | head -c -2)
    sentence_type=${filename: -4 : 1}

    while IFS=$'\t' read -r field1 field2 field3; do
        startidx=$(echo $field2 | cut -d " " -f2)
        endidx=$(echo $field2 | cut -d " " -f3)
        echo -e "$id\t$sentence_type:$startidx:$endidx" >> ./chemdner/predictions.txt
        read -r tmp;
    done < "$filename"
done

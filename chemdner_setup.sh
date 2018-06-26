#!/bin/bash

########################################################################

echo "Converting training.abstracts from TSV to BC2..." && sleep 1
rm "./chemdner/training.abstracts.bc2"
while IFS=$'\t' read -r field1 field2 field3; do
    echo $field1
    echo -e "$field1 $field2 $field3" >> "./chemdner/training.abstracts.bc2"
done < ./chemdner/training.abstracts.txt

########################################################################

# TODO: what to do with other fields?
echo "Converting training.annotations from TSV to BC2..." && sleep 1
rm "./chemdner/training.annotations.bc2"
while IFS=$'\t' read -r field1 field2 field3 field4 field5 field6; do
    echo $field1
    echo -e "$field1|$field3 $field4|$field5" >> "./chemdner/training.annotations.bc2"
done < ./chemdner/training.annotations.txt

########################################################################

echo "Splitting development.abstracts from TSV to multiple RAW files..." && sleep 1
rm -rf "./chemdner/annotate/in/" && mkdir -p "./chemdner/annotate/in/"
while IFS=$'\t' read -r field1 field2 field3; do
    echo $field1
    echo -e "$field2\n$field3" > "./chemdner/annotate/in/$field1.txt"
done < ./chemdner/development.abstracts.txt

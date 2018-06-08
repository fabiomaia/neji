#!/bin/bash
cp=target/neji-2.0.2-jar-with-dependencies.jar:$CLASSPATH
MEMORY=6G
JAVA_COMMAND="java -Xmx$MEMORY -Dfile.encoding=UTF-8 -classpath $cp"
CLASS=pt.ua.tm.neji.train.util.ChemnerToBC2

echo "Converting from BIOC to BC2..."
$JAVA_COMMAND $CLASS ./chemdner/training.abstracts.txt ./chemdner/training.annotations.txt
$JAVA_COMMAND $CLASS ./chemdner/development.abstracts.txt

echo "Splitting BC2 into multiple RAW files..."
rm -rf ./chemdner/annotate/in/
rm -rf ./chemdner/annotate/out/
mkdir -p ./chemdner/annotate/in/
mkdir -p ./chemdner/annotate/out/
while IFS="|" read -r field1 field2; do
    echo $field1
    echo $field2 > ./chemdner/annotate/in/"$field1".txt
done < ./chemdner/development.abstracts.bc2

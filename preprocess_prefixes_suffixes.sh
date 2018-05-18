#! /bin/bash

sed 's/-//g' chemdner/prefixes.txt | uniq > chemdner/prefixes.preprocessed.txt
sed 's/-//g' chemdner/suffixes.txt | uniq > chemdner/suffixes.preprocessed.txt

#! /bin/bash

if [ ! -f ./chemdner_corpus.tar.gz ]; then
    echo "chemdner_corpus.tar.gz not found! Please download it and place it in the current directory."
    exit
fi

rm -rf ./chemdner_corpus && tar -xvf ./chemdner_corpus.tar.gz

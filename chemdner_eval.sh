#! /bin/bash

echo "Evaluating..." && sleep 1
bc-evaluate -l "./chemdner/predictions.txt" "./chemdner/development.predictions.txt"

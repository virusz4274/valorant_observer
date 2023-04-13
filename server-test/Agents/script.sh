#!/bin/bash
cd ./MIXED
for file in *.webp; do
  dwebp "$file" -quiet -o - | convert - "${file%.*}.jpg"
done
#!/bin/bash
file="/Users/volodymyrpeliukh/Desktop/creds.txt"
while IFS= read -r line
do
    printf '%s\n' "$line"
done <"$file" 
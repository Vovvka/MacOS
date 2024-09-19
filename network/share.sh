#!/bin/bash
file="/Users/volodymyrpeliukh/Desktop/creds.txt"
while IFS= read -r line
do
    # display $line or do somthing with $line
    printf '%s\n' "$line"
done <"$file"
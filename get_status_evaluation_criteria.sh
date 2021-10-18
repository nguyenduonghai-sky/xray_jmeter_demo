#!/bin/bash
ac =  readFile "$filePath"
echo "ac is:  " + $ac
if [[ $ac == *"False"* ]]; then
    echo "FAILED"
else
    echo "PASSED"
fi
#!/bin/bash
ac="cat $filePath"
echo "ac is:  " + $ac
if [[ $ac == *"False"* ]]; then
    echo "FAILED"
else
    echo "PASSED"
fi
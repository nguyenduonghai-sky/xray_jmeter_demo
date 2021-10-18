#!/bin/bash
filePath=$1
ac=`cat $1`
echo "ac is:  $ac"
if [[ $ac == *"False"* ]] 
then
    echo "FAILED"
else
    echo "PASSED"
fi
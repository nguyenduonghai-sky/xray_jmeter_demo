#!/bin/bash
filePath=$1
ac=`cat $1`
if [[ $ac == *"False"* ]] 
then
    echo "FAILED"
else
    echo "PASSED"
fi
#!/bin/bash
def ac =  readFile "$filePath"
echo "ac is:  " + ac
if (ac.contains("False"))
{
    print "PASSED"
}
else {
    print "FAILED"
}
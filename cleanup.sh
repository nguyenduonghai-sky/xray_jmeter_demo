#!/bin/bash

#./cleanup.sh
TAKEOWN /F "./dashboard" /R /D Y
TAKEOWN /F "./reports" /R /D Y

if [ -d "./dashboard" ]; then rm -Rf ./dashboard; fi
if [ -d "./reports" ]; then rm -Rf ./reports; fi
rm -f results.jtl; 
rm -f systhesis_results.csv;

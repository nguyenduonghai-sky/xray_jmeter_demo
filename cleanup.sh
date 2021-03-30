#!/bin/bash

#./cleanup.sh
ICACLS  ./dashboard
ICACLS  ./reports
if [ -d "./dashboard" ]; then rm -Rf ./dashboard; fi
if [ -d "./reports" ]; then rm -Rf ./reports; fi
rm -f results.jtl; 
rm -f systhesis_results.csv;

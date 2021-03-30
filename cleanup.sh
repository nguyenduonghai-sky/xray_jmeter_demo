#!/bin/bash

#./cleanup.sh
chmod a+x dashboard
chmod a+x reports

if [ -d "./dashboard" ]; then rm -Rf ./dashboard; fi
if [ -d "./reports" ]; then rm -Rf ./reports; fi
rm -f results.jtl; 
rm -f systhesis_results.csv;

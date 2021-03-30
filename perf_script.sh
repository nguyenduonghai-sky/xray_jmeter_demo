#!/bin/bash
 
JMETERPLUGINSCMD=JMeterPluginsCMD.bat;
#./cleanup.sh
 
# run jmeter and produce a JTL csv report
echo "run jmeter and produce a JTL csv report";
jmeter -H 10.225.3.1 -P 3128 -n -t  jpetstore_configurable_host.jmx -l results.jtl -e -o dashboard;



# process JTL and covert it to a synthesis report as CSV
echo "process JTL and covert it to a synthesis report as CSV";

$JMETERPLUGINSCMD --generate-csv synthesis_results.csv --input-jtl results.jtl --plugin-type SynthesisReport;
$JMETERPLUGINSCMD --tool Reporter --generate-csv reports/aggregate_results.csv --input-jtl results.jtl --plugin-type AggregateReport;
 
$JMETERPLUGINSCMD --generate-png reports/ResponseTimesOverTime.png --input-jtl results.jtl --plugin-type ResponseTimesOverTime --width 800 --height 600;
$JMETERPLUGINSCMD --generate-png reports/TransactionsPerSecond.png --input-jtl results.jtl --plugin-type TransactionsPerSecond --width 800 --height 600;
 
#./convert.sh "jmeter.jpetstore"
#!/bin/bash
cat reports/aggregate_results_2.csv  |tr "," "|" | sed -e 's/^/|/' | sed -e '1 s/|/||/g'
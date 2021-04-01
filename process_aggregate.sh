#!/bin/bash
cat reports/aggregate_results.csv  |tr "," "|" | sed -e 's/^/|/' | sed -e 's/$/|\\\\13\\/' | sed -e '1 s/|/||/g'
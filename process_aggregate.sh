#!/bin/bash
cat reports/aggregate_results.csv  |tr "," "|" | sed -e 's/$/|\\\\n\\/' | sed -e '1 s/|/||/g'
#!/bin/bash
curl -H "Content-Type: application/json" -X POST -H "Authorization: Bearer $1"  --data @"data.json" https://xray.cloud.xpand-it.com/api/v1/import/execution
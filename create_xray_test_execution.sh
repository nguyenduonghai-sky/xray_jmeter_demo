#!/bin/bash
curl --location --request POST 'https://xray.cloud.xpand-it.com/api/v1/graphql' \
--header 'Authorization: Bearer $1' \
--header 'Content-Type: application/json' \
--data-raw @'create_xray_test_execution_data.txt'
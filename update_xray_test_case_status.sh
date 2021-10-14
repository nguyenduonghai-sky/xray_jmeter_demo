#!/bin/bash
curl --location --request POST 'https://xray.cloud.xpand-it.com/api/v1/graphql' \
--header 'Authorization: Bearer $1' \
--header 'Content-Type: application/json' \
--data-raw '{"query":"mutation {\n    updateTestRunStatus( \n            id: \"XRAY-22\",\n            status: \"PASSED\"\n        ) \n}","variables":{}}
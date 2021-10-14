#!/bin/bash
curl --location --request POST 'https://xray.cloud.xpand-it.com/api/v1/graphql' \
--header 'Authorization: Bearer $1' \
--header 'Content-Type: application/json' \
--data-raw '{"query":"mutation {\n    createTestExecution(\n        testIssueIds: []\n        jira: {\n            fields: {\n                summary: \"empty Test Execution\",\n                project: {key: \"XRAY\"} \n            }\n        }\n    ) {\n        testExecution {\n            issueId\n            jira(fields: [\"10008\"])\n        }\n        warnings\n    }\n}","variables":{}}'
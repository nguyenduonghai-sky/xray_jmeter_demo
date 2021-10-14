#!/bin/bash
curl --location --request POST 'https://xray.cloud.xpand-it.com/api/v1/graphql' \
--header 'Authorization: Bearer {{TOKEN}}' \
--header 'Content-Type: application/json' \
--data-raw '{"query":"mutation {\n    createTestExecution(\n        testIssueIds: []\n        jira: {\n            fields: {\n                summary: \"Test Execution of {{TEST}}, build time {{BUILD_TIME}}\",\n                project: {key: \"XRAY\"} \n            }\n        }\n    ) {\n        testExecution {\n            issueId\n            jira(fields: [\"10008\"])\n        }\n        warnings\n    }\n}","variables":{}}'
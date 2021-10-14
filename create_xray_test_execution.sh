curl --location --request POST 'https://xray.cloud.xpand-it.com/api/v1/import/execution' \
--header 'Authorization: Bearer {{TOKEN}}' \
--header 'Content-Type: application/json' \
--data-raw '{
    "info" : {
        "summary" : "NFT Test Execution of of {{TEST}}, build time {{BUILD_TIME}}",
        "description" : "This execution is automatically created when run in jenkin job"
    },
    "tests" : [
        {
            "testKey" : "{{TEST}}",
            "start" : "2014-08-30T11:47:35+01:00",
            "finish" : "2014-08-30T11:50:56+01:00",
            "comment" : "Successful execution",
            "status" : "PASS"
        }
 ]
}'
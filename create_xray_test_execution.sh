#!/bin/bash
curl --location --request POST 'https://xray.cloud.xpand-it.com/api/v1/graphql' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0ZW5hbnQiOiI3MmJkMmY2OC1iMzY4LTM3MjAtYTVkYi02YmM0MDc0YjU2YzUiLCJhY2NvdW50SWQiOiI2MDQ5ZjljYjQzZWFjNjAwNmY4YzE2MTAiLCJpc1hlYSI6ZmFsc2UsImlhdCI6MTYzNDE4NTEzOCwiZXhwIjoxNjM0MjcxNTM4LCJhdWQiOiJBNTY1NkNFMTczOEI0QzNFOTZCOUYwQUJENjExMTlFOSIsImlzcyI6ImNvbS54cGFuZGl0LnBsdWdpbnMueHJheSIsInN1YiI6IkE1NjU2Q0UxNzM4QjRDM0U5NkI5RjBBQkQ2MTExOUU5In0.W3U-SOs0K_7SHuj2_XXo0VPqTzimIOpDyacJTU7FBtc' \
--data-raw @"create_xray_test_execution_data.json"
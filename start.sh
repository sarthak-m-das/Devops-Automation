#!/bin/bash

# Token API Endpoint
TOKEN_API_ENDPOINT="http://localhost:9000/api/user_tokens/generate?name=my-Token&expirationDate=2024-01-01&type=GLOBAL_ANALYSIS_TOKEN"

# Authorization Header
AUTH_HEADER="Authorization: Basic YWRtaW46Yml0c29mUGFwZXI="

# Make the API request and save the token to a file
curl --location --request POST "$TOKEN_API_ENDPOINT" \
     --header "$AUTH_HEADER" \
     --data '' >> token.json


echo "Token saved to token.json"

# Webhook API Endpoint
WEBHOOK_API_ENDPOINT="http://localhost:9000/api/webhooks/create?name=jenkins&url=http%3A%2F%2F10.0.0.14%3A8080%2Fsonarqube-webhook%2F"

curl --location --request POST "$WEBHOOK_API_ENDPOINT" \
    --header 'Authorization: Basic YWRtaW46Yml0c29mUGFwZXI='

echo "Webhook created"
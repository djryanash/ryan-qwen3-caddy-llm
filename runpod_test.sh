#!/usr/bin/env zsh

# Exit immediately if anything fails
set -e 

curl -s https://3kmf7xu5nmcab7.api.runpod.ai/api/generate \
  -H "Authorization: Bearer ${RUNPOD_KEY}" \
  -H "Content-Type: application/json" \
-d '{
  "model": "qwen3.5:2b",
  "prompt": "What is the capital of Spain?",
  "stream": false,
  "think": false 
}'

echo "Runpod verified."
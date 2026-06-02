#!/usr/bin/env zsh

# Exit immediately if anything fails
set -e 

# Verify that runpod is working
echo "Testing debug..."

curl -s https://3kmf7xu5nmcab7.api.runpod.ai/debug \
  -H "Authorization: Bearer ${RUNPOD_KEY}" \
  -H "X-Api-Key: ${RYAN_KEY}" \
  -H "Content-Type: application/json"

echo "Runpod verified."
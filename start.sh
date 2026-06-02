#!/bin/sh
#Start Ollama
ollama serve &

# Wait for Ollama to be ready
until curl -s http://127.0.0.1:11434/api/tags > /dev/null; do 
    echo "Waiting for Ollama..."
    sleep 0.5
done 

# Verify the model is responsive
echo "Testing model..."
curl -s http://127.0.0.1:11434/api/generate -d '{
  "model": "qwen3.5:2b",
  "prompt": "How are you?",
  "stream": false,
  "think": false 
}'
echo "Model verified."

# Start Caddy
echo "Starting Caddy..."
caddy run --config /Caddyfile -- adapter caddyfile
echo "Caddy exited with status $?"
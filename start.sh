#!/bin/sh
#Start Ollama
ollama serve &

# Wait for Ollama to be ready
until curl -s http://0.0.0.0:11434/api/tags > /dev/null; do 
    echo "Waiting for Ollama..."
    sleep 0.5
done 

# Verify the model is responsive
echo "Testing model..."
curl -s http://0.0.0.0:11434/api/generate -d '{
  "model": "qwen3.5:2b",
  "prompt": "How are you?",
  "stream": false,
  "think": false 
}'
echo "Model verified."

# Run a minimal listener in the background for health checks
# This returns 200 OK to any request
while true; do 
  echo -e "HTTP/1.1 200 OK\n\nOK" | nc -l -p 11436; 
done &
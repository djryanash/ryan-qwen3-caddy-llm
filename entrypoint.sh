#!/bin/bash

# Start Ollama in the background
ollama serve &
PID=$!

# Wait for Ollama to be ready
until curl -s http://localhost:11434/api/tags > /dev/null; do
    sleep 2
done
    
# Pull the model
ollama pull qwen2.5:0.5b

# Keep container running
wait $PID
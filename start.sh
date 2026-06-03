#!/bin/sh
# Start Ollama in the background
ollama serve &

# Wait for Ollama to be ready
until curl -s http://0.0.0.0:11434/api/tags > /dev/null; do 
    sleep 0.5
done 

# Keep the container alive
wait
FROM ollama/ollama

# Install curl to run setup commands
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Copy a script to pull the model and start the server
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
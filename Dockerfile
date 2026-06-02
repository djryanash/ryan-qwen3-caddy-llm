FROM ollama/ollama 

# Add netcat to your existing apt-get install line
RUN apt-get update && \ 
    apt-get install -y --no-install-recommends curl netcat-traditional && \
    rm -rf /var/lib/apt/lists/*

# Set host to allow external connections 
ENV OLLAMA_HOST=0.0.0.0:11434
ENV OLLAMA_MODELS=/root/.ollama 
ENV MODEL=qwen3.5:2b
# ENV MODEL=qwen3.6:35bg

# Back the model into the image layer 
RUN ollama serve & \
    PID=$! && \
    sleep 5 && \
    ollama pull ${MODEL} && \
    kill $PID 

EXPOSE 11434

COPY start.sh start.sh 

RUN chmod +x /start.sh 
ENTRYPOINT [ "/start.sh" ]
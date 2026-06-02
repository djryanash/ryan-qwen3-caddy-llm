FROM ollama/ollama 

RUN apt-get update && \ 
    apt-get install -y --no-install-recommends curl && \
    rm -rf /var/lib/apt/lists/*
    
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
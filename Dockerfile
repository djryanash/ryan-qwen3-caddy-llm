# Stage 1: Get Caddy
FROM caddy:2 AS builder 

# Starge 2: Final image
FROM ollama/ollama 

# 1. Install system utilities first (highly cacheable)
RUN apt-get update && \ 
    apt-get install -y --no-install-recommends curl && \
    rm -rf /var/lib/apt/lists/*

# 2. Install Caddy binaries and copy minimal runtime dependencies 
COPY --from=builder /usr/bin/caddy /usr/bin/caddy 

# Set host to allow external connections 
ENV OLLAMA_HOST=127.0.0.1:11434
ENV OLLAMA_MODELS=/root/.ollama 
ENV MODEL=qwen3.5:2b
# ENV MODEL=qwen3.6:35bg

# Back the model into the image layer 
RUN ollama serve & \
    PID=$! && \
    sleep 5 && \
    ollama pull ${MODEL} && \
    kill $PID 

COPY Caddyfile /Caddyfile

EXPOSE 11435

COPY start.sh start.sh 

RUN chmod +x /start.sh 
ENTRYPOINT [ "/start.sh" ]
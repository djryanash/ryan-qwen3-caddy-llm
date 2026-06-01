# Stage 1: Use Caddy builder to get the server binary
FROM caddy:2 AS builder 

# Starge 2: Final image combining Ollama and Caddy
FROM ollama/ollama 

# 1. Install system utilities first (highly cacheable)
RUN apt-get update && \ 
    apt-get install -y --no-install-recommends curl && \
    rm -rf /var/lib/apt/lists/*


# 2. Install Caddy binaries and copy minimal runtime dependencies 
COPY --from=builder /usr/bin/caddy /usr/bin/caddy 

# Set host to allow external connections 
ENV OLLAMA_HOST=127.0.0.1:11434

# Back the model into the image layer 
RUN ollama serve & \
    sleep 3 && \
    ollama pull qwen3.6:35b

COPY Caddyfile /Caddyfile

EXPOSE 11435

# Start Ollama in the background, wait for it to be ready, then start Caddy
ENTRYPOINT ["sh", "-c", "ollama serve & until curl -s http://127.0.0.1:11434/api/tags > /dev/null; do sleep 0.5; done && exec caddy run --config /Caddyfile --adapter caddyfile"]


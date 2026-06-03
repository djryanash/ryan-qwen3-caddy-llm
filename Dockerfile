FROM ollama/ollama

ENV OLLAMA_HOST=0.0.0.0
EXPOSE 11434

RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
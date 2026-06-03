FROM python:3.10-slim
WORKDIR /app

# Simple command to start a web server on port 8080
CMD ["python3", "-m", "http.server", "8080"]
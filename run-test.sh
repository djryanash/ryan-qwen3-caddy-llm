#!/bin/bash

docker build -t my-app .
docker run -d --name my-app-container -p 8080:8080 my-app

sleep 2
curl http://localhost:8080

# docker container stop my-app-container 2>/dev/null || true
# docker container rm my-app-container 2>/dev/null || true
# docker rmi my-app:latest --force 2>/dev/null || true
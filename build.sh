#!/bin/bash
mvn clean package
docker build -t bproenca/simple-java-docker-fat -f Dockerfile_fat .
docker build -t bproenca/simple-java-docker-slim -f Dockerfile_slim .
docker image prune -f --filter label=stage=builder

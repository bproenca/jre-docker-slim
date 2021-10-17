#!/bin/bash
echo ">>> Running all JRE images"
docker run --name jre-temurin-slim --rm -d -p 8082:8080 bproenca/jre-temurin-slim
docker run --name jre-oracle-slim --rm -d -p 8084:8080 bproenca/jre-oracle-slim

echo ">>> Wait for startup"
sleep 10

echo ">> Java vm vendor - port 8082"
curl -s http://localhost:8082/actuator/env | jq -r '.propertySources[2].properties."java.vm.vendor"'
echo ">> Java vm vendor - port 8084"
curl -s http://localhost:8084/actuator/env | jq -r '.propertySources[2].properties."java.vm.vendor"'

docker stop jre-temurin-slim
docker stop jre-oracle-slim
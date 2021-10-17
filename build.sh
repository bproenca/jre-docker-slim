#!/bin/bash
echo -e "\n\n>>>> Maven tasks"
mvn clean package
echo -e "\n\n>>>> Clean old images"
docker rmi  bproenca/jre-temurin-fat \
            bproenca/jre-temurin-slim \
            bproenca/jre-oracle-fat \
            bproenca/jre-oracle-slim \
            bproenca/jre-amazon-fat \
            bproenca/jre-amazon-slim \
            bproenca/jre-azul-fat \
            bproenca/jre-azul-slim

echo -e "\n\n>>>> Temurin Fat (jdk) Image"
docker build -t bproenca/jre-temurin-fat -f docker/Dockerfile_Temurin_fat .
echo -e "\n\n>>>> Temurin Slim (jre) Image"
docker build -t bproenca/jre-temurin-slim -f docker/Dockerfile_Temurin_slim .

echo -e "\n\n>>>> Oracle Fat (jdk) Image"
docker build -t bproenca/jre-oracle-fat -f docker/Dockerfile_Oracle_fat .
echo -e "\n\n>>>> Oracle Slim (jdk) Image"
docker build -t bproenca/jre-oracle-slim -f docker/Dockerfile_Oracle_slim .
docker image prune -f --filter label=stage=builder

echo -e "\n\n>>>> Amazon Fat (jdk) Image"
docker build -t bproenca/jre-amazon-fat -f docker/Dockerfile_Amazon_fat .
echo -e "\n\n>>>> Amazon Slim (jdk) Image"
docker build -t bproenca/jre-amazon-slim -f docker/Dockerfile_Amazon_slim .

echo -e "\n\n>>>> Azul Fat (jdk) Image"
docker build -t bproenca/jre-azul-fat -f docker/Dockerfile_Azul_fat .
echo -e "\n\n>>>> Azul Slim (jdk) Image"
docker build -t bproenca/jre-azul-slim -f docker/Dockerfile_Azul_slim .

echo -e "\n\n>>>> Clean intermediate images"
docker image prune -f --filter label=stage=builder
echo -e "\n\n>>>> Result"
docker image ls

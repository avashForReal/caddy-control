#!/bin/bash

# ANSI color codes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' 

echo -e "${BLUE}=========================================${NC}"
echo -e "${GREEN}Caddy Control Setup${NC}"
echo -e "${BLUE}=========================================${NC}"

echo -e "${YELLOW}Enter Caddy Server IP (required):${NC}"
read -p "> " CADDY_SERVER_IP

if [[ -z "$CADDY_SERVER_IP" ]]; then
    echo -e "${RED}Error: Caddy Server IP is required. Exiting.${NC}"
    exit 1
fi

echo -e "${YELLOW}Enter App Host domain (required):${NC}"
read -p "> " APP_HOST

if [[ -z "$APP_HOST" ]]; then
    echo -e "${RED}Error: App Host is required. Exiting.${NC}"
    exit 1
fi

echo -e "${YELLOW}Enter JWT secret (required):${NC}"
read -p "> " JWT_SECRET

if [[ -z "$JWT_SECRET" ]]; then
    echo -e "${RED}Error: JWT secret is required. Exiting.${NC}"
    exit 1
fi

echo "Creating docker-compose.yml file with your configuration..."

# replace values in the docker-compose.yml file
if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' "s/APP_HOST=.*/APP_HOST=${APP_HOST}/" docker-compose.yml
    sed -i '' "s/CADDY_SERVER_IP=.*/CADDY_SERVER_IP=${CADDY_SERVER_IP}/" docker-compose.yml
    sed -i '' "s/JWT_SECRET=.*/JWT_SECRET=${JWT_SECRET}/" docker-compose.yml
else
    sed -i "s/APP_HOST=.*/APP_HOST=${APP_HOST}/" docker-compose.yml
    sed -i "s/CADDY_SERVER_IP=.*/CADDY_SERVER_IP=${CADDY_SERVER_IP}/" docker-compose.yml
    sed -i "s/JWT_SECRET=.*/JWT_SECRET=${JWT_SECRET}/" docker-compose.yml
fi


echo -e "${GREEN}Configuration complete!${NC}"
echo -e "${BLUE}----------------------------------------${NC}"
echo -e "${GREEN}Settings:${NC}"
echo -e "  App Host: ${APP_HOST}"
echo -e "  Caddy Server IP: ${CADDY_SERVER_IP}"
echo -e "  JWT Secret: ${JWT_SECRET}"
echo -e "${BLUE}----------------------------------------${NC}"
echo -e "${GREEN}You can now run 'docker-compose up -d' to start your services${NC}"
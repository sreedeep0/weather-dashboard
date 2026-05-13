#!/bin/bash

source .env

# Colors
RED='\033[1;31m'
GREEN='\033[1;32m'
CYAN='\033[1;36m'
BLUE='\033[1;34m'
YELLOW='\033[1;33m'
MAGENTA='\033[1;35m'
WHITE='\033[1;37m'
NC='\033[0m'

echo -e "${CYAN}"
cat << "EOF"

⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠏⠕⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⢤⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠩⢛⠁⠀⠀⠀⢀⣀⣤⣴⣲⣖⣦⣤⣄⡀⠀⠀⠀⠈⠑⠋⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣴⡿⣾⢿⡿⣟⣿⣻⣽⣾⢿⣧⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⡻⢾⣝⡙⣎⡜⣱⢎⡵⣯⣞⡿⣽⣞⠷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⢳⡝⢣⠾⣽⡞⣽⡽⣫⣟⡳⠽⢫⠗⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⣀⠀⠀⠀⠀⢧⢫⡜⢣⢻⡵⣫⠷⡙⠡⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠈⠓⠥⠂⠀⠀⠘⣌⢳⠸⣌⠧⡝⠅⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠦⡙⢤⠛⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠂⠍⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀

EOF

echo -e "${BLUE}==================================================${NC}"
echo -e "${YELLOW}              WEATHER DASHBOARD                   ${NC}"
echo -e "${BLUE}==================================================${NC}"

echo -e "${GREEN}Enter city name:${NC}"
read CITY

CHECK_URL="https://api.openweathermap.org/data/2.5/weather?q=${CITY}&appid=${API_KEY}"

CHECK_RESPONSE=$(curl -s "$CHECK_URL")

ERROR_CHECK=$(echo $CHECK_RESPONSE | jq -r '.cod')

if [ "$ERROR_CHECK" != "200" ]; then
    echo -e "${RED}Invalid city name. Please enter a valid city.${NC}"
    exit 1
fi

echo -e "${MAGENTA}Choose unit:${NC}"
echo "1. Celsius"
echo "2. Fahrenheit"
read UNIT_CHOICE

if [ "$UNIT_CHOICE" -eq 1 ]; then
    UNIT="metric"
    SYMBOL="°C"
else
    UNIT="imperial"
    SYMBOL="°F"
fi

URL="https://api.openweathermap.org/data/2.5/weather?q=${CITY}&appid=${API_KEY}&units=${UNIT}"

RESPONSE=$(curl -s "$URL")

CITY_NAME=$(echo $RESPONSE | jq -r '.name')
TEMP=$(echo $RESPONSE | jq -r '.main.temp')
WEATHER=$(echo $RESPONSE | jq -r '.weather[0].main')
HUMIDITY=$(echo $RESPONSE | jq -r '.main.humidity')
WIND=$(echo $RESPONSE | jq -r '.wind.speed')

echo
echo -e "${BLUE}==================================================${NC}"
echo -e "${CYAN}                 WEATHER REPORT                   ${NC}"
echo -e "${BLUE}==================================================${NC}"

echo -e "${WHITE}City        : ${GREEN}$CITY_NAME${NC}"
echo -e "${WHITE}Temperature : ${YELLOW}$TEMP$SYMBOL${NC}"
echo -e "${WHITE}Condition   : ${CYAN}$WEATHER${NC}"
echo -e "${WHITE}Humidity    : ${MAGENTA}$HUMIDITY%${NC}"
echo -e "${WHITE}Wind Speed  : ${GREEN}$WIND${NC}"

echo -e "${BLUE}==================================================${NC}"

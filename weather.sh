#!/bin/bash

source .env

clear

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

echo "=================================================="
echo "              WEATHER DASHBOARD                   "
echo "=================================================="

echo "Enter city name:"
read CITY

CHECK_URL="https://api.openweathermap.org/data/2.5/weather?q=${CITY}&appid=${API_KEY}"

CHECK_RESPONSE=$(curl -s "$CHECK_URL")

ERROR_CHECK=$(echo $CHECK_RESPONSE | jq -r '.cod')

if [ "$ERROR_CHECK" != "200" ]; then
    echo "Invalid city name. Please enter a valid city."
    exit 1
fi

echo "Choose unit:"
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
echo "=================================================="
echo "                 WEATHER REPORT                   "
echo "=================================================="

echo "City        : $CITY_NAME"
echo "Temperature : $TEMP$SYMBOL"
echo "Condition   : $WEATHER"
echo "Humidity    : $HUMIDITY%"
echo "Wind Speed  : $WIND"

echo "=================================================="
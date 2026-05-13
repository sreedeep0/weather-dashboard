# Weather Dashboard

A command-line weather dashboard developed using Bash scripting and OpenWeatherMap API integration. The application retrieves and displays real-time weather information for user-specified cities directly from the terminal.

---

## Features

- Real-time weather data retrieval
- Supports Celsius and Fahrenheit units
- JSON parsing using `jq`
- API requests using `curl`
- Interactive command-line interface
- Displays:
  - Temperature
  - Weather condition
  - Humidity
  - Wind speed

---

## Technologies Used

- Bash Scripting
- OpenWeatherMap API
- curl
- jq
- Git & GitHub

---

## Project Structure

```bash
weather-dashboard/
├── weather.sh
└── README.md
```

---

## Installation

### Install Dependencies

```bash
sudo apt update
sudo apt install curl jq
```

---

## API Setup

1. Create an account at:
   https://openweathermap.org/api

2. Generate an API key

3. Open `weather.sh` and replace:

```bash
API_KEY="YOUR_API_KEY"
```

with your actual API key.

---

## Run the Application

```bash
chmod +x weather.sh
./weather.sh
```

---

## Sample Output

```text
--------------------------
Weather Dashboard
--------------------------
City: London
Temperature: 20°C
Condition: Clouds
Humidity: 42%
Wind Speed: 4.02
```

---

## Learning Outcomes

This project demonstrates:
- API integration in shell scripting
- JSON parsing in Linux
- Command-line automation
- Bash scripting fundamentals
- Version control using Git and GitHub

---

## Authors

- Sreedeep
- Siddhu
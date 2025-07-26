#!/bin/bash

# You need to get an API key from OpenWeatherMap
# Sign up at https://openweathermap.org/ and get a free API key
API_KEY="416adffa17f5148fbb1a6dd05fa2f9a7"

# Your city (change this)
# CITY=""

# You can specify city ID instead for more accuracy
CITY_ID="3106868"

# Fetch weather data
get_weather() {
    # Use city name or ID based on what's provided
    if [[ -n "$CITY" && "$CITY" != "YOUR_CITY_HERE" ]]; then
        weather=$(curl -sf "https://api.openweathermap.org/data/2.5/weather?q=$CITY&appid=$API_KEY&units=metric")
    elif [[ -n "$CITY_ID" && "$CITY_ID" != "YOUR_CITY_ID_HERE" ]]; then
        weather=$(curl -sf "https://api.openweathermap.org/data/2.5/weather?id=$CITY_ID&appid=$API_KEY&units=metric")
    else
        echo "Error: Please set your city or city ID in the weather.sh script"
        exit 1
    fi

    # Check if weather data was retrieved successfully
    if [ -z "$weather" ]; then
        echo "Error: Failed to fetch weather data"
        exit 1
    fi

    # Parse weather data
    temperature=$(echo "$weather" | jq -r '.main.temp')
    temperature_rounded=$(printf "%.1f" "$temperature")
    city_name=$(echo "$weather" | jq -r '.name')
    weather_description=$(echo "$weather" | jq -r '.weather[0].description')
    weather_icon=$(echo "$weather" | jq -r '.weather[0].icon')
    humidity=$(echo "$weather" | jq -r '.main.humidity')
    wind_speed=$(echo "$weather" | jq -r '.wind.speed')
    wind_speed_kmh=$(echo "$wind_speed * 3.6" | bc)
    
    # Map weather icon to an emoji for simple display
    case "${weather_icon:0:2}" in
        "01") icon="☀️" ;; # clear sky
        "02") icon="⛅" ;; # few clouds
        "03") icon="☁️" ;; # scattered clouds
        "04") icon="☁️" ;; # broken clouds
        "09") icon="🌧️" ;; # shower rain
        "10") icon="🌦️" ;; # rain
        "11") icon="⛈️" ;; # thunderstorm
        "13") icon="❄️" ;; # snow
        "50") icon="🌫️" ;; # mist
        *) icon="❓" ;; # unknown
    esac

    # Output in JSON format for eww
    echo "{\"temperature\": \"$temperature_rounded\", \"city\": \"$city_name\", \"description\": \"$weather_description\", \"icon\": \"$icon\", \"humidity\": \"$humidity\", \"wind\": \"$(printf "%.1f" "$wind_speed_kmh")\"}"
}

get_weather


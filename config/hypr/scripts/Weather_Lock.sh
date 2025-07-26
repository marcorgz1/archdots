#!/bin/bash

# Function to get weather emoji based on condition
get_weather_emoji() {
    local weather_main="$1"
    local weather_description="$2"
    
    case "$weather_main" in
        "Clear")
            echo "☀️"
            ;;
        "Clouds")
            if [[ "$weather_description" == *"few clouds"* ]]; then
                echo "🌤️"
            elif [[ "$weather_description" == *"scattered clouds"* || "$weather_description" == *"broken clouds"* ]]; then
                echo "⛅"
            else
                echo "☁️"
            fi
            ;;
        "Rain")
            if [[ "$weather_description" == *"light rain"* ]]; then
                echo "🌦️"
            elif [[ "$weather_description" == *"heavy"* ]]; then
                echo "⛈️"
            else
                echo "🌧️"
            fi
            ;;
        "Drizzle")
            echo "🌦️"
            ;;
        "Thunderstorm")
            echo "⛈️"
            ;;
        "Snow")
            echo "❄️"
            ;;
        "Mist"|"Fog")
            echo "🌫️"
            ;;
        "Haze")
            echo "😶‍🌫️"
            ;;
        "Dust"|"Sand")
            echo "🌪️"
            ;;
        *)
            echo "🌍"
            ;;
    esac
}

# Function to fetch weather data for a given city
get_weather_data() {
    local city_name="$1"
    local api_key="9f815d625b1fa077b8d8f70bdfb0c205"  # Your OpenWeatherMap API key
    local url="http://api.openweathermap.org/data/2.5/weather?q=${city_name}&appid=${api_key}&units=metric"
    
    # Fetch data from API
    local response=$(curl -s "$url")
    
    # Check if the API call was successful
    local cod=$(echo "$response" | jq -r '.cod // empty')
    if [ "$cod" != "200" ]; then
        echo "Error: Unable to fetch weather data for $city_name"
        return 1
    fi
    
    # Parse JSON response
    local feels_like=$(echo "$response" | jq -r '.main.feels_like')
    local temp=$(echo "$response" | jq -r '.main.temp')
    local weather_main=$(echo "$response" | jq -r '.weather[0].main')
    local weather_description=$(echo "$response" | jq -r '.weather[0].description')
    local city_display=$(echo "$response" | jq -r '.name')
    local country=$(echo "$response" | jq -r '.sys.country')
    
    # Round temperatures
    local rounded_feels_like=$(printf "%.0f" "$feels_like")
    local rounded_temp=$(printf "%.0f" "$temp")
    
    # Get weather emoji
    local emoji=$(get_weather_emoji "$weather_main" "$weather_description")
    
    # Display results
    echo "$city_display, $country: $emoji     $weather_description  ${rounded_feels_like}°C"
}

# Function to get weather by city ID (for backward compatibility)
get_weather_by_id() {
    local city_id="$1"
    local api_key="9f815d625b1fa077b8d8f70bdfb0c205"
    local url="http://api.openweathermap.org/data/2.5/weather?id=${city_id}&appid=${api_key}&units=metric"
    
    local response=$(curl -s "$url")
    local cod=$(echo "$response" | jq -r '.cod // empty')
    
    if [ "$cod" != "200" ]; then
        echo "Error: Unable to fetch weather data for city ID $city_id"
        return 1
    fi
    
    local feels_like=$(echo "$response" | jq -r '.main.feels_like')
    local temp=$(echo "$response" | jq -r '.main.temp')
    local weather_main=$(echo "$response" | jq -r '.weather[0].main')
    local weather_description=$(echo "$response" | jq -r '.weather[0].description')
    local city_display=$(echo "$response" | jq -r '.name')
    local country=$(echo "$response" | jq -r '.sys.country')
    
    local rounded_feels_like=$(printf "%.0f" "$feels_like")
    local rounded_temp=$(printf "%.0f" "$temp")
    local emoji=$(get_weather_emoji "$weather_main" "$weather_description")
    
    echo "$city_display, $country: $emoji $weather_description    ${rounded_feels_like}°C"
}

# Main function
main() {
    # Check if city argument is provided
    if [ $# -eq 0 ]; then
        echo "Usage: $0 <city_name>"
        echo "Example: $0 \"New York\""
        echo "Example: $0 \"London\""
        echo ""
        echo "Running with default city (Bangalore)..."
        get_weather_by_id 1260788  # Bangalore city ID
    else
        # Use the provided city name
        city_name="$1"
        get_weather_data "$city_name"
    fi
}

# Execute main function with all arguments
main "$@"


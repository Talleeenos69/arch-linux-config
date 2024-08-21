import requests

# Coordinates for Toronto
lat = 43.65107  
lon = -79.347015  

# Open-Meteo API URL
url = f"https://api.open-meteo.com/v1/forecast?latitude={lat}&longitude={lon}&current_weather=true"

response = requests.get(url)

if response.status_code == 200:
    data = response.json()
    
    # Extracting the relevant data
    temperature = data['current_weather']['temperature']
    weather_code = data['current_weather']['weathercode']
    cloud_cover = data['current_weather'].get('cloudcover', 0)  # Cloud cover if available
    
    # Mapping weather code to condition with emojis
    if weather_code == 0:
        condition = ""
    elif weather_code in [1, 2, 3]:
        condition = ""
    elif weather_code in [45, 48]:
        condition = ""
    elif weather_code in [51, 53, 55]:
        condition = ""
    elif weather_code in [56, 57]:
        condition = "⛆"
    elif weather_code in [61, 63, 65]:
        condition = "⛆"
    elif weather_code in [66, 67]:
        condition = "⛄"
    elif weather_code in [71, 73, 75]:
        condition = "❄"
    elif weather_code == 77:
        condition = "❄"
    elif weather_code in [80, 81, 82]:
        condition = "⛆"
    elif weather_code in [85, 86]:
        condition = ""
    elif weather_code == 95:
        condition = ""
    elif weather_code in [96, 99]:
        condition = ""
    else:
        condition = ""
    
    # Adjust condition based on cloud cover
    if cloud_cover >= 75:
        condition = "☁️"
    elif 25 <= cloud_cover < 75:
        condition = "🌤️"
    
    print(f"{condition} {round(temperature)}°C")
else:
    print(f"Failed to retrieve data: {response.status_code} - {response.text}")


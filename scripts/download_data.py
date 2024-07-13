import os
import requests

# URLs to download datasets
health_data_url = "URL_TO_HEALTH_DATA_CSV"
geo_data_url = "URL_TO_GEO_DATA_SHAPEFILE"

# Directories
raw_data_dir = "/app/data/raw"

# Download health data
health_response = requests.get(health_data_url)
with open(os.path.join(raw_data_dir, "health_data.csv"), "wb") as file:
    file.write(health_response.content)

# Download geo data
geo_response = requests.get(geo_data_url)
with open(os.path.join(raw_data_dir, "geo_data.zip"), "wb") as file:
    file.write(geo_response.content)

print("Data downloaded successfully!")

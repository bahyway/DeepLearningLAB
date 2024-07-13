import pandas as pd
from sqlalchemy import create_engine
import geopandas as gpd

# Database connection
engine = create_engine("postgresql://user:password@db:5432/deeplearning_db")

# Load health data
health_data = pd.read_csv("/app/data/raw/health_data.csv")
health_data.to_sql("health_data", engine, if_exists="replace", index=False)

# Load geo data
geo_data = gpd.read_file("/app/data/raw/geo_data.shp")
geo_data.to_postgis("geo_data", engine, if_exists="replace")

print("Data loaded successfully!")

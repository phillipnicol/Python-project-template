# Data cleaning script
# This script processes raw data into analysis-ready format

import pandas as pd
from pathlib import Path

# Load raw data
raw_data = pd.read_csv(Path("raw_data") / "data.csv")
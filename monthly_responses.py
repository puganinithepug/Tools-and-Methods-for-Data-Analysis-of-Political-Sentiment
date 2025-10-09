#!/usr/bin/env python
# coding: utf-8

# In[3]:


import pandas as pd

# 1. Load only needed columns, disable dtype guessing
df = pd.read_csv("filtered_data.csv", header=None, usecols=[1, 2, 9], low_memory=False)
df.columns = ["created", "closed", "zipcode"]

# 2. Clean zipcode: only keep 5-digit ones
df = df[df["zipcode"].astype(str).str.match(r"^\d{5}$")]

# 3. Parse dates with explicit format
date_fmt = "%m/%d/%Y %I:%M:%S %p"
df["created"] = pd.to_datetime(df["created"], format=date_fmt, errors="coerce")
df["closed"] = pd.to_datetime(df["closed"], format=date_fmt, errors="coerce")

# Drop rows with missing/invalid dates
df = df.dropna(subset=["created", "closed"])

# 4. Compute response hours
df["response_hours"] = (df["closed"] - df["created"]).dt.total_seconds() / 3600

# 5. Extract Year-Month
df["month"] = df["created"].dt.to_period("M")

# 6. Group by zipcode + month
agg = (
    df.groupby(["zipcode", "month"])
      .agg(
          count=("response_hours", "count"),
          sum_hours=("response_hours", "sum"),
          avg_hours=("response_hours", "mean")
      )
      .reset_index()
)

# 7. Save results
agg.to_csv("zipcode_month_avg.csv", index=False)

print(agg.head(10))


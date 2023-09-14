import argparse
import logging
import sys
import time
from platform import python_version
print(python_version())
import pandas as pd
import json
import requests
import os
from dotenv import load_dotenv # add this line
load_dotenv()
ACS_API_KEY = os.getenv('ACS_API_KEY')
BLS_API_KEY = os.getenv("BLS_API_KEY")
logger = logging.getLogger()
formatter = logging.Formatter('[%(asctime)s [%(process)d] %(message)s')
handler = logging.StreamHandler(sys.stderr)
handler.setFormatter(formatter)
logger.addHandler(handler)
from concurrent.futures import ThreadPoolExecutor, as_completed
with open('./data/json_acs_1_dp_2021_column_mapper.json') as json_file:
    variable_mapper = json.load(json_file)
with open('./data/json_acs_1_cp_2021_column_mapper.json') as json_file:
    temp_mapper = json.load(json_file)
variable_mapper.update(temp_mapper)
with open('./data/json_acs_1_cp_2016_column_mapper.json') as json_file:
    temp_mapper = json.load(json_file)
variable_mapper.update(temp_mapper)
for key, val in variable_mapper.items():
    variable_mapper[key] = "_" + val.replace("!!", "__")\
    .replace(" ", "_")\
    .replace("-", "_")\
    .replace("Estimate__", "")\
    .replace("years", "y")\
    .replace("_or_African_American","")\
    .replace("(", "")\
    .replace(")","")\
    .replace("HOUSING_OCCUPANCY__", "")\
    .replace("YEAR_STRUCTURE_BUILT__", "")\
    .replace("UNITS_IN_STRUCTURE__", "")\
    .replace("HOUSING_TENURE__", "")\
    .replace("YEAR_HOUSEHOLDER_MOVED_INTO_UNIT__", "")\
    .replace("VEHICLES_AVAILABLE__", "")\
    .replace("MORTGAGE_STATUS__", "")\
    .replace("SELECTED_MONTHLY_OWNER_COSTS_", "")\
    .replace("AS_A_PERCENTAGE_OF_HOUSEHOLD_INCOME_", "")\
    .replace("GROSS_RENT_AS_A_PERCENTAGE_OF_HOUSEHOLD_INCOME_", "")\
    .replace("_excluding_units_where_SMOCAPI_cannot_be_computed", "")\
    .replace("_excluding_units_where_GRAPI_cannot_be_computed", "")\
    .replace("GROSS_RENT_GRAPI__", "")\
    .replace("EMPLOYMENT_STATUS__", "")\
    .replace("and_over", "up")\
    .replace("labor_force", "work")\
    .replace("OCCUPATION__", "")\
    .replace("INDUSTRY__", "")\
    .replace(",", "")\
    .replace(".0", "")\
    .replace(".", "")
with open('./data/json_acs_5_dp_2016_column_mapper.json') as json_file:
    variable_mapper_2016 = json.load(json_file)
for key, val in variable_mapper_2016.items():
    variable_mapper_2016[key] = "_" + val.replace("!!", "__")\
    .replace(" ", "_")\
    .replace("-", "_")\
    .replace("Estimate__", "")\
    .replace("years", "y")\
    .replace("_or_African_American","")\
    .replace("(", "")\
    .replace(")","")\
    .replace("HOUSING_OCCUPANCY__", "")\
    .replace("YEAR_STRUCTURE_BUILT__", "")\
    .replace("UNITS_IN_STRUCTURE__", "")\
    .replace("HOUSING_TENURE__", "")\
    .replace("YEAR_HOUSEHOLDER_MOVED_INTO_UNIT__", "")\
    .replace("VEHICLES_AVAILABLE__", "")\
    .replace("MORTGAGE_STATUS__", "")\
    .replace("SELECTED_MONTHLY_OWNER_COSTS_", "")\
    .replace("AS_A_PERCENTAGE_OF_HOUSEHOLD_INCOME_", "")\
    .replace("GROSS_RENT_AS_A_PERCENTAGE_OF_HOUSEHOLD_INCOME_", "")\
    .replace("_excluding_units_where_SMOCAPI_cannot_be_computed", "")\
    .replace("_excluding_units_where_GRAPI_cannot_be_computed", "")\
    .replace("GROSS_RENT_GRAPI__", "")\
    .replace("EMPLOYMENT_STATUS__", "")\
    .replace("and_over", "up")\
    .replace("labor_force", "work")\
    .replace("OCCUPATION__", "")\
    .replace("INDUSTRY__", "")\
    .replace(",", "")\
    .replace(".0", "")\
    .replace(".", "")



def acs_2021_census_tract(key, num, state_):
    # range: 5 year
    # year: 2021
    # type: # Data profile
    variable = f"{key}_{str(num).zfill(4)}E"
    try:
        res = requests.get(f'https://api.census.gov/data/2021/acs/acs5/profile?get=NAME,{variable}&for=tract:*&in=state:{state_}&in=county:*&key={ACS_API_KEY}')
    except:
        print("Error")
        raise
    json_list = res.json()
    if len(variable_mapper[variable]) > 62:
        column_name = variable
    else:
        column_name = variable_mapper[variable]
    df = pd.DataFrame(json_list[1:], columns = ["Name", column_name, "state", "county", "tract"])
    df[column_name] = df[column_name].astype(float)
    df = df.replace(-666666666, 0)
    return df, key

    combined_df.to_csv(f"./data/acs_5_{key}_census_tract_state_{state_}_2021.csv", index=False)
    combined_df = None


def acs_2016_census_tract(key, num, state_):
    # range: 5 year
    # year: 2016
    # type: # Data profile
    variable = f"{key}_{str(num).zfill(4)}E"
    try:
        res = requests.get(f'https://api.census.gov/data/2016/acs/acs5/profile?get=NAME,{variable}&for=tract:*&in=state:{state_}&in=county:*&key={ACS_API_KEY}')
    except:
        print("Error")
        raise
    json_list = res.json()
    if len(variable_mapper_2016[variable]) > 62:
        column_name = variable
    else:
        column_name = variable_mapper_2016[variable]
    df = pd.DataFrame(json_list[1:], columns = ["Name", column_name, "state", "county", "tract"])
    df[column_name] = df[column_name].astype(float)
    df = df.replace(-666666666, 0)
    return df, key


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("-t", "--threads", type=int, default=10)
    parser.add_argument("-r", "--requests", type=int, default=10)
    args = parser.parse_args()
    logger.setLevel(logging.WARNING)
    pool = ThreadPoolExecutor(max_workers=args.threads)
    state = '05'
    acs_2016_census_tract_dict = {
        "DP05": [1, 4, 5, 6, 7, 8, 9, 10,11,12,13,14,15,16,17,31,32,33,39,52,65,66],
        "DP04": [num for num in range(1,144) if num not in range(62,80)],
        "DP03": [num for num in range(1, 138) if num not in range(8,14)],
        "DP02": [num for num in range(1,103) if num not in range(68,78)]
    }
    acs_2021_census_tract_dict = {
        "DP05": [1, 5, 6, 7, 8, 9, 10,11,12,13,14,15,16,17,18,33,36,37,38,44,57, 70],
        "DP04": [num for num in range(1,144) if num not in range(62,80)],
        "DP03": [num for num in range(1, 138) if num not in range(8,14)],
        "DP02": [num for num in range(1,105) if num not in range(69,79)]
    }
    start = time.time()
    futures = []
    df_dict = {}
    year = "2021"
    result = {
        "2016": {
            "dict": acs_2016_census_tract_dict,
            "func": acs_2016_census_tract
        },
        "2021": {
            "dict": acs_2021_census_tract_dict,
            "func": acs_2021_census_tract
        }
    }

    for k, v in result[year]["dict"].items():
        for num in v:
            futures.append(
                pool.submit(
                    result[year]["func"],
                    key = k,
                    num = num,
                    state_ = state
                )
            )
    for future in as_completed(futures):
        df, key = future.result()
        if key not in df_dict:
            df_dict[key] = df.copy()
        else:
            df = df.drop(columns="Name")
            df_dict[key] = df_dict[key].merge(df, how='left', on=["state", "county", "tract"])
            df_dict[key].to_csv(f"./data/acs_5_{key}_census_tract_state_{state}_{year}.csv", index=False)
        # print(key)
sys.exit(main())
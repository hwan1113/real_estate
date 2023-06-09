-- Population
-- select A.Name, A.state, A.city, A._2013_SEX_AND_AGE__Total_population, A._2014_SEX_AND_AGE__Total_population, A._2015_SEX_AND_AGE__Total_population, A._2016_SEX_AND_AGE__Total_population,
-- B._2017_SEX_AND_AGE__Total_population, B._2018_SEX_AND_AGE__Total_population, B._2019_SEX_AND_AGE__Total_population, B._2021_SEX_AND_AGE__Total_population 
-- from acs_1_demographic_city_2016 A
-- join acs_1_demographic_city_2021 B on A.name = B.name
-- order by A.name asc

-- select A.Name, A.state, A.city, A._2013_SEX_AND_AGE__Total_population, A._2014_SEX_AND_AGE__Total_population, A._2015_SEX_AND_AGE__Total_population, A._2016_SEX_AND_AGE__Total_population,
-- B._2017_SEX_AND_AGE__Total_population, B._2018_SEX_AND_AGE__Total_population, B._2019_SEX_AND_AGE__Total_population, B._2021_SEX_AND_AGE__Total_population
-- from acs_1_demographic_city_2016 A
-- join acs_1_demographic_city_2021 B on A.name = B.name
-- where A._2013_SEX_AND_AGE__Total_population != 0 or A._2014_SEX_AND_AGE__Total_population != 0
-- order by A.name asc

-- Final
-- select C.*, 
-- round(CAST((((C._2014_SEX_AND_AGE__Total_population - C._2013_SEX_AND_AGE__Total_population)/C._2013_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2013_2014,
-- round(CAST((((C._2015_SEX_AND_AGE__Total_population - C._2014_SEX_AND_AGE__Total_population)/C._2014_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2014_2015,
-- round(CAST((((C._2016_SEX_AND_AGE__Total_population - C._2015_SEX_AND_AGE__Total_population)/C._2015_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2015_2016,
-- round(CAST((((C._2017_SEX_AND_AGE__Total_population - C._2016_SEX_AND_AGE__Total_population)/C._2016_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2016_2017,
-- round(CAST((((C._2018_SEX_AND_AGE__Total_population - C._2017_SEX_AND_AGE__Total_population)/C._2017_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2017_2018,
-- round(CAST((((C._2019_SEX_AND_AGE__Total_population - C._2018_SEX_AND_AGE__Total_population)/C._2018_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2018_2019,
-- round(CAST((((C._2021_SEX_AND_AGE__Total_population - C._2019_SEX_AND_AGE__Total_population)/C._2019_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2019_2021
-- from (
-- select A.Name, A.state, A.city, A._2013_SEX_AND_AGE__Total_population, A._2014_SEX_AND_AGE__Total_population, A._2015_SEX_AND_AGE__Total_population, A._2016_SEX_AND_AGE__Total_population,
-- B._2017_SEX_AND_AGE__Total_population, B._2018_SEX_AND_AGE__Total_population, B._2019_SEX_AND_AGE__Total_population, B._2021_SEX_AND_AGE__Total_population
-- from acs_1_demographic_city_2016 A
-- join acs_1_demographic_city_2021 B on A.name = B.name
-- where A._2013_SEX_AND_AGE__Total_population != 0 and A._2014_SEX_AND_AGE__Total_population != 0
-- ) C 
-- order by _2019_2021 desc

-- CREATE OR REPLACE view population_city_check as (
-- select D.*, CASE WHEN (D._2019_2021 > 0 and D._2018_2019 > 0 and D._2017_2018 > 0 and D._2016_2017 > 0 and D._2015_2016 > 0 and D._2014_2015 > 0) 
-- THEN 'o' ELSE 'x' END check from 
-- (select C.*, 
-- round(CAST((((C._2014_SEX_AND_AGE__Total_population - C._2013_SEX_AND_AGE__Total_population)/C._2013_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2013_2014,
-- round(CAST((((C._2015_SEX_AND_AGE__Total_population - C._2014_SEX_AND_AGE__Total_population)/C._2014_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2014_2015,
-- round(CAST((((C._2016_SEX_AND_AGE__Total_population - C._2015_SEX_AND_AGE__Total_population)/C._2015_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2015_2016,
-- round(CAST((((C._2017_SEX_AND_AGE__Total_population - C._2016_SEX_AND_AGE__Total_population)/C._2016_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2016_2017,
-- round(CAST((((C._2018_SEX_AND_AGE__Total_population - C._2017_SEX_AND_AGE__Total_population)/C._2017_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2017_2018,
-- round(CAST((((C._2019_SEX_AND_AGE__Total_population - C._2018_SEX_AND_AGE__Total_population)/C._2018_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2018_2019,
-- round(CAST((((C._2021_SEX_AND_AGE__Total_population - C._2019_SEX_AND_AGE__Total_population)/C._2019_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2019_2021
-- from (
-- select A.Name, A.state, A.city, A._2013_SEX_AND_AGE__Total_population, A._2014_SEX_AND_AGE__Total_population, A._2015_SEX_AND_AGE__Total_population, A._2016_SEX_AND_AGE__Total_population,
-- B._2017_SEX_AND_AGE__Total_population, B._2018_SEX_AND_AGE__Total_population, B._2019_SEX_AND_AGE__Total_population, B._2021_SEX_AND_AGE__Total_population
-- from acs_1_demographic_city_2016 A
-- join acs_1_demographic_city_2021 B on A.name = B.name
-- where A._2013_SEX_AND_AGE__Total_population != 0 and A._2014_SEX_AND_AGE__Total_population != 0
-- ) C order by _2019_2021 desc) D)

-- select A.Name, A._2013_SEX_AND_AGE__Total_population, A._2014_SEX_AND_AGE__Total_population, A._2015_SEX_AND_AGE__Total_population, A._2016_SEX_AND_AGE__Total_population,
-- B._2017_SEX_AND_AGE__Total_population, B._2018_SEX_AND_AGE__Total_population, B._2019_SEX_AND_AGE__Total_population, B._2021_SEX_AND_AGE__Total_population 
-- from acs_1_demographic_metro_politan_2016 A
-- join acs_1_demographic_metro_politan_2021 B on A.name = B.name
-- order by A.name asc

-- select A.Name, A._2013_SEX_AND_AGE__Total_population, A._2014_SEX_AND_AGE__Total_population, A._2015_SEX_AND_AGE__Total_population, A._2016_SEX_AND_AGE__Total_population,
-- B._2017_SEX_AND_AGE__Total_population, B._2018_SEX_AND_AGE__Total_population, B._2019_SEX_AND_AGE__Total_population, B._2021_SEX_AND_AGE__Total_population
-- from acs_1_demographic_metro_politan_2016 A
-- join acs_1_demographic_metro_politan_2021 B on A.name = B.name
-- order by A.name asc

-- Final
-- select C.*, 
-- round(CAST((((C._2014_SEX_AND_AGE__Total_population - C._2013_SEX_AND_AGE__Total_population)/C._2013_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2013_2014,
-- round(CAST((((C._2015_SEX_AND_AGE__Total_population - C._2014_SEX_AND_AGE__Total_population)/C._2014_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2014_2015,
-- round(CAST((((C._2016_SEX_AND_AGE__Total_population - C._2015_SEX_AND_AGE__Total_population)/C._2015_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2015_2016,
-- round(CAST((((C._2017_SEX_AND_AGE__Total_population - C._2016_SEX_AND_AGE__Total_population)/C._2016_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2016_2017,
-- round(CAST((((C._2018_SEX_AND_AGE__Total_population - C._2017_SEX_AND_AGE__Total_population)/C._2017_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2017_2018,
-- round(CAST((((C._2019_SEX_AND_AGE__Total_population - C._2018_SEX_AND_AGE__Total_population)/C._2018_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2018_2019,
-- round(CAST((((C._2021_SEX_AND_AGE__Total_population - C._2019_SEX_AND_AGE__Total_population)/C._2019_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2019_2021
-- from (
-- select A.Name, A._2013_SEX_AND_AGE__Total_population, A._2014_SEX_AND_AGE__Total_population, A._2015_SEX_AND_AGE__Total_population, A._2016_SEX_AND_AGE__Total_population,
-- B._2017_SEX_AND_AGE__Total_population, B._2018_SEX_AND_AGE__Total_population, B._2019_SEX_AND_AGE__Total_population, B._2021_SEX_AND_AGE__Total_population
-- from acs_1_demographic_metro_politan_2016 A
-- join acs_1_demographic_metro_politan_2021 B on A.name = B.name
-- ) C 
-- order by _2019_2021 desc

-- CREATE OR REPLACE view population_metro_politan_check as (
-- select D.*, CASE WHEN (D._2019_2021 > 0 and D._2018_2019 > 0 and D._2017_2018 > 0 and D._2016_2017 > 0 and D._2015_2016 > 0 and D._2014_2015 > 0) 
-- THEN 'o' ELSE 'x' END check from 
-- (select C.*, 
-- round(CAST((((C._2014_SEX_AND_AGE__Total_population - C._2013_SEX_AND_AGE__Total_population)/C._2013_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2013_2014,
-- round(CAST((((C._2015_SEX_AND_AGE__Total_population - C._2014_SEX_AND_AGE__Total_population)/C._2014_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2014_2015,
-- round(CAST((((C._2016_SEX_AND_AGE__Total_population - C._2015_SEX_AND_AGE__Total_population)/C._2015_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2015_2016,
-- round(CAST((((C._2017_SEX_AND_AGE__Total_population - C._2016_SEX_AND_AGE__Total_population)/C._2016_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2016_2017,
-- round(CAST((((C._2018_SEX_AND_AGE__Total_population - C._2017_SEX_AND_AGE__Total_population)/C._2017_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2017_2018,
-- round(CAST((((C._2019_SEX_AND_AGE__Total_population - C._2018_SEX_AND_AGE__Total_population)/C._2018_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2018_2019,
-- round(CAST((((C._2021_SEX_AND_AGE__Total_population - C._2019_SEX_AND_AGE__Total_population)/C._2019_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2019_2021
-- from (
-- select A.Name, A._2013_SEX_AND_AGE__Total_population, A._2014_SEX_AND_AGE__Total_population, A._2015_SEX_AND_AGE__Total_population, A._2016_SEX_AND_AGE__Total_population,
-- B._2017_SEX_AND_AGE__Total_population, B._2018_SEX_AND_AGE__Total_population, B._2019_SEX_AND_AGE__Total_population, B._2021_SEX_AND_AGE__Total_population
-- from acs_1_demographic_metro_politan_2016 A
-- join acs_1_demographic_metro_politan_2021 B on A.name = B.name
-- where A._2013_SEX_AND_AGE__Total_population != 0 and A._2014_SEX_AND_AGE__Total_population != 0
-- ) C order by _2019_2021 desc) D)



-- rent_per_housing_price
-- select A.Name, A._2013_SEX_AND_AGE__Total_population, A._2014_SEX_AND_AGE__Total_population, A._2015_SEX_AND_AGE__Total_population, A._2016_SEX_AND_AGE__Total_population,
-- B._2017_SEX_AND_AGE__Total_population, B._2018_SEX_AND_AGE__Total_population, B._2019_SEX_AND_AGE__Total_population, B._2021_SEX_AND_AGE__Total_population
-- from acs_1_housing_city_2016 A
-- join acs_1_demographic_city_2021 B on A.name = B.name
-- select _2013_value__owner_occupied_units__median_dollars from acs_1_housing_city_2016

-- final
-- select A.Name, A.state, A.city, 
-- round(cast((E._2013_GROSS_RENT__Occupied_units_paying_rent__Median_dollars/A._2013_VALUE__Owner_occupied_units__Median_dollars)*1200 as numeric), 4) _2013_value,
-- round(cast((E._2014_GROSS_RENT__Occupied_units_paying_rent__Median_dollars/A._2014_VALUE__Owner_occupied_units__Median_dollars)*1200 as numeric), 4) _2014_value,
-- round(cast((E._2015_GROSS_RENT__Occupied_units_paying_rent__Median_dollars/A._2015_VALUE__Owner_occupied_units__Median_dollars)*1200 as numeric), 4) _2015_value,
-- round(cast((E._2016_GROSS_RENT__Occupied_units_paying_rent__Median_dollars/A._2016_VALUE__Owner_occupied_units__Median_dollars)*1200 as numeric), 4) _2016_value,
-- round(cast((E._2017_GROSS_RENT__Occupied_units_paying_rent__Median_dollars/B._2017_VALUE__Owner_occupied_units__Median_dollars)*1200 as numeric), 4) _2017_value,
-- round(cast((E._2018_GROSS_RENT__Occupied_units_paying_rent__Median_dollars/B._2018_VALUE__Owner_occupied_units__Median_dollars)*1200 as numeric), 4) _2018_value,
-- round(cast((E._2019_GROSS_RENT__Occupied_units_paying_rent__Median_dollars/B._2019_VALUE__Owner_occupied_units__Median_dollars)*1200 as numeric), 4) _2019_value,
-- round(cast((E._2021_GROSS_RENT__Occupied_units_paying_rent__Median_dollars/B._2021_VALUE__Owner_occupied_units__Median_dollars)*1200 as numeric), 4) _2021_value
-- from acs_1_housing_city_2016 A
-- join acs_1_housing_city_2021 B on A.name = B.name
-- join (select C.Name, C.state, C.city, C._2013_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
-- C._2014_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
-- C._2015_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
-- C._2016_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
-- D._2017_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
-- D._2018_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
-- D._2019_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
-- D._2021_GROSS_RENT__Occupied_units_paying_rent__Median_dollars
-- from acs_1_housing_city_2016 C
-- join acs_1_housing_city_2021 D on C.name = D.name) E
-- on A.name = E.name
-- where A._2013_VALUE__Owner_occupied_units__Median_dollars != 0


-- CREATE OR REPLACE view rent_per_housing_price_ratio as (
-- select A.Name, A.state, A.city, 
-- round(cast((E._2013_GROSS_RENT__Occupied_units_paying_rent__Median_dollars/A._2013_VALUE__Owner_occupied_units__Median_dollars)*1200 as numeric), 4) _2013_value,
-- round(cast((E._2014_GROSS_RENT__Occupied_units_paying_rent__Median_dollars/A._2014_VALUE__Owner_occupied_units__Median_dollars)*1200 as numeric), 4) _2014_value,
-- round(cast((E._2015_GROSS_RENT__Occupied_units_paying_rent__Median_dollars/A._2015_VALUE__Owner_occupied_units__Median_dollars)*1200 as numeric), 4) _2015_value,
-- round(cast((E._2016_GROSS_RENT__Occupied_units_paying_rent__Median_dollars/A._2016_VALUE__Owner_occupied_units__Median_dollars)*1200 as numeric), 4) _2016_value,
-- round(cast((E._2017_GROSS_RENT__Occupied_units_paying_rent__Median_dollars/B._2017_VALUE__Owner_occupied_units__Median_dollars)*1200 as numeric), 4) _2017_value,
-- round(cast((E._2018_GROSS_RENT__Occupied_units_paying_rent__Median_dollars/B._2018_VALUE__Owner_occupied_units__Median_dollars)*1200 as numeric), 4) _2018_value,
-- round(cast((E._2019_GROSS_RENT__Occupied_units_paying_rent__Median_dollars/B._2019_VALUE__Owner_occupied_units__Median_dollars)*1200 as numeric), 4) _2019_value,
-- round(cast((E._2021_GROSS_RENT__Occupied_units_paying_rent__Median_dollars/B._2021_VALUE__Owner_occupied_units__Median_dollars)*1200 as numeric), 4) _2021_value
-- from acs_1_housing_city_2016 A
-- join acs_1_housing_city_2021 B on A.name = B.name
-- join (select C.Name, C.state, C.city, C._2013_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
-- C._2014_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
-- C._2015_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
-- C._2016_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
-- D._2017_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
-- D._2018_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
-- D._2019_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
-- D._2021_GROSS_RENT__Occupied_units_paying_rent__Median_dollars
-- from acs_1_housing_city_2016 C
-- join acs_1_housing_city_2021 D on C.name = D.name) E
-- on A.name = E.name
-- where A._2013_VALUE__Owner_occupied_units__Median_dollars != 0
-- )

--income
-- select A.Name, A.state, A.city, round(A.CP03_2013_062E *1.15) as _2013_median_household_income_adj, round(A.CP03_2014_062E *1.15) _2014_median_household_income_adj, round(A.CP03_2015_062E *1.15) _2015_median_household_income_adj, 
-- round(A.CP03_2016_062E*1.15) _2016_median_household_income_adj, B.CP03_2017_062E _2017_median_household_income_adj, B.CP03_2018_062E _2018_median_household_income_adj, 
-- B.CP03_2019_062E _2019_median_household_income_adj, B.CP03_2021_062E _2021_median_household_income_adj
-- from acs_1_economic_city_2016 A
-- join acs_1_economic_city_2021 B on A.name = B.name

-- final
--select A.name, A.state, A.county, A.tract, B.dp03_0062e as median_household_income_2016, A.dp03_0062e as median_household_income_2021, 
--round(CAST((((A.dp03_0062e - B.dp03_0062e )/B.dp03_0062e )*100) as numeric), 4) as price_increase
--from acs_5_economic_census_tract_fl_2021 A
--join acs_5_economic_census_tract_fl_2016 B
--on A.name = B.name
--where A.county = '031' and B.dp03_0062e != 0


-- Housing units
-- select A.Name, A.state, A.city, A._2013_Total_housing_units_x, A._2014_Total_housing_units_x, A._2015_Total_housing_units_x, A._2016_Total_housing_units_x,
-- B._2017_Total_housing_units_x, B._2018_Total_housing_units_x, B._2019_Total_housing_units_x, B._2021_Total_housing_units_x
-- from acs_1_housing_city_2016 A
-- join acs_1_housing_city_2021 B on A.name = B.name

-- select A.Name, A.state, A.city, A._2013_Total_housing_units_x, A._2014_Total_housing_units_x, A._2015_Total_housing_units_x, A._2016_Total_housing_units_x,
-- B._2017_Total_housing_units_x, B._2018_Total_housing_units_x, B._2019_Total_housing_units_x, B._2021_Total_housing_units_x
-- from acs_1_housing_city_2016 A
-- join acs_1_housing_city_2021 B on A.name = B.name
-- where A._2013_Total_housing_units_x != 0

-- final
--select C.*,
--round(CAST((((C._2014_Total_housing_units_x - C._2013_Total_housing_units_x)/C._2013_Total_housing_units_x)*100) as numeric), 4) as _2013_2014,
-- round(CAST((((C._2015_Total_housing_units_x - C._2014_Total_housing_units_x)/C._2014_Total_housing_units_x)*100) as numeric), 4) as _2014_2015,
-- round(CAST((((C._2016_Total_housing_units_x - C._2015_Total_housing_units_x)/C._2015_Total_housing_units_x)*100) as numeric), 4) as _2015_2016,
-- round(CAST((((C._2017_Total_housing_units_x - C._2016_Total_housing_units_x)/C._2016_Total_housing_units_x)*100) as numeric), 4) as _2016_2017,
-- round(CAST((((C._2018_Total_housing_units_x - C._2017_Total_housing_units_x)/C._2017_Total_housing_units_x)*100) as numeric), 4) as _2017_2018,
-- round(CAST((((C._2019_Total_housing_units_x - C._2018_Total_housing_units_x)/C._2018_Total_housing_units_x)*100) as numeric), 4) as _2018_2019,
-- round(CAST((((C._2021_Total_housing_units_x - C._2019_Total_housing_units_x)/C._2019_Total_housing_units_x)*100) as numeric), 4) as _2019_2021
--from (
-- select A.Name, A.state, A.city, A._2013_Total_housing_units_x, A._2014_Total_housing_units_x, A._2015_Total_housing_units_x, A._2016_Total_housing_units_x,
-- B._2017_Total_housing_units_x, B._2018_Total_housing_units_x, B._2019_Total_housing_units_x, B._2021_Total_housing_units_x
-- from acs_1_housing_city_2016 A
-- join acs_1_housing_city_2021 B on A.name = B.name
-- where A._2013_Total_housing_units_x != 0
--) C
 
-- census_tract
--select A.name, A.state, A.county, A.tract, A."_total_housing_units_x" as total_housing_unit_2016, B."_total_housing_units_x" as total_housing_unit_2021 from 
--acs_5_housing_census_tract_fl_2016 A join acs_5_housing_census_tract_fl_2021 B
--on A.name = B.name


-- Racial
-- final
--select * from (
-- select A.Name, A.state, A.city, 'white' as race, A._2013_RACE__One_race__White as _2013, A._2014_RACE__One_race__White _2014, 
-- A._2015_RACE__One_race__White _2015, A._2016_RACE__One_race__White _2016, B._2017_RACE__Total_population__One_race__White _2017,
-- B._2018_RACE__Total_population__One_race__White _2018, B._2019_RACE__Total_population__One_race__White _2019,
-- B._2021_RACE__Total_population__One_race__White _2021
-- from acs_1_demographic_city_2016 A
-- join acs_1_demographic_city_2021 B on A.name = B.name
-- union
-- select A.Name, A.state, A.city, 'black' as race, A._2013_RACE__One_race__Black as _2013, A._2014_RACE__One_race__Black _2014, 
-- A._2015_RACE__One_race__Black _2015, A._2016_RACE__One_race__Black _2016, B._2017_RACE__Total_population__One_race__Black _2017,
-- B._2018_RACE__Total_population__One_race__Black _2018, B._2019_RACE__Total_population__One_race__Black _2019,
-- B._2021_RACE__Total_population__One_race__Black _2021
-- from acs_1_demographic_city_2016 A
-- join acs_1_demographic_city_2021 B on A.name = B.name
-- union
-- select A.Name, A.state, A.city, 'asian' as race, A._2013_RACE__One_race__Asian as _2013, A._2014_RACE__One_race__Asian _2014, 
-- A._2015_RACE__One_race__Asian _2015, A._2016_RACE__One_race__Asian _2016, B._2017_RACE__Total_population__One_race__Asian _2017,
-- B._2018_RACE__Total_population__One_race__Asian _2018, B._2019_RACE__Total_population__One_race__Asian _2019,
-- B._2021_RACE__Total_population__One_race__Asian _2021
-- from acs_1_demographic_city_2016 A
-- join acs_1_demographic_city_2021 B on A.name = B.name
-- union
-- select A.Name, A.state, A.city, 'others' as race, A._2013_RACE__One_race__Some_other_race as _2013, A._2014_RACE__One_race__Some_other_race _2014, 
-- A._2015_RACE__One_race__Some_other_race _2015, A._2016_RACE__One_race__Some_other_race _2016, 
-- B._2017_RACE__Total_population__One_race__Some_other_race _2017,
-- B._2018_RACE__Total_population__One_race__Some_other_race _2018, B._2019_RACE__Total_population__One_race__Some_other_race _2019,
-- B._2021_RACE__Total_population__One_race__Some_other_race _2021
-- from acs_1_demographic_city_2016 A
-- join acs_1_demographic_city_2021 B on A.name = B.name
-- ) C
--order by C.name, C.race

--census_tract
--select * from (
-- select A.Name, A.state, A.county, A.tract, 'white' as race, A."_race__one_race__white"  as _2016, B."_race__total_population__one_race__white" as _2021
-- from acs_5_demographic_census_tract_fl_2016 A
-- join acs_5_demographic_census_tract_fl_2021 B on A.name = B.name
-- union
-- select A.Name, A.state, A.county, A.tract, 'black' as race, A."_race__one_race__black"  as _2016, B."_race__total_population__one_race__black" as _2021
-- from acs_5_demographic_census_tract_fl_2016 A
-- join acs_5_demographic_census_tract_fl_2021 B on A.name = B.name
-- union
--  select A.Name, A.state, A.county, A.tract, 'asian' as race, A."_race__one_race__asian"  as _2016, B."_race__total_population__one_race__asian" as _2021
-- from acs_5_demographic_census_tract_fl_2016 A
-- join acs_5_demographic_census_tract_fl_2021 B on A.name = B.name
-- union
-- select A.Name, A.state, A.county, A.tract, 'others' as race, A."_race__one_race__some_other_race" as _2016, B."_race__total_population__one_race__some_other_race" as _2021
-- from acs_5_demographic_census_tract_fl_2016 A
-- join acs_5_demographic_census_tract_fl_2021 B on A.name = B.name
-- ) C
-- order by C.name, C.race
 

-- age
 select A.Name, A.state, A.city, A._2013_SEX_AND_AGE__Median_age_y, A._2014_SEX_AND_AGE__Median_age_y, A._2015_SEX_AND_AGE__Median_age_y, A._2016_SEX_AND_AGE__Median_age_y,
 B._2017_sex_and_age__total_population__median_age_, B._2018_sex_and_age__total_population__median_age_, B._2019_sex_and_age__total_population__median_age_,
 B._2021_sex_and_age__total_population__median_age_
 from acs_1_demographic_city_2016 A
 join acs_1_demographic_city_2021 B on A.name = B.name
 
 select A.name, A.state, A.county, A.tract, A."_sex_and_age__median_age_y", B."_sex_and_age__total_population__median_age_y"
 from acs_5_demographic_census_tract_fl_2016 A
 join acs_5_demographic_census_tract_fl_2021 B on A.name = B.name
 
 select A.name, A.state, A.county, A.tract, 
 round(CAST((((A."_sex_and_age__20_to_24_y" + A."_sex_and_age__25_to_34_y" + A."_sex_and_age__35_to_44_y") / A."_sex_and_age__total_population")*100) as numeric),2) as young_ratio_2016,
 round(CAST((((B."_sex_and_age__total_population__20_to_24_y" + B."_sex_and_age__total_population__25_to_34_y" + B."_sex_and_age__total_population__35_to_44_y") / B."_sex_and_age__total_population")*100) as numeric),2) as young_ratio_2021
 from acs_5_demographic_census_tract_fl_2016 A
 join acs_5_demographic_census_tract_fl_2021 B on A.name = B.name
 where A._sex_and_age__total_population != 0


-- vacancy rate
-- select A.Name, A.state, A.city, 'housing vacancy' as vacancy_type, A._2013_Homeowner_vacancy_rate as _2013_Rental_vacancy_rate,
-- A._2014_Homeowner_vacancy_rate as _2014_Rental_vacancy_rate,
-- A._2015_Homeowner_vacancy_rate as _2015_Rental_vacancy_rate,
-- A._2016_Homeowner_vacancy_rate as _2016_Rental_vacancy_rate,
-- B._2017_Total_housing_units__Homeowner_vacancy_rate,
-- B._2018_Total_housing_units__Homeowner_vacancy_rate, B._2019_Total_housing_units__Homeowner_vacancy_rate,
-- B._2021_Total_housing_units__Homeowner_vacancy_rate
-- from acs_1_housing_city_2016 A
-- join acs_1_housing_city_2021 B on A.name = B.name
-- union
-- select A.Name, A.state, A.city, 'rental vacancy' as vacancy_type, A._2013_Rental_vacancy_rate, A._2014_Rental_vacancy_rate, 
-- A._2015_Rental_vacancy_rate, A._2016_Rental_vacancy_rate,
-- B._2017_Total_housing_units__Rental_vacancy_rate,
-- B._2018_Total_housing_units__Rental_vacancy_rate, B._2019_Total_housing_units__Rental_vacancy_rate,
-- B._2021_Total_housing_units__Rental_vacancy_rate
-- from acs_1_housing_city_2016 A
-- join acs_1_housing_city_2021 B on A.name = B.name

 
 
-- renter-occupied
-- select A.Name, A.state, A.city, A._2013_Occupied_housing_units__Renter_occupied,
-- A._2014_Occupied_housing_units__Renter_occupied,
-- A._2015_Occupied_housing_units__Renter_occupied,
-- A._2016_Occupied_housing_units__Renter_occupied,
-- B._2017_Occupied_housing_units__Renter_occupied,
-- B._2018_Occupied_housing_units__Renter_occupied, B._2019_Occupied_housing_units__Renter_occupied,
-- B._2021_Occupied_housing_units__Renter_occupied
-- from acs_1_housing_city_2016 A
-- join acs_1_housing_city_2021 B on A.name = B.name

-- Moving trend
-- select A.Name, A.state, A.city, A._2021_Occupied_housing_units__Moved_in_2019_or_later
-- from acs_1_housing_city_2021 A

-- Housing price detail
-- select A.Name, A.state, A.city, 'less_than_50,000' as price_range, A._2013_VALUE__Owner_occupied_units__Less_than_$50000 as _2013_price,
-- A._2014_VALUE__Owner_occupied_units__Less_than_$50000 as _2014_price,
-- A._2015_VALUE__Owner_occupied_units__Less_than_$50000 as _2015_price,
-- A._2016_VALUE__Owner_occupied_units__Less_than_$50000 as _2016_price,
-- B._2017_VALUE__Owner_occupied_units__Less_than_$50000 as _2017_price,
-- B._2018_VALUE__Owner_occupied_units__Less_than_$50000 as _2018_price,
-- B._2019_VALUE__Owner_occupied_units__Less_than_$50000 as _2019_price,
-- B._2021_VALUE__Owner_occupied_units__Less_than_$50000 as _2021_price
-- from acs_1_housing_city_2016 A
-- join acs_1_housing_city_2021 B on A.name = B.name
-- union
-- select A.Name, A.state, A.city, '50,000_to_99,999' as price_range, 
-- A._2013_VALUE__Owner_occupied_units__$50000_to_$99999 as _2013_price,
-- A._2014_VALUE__Owner_occupied_units__$50000_to_$99999 as _2014_price,
-- A._2015_VALUE__Owner_occupied_units__$50000_to_$99999 as _2015_price,
-- A._2016_VALUE__Owner_occupied_units__$50000_to_$99999 as _2016_price,
-- B._2017_VALUE__Owner_occupied_units__$50000_to_$99999 as _2017_price,
-- B._2018_VALUE__Owner_occupied_units__$50000_to_$99999 as _2018_price,
-- B._2019_VALUE__Owner_occupied_units__$50000_to_$99999 as _2019_price,
-- B._2021_VALUE__Owner_occupied_units__$50000_to_$99999 as _2021_price
-- from acs_1_housing_city_2016 A
-- join acs_1_housing_city_2021 B on A.name = B.name
-- union
-- select A.Name, A.state, A.city, '100,000_to_149,999' as price_range, 
-- A._2013_VALUE__Owner_occupied_units__$100000_to_$149999 as _2013_price,
-- A._2014_VALUE__Owner_occupied_units__$100000_to_$149999 as _2014_price,
-- A._2015_VALUE__Owner_occupied_units__$100000_to_$149999 as _2015_price,
-- A._2016_VALUE__Owner_occupied_units__$100000_to_$149999 as _2016_price,
-- B._2017_VALUE__Owner_occupied_units__$100000_to_$149999 as _2017_price,
-- B._2018_VALUE__Owner_occupied_units__$100000_to_$149999 as _2018_price,
-- B._2019_VALUE__Owner_occupied_units__$100000_to_$149999 as _2019_price,
-- B._2021_VALUE__Owner_occupied_units__$100000_to_$149999 as _2021_price
-- from acs_1_housing_city_2016 A
-- join acs_1_housing_city_2021 B on A.name = B.name
-- union
-- select A.Name, A.state, A.city, '150,000_to_199,999' as price_range, 
-- A._2013_VALUE__Owner_occupied_units__$150000_to_$199999 as _2013_price,
-- A._2014_VALUE__Owner_occupied_units__$150000_to_$199999 as _2014_price,
-- A._2015_VALUE__Owner_occupied_units__$150000_to_$199999 as _2015_price,
-- A._2016_VALUE__Owner_occupied_units__$150000_to_$199999 as _2016_price,
-- B._2017_VALUE__Owner_occupied_units__$150000_to_$199999 as _2017_price,
-- B._2018_VALUE__Owner_occupied_units__$150000_to_$199999 as _2018_price,
-- B._2019_VALUE__Owner_occupied_units__$150000_to_$199999 as _2019_price,
-- B._2021_VALUE__Owner_occupied_units__$150000_to_$199999 as _2021_price
-- from acs_1_housing_city_2016 A
-- join acs_1_housing_city_2021 B on A.name = B.name
-- union
-- select A.Name, A.state, A.city, '200,000_to_299,999' as price_range, 
-- A._2013_VALUE__Owner_occupied_units__$200000_to_$299999 as _2013_price,
-- A._2014_VALUE__Owner_occupied_units__$200000_to_$299999 as _2014_price,
-- A._2015_VALUE__Owner_occupied_units__$200000_to_$299999 as _2015_price,
-- A._2016_VALUE__Owner_occupied_units__$200000_to_$299999 as _2016_price,
-- B._2017_VALUE__Owner_occupied_units__$200000_to_$299999 as _2017_price,
-- B._2018_VALUE__Owner_occupied_units__$200000_to_$299999 as _2018_price,
-- B._2019_VALUE__Owner_occupied_units__$200000_to_$299999 as _2019_price,
-- B._2021_VALUE__Owner_occupied_units__$200000_to_$299999 as _2021_price
-- from acs_1_housing_city_2016 A
-- join acs_1_housing_city_2021 B on A.name = B.name
-- union
-- select A.Name, A.state, A.city, '300,000_to_499,999' as price_range, 
-- A._2013_VALUE__Owner_occupied_units__$300000_to_$499999 as _2013_price,
-- A._2014_VALUE__Owner_occupied_units__$300000_to_$499999 as _2014_price,
-- A._2015_VALUE__Owner_occupied_units__$300000_to_$499999 as _2015_price,
-- A._2016_VALUE__Owner_occupied_units__$300000_to_$499999 as _2016_price,
-- B._2017_VALUE__Owner_occupied_units__$300000_to_$499999 as _2017_price,
-- B._2018_VALUE__Owner_occupied_units__$300000_to_$499999 as _2018_price,
-- B._2019_VALUE__Owner_occupied_units__$300000_to_$499999 as _2019_price,
-- B._2021_VALUE__Owner_occupied_units__$300000_to_$499999 as _2021_price
-- from acs_1_housing_city_2016 A
-- join acs_1_housing_city_2021 B on A.name = B.name
-- union
-- select A.Name, A.state, A.city, '500,000_to_999,999' as price_range, 
-- A._2013_VALUE__Owner_occupied_units__$500000_to_$999999 as _2013_price,
-- A._2014_VALUE__Owner_occupied_units__$500000_to_$999999 as _2014_price,
-- A._2015_VALUE__Owner_occupied_units__$500000_to_$999999 as _2015_price,
-- A._2016_VALUE__Owner_occupied_units__$500000_to_$999999 as _2016_price,
-- B._2017_VALUE__Owner_occupied_units__$500000_to_$999999 as _2017_price,
-- B._2018_VALUE__Owner_occupied_units__$500000_to_$999999 as _2018_price,
-- B._2019_VALUE__Owner_occupied_units__$500000_to_$999999 as _2019_price,
-- B._2021_VALUE__Owner_occupied_units__$500000_to_$999999 as _2021_price
-- from acs_1_housing_city_2016 A
-- join acs_1_housing_city_2021 B on A.name = B.name
-- union
-- select A.Name, A.state, A.city, '1,000,000_and_more' as price_range, 
-- A._2013_VALUE__Owner_occupied_units__$1000000_or_more as _2013_price,
-- A._2014_VALUE__Owner_occupied_units__$1000000_or_more as _2014_price,
-- A._2015_VALUE__Owner_occupied_units__$1000000_or_more as _2015_price,
-- A._2016_VALUE__Owner_occupied_units__$1000000_or_more as _2016_price,
-- B._2017_VALUE__Owner_occupied_units__$1000000_or_more as _2017_price,
-- B._2018_VALUE__Owner_occupied_units__$1000000_or_more as _2018_price,
-- B._2019_VALUE__Owner_occupied_units__$1000000_or_more as _2019_price,
-- B._2021_VALUE__Owner_occupied_units__$1000000_or_more as _2021_price
-- from acs_1_housing_city_2016 A
-- join acs_1_housing_city_2021 B on A.name = B.name

-- Housing price detail
-- select A.Name, A.state, A.city, A._2013_VALUE__Owner_occupied_units__Median_dollars,
-- A._2014_VALUE__Owner_occupied_units__Median_dollars,
-- A._2015_VALUE__Owner_occupied_units__Median_dollars,
-- A._2016_VALUE__Owner_occupied_units__Median_dollars,
-- B._2017_VALUE__Owner_occupied_units__Median_dollars,
-- B._2018_VALUE__Owner_occupied_units__Median_dollars,
-- B._2019_VALUE__Owner_occupied_units__Median_dollars,
-- B._2021_VALUE__Owner_occupied_units__Median_dollars
-- from acs_1_housing_city_2016 A
-- join acs_1_housing_city_2021 B on A.name = B.name

-- Rent price detail
-- select A.Name, A.state, A.city, A._2013_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
-- A._2014_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
-- A._2015_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
-- A._2016_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
-- B._2017_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
-- B._2018_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
-- B._2019_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
-- B._2021_GROSS_RENT__Occupied_units_paying_rent__Median_dollars
-- from acs_1_housing_city_2016 A
-- join acs_1_housing_city_2021 B on A.name = B.name



-- combining together
 select A.name, A.state, A.city, A.check, B.metro_politan, C.check, D._2021_value, E._2021_SEX_AND_AGE__Total_population as population  from population_city_check A
 left join city_metro_politan_mapping B
 on A.name = B.city
 left join population_metro_politan_check C
 on B.metro_politan = C.name
 left join rent_per_housing_price_ratio D
 on A.name = D.name
 left join acs_1_demographic_city_2021 E
 on A.name = E.name
 order by D._2021_value desc

select * from rent_per_housing_price_ratio order by _2021_value desc





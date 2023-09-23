--##########################################################################################################################################################################
-- Duplex location, can I afford multifamily
--##########################################################################################################################################################################
-- census_tract
select A.name, A.state, A.county, A.tract, A."_total_housing_units__2_units" as duplex_2016, B."_total_housing_units__2_units" as duplex_2021  from acs_5_housing_census_tract_fl_2016 A
join acs_5_housing_census_tract_fl_2021 B
on A.name = B."name"
where A.county = '031'
order by B."_total_housing_units__2_units" desc


--########################################################################################################################################################################## 
-- Moving trend
--##########################################################################################################################################################################
-- final
 select A.Name, A.state, A.city, A._2021_Occupied_housing_units__Moved_in_2019_or_later
from acs_1_housing_city_2021 A


 
 --##########################################################################################################################################################################
-- Housing units
--##########################################################################################################################################################################

 select A.Name, A.state, A.city, A._2013_Total_housing_units_x, A._2014_Total_housing_units_x, A._2015_Total_housing_units_x, A._2016_Total_housing_units_x,
 B._2017_Total_housing_units_x, B._2018_Total_housing_units_x, B._2019_Total_housing_units_x, B._2021_Total_housing_units_x
 from acs_1_housing_city_2016 A
 join acs_1_housing_city_2021 B on A.name = B.name
 where A._2013_Total_housing_units_x != 0

-- final
select C.*,
round(CAST((((C._2014_Total_housing_units_x - C._2013_Total_housing_units_x)/C._2013_Total_housing_units_x)*100) as numeric), 4) as _2013_2014,
 round(CAST((((C._2015_Total_housing_units_x - C._2014_Total_housing_units_x)/C._2014_Total_housing_units_x)*100) as numeric), 4) as _2014_2015,
 round(CAST((((C._2016_Total_housing_units_x - C._2015_Total_housing_units_x)/C._2015_Total_housing_units_x)*100) as numeric), 4) as _2015_2016,
 round(CAST((((C._2017_Total_housing_units_x - C._2016_Total_housing_units_x)/C._2016_Total_housing_units_x)*100) as numeric), 4) as _2016_2017,
 round(CAST((((C._2018_Total_housing_units_x - C._2017_Total_housing_units_x)/C._2017_Total_housing_units_x)*100) as numeric), 4) as _2017_2018,
 round(CAST((((C._2019_Total_housing_units_x - C._2018_Total_housing_units_x)/C._2018_Total_housing_units_x)*100) as numeric), 4) as _2018_2019,
 round(CAST((((C._2021_Total_housing_units_x - C._2019_Total_housing_units_x)/C._2019_Total_housing_units_x)*100) as numeric), 4) as _2019_2021
from (
 select A.Name, A.state, A.city, A._2013_Total_housing_units_x, A._2014_Total_housing_units_x, A._2015_Total_housing_units_x, A._2016_Total_housing_units_x,
 B._2017_Total_housing_units_x, B._2018_Total_housing_units_x, B._2019_Total_housing_units_x, B._2021_Total_housing_units_x
 from acs_1_housing_city_2016 A
 join acs_1_housing_city_2021 B on A.name = B.name
 where A._2013_Total_housing_units_x != 0
) C

--########################################################################################################################################################################## 
-- Relationship between multifamily and housing price
--########################################################################################################################################################################## 

select B.name, B.state, B.county, B.tract,
round(cast((((A."_total_housing_units__2_units" + A."_total_housing_units__3_or_4_units" + A."_total_housing_units__5_to_9_units" + 
A."_total_housing_units__10_to_19_units" + 
A."_total_housing_units__20_or_more_units")/A."_total_housing_units_x")*100) as numeric), 4) as _2016_multifamily_proportion,
round(cast((((B."_total_housing_units__2_units" + B."_total_housing_units__3_or_4_units" + B."_total_housing_units__5_to_9_units" + 
B."_total_housing_units__10_to_19_units" + 
B."_total_housing_units__20_or_more_units")/B."_total_housing_units_x")*100) as numeric), 4) as _2021_multifamily_proportion,
(round(cast((((B."_total_housing_units__2_units" + B."_total_housing_units__3_or_4_units" + B."_total_housing_units__5_to_9_units" + 
B."_total_housing_units__10_to_19_units" + 
B."_total_housing_units__20_or_more_units")/B."_total_housing_units_x")*100) as numeric), 4) - 
round(cast((((A."_total_housing_units__2_units" + A."_total_housing_units__3_or_4_units" + A."_total_housing_units__5_to_9_units" + 
A."_total_housing_units__10_to_19_units" + 
A."_total_housing_units__20_or_more_units")/A."_total_housing_units_x")*100) as numeric), 4)) as multifamily_proportion_change_2016_2021,
C.housing_price_change
from acs_5_housing_census_tract_tx_2016  A
join acs_5_housing_census_tract_tx_2021 B on A.name = B.name
join rent_vacancy_census_tract_tx_viz C on B.name = C.name


select B.name, B.state, B.county, B.tract, (B."_total_housing_units__20_or_more_units" - 
A."_total_housing_units__20_or_more_units") as multifamily_proportion_change_2016_2021,
C.housing_price_change
from acs_5_housing_census_tract_tx_2016  A
join acs_5_housing_census_tract_tx_2021 B on A.name = B.name
join rent_vacancy_census_tract_tx_viz C on B.name = C.name



select * from rent_vacancy_census_tract_tx_viz




select avg("_2013_rent_per_price"), avg("_2014_rent_per_price"), avg("_2015_rent_per_price"),
avg("_2016_rent_per_price"), avg("_2017_rent_per_price"), avg("_2018_rent_per_price"), avg("_2019_rent_per_price"),
avg("_2021_rent_per_price")
from rent_per_housing_price_metro_politan_check


select * from rent_per_housing_price_city_check
where name in (select distinct name from acs_1_demographic_city_2021
where "_2021_sex_and_age__total_population" > 500000)
order by "_2021_rent_per_price" 


--Average Household income of top cities.
select 
  B.name, 
  B.state, 
  B.city, 
  A.cp03_2013_062e as median_household_income_2013, 
  A.cp03_2014_062e as median_household_income_2014, 
  A.cp03_2015_062e as median_household_income_2015, 
  A.cp03_2016_062e as median_household_income_2016, 
  B.cp03_2017_062e as median_household_income_2017, 
  B.cp03_2018_062e as median_household_income_2018, 
  B.cp03_2019_062e median_household_income_2019, 
  B.cp03_2021_062e as median_household_income_2021 
from 
  acs_1_economic_city_2016 A 
  join acs_1_economic_city_2021 B on A.name = B.name 
where 
  A.cp03_2013_062e != 0 
  and B.cp03_2017_062e != 0
  and B.name in (
    select 
      name
    from 
      acs_1_demographic_city_2021 
    where 
      "_2021_sex_and_age__total_population" > 500000
  )
  

--Average Household income of top metropolitan areas
select 
  B.name, 
  B.metro_politan_area, 
  A.cp03_2013_062e as median_household_income_2013, 
  A.cp03_2014_062e as median_household_income_2014, 
  A.cp03_2015_062e as median_household_income_2015, 
  A.cp03_2016_062e as median_household_income_2016, 
  B.cp03_2017_062e as median_household_income_2017, 
  B.cp03_2018_062e as median_household_income_2018, 
  B.cp03_2019_062e median_household_income_2019, 
  B.cp03_2021_062e as median_household_income_2021 
from 
  acs_1_economic_metro_politan_2016 A 
  join acs_1_economic_metro_politan_2021 B on A.metro_politan_area = B.metro_politan_area 
where 
  A.cp03_2013_062e != 0 
  and B.cp03_2017_062e != 0 
  and B.metro_politan_area in (
    select 
      metro_politan_area etro 
    from 
      acs_1_demographic_metro_politan_2021 
    where 
      "_2021_sex_and_age__total_population" > 500000
  )
  
  
  


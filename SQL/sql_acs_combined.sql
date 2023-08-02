--##########################################################################################################################################################################
-- 2. We don't want to build too many houses and this is reason why - Housing Supply
select
  A.Name,
  A._2013_SEX_AND_AGE__Total_population,
  A._2014_SEX_AND_AGE__Total_population,
  A._2015_SEX_AND_AGE__Total_population,
  A._2016_SEX_AND_AGE__Total_population,
  B._2017_SEX_AND_AGE__Total_population,
  B._2018_SEX_AND_AGE__Total_population,
  B._2019_SEX_AND_AGE__Total_population,
  B._2021_SEX_AND_AGE__Total_population 
from
  acs_1_demographic_metro_politan_2016 A 
  join
    acs_1_demographic_metro_politan_2021 B 
    on A.name = B.name 
order by
  A.name asc

  
CREATE OR REPLACE view units_estimate_metro_politan_table as (
select A.Name, A.metro_politan_area, 
ceil(_2013_total_housing_units * ("_2013_total_housing_units__1_unit_detached" + "_2013_total_housing_units__1_unit_attached")/100) + 
ceil(2 * _2013_total_housing_units * "_2013_total_housing_units__2_units"/100) + 
ceil(3 * _2013_total_housing_units * "_2013_total_housing_units__3_or_4_units"/100) +
ceil(5 * _2013_total_housing_units * "_2013_total_housing_units__5_to_9_units"/100) +
ceil(10 * _2013_total_housing_units * "_2013_total_housing_units__10_to_19_units"/100) +
ceil(20 * _2013_total_housing_units * "_2013_total_housing_units__20_or_more_units"/100) as _2013_total_units,
ceil(_2014_total_housing_units * ("_2014_total_housing_units__1_unit_detached" + "_2014_total_housing_units__1_unit_attached")/100) + 
ceil(2 * _2014_total_housing_units * "_2014_total_housing_units__2_units"/100) + 
ceil(3 * _2014_total_housing_units * "_2014_total_housing_units__3_or_4_units"/100) +
ceil(5 * _2014_total_housing_units * "_2014_total_housing_units__5_to_9_units"/100) +
ceil(10 * _2014_total_housing_units * "_2014_total_housing_units__10_to_19_units"/100) +
ceil(20 * _2014_total_housing_units * "_2014_total_housing_units__20_or_more_units"/100) as _2014_total_units,
ceil(_2015_total_housing_units * ("_2015_total_housing_units__1_unit_detached" + "_2015_total_housing_units__1_unit_attached")/100) + 
ceil(2 * _2015_total_housing_units * "_2015_total_housing_units__2_units"/100) + 
ceil(3 * _2015_total_housing_units * "_2015_total_housing_units__3_or_4_units"/100) +
ceil(5 * _2015_total_housing_units * "_2015_total_housing_units__5_to_9_units"/100) +
ceil(10 * _2015_total_housing_units * "_2015_total_housing_units__10_to_19_units"/100) +
ceil(20 * _2015_total_housing_units * "_2015_total_housing_units__20_or_more_units"/100) as _2015_total_units,
ceil(_2016_total_housing_units * ("_2016_total_housing_units__1_unit_detached" + "_2016_total_housing_units__1_unit_attached")/100) + 
ceil(2 * _2016_total_housing_units * "_2016_total_housing_units__2_units"/100) + 
ceil(3 * _2016_total_housing_units * "_2016_total_housing_units__3_or_4_units"/100) +
ceil(5 * _2016_total_housing_units * "_2016_total_housing_units__5_to_9_units"/100) +
ceil(10 * _2016_total_housing_units * "_2016_total_housing_units__10_to_19_units"/100) +
ceil(20 * _2016_total_housing_units * "_2016_total_housing_units__20_or_more_units"/100) as _2016_total_units,
ceil(_2017_total_housing_units * ("_2017_total_housing_units__1_unit_detached" + "_2017_total_housing_units__1_unit_attached")/100) + 
ceil(2 * _2017_total_housing_units * "_2017_total_housing_units__2_units"/100) + 
ceil(3 * _2017_total_housing_units * "_2017_total_housing_units__3_or_4_units"/100) +
ceil(5 * _2017_total_housing_units * "_2017_total_housing_units__5_to_9_units"/100) +
ceil(10 * _2017_total_housing_units * "_2017_total_housing_units__10_to_19_units"/100) +
ceil(20 * _2017_total_housing_units * "_2017_total_housing_units__20_or_more_units"/100) as _2017_total_units,
ceil(_2018_total_housing_units * ("_2018_total_housing_units__1_unit_detached" + "_2018_total_housing_units__1_unit_attached")/100) + 
ceil(2 * _2018_total_housing_units * "_2018_total_housing_units__2_units"/100) + 
ceil(3 * _2018_total_housing_units * "_2018_total_housing_units__3_or_4_units"/100) +
ceil(5 * _2018_total_housing_units * "_2018_total_housing_units__5_to_9_units"/100) +
ceil(10 * _2018_total_housing_units * "_2018_total_housing_units__10_to_19_units"/100) +
ceil(20 * _2018_total_housing_units * "_2018_total_housing_units__20_or_more_units"/100) as _2018_total_units,
ceil(_2019_total_housing_units * ("_2019_total_housing_units__1_unit_detached" + "_2019_total_housing_units__1_unit_attached")/100) + 
ceil(2 * _2019_total_housing_units * "_2019_total_housing_units__2_units"/100) + 
ceil(3 * _2019_total_housing_units * "_2019_total_housing_units__3_or_4_units"/100) +
ceil(5 * _2019_total_housing_units * "_2019_total_housing_units__5_to_9_units"/100) +
ceil(10 * _2019_total_housing_units * "_2019_total_housing_units__10_to_19_units"/100) +
ceil(20 * _2019_total_housing_units * "_2019_total_housing_units__20_or_more_units"/100) as _2019_total_units,
ceil(_2021_total_housing_units * ("_2021_total_housing_units__1_unit_detached" + "_2021_total_housing_units__1_unit_attached")/100) + 
ceil(2 * _2021_total_housing_units * "_2021_total_housing_units__2_units"/100) + 
ceil(3 * _2021_total_housing_units * "_2021_total_housing_units__3_or_4_units"/100) +
ceil(5 * _2021_total_housing_units * "_2021_total_housing_units__5_to_9_units"/100) +
ceil(10 * _2021_total_housing_units * "_2021_total_housing_units__10_to_19_units"/100) +
ceil(20 * _2021_total_housing_units * "_2021_total_housing_units__20_or_more_units"/100) as _2021_total_units
from acs_1_housing_metro_politan_2016 A
join acs_1_housing_metro_politan_2021 B
on A.name = B.name
)


select D.name, D.metro_politan_area,
C._2013_SEX_AND_AGE__Total_population/D."_2013_total_units" as _2013_population_per_units,
C._2014_SEX_AND_AGE__Total_population/D."_2014_total_units" as _2014_population_per_units,
C._2015_SEX_AND_AGE__Total_population/D."_2015_total_units" as _2015_population_per_units,
C._2016_SEX_AND_AGE__Total_population/D."_2016_total_units" as _2016_population_per_units,
C._2017_SEX_AND_AGE__Total_population/D."_2017_total_units" as _2017_population_per_units,
C._2018_SEX_AND_AGE__Total_population/D."_2018_total_units" as _2018_population_per_units,
C._2019_SEX_AND_AGE__Total_population/D."_2019_total_units" as _2019_population_per_units,
C._2021_SEX_AND_AGE__Total_population/D."_2021_total_units" as _2021_population_per_units
from units_estimate_metro_politan_table D
join (select
  A.Name,
  A._2013_SEX_AND_AGE__Total_population,
  A._2014_SEX_AND_AGE__Total_population,
  A._2015_SEX_AND_AGE__Total_population,
  A._2016_SEX_AND_AGE__Total_population,
  B._2017_SEX_AND_AGE__Total_population,
  B._2018_SEX_AND_AGE__Total_population,
  B._2019_SEX_AND_AGE__Total_population,
  B._2021_SEX_AND_AGE__Total_population 
from
  acs_1_demographic_metro_politan_2016 A 
  join
    acs_1_demographic_metro_politan_2021 B 
    on A.name = B.name ) C
on C.name = D.name
where "_2021_sex_and_age__total_population" > 500000

CREATE  OR REPLACE view population_per_unit_metro_politan_check as (
select
  E.*,
  round(CAST((((E._2014_population_per_units - E._2013_population_per_units) / E._2013_population_per_units)*100) as numeric), 4) as _2013_2014,
  round(CAST((((E._2015_population_per_units - E._2014_population_per_units) / E._2014_population_per_units)*100) as numeric), 4) as _2014_2015,
  round(CAST((((E._2016_population_per_units - E._2015_population_per_units) / E._2015_population_per_units)*100) as numeric), 4) as _2015_2016,
  round(CAST((((E._2017_population_per_units - E._2016_population_per_units) / E._2016_population_per_units)*100) as numeric), 4) as _2016_2017,
  round(CAST((((E._2018_population_per_units - E._2017_population_per_units) / E._2017_population_per_units)*100) as numeric), 4) as _2017_2018,
  round(CAST((((E._2019_population_per_units - E._2018_population_per_units) / E._2018_population_per_units)*100) as numeric), 4) as _2018_2019,
  round(CAST((((E._2021_population_per_units - E._2019_population_per_units) / E._2019_population_per_units)*100) as numeric), 4) as _2019_2021
from
(select D.name, D.metro_politan_area,
C._2013_SEX_AND_AGE__Total_population/D."_2013_total_units" as _2013_population_per_units,
C._2014_SEX_AND_AGE__Total_population/D."_2014_total_units" as _2014_population_per_units,
C._2015_SEX_AND_AGE__Total_population/D."_2015_total_units" as _2015_population_per_units,
C._2016_SEX_AND_AGE__Total_population/D."_2016_total_units" as _2016_population_per_units,
C._2017_SEX_AND_AGE__Total_population/D."_2017_total_units" as _2017_population_per_units,
C._2018_SEX_AND_AGE__Total_population/D."_2018_total_units" as _2018_population_per_units,
C._2019_SEX_AND_AGE__Total_population/D."_2019_total_units" as _2019_population_per_units,
C._2021_SEX_AND_AGE__Total_population/D."_2021_total_units" as _2021_population_per_units
from units_estimate_metro_politan_table D
join (select
  A.Name,
  A._2013_SEX_AND_AGE__Total_population,
  A._2014_SEX_AND_AGE__Total_population,
  A._2015_SEX_AND_AGE__Total_population,
  A._2016_SEX_AND_AGE__Total_population,
  B._2017_SEX_AND_AGE__Total_population,
  B._2018_SEX_AND_AGE__Total_population,
  B._2019_SEX_AND_AGE__Total_population,
  B._2021_SEX_AND_AGE__Total_population 
from
  acs_1_demographic_metro_politan_2016 A 
  join
    acs_1_demographic_metro_politan_2021 B 
    on A.name = B.name ) C
on C.name = D.name
where "_2021_sex_and_age__total_population" > 500000) E
)



CREATE OR REPLACE view population_per_unit_metro_politan_viz as (
SELECT name, metro_politan_area,
       unnest(array['2013_2014', '2014_2015', '2015_2016', '2016_2017', '2017_2018', '2018_2019', '2019_2021']) AS year,
       unnest(array["_2013_2014" , "_2014_2015","_2015_2016", "_2016_2017", "_2017_2018", "_2018_2019", "_2019_2021"]) AS change
FROM population_per_unit_metro_politan_check
ORDER BY name
)

CREATE OR REPLACE view units_estimate_city_table as (
select A.Name, A.state, A.city, 
ceil(_2013_total_housing_units * ("_2013_total_housing_units__1_unit_detached" + "_2013_total_housing_units__1_unit_attached")/100) + 
ceil(2 * _2013_total_housing_units * "_2013_total_housing_units__2_units"/100) + 
ceil(3 * _2013_total_housing_units * "_2013_total_housing_units__3_or_4_units"/100) +
ceil(5 * _2013_total_housing_units * "_2013_total_housing_units__5_to_9_units"/100) +
ceil(10 * _2013_total_housing_units * "_2013_total_housing_units__10_to_19_units"/100) +
ceil(20 * _2013_total_housing_units * "_2013_total_housing_units__20_or_more_units"/100) as _2013_total_units,
ceil(_2014_total_housing_units * ("_2014_total_housing_units__1_unit_detached" + "_2014_total_housing_units__1_unit_attached")/100) + 
ceil(2 * _2014_total_housing_units * "_2014_total_housing_units__2_units"/100) + 
ceil(3 * _2014_total_housing_units * "_2014_total_housing_units__3_or_4_units"/100) +
ceil(5 * _2014_total_housing_units * "_2014_total_housing_units__5_to_9_units"/100) +
ceil(10 * _2014_total_housing_units * "_2014_total_housing_units__10_to_19_units"/100) +
ceil(20 * _2014_total_housing_units * "_2014_total_housing_units__20_or_more_units"/100) as _2014_total_units,
ceil(_2015_total_housing_units * ("_2015_total_housing_units__1_unit_detached" + "_2015_total_housing_units__1_unit_attached")/100) + 
ceil(2 * _2015_total_housing_units * "_2015_total_housing_units__2_units"/100) + 
ceil(3 * _2015_total_housing_units * "_2015_total_housing_units__3_or_4_units"/100) +
ceil(5 * _2015_total_housing_units * "_2015_total_housing_units__5_to_9_units"/100) +
ceil(10 * _2015_total_housing_units * "_2015_total_housing_units__10_to_19_units"/100) +
ceil(20 * _2015_total_housing_units * "_2015_total_housing_units__20_or_more_units"/100) as _2015_total_units,
ceil(_2016_total_housing_units * ("_2016_total_housing_units__1_unit_detached" + "_2016_total_housing_units__1_unit_attached")/100) + 
ceil(2 * _2016_total_housing_units * "_2016_total_housing_units__2_units"/100) + 
ceil(3 * _2016_total_housing_units * "_2016_total_housing_units__3_or_4_units"/100) +
ceil(5 * _2016_total_housing_units * "_2016_total_housing_units__5_to_9_units"/100) +
ceil(10 * _2016_total_housing_units * "_2016_total_housing_units__10_to_19_units"/100) +
ceil(20 * _2016_total_housing_units * "_2016_total_housing_units__20_or_more_units"/100) as _2016_total_units,
ceil(_2017_total_housing_units * ("_2017_total_housing_units__1_unit_detached" + "_2017_total_housing_units__1_unit_attached")/100) + 
ceil(2 * _2017_total_housing_units * "_2017_total_housing_units__2_units"/100) + 
ceil(3 * _2017_total_housing_units * "_2017_total_housing_units__3_or_4_units"/100) +
ceil(5 * _2017_total_housing_units * "_2017_total_housing_units__5_to_9_units"/100) +
ceil(10 * _2017_total_housing_units * "_2017_total_housing_units__10_to_19_units"/100) +
ceil(20 * _2017_total_housing_units * "_2017_total_housing_units__20_or_more_units"/100) as _2017_total_units,
ceil(_2018_total_housing_units * ("_2018_total_housing_units__1_unit_detached" + "_2018_total_housing_units__1_unit_attached")/100) + 
ceil(2 * _2018_total_housing_units * "_2018_total_housing_units__2_units"/100) + 
ceil(3 * _2018_total_housing_units * "_2018_total_housing_units__3_or_4_units"/100) +
ceil(5 * _2018_total_housing_units * "_2018_total_housing_units__5_to_9_units"/100) +
ceil(10 * _2018_total_housing_units * "_2018_total_housing_units__10_to_19_units"/100) +
ceil(20 * _2018_total_housing_units * "_2018_total_housing_units__20_or_more_units"/100) as _2018_total_units,
ceil(_2019_total_housing_units * ("_2019_total_housing_units__1_unit_detached" + "_2019_total_housing_units__1_unit_attached")/100) + 
ceil(2 * _2019_total_housing_units * "_2019_total_housing_units__2_units"/100) + 
ceil(3 * _2019_total_housing_units * "_2019_total_housing_units__3_or_4_units"/100) +
ceil(5 * _2019_total_housing_units * "_2019_total_housing_units__5_to_9_units"/100) +
ceil(10 * _2019_total_housing_units * "_2019_total_housing_units__10_to_19_units"/100) +
ceil(20 * _2019_total_housing_units * "_2019_total_housing_units__20_or_more_units"/100) as _2019_total_units,
ceil(_2021_total_housing_units * ("_2021_total_housing_units__1_unit_detached" + "_2021_total_housing_units__1_unit_attached")/100) + 
ceil(2 * _2021_total_housing_units * "_2021_total_housing_units__2_units"/100) + 
ceil(3 * _2021_total_housing_units * "_2021_total_housing_units__3_or_4_units"/100) +
ceil(5 * _2021_total_housing_units * "_2021_total_housing_units__5_to_9_units"/100) +
ceil(10 * _2021_total_housing_units * "_2021_total_housing_units__10_to_19_units"/100) +
ceil(20 * _2021_total_housing_units * "_2021_total_housing_units__20_or_more_units"/100) as _2021_total_units
from acs_1_housing_city_2016 A
join acs_1_housing_city_2021 B
on A.name = B.name
)


select D.name, D.state, D.city,
C._2013_SEX_AND_AGE__Total_population/D."_2013_total_units" as _2013_population_per_units,
C._2014_SEX_AND_AGE__Total_population/D."_2014_total_units" as _2014_population_per_units,
C._2015_SEX_AND_AGE__Total_population/D."_2015_total_units" as _2015_population_per_units,
C._2016_SEX_AND_AGE__Total_population/D."_2016_total_units" as _2016_population_per_units,
C._2017_SEX_AND_AGE__Total_population/D."_2017_total_units" as _2017_population_per_units,
C._2018_SEX_AND_AGE__Total_population/D."_2018_total_units" as _2018_population_per_units,
C._2019_SEX_AND_AGE__Total_population/D."_2019_total_units" as _2019_population_per_units,
C._2021_SEX_AND_AGE__Total_population/D."_2021_total_units" as _2021_population_per_units
from units_estimate_city_table D
join (select
  A.Name,
  A._2013_SEX_AND_AGE__Total_population,
  A._2014_SEX_AND_AGE__Total_population,
  A._2015_SEX_AND_AGE__Total_population,
  A._2016_SEX_AND_AGE__Total_population,
  B._2017_SEX_AND_AGE__Total_population,
  B._2018_SEX_AND_AGE__Total_population,
  B._2019_SEX_AND_AGE__Total_population,
  B._2021_SEX_AND_AGE__Total_population 
from
  acs_1_demographic_city_2016 A 
  join
    acs_1_demographic_city_2021 B 
    on A.name = B.name ) C
on C.name = D.name
where "_2021_sex_and_age__total_population" > 500000


CREATE  OR REPLACE view population_per_unit_city_check as (
select
  E.*,
  round(CAST((((E._2014_population_per_units - E._2013_population_per_units) / E._2013_population_per_units)*100) as numeric), 4) as _2013_2014,
  round(CAST((((E._2015_population_per_units - E._2014_population_per_units) / E._2014_population_per_units)*100) as numeric), 4) as _2014_2015,
  round(CAST((((E._2016_population_per_units - E._2015_population_per_units) / E._2015_population_per_units)*100) as numeric), 4) as _2015_2016,
  round(CAST((((E._2017_population_per_units - E._2016_population_per_units) / E._2016_population_per_units)*100) as numeric), 4) as _2016_2017,
  round(CAST((((E._2018_population_per_units - E._2017_population_per_units) / E._2017_population_per_units)*100) as numeric), 4) as _2017_2018,
  round(CAST((((E._2019_population_per_units - E._2018_population_per_units) / E._2018_population_per_units)*100) as numeric), 4) as _2018_2019,
  round(CAST((((E._2021_population_per_units - E._2019_population_per_units) / E._2019_population_per_units)*100) as numeric), 4) as _2019_2021
from
(select D.name, D.state, D.city,
C._2013_SEX_AND_AGE__Total_population/D."_2013_total_units" as _2013_population_per_units,
C._2014_SEX_AND_AGE__Total_population/D."_2014_total_units" as _2014_population_per_units,
C._2015_SEX_AND_AGE__Total_population/D."_2015_total_units" as _2015_population_per_units,
C._2016_SEX_AND_AGE__Total_population/D."_2016_total_units" as _2016_population_per_units,
C._2017_SEX_AND_AGE__Total_population/D."_2017_total_units" as _2017_population_per_units,
C._2018_SEX_AND_AGE__Total_population/D."_2018_total_units" as _2018_population_per_units,
C._2019_SEX_AND_AGE__Total_population/D."_2019_total_units" as _2019_population_per_units,
C._2021_SEX_AND_AGE__Total_population/D."_2021_total_units" as _2021_population_per_units
from units_estimate_city_table D
join (select
  A.Name,
  A._2013_SEX_AND_AGE__Total_population,
  A._2014_SEX_AND_AGE__Total_population,
  A._2015_SEX_AND_AGE__Total_population,
  A._2016_SEX_AND_AGE__Total_population,
  B._2017_SEX_AND_AGE__Total_population,
  B._2018_SEX_AND_AGE__Total_population,
  B._2019_SEX_AND_AGE__Total_population,
  B._2021_SEX_AND_AGE__Total_population 
from
  acs_1_demographic_city_2016 A 
  join
    acs_1_demographic_city_2021 B 
    on A.name = B.name ) C
on C.name = D.name
where "_2021_sex_and_age__total_population" > 500000) E
)


CREATE OR REPLACE view population_per_unit_city_viz as (
SELECT name, state, city,
       unnest(array['2013_2014', '2014_2015', '2015_2016', '2016_2017', '2017_2018', '2018_2019', '2019_2021']) AS year,
       unnest(array["_2013_2014" , "_2014_2015","_2015_2016", "_2016_2017", "_2017_2018", "_2018_2019", "_2019_2021"]) AS change
FROM population_per_unit_city_check
ORDER BY name
)


--##########################################################################################################################################################################





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



select
  C.name,
  C.state,
  C.county,
  C.tract,
  C.median_household_income_2016,
  C.median_household_income_2021,
  D._2016_ROI,
  D._2021_ROI 
from
  (
    select
      A.name,
      A.state,
      A.county,
      A.tract,
      B.dp03_0062e as median_household_income_2016,
      A.dp03_0062e as median_household_income_2021,
      round(CAST((((A.dp03_0062e - B.dp03_0062e ) / B.dp03_0062e )*100) as numeric), 4) as price_increase 
    from
      acs_5_economic_census_tract_fl_2021 A 
      join
        acs_5_economic_census_tract_fl_2016 B 
        on A.name = B.name 
    where
      A.county = '031' 
      and B.dp03_0062e != 0
  )
  C 
  join
    (
      select
        A."name",
        A.state,
        A.county,
        A.tract,
        round(cast((A._gross_rent__occupied_units_paying_rent__median_dollars / A._value__owner_occupied_units__median_dollars)*1200 as numeric), 4) _2016_ROI,
        round(cast((B._gross_rent__occupied_units_paying_rent__median_dollars / B._value__owner_occupied_units__median_dollars)*1200 as numeric), 4) _2021_ROI 
      from
        acs_5_housing_census_tract_fl_2016 A 
        join
          acs_5_housing_census_tract_fl_2021 B 
          on A.name = B."name" 
      where
        A._value__owner_occupied_units__median_dollars != 0 
        and B._value__owner_occupied_units__median_dollars != 0 
        and A.county = '031'
    )
    D 
    on C.name = D.name
    
    


SELECT C.name, C.state, C.county, C.tract, 
    C.median_household_income_2016, C.median_household_income_2021,
    D.median_rent_2016, D.median_rent_2021,
    D._2016_ROI, D._2021_ROI,
    D.rent_vacancy_2016, D.rent_vacancy_2021,
    D.occupied_housing_unit_2016,
    D.renter_occupied_ratio_2016,
    D.occupied_housing_unit_2021,
    D.renter_occupied_ratio_2021
FROM 
    (SELECT A.name, A.state, A.county, A.tract, B.dp03_0062e AS median_household_income_2016, A.dp03_0062e AS median_household_income_2021, 
        ROUND(CAST((((A.dp03_0062e - B.dp03_0062e) / B.dp03_0062e) * 100) AS numeric), 4) AS price_increase
    FROM acs_5_economic_census_tract_fl_2021 A
    JOIN acs_5_economic_census_tract_fl_2016 B ON A.name = B.name
    WHERE A.county = '031' AND B.dp03_0062e != 0) C
JOIN 
    (SELECT A."name", A.state, A.county, A.tract,
        A._gross_rent__occupied_units_paying_rent__median_dollars AS median_rent_2016, 
        A._rental_vacancy_rate AS rent_vacancy_2016,
        B._gross_rent__occupied_units_paying_rent__median_dollars AS median_rent_2021, 
        B."_total_housing_units__rental_vacancy_rate" AS rent_vacancy_2021,
        ROUND(CAST((A._gross_rent__occupied_units_paying_rent__median_dollars / A._value__owner_occupied_units__median_dollars) * 1200 AS numeric), 4) _2016_ROI,
        ROUND(CAST((B._gross_rent__occupied_units_paying_rent__median_dollars / B._value__owner_occupied_units__median_dollars) * 1200 AS numeric), 4) _2021_ROI,
        A."_occupied_housing_units_x" AS occupied_housing_unit_2016,
        ROUND(CAST((A."_occupied_housing_units__renter_occupied" / A."_occupied_housing_units_x") * 100 AS numeric), 4) renter_occupied_ratio_2016,
        B."_occupied_housing_units_x" AS occupied_housing_unit_2021,
        ROUND(CAST((B."_occupied_housing_units__renter_occupied" / B."_occupied_housing_units_x") * 100 AS numeric), 4) renter_occupied_ratio_2021
    FROM acs_5_housing_census_tract_fl_2016 A
    JOIN acs_5_housing_census_tract_fl_2021 B ON A.name = B."name"
    WHERE A._value__owner_occupied_units__median_dollars != 0 
        AND B._value__owner_occupied_units__median_dollars != 0 
        AND A.county = '031') D
ON C.name = D.name;










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

  
select
   C.name,
   C.metro_politan_area,
   F._2013_SEX_AND_AGE__Total_population / C."_2013_total_housing_units" as _2013_population_per_units,
   F._2014_SEX_AND_AGE__Total_population / C."_2014_total_housing_units" as _2014_population_per_units,
   F._2015_SEX_AND_AGE__Total_population / C."_2015_total_housing_units" as _2015_population_per_units,
   F._2016_SEX_AND_AGE__Total_population / C."_2016_total_housing_units" as _2016_population_per_units,
   F._2017_SEX_AND_AGE__Total_population / C."_2017_total_housing_units" as _2017_population_per_units,
   F._2018_SEX_AND_AGE__Total_population / C."_2018_total_housing_units" as _2018_population_per_units,
   F._2019_SEX_AND_AGE__Total_population / C."_2019_total_housing_units" as _2019_population_per_units,
   F._2021_SEX_AND_AGE__Total_population / C."_2021_total_housing_units" as _2021_population_per_units 
from
   (
      select
         A.name,
         A.metro_politan_area,
         _2013_total_housing_units,
         _2014_total_housing_units,
         _2015_total_housing_units,
         _2016_total_housing_units,
         _2017_total_housing_units,
         _2018_total_housing_units,
         _2019_total_housing_units,
         _2021_total_housing_units 
      from
         acs_1_housing_metro_politan_2016 A 
         join
            acs_1_housing_metro_politan_2021 B 
            on A.name = B.name
   )
   C 
   join
      (
         select
            D.Name,
            D._2013_SEX_AND_AGE__Total_population,
            D._2014_SEX_AND_AGE__Total_population,
            D._2015_SEX_AND_AGE__Total_population,
            D._2016_SEX_AND_AGE__Total_population,
            E._2017_SEX_AND_AGE__Total_population,
            E._2018_SEX_AND_AGE__Total_population,
            E._2019_SEX_AND_AGE__Total_population,
            E._2021_SEX_AND_AGE__Total_population 
         from
            acs_1_demographic_metro_politan_2016 D 
            join
               acs_1_demographic_metro_politan_2021 E 
               on D.name = E.name 
      )
      F 
      on C.name = F.name
      where F._2021_SEX_AND_AGE__Total_population > 500000


CREATE  OR REPLACE view population_per_unit_metro_politan_check as (
select
  G.*,
  round(CAST((((G._2014_population_per_units - G._2013_population_per_units) / G._2013_population_per_units)*100) as numeric), 4) as _2013_2014,
  round(CAST((((G._2015_population_per_units - G._2014_population_per_units) / G._2014_population_per_units)*100) as numeric), 4) as _2014_2015,
  round(CAST((((G._2016_population_per_units - G._2015_population_per_units) / G._2015_population_per_units)*100) as numeric), 4) as _2015_2016,
  round(CAST((((G._2017_population_per_units - G._2016_population_per_units) / G._2016_population_per_units)*100) as numeric), 4) as _2016_2017,
  round(CAST((((G._2018_population_per_units - G._2017_population_per_units) / G._2017_population_per_units)*100) as numeric), 4) as _2017_2018,
  round(CAST((((G._2019_population_per_units - G._2018_population_per_units) / G._2018_population_per_units)*100) as numeric), 4) as _2018_2019,
  round(CAST((((G._2021_population_per_units - G._2019_population_per_units) / G._2019_population_per_units)*100) as numeric), 4) as _2019_2021
from
(select
   C.name,
   C.metro_politan_area,
   F._2013_SEX_AND_AGE__Total_population / C."_2013_total_housing_units" as _2013_population_per_units,
   F._2014_SEX_AND_AGE__Total_population / C."_2014_total_housing_units" as _2014_population_per_units,
   F._2015_SEX_AND_AGE__Total_population / C."_2015_total_housing_units" as _2015_population_per_units,
   F._2016_SEX_AND_AGE__Total_population / C."_2016_total_housing_units" as _2016_population_per_units,
   F._2017_SEX_AND_AGE__Total_population / C."_2017_total_housing_units" as _2017_population_per_units,
   F._2018_SEX_AND_AGE__Total_population / C."_2018_total_housing_units" as _2018_population_per_units,
   F._2019_SEX_AND_AGE__Total_population / C."_2019_total_housing_units" as _2019_population_per_units,
   F._2021_SEX_AND_AGE__Total_population / C."_2021_total_housing_units" as _2021_population_per_units 
from
   (
      select
         A.name,
         A.metro_politan_area,
         _2013_total_housing_units,
         _2014_total_housing_units,
         _2015_total_housing_units,
         _2016_total_housing_units,
         _2017_total_housing_units,
         _2018_total_housing_units,
         _2019_total_housing_units,
         _2021_total_housing_units 
      from
         acs_1_housing_metro_politan_2016 A 
         join
            acs_1_housing_metro_politan_2021 B 
            on A.name = B.name
   )
   C 
   join
      (
         select
            D.Name,
            D._2013_SEX_AND_AGE__Total_population,
            D._2014_SEX_AND_AGE__Total_population,
            D._2015_SEX_AND_AGE__Total_population,
            D._2016_SEX_AND_AGE__Total_population,
            E._2017_SEX_AND_AGE__Total_population,
            E._2018_SEX_AND_AGE__Total_population,
            E._2019_SEX_AND_AGE__Total_population,
            E._2021_SEX_AND_AGE__Total_population 
         from
            acs_1_demographic_metro_politan_2016 D 
            join
               acs_1_demographic_metro_politan_2021 E 
               on D.name = E.name 
      )
      F
      on C.name = F.name
      where F._2021_SEX_AND_AGE__Total_population > 500000) G
)



CREATE OR REPLACE view population_per_unit_metro_politan_viz as (
SELECT name, metro_politan_area,
       unnest(array['2013_2014', '2014_2015', '2015_2016', '2016_2017', '2017_2018', '2018_2019', '2019_2021']) AS year,
       unnest(array["_2013_2014" , "_2014_2015","_2015_2016", "_2016_2017", "_2017_2018", "_2018_2019", "_2019_2021"]) AS change
FROM population_per_unit_metro_politan_check
ORDER BY name
)

select
   C.name,
   C.state,
   C.city,
   F._2013_SEX_AND_AGE__Total_population / C."_2013_total_housing_units" as _2013_population_per_units,
   F._2014_SEX_AND_AGE__Total_population / C."_2014_total_housing_units" as _2014_population_per_units,
   F._2015_SEX_AND_AGE__Total_population / C."_2015_total_housing_units" as _2015_population_per_units,
   F._2016_SEX_AND_AGE__Total_population / C."_2016_total_housing_units" as _2016_population_per_units,
   F._2017_SEX_AND_AGE__Total_population / C."_2017_total_housing_units" as _2017_population_per_units,
   F._2018_SEX_AND_AGE__Total_population / C."_2018_total_housing_units" as _2018_population_per_units,
   F._2019_SEX_AND_AGE__Total_population / C."_2019_total_housing_units" as _2019_population_per_units,
   F._2021_SEX_AND_AGE__Total_population / C."_2021_total_housing_units" as _2021_population_per_units 
from
   (
      select
         A.name,
         A.state,
         A.city,
         _2013_total_housing_units,
         _2014_total_housing_units,
         _2015_total_housing_units,
         _2016_total_housing_units,
         _2017_total_housing_units,
         _2018_total_housing_units,
         _2019_total_housing_units,
         _2021_total_housing_units 
      from
         acs_1_housing_city_2016 A 
         join
            acs_1_housing_city_2021 B 
            on A.name = B.name
   )
   C 
   join
      (
         select
            D.Name,
            D._2013_SEX_AND_AGE__Total_population,
            D._2014_SEX_AND_AGE__Total_population,
            D._2015_SEX_AND_AGE__Total_population,
            D._2016_SEX_AND_AGE__Total_population,
            E._2017_SEX_AND_AGE__Total_population,
            E._2018_SEX_AND_AGE__Total_population,
            E._2019_SEX_AND_AGE__Total_population,
            E._2021_SEX_AND_AGE__Total_population 
         from
            acs_1_demographic_city_2016 D 
            join
               acs_1_demographic_city_2021 E 
               on D.name = E.name 
      )
      F 
      on C.name = F.name
      where F._2021_SEX_AND_AGE__Total_population > 500000


CREATE  OR REPLACE view population_per_unit_city_check as (
select
  G.*,
  round(CAST((((G._2014_population_per_units - G._2013_population_per_units) / G._2013_population_per_units)*100) as numeric), 4) as _2013_2014,
  round(CAST((((G._2015_population_per_units - G._2014_population_per_units) / G._2014_population_per_units)*100) as numeric), 4) as _2014_2015,
  round(CAST((((G._2016_population_per_units - G._2015_population_per_units) / G._2015_population_per_units)*100) as numeric), 4) as _2015_2016,
  round(CAST((((G._2017_population_per_units - G._2016_population_per_units) / G._2016_population_per_units)*100) as numeric), 4) as _2016_2017,
  round(CAST((((G._2018_population_per_units - G._2017_population_per_units) / G._2017_population_per_units)*100) as numeric), 4) as _2017_2018,
  round(CAST((((G._2019_population_per_units - G._2018_population_per_units) / G._2018_population_per_units)*100) as numeric), 4) as _2018_2019,
  round(CAST((((G._2021_population_per_units - G._2019_population_per_units) / G._2019_population_per_units)*100) as numeric), 4) as _2019_2021
from (
select
   C.name,
   C.state,
   C.city,
   F._2013_SEX_AND_AGE__Total_population / C."_2013_total_housing_units" as _2013_population_per_units,
   F._2014_SEX_AND_AGE__Total_population / C."_2014_total_housing_units" as _2014_population_per_units,
   F._2015_SEX_AND_AGE__Total_population / C."_2015_total_housing_units" as _2015_population_per_units,
   F._2016_SEX_AND_AGE__Total_population / C."_2016_total_housing_units" as _2016_population_per_units,
   F._2017_SEX_AND_AGE__Total_population / C."_2017_total_housing_units" as _2017_population_per_units,
   F._2018_SEX_AND_AGE__Total_population / C."_2018_total_housing_units" as _2018_population_per_units,
   F._2019_SEX_AND_AGE__Total_population / C."_2019_total_housing_units" as _2019_population_per_units,
   F._2021_SEX_AND_AGE__Total_population / C."_2021_total_housing_units" as _2021_population_per_units 
from
   (
      select
         A.name,
         A.state,
         A.city,
         _2013_total_housing_units,
         _2014_total_housing_units,
         _2015_total_housing_units,
         _2016_total_housing_units,
         _2017_total_housing_units,
         _2018_total_housing_units,
         _2019_total_housing_units,
         _2021_total_housing_units 
      from
         acs_1_housing_city_2016 A 
         join
            acs_1_housing_city_2021 B 
            on A.name = B.name
   )
   C 
   join
      (
         select
            D.Name,
            D._2013_SEX_AND_AGE__Total_population,
            D._2014_SEX_AND_AGE__Total_population,
            D._2015_SEX_AND_AGE__Total_population,
            D._2016_SEX_AND_AGE__Total_population,
            E._2017_SEX_AND_AGE__Total_population,
            E._2018_SEX_AND_AGE__Total_population,
            E._2019_SEX_AND_AGE__Total_population,
            E._2021_SEX_AND_AGE__Total_population 
         from
            acs_1_demographic_city_2016 D 
            join
               acs_1_demographic_city_2021 E 
               on D.name = E.name 
      )
      F 
      on C.name = F.name
      where F._2021_SEX_AND_AGE__Total_population > 500000
) G
)



CREATE OR REPLACE view population_per_unit_city_viz as (
SELECT name, state, city,
       unnest(array['2013_2014', '2014_2015', '2015_2016', '2016_2017', '2017_2018', '2018_2019', '2019_2021']) AS year,
       unnest(array["_2013_2014" , "_2014_2015","_2015_2016", "_2016_2017", "_2017_2018", "_2018_2019", "_2019_2021"]) AS change
FROM population_per_unit_city_check
ORDER BY name
)


--##########################################################################################################################################################################
--4. The reason you can double the rent in Jacksonville Florida every 10 years
create or replace view income_census_tract_fl_viz as (
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
      A.dp03_0062e as median_household_income_2021
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
 )

select avg(median_household_income_2021) from  income_census_tract_fl_viz



select 
A.name, A.state, A.city,
A.cp03_2013_062e as median_household_income_2013,
A.cp03_2014_062e as median_household_income_2014,
A.cp03_2015_062e as median_household_income_2015,
A.cp03_2016_062e as median_household_income_2016,
B.cp03_2017_062e as median_household_income_2017, 
B.cp03_2018_062e as median_household_income_2018, 
B.cp03_2019_062e median_household_income_2019, 
B.cp03_2021_062e as median_household_income_2021 from acs_1_economic_city_2016 A
join acs_1_economic_city_2021 B
on A.name = B.name
where A.cp03_2013_062e != 0 and B.cp03_2017_062e !=0 and B.name in
(select distinct name from acs_1_demographic_city_2021
where "_2021_sex_and_age__total_population" > 500000)


select 
avg(A.cp03_2013_062e) as avg_median_household_income_2013,
avg(A.cp03_2014_062e) as median_household_income_2014,
avg(A.cp03_2015_062e) as median_household_income_2015,
avg(A.cp03_2016_062e) as median_household_income_2016,
avg(B.cp03_2017_062e) as median_household_income_2017, 
avg(B.cp03_2018_062e) as median_household_income_2018, 
avg(B.cp03_2019_062e) median_household_income_2019, 
avg(B.cp03_2021_062e) as median_household_income_2021 from acs_1_economic_city_2016 A
join acs_1_economic_city_2021 B
on A.name = B.name
where A.cp03_2013_062e != 0 and B.cp03_2017_062e !=0 and B.name in
(select distinct name from acs_1_demographic_city_2021
where "_2021_sex_and_age__total_population" > 500000)


    
    

--##########################################################################################################################################################################


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










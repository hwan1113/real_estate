--##########################################################################################################################################################################
-- 1. Where is the next real estate gold rush? - Population
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
  C.*,
  round(CAST((((C._2014_SEX_AND_AGE__Total_population - C._2013_SEX_AND_AGE__Total_population) / C._2013_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2013_2014,
  round(CAST((((C._2015_SEX_AND_AGE__Total_population - C._2014_SEX_AND_AGE__Total_population) / C._2014_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2014_2015,
  round(CAST((((C._2016_SEX_AND_AGE__Total_population - C._2015_SEX_AND_AGE__Total_population) / C._2015_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2015_2016,
  round(CAST((((C._2017_SEX_AND_AGE__Total_population - C._2016_SEX_AND_AGE__Total_population) / C._2016_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2016_2017,
  round(CAST((((C._2018_SEX_AND_AGE__Total_population - C._2017_SEX_AND_AGE__Total_population) / C._2017_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2017_2018,
  round(CAST((((C._2019_SEX_AND_AGE__Total_population - C._2018_SEX_AND_AGE__Total_population) / C._2018_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2018_2019,
  round(CAST((((C._2021_SEX_AND_AGE__Total_population - C._2019_SEX_AND_AGE__Total_population) / C._2019_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2019_2021 
from
  (
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
  )
  C 
order by
  _2019_2021 desc

CREATE 
OR REPLACE view population_metro_politan_check as 
(
  select
    D.*,
    CASE
      WHEN
        (
          D._2019_2021 > 0 
          and D._2018_2019 > 0 
          and D._2017_2018 > 0 
          and D._2016_2017 > 0 
          and D._2015_2016 > 0 
          and D._2014_2015 > 0
        )
      THEN
        'o' 
      ELSE
        'x' 
    END
    check 
  from
    (
      select
        C.*,
        round(CAST((((C._2014_SEX_AND_AGE__Total_population - C._2013_SEX_AND_AGE__Total_population) / C._2013_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2013_2014,
        round(CAST((((C._2015_SEX_AND_AGE__Total_population - C._2014_SEX_AND_AGE__Total_population) / C._2014_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2014_2015,
        round(CAST((((C._2016_SEX_AND_AGE__Total_population - C._2015_SEX_AND_AGE__Total_population) / C._2015_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2015_2016,
        round(CAST((((C._2017_SEX_AND_AGE__Total_population - C._2016_SEX_AND_AGE__Total_population) / C._2016_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2016_2017,
        round(CAST((((C._2018_SEX_AND_AGE__Total_population - C._2017_SEX_AND_AGE__Total_population) / C._2017_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2017_2018,
        round(CAST((((C._2019_SEX_AND_AGE__Total_population - C._2018_SEX_AND_AGE__Total_population) / C._2018_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2018_2019,
        round(CAST((((C._2021_SEX_AND_AGE__Total_population - C._2019_SEX_AND_AGE__Total_population) / C._2019_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2019_2021 
      from
        (
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
          where
            A._2013_SEX_AND_AGE__Total_population != 0 
            and A._2014_SEX_AND_AGE__Total_population != 0 
        )
        C 
      order by
        _2019_2021 desc
    )
    D
)


CREATE 
OR REPLACE view population_metro_politan_viz as (
SELECT name,
       unnest(array['2013_2014', '2014_2015', '2015_2016', '2016_2017', '2017_2018', '2018_2019', '2019_2021']) AS year,
       unnest(array["_2013_2014" , "_2014_2015","_2015_2016", "_2016_2017", "_2017_2018", "_2018_2019", "_2019_2021"]) AS change
FROM population_metro_politan_check
where "_2021_sex_and_age__total_population" > 500000
ORDER BY name
)

select
  A.Name,
  A.state,
  A.city,
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
    on A.name = B.name 
where
  A._2013_SEX_AND_AGE__Total_population != 0 
  or A._2014_SEX_AND_AGE__Total_population != 0 
order by
  A.name asc

select
  C.*,
  round(CAST((((C._2014_SEX_AND_AGE__Total_population - C._2013_SEX_AND_AGE__Total_population) / C._2013_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2013_2014,
  round(CAST((((C._2015_SEX_AND_AGE__Total_population - C._2014_SEX_AND_AGE__Total_population) / C._2014_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2014_2015,
  round(CAST((((C._2016_SEX_AND_AGE__Total_population - C._2015_SEX_AND_AGE__Total_population) / C._2015_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2015_2016,
  round(CAST((((C._2017_SEX_AND_AGE__Total_population - C._2016_SEX_AND_AGE__Total_population) / C._2016_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2016_2017,
  round(CAST((((C._2018_SEX_AND_AGE__Total_population - C._2017_SEX_AND_AGE__Total_population) / C._2017_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2017_2018,
  round(CAST((((C._2019_SEX_AND_AGE__Total_population - C._2018_SEX_AND_AGE__Total_population) / C._2018_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2018_2019,
  round(CAST((((C._2021_SEX_AND_AGE__Total_population - C._2019_SEX_AND_AGE__Total_population) / C._2019_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2019_2021 
from
  (
    select
      A.Name,
      A.state,
      A.city,
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
        on A.name = B.name 
    where
      A._2013_SEX_AND_AGE__Total_population != 0 
      and A._2014_SEX_AND_AGE__Total_population != 0 
  )
  C 
order by
  _2019_2021 desc

CREATE 
OR REPLACE view population_city_check as 
(
  select
    D.*,
    CASE
      WHEN
        (
          D._2019_2021 > 0 
          and D._2018_2019 > 0 
          and D._2017_2018 > 0 
          and D._2016_2017 > 0 
          and D._2015_2016 > 0 
          and D._2014_2015 > 0
        )
      THEN
        'o' 
      ELSE
        'x' 
    END
    check 
  from
    (
      select
        C.*,
        round(CAST((((C._2014_SEX_AND_AGE__Total_population - C._2013_SEX_AND_AGE__Total_population) / C._2013_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2013_2014,
        round(CAST((((C._2015_SEX_AND_AGE__Total_population - C._2014_SEX_AND_AGE__Total_population) / C._2014_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2014_2015,
        round(CAST((((C._2016_SEX_AND_AGE__Total_population - C._2015_SEX_AND_AGE__Total_population) / C._2015_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2015_2016,
        round(CAST((((C._2017_SEX_AND_AGE__Total_population - C._2016_SEX_AND_AGE__Total_population) / C._2016_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2016_2017,
        round(CAST((((C._2018_SEX_AND_AGE__Total_population - C._2017_SEX_AND_AGE__Total_population) / C._2017_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2017_2018,
        round(CAST((((C._2019_SEX_AND_AGE__Total_population - C._2018_SEX_AND_AGE__Total_population) / C._2018_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2018_2019,
        round(CAST((((C._2021_SEX_AND_AGE__Total_population - C._2019_SEX_AND_AGE__Total_population) / C._2019_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2019_2021 
      from
        (
          select
            A.Name,
            A.state,
            A.city,
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
              on A.name = B.name 
          where
            A._2013_SEX_AND_AGE__Total_population != 0 
            and A._2014_SEX_AND_AGE__Total_population != 0 
        )
        C 
      order by
        _2019_2021 desc
    )
    D
)


CREATE OR REPLACE view population_city_viz as (
SELECT name,
       unnest(array['2013_2014', '2014_2015', '2015_2016', '2016_2017', '2017_2018', '2018_2019', '2019_2021']) AS year,
       unnest(array["_2013_2014" , "_2014_2015","_2015_2016", "_2016_2017", "_2017_2018", "_2018_2019", "_2019_2021"]) AS change
FROM population_city_check
where "_2021_sex_and_age__total_population" > 500000
ORDER BY name
)




--##########################################################################################################################################################################
-- Racial
--##########################################################################################################################################################################

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
 
--##########################################################################################################################################################################
-- age
--##########################################################################################################################################################################

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
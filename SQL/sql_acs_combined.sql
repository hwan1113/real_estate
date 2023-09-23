
--##########################################################################################################################################################################
-- 1. How to Choose the Right Real Estate Market in the US: Are Rising Stars or Fading Markets Your Best Investment?
select
  B.name,
  B.metro_politan_area,
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
    on A.metro_politan_area  = B.metro_politan_area 
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
  round(CAST((((C._2021_SEX_AND_AGE__Total_population - C._2019_SEX_AND_AGE__Total_population) / C._2019_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2019_2021,
  round(CAST((((C._2021_SEX_AND_AGE__Total_population - C._2013_SEX_AND_AGE__Total_population) / C._2013_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2013_2021
from
  (
    select
      B.Name,
      B.metro_politan_area,
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
        on A.metro_politan_area  = B.metro_politan_area  
  )
  C 
order by
  _2019_2021 desc

create or replace
view population_metro_politan_check as 
(
select
	D.*,
	case
		when
        (
          D._2019_2021_population_change > 0
		and D._2018_2019_population_change > 0
		and D._2017_2018_population_change > 0
		and D._2016_2017_population_change > 0
		and D._2015_2016_population_change > 0
		and D._2014_2015_population_change > 0
        )
      then
        'o'
		else
        'x'
	end
    check
from
	(
	select
		C.*,
		round(cast((((C._2014_SEX_AND_AGE__Total_population - C._2013_SEX_AND_AGE__Total_population) / C._2013_SEX_AND_AGE__Total_population)* 100) as numeric),
		4) as _2013_2014_population_change,
		round(cast((((C._2015_SEX_AND_AGE__Total_population - C._2014_SEX_AND_AGE__Total_population) / C._2014_SEX_AND_AGE__Total_population)* 100) as numeric),
		4) as _2014_2015_population_change,
		round(cast((((C._2016_SEX_AND_AGE__Total_population - C._2015_SEX_AND_AGE__Total_population) / C._2015_SEX_AND_AGE__Total_population)* 100) as numeric),
		4) as _2015_2016_population_change,
		round(cast((((C._2017_SEX_AND_AGE__Total_population - C._2016_SEX_AND_AGE__Total_population) / C._2016_SEX_AND_AGE__Total_population)* 100) as numeric),
		4) as _2016_2017_population_change,
		round(cast((((C._2018_SEX_AND_AGE__Total_population - C._2017_SEX_AND_AGE__Total_population) / C._2017_SEX_AND_AGE__Total_population)* 100) as numeric),
		4) as _2017_2018_population_change,
		round(cast((((C._2019_SEX_AND_AGE__Total_population - C._2018_SEX_AND_AGE__Total_population) / C._2018_SEX_AND_AGE__Total_population)* 100) as numeric),
		4) as _2018_2019_population_change,
		round(cast((((C._2021_SEX_AND_AGE__Total_population - C._2019_SEX_AND_AGE__Total_population) / C._2019_SEX_AND_AGE__Total_population)* 100) as numeric),
		4) as _2019_2021_population_change,
		 round(cast((((C._2021_SEX_AND_AGE__Total_population - C._2013_SEX_AND_AGE__Total_population) / C._2013_SEX_AND_AGE__Total_population)* 100) as numeric),
		4) as _2013_2021_population_change
	from
		(
		select
			B.Name,
			B.metro_politan_area,
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
              on
			A.metro_politan_area = B.metro_politan_area
		where
			A._2013_SEX_AND_AGE__Total_population != 0
			and A._2014_SEX_AND_AGE__Total_population != 0 
        )
        C
	order by
		_2019_2021_population_change desc
    )
    D
)

select * from population_metro_politan_check

CREATE 
OR REPLACE view population_metro_politan_viz as (
SELECT name,
       unnest(array['2013_2014', '2014_2015', '2015_2016', '2016_2017', '2017_2018', '2018_2019', '2019_2021', '2013_2021']) AS year,
       unnest(array["_2013_2014_population_change" , "_2014_2015_population_change","_2015_2016_population_change", "_2016_2017_population_change",
       "_2017_2018_population_change", "_2018_2019_population_change", "_2019_2021_population_change", "_2019_2021_population_change"]) AS change
FROM population_metro_politan_check
where "_2021_sex_and_age__total_population" > 500000
ORDER BY name
)

select
  B.Name,
  B.state,
  B.city,
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
order by
  A.name asc

select
  C.*,
  round(CAST((((C._2014_SEX_AND_AGE__Total_population - C._2013_SEX_AND_AGE__Total_population) / C._2013_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2013_2014_population_change,
  round(CAST((((C._2015_SEX_AND_AGE__Total_population - C._2014_SEX_AND_AGE__Total_population) / C._2014_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2014_2015_population_change,
  round(CAST((((C._2016_SEX_AND_AGE__Total_population - C._2015_SEX_AND_AGE__Total_population) / C._2015_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2015_2016_population_change,
  round(CAST((((C._2017_SEX_AND_AGE__Total_population - C._2016_SEX_AND_AGE__Total_population) / C._2016_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2016_2017_population_change,
  round(CAST((((C._2018_SEX_AND_AGE__Total_population - C._2017_SEX_AND_AGE__Total_population) / C._2017_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2017_2018_population_change,
  round(CAST((((C._2019_SEX_AND_AGE__Total_population - C._2018_SEX_AND_AGE__Total_population) / C._2018_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2018_2019_population_change,
  round(CAST((((C._2021_SEX_AND_AGE__Total_population - C._2019_SEX_AND_AGE__Total_population) / C._2019_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2019_2021_population_change, 
  round(CAST((((C._2021_SEX_AND_AGE__Total_population - C._2013_SEX_AND_AGE__Total_population) / C._2013_SEX_AND_AGE__Total_population)*100) as numeric), 4) as _2013_2021_population_change 
  from
  (
    select
      B.Name,
      B.state,
      B.city,
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
  )
  C 

create or replace
view population_city_check as 
(
select
	D.*,
	case
		when
        (
          D._2019_2021_population_change > 0
		and D._2018_2019_population_change > 0
		and D._2017_2018_population_change > 0
		and D._2016_2017_population_change > 0
		and D._2015_2016_population_change > 0
		and D._2014_2015_population_change > 0
        )
      then
        'o'
		else
        'x'
	end
    check
from
	(
	select
		C.*,
		round(cast((((C._2014_SEX_AND_AGE__Total_population - C._2013_SEX_AND_AGE__Total_population) / C._2013_SEX_AND_AGE__Total_population)* 100) as numeric),
		4) as _2013_2014_population_change,
		round(cast((((C._2015_SEX_AND_AGE__Total_population - C._2014_SEX_AND_AGE__Total_population) / C._2014_SEX_AND_AGE__Total_population)* 100) as numeric),
		4) as _2014_2015_population_change,
		round(cast((((C._2016_SEX_AND_AGE__Total_population - C._2015_SEX_AND_AGE__Total_population) / C._2015_SEX_AND_AGE__Total_population)* 100) as numeric),
		4) as _2015_2016_population_change,
		round(cast((((C._2017_SEX_AND_AGE__Total_population - C._2016_SEX_AND_AGE__Total_population) / C._2016_SEX_AND_AGE__Total_population)* 100) as numeric),
		4) as _2016_2017_population_change,
		round(cast((((C._2018_SEX_AND_AGE__Total_population - C._2017_SEX_AND_AGE__Total_population) / C._2017_SEX_AND_AGE__Total_population)* 100) as numeric),
		4) as _2017_2018_population_change,
		round(cast((((C._2019_SEX_AND_AGE__Total_population - C._2018_SEX_AND_AGE__Total_population) / C._2018_SEX_AND_AGE__Total_population)* 100) as numeric),
		4) as _2018_2019_population_change,
		round(cast((((C._2021_SEX_AND_AGE__Total_population - C._2019_SEX_AND_AGE__Total_population) / C._2019_SEX_AND_AGE__Total_population)* 100) as numeric),
		4) as _2019_2021_population_change,
		round(CAST((((C._2021_SEX_AND_AGE__Total_population - C._2013_SEX_AND_AGE__Total_population) / C._2013_SEX_AND_AGE__Total_population)*100) as numeric), 
		4) as _2013_2021_population_change
	from
		(
		select
			B.Name,
			B.state,
			B.city,
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
              on
			A.name = B.name
		where
			A._2013_SEX_AND_AGE__Total_population != 0 
        )
        C
        )
    D
)

select * from population_city_check where "check" = 'o'
order by "_2013_2021_population_change" desc

select name, state, "check" from population_city_check

CREATE OR REPLACE view population_city_viz as (
SELECT name,
       unnest(array['2013_2014', '2014_2015', '2015_2016', '2016_2017', '2017_2018', '2018_2019', '2019_2021', '2013_2021']) AS year,
       unnest(array["_2013_2014_population_change" , "_2014_2015_population_change","_2015_2016_population_change",
       "_2016_2017_population_change", "_2017_2018_population_change", "_2018_2019_population_change", "_2019_2021_population_change",
       "_2013_2021_population_change"]) AS change
FROM population_city_check
--where "_2021_sex_and_age__total_population" > 500000
ORDER BY name
)


select
	avg("_2013_2014_population_change"),
	avg("_2014_2015_population_change"),
	avg("_2015_2016_population_change"),
	avg("_2016_2017_population_change"),
	avg("_2017_2018_population_change"),
	avg("_2018_2019_population_change"),
	avg("_2019_2021_population_change")
from
	population_metro_politan_check
where
	"_2021_sex_and_age__total_population" > 500000



--##########################################################################################################################################################################
-- 2. We don't want to build too many houses and this is reason why - Housing Supply
create or replace
view population_per_unit_metro_politan_check as (
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
		B.name,
		B.metro_politan_area,
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
            on
		A.metro_politan_area = B.metro_politan_area
   )
   C
join
      (
	select
		E.Name,
		E.metro_politan_area,
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
               on
		D.metro_politan_area = E.metro_politan_area 
      )
      F 
      on
	C.name = F.name
where
	F._2021_SEX_AND_AGE__Total_population > 500000
)

create or replace
view population_per_unit_metro_politan_viz as (
select
	name,
	metro_politan_area,
	unnest(array['2013',
	'2014',
	'2015',
	'2016',
	'2017',
	'2018',
	'2019',
	'2021']) as year,
	unnest(array["_2013_population_per_units" ,
	"_2014_population_per_units",
	"_2015_population_per_units",
	"_2016_population_per_units",
	"_2017_population_per_units",
	"_2018_population_per_units",
	"_2019_population_per_units",
	"_2021_population_per_units"]) as change
from
	population_per_unit_metro_politan_check
order by
	name
)


create or replace
view population_per_unit_city_check as (
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
		B.name,
		B.state,
		B.city,
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
            on
		A.name = B.name
   )
   C
join
      (
	select
		E.Name,
		E.state,
		E.city,
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
	join acs_1_demographic_city_2021 E 
    on
		D.name = E.name
	where
		E._2021_SEX_AND_AGE__Total_population > 500000
      )
      F 
      on
	C.name = F.name
where
	F._2013_SEX_AND_AGE__Total_population != 0
)


create 
or replace
view population_per_unit_city_viz as (
select
	name,
	state,
	city,
	unnest(
      array[ '2013',
	'2014',
	'2015',
	'2016',
	'2017',
	'2018',
	'2019',
	'2021' ]
    ) as year,
	unnest(
      array[ "_2013_population_per_units",
	"_2014_population_per_units",
	"_2015_population_per_units",
	"_2016_population_per_units",
	"_2017_population_per_units",
	"_2018_population_per_units",
	"_2019_population_per_units",
	"_2021_population_per_units" ]
    ) as change
from
	population_per_unit_city_check
order by
	name
)


select
	avg("_2013_population_per_units"),
	avg("_2014_population_per_units"),
	avg("_2015_population_per_units"),
	avg("_2016_population_per_units"),
	avg("_2017_population_per_units"),
	avg("_2018_population_per_units"),
	avg("_2019_population_per_units"),
	avg("_2021_population_per_units")
from
	population_per_unit_metro_politan_check


--##########################################################################################################################################################################
-- 3. These are regions with high yield properties you didn't know in Jacksonville Florida

create or replace view rent_per_housing_price_metro_politan_check as (
select
	B.Name,
	B.metro_politan_area,
	round(cast((E._2013_GROSS_RENT__Occupied_units_paying_rent__Median_dollars / A._2013_VALUE__Owner_occupied_units__Median_dollars)* 1200 as numeric),
	4) _2013_rent_per_price,
	round(cast((E._2014_GROSS_RENT__Occupied_units_paying_rent__Median_dollars / A._2014_VALUE__Owner_occupied_units__Median_dollars)* 1200 as numeric),
	4) _2014_rent_per_price,
	round(cast((E._2015_GROSS_RENT__Occupied_units_paying_rent__Median_dollars / A._2015_VALUE__Owner_occupied_units__Median_dollars)* 1200 as numeric),
	4) _2015_rent_per_price,
	round(cast((E._2016_GROSS_RENT__Occupied_units_paying_rent__Median_dollars / A._2016_VALUE__Owner_occupied_units__Median_dollars)* 1200 as numeric),
	4) _2016_rent_per_price,
	round(cast((E._2017_GROSS_RENT__Occupied_units_paying_rent__Median_dollars / B._2017_VALUE__Owner_occupied_units__Median_dollars)* 1200 as numeric),
	4) _2017_rent_per_price,
	round(cast((E._2018_GROSS_RENT__Occupied_units_paying_rent__Median_dollars / B._2018_VALUE__Owner_occupied_units__Median_dollars)* 1200 as numeric),
	4) _2018_rent_per_price,
	round(cast((E._2019_GROSS_RENT__Occupied_units_paying_rent__Median_dollars / B._2019_VALUE__Owner_occupied_units__Median_dollars)* 1200 as numeric),
	4) _2019_rent_per_price,
	round(cast((E._2021_GROSS_RENT__Occupied_units_paying_rent__Median_dollars / B._2021_VALUE__Owner_occupied_units__Median_dollars)* 1200 as numeric),
	4) _2021_rent_per_price
from
	acs_1_housing_metro_politan_2016 A
join acs_1_housing_metro_politan_2021 B on
	A.metro_politan_area = B.metro_politan_area
join (
	select
		D.Name,
		D.metro_politan_area,
		C._2013_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
		C._2014_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
		C._2015_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
		C._2016_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
		D._2017_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
		D._2018_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
		D._2019_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
		D._2021_GROSS_RENT__Occupied_units_paying_rent__Median_dollars
	from
		acs_1_housing_metro_politan_2016 C
	join acs_1_housing_metro_politan_2021 D on
		C.metro_politan_area = D.metro_politan_area) E
on
	B.metro_politan_area = E.metro_politan_area
where
	A._2013_VALUE__Owner_occupied_units__Median_dollars != 0
	and B.metro_politan_area in 
(
	select
		metro_politan_area
	from
		acs_1_demographic_metro_politan_2021
	where
		"_2021_sex_and_age__total_population" > 500000)
)

CREATE OR REPLACE view rent_per_housing_price_metro_politan_viz as (
SELECT name, metro_politan_area,
       unnest(array['2013', '2014', '2015', '2016', '2017', '2018', '2019', '2021']) AS year,
       unnest(array["_2013_rent_per_price" , "_2014_rent_per_price","_2015_rent_per_price", "_2016_rent_per_price", 
       "_2017_rent_per_price", "_2018_rent_per_price", "_2019_rent_per_price", "_2021_rent_per_price"]) AS rent_per_price
FROM rent_per_housing_price_metro_politan_check
ORDER BY name
)

create or replace view rent_per_housing_price_city_check as (
select B.Name, B.state, B.city,
round(cast((E._2013_GROSS_RENT__Occupied_units_paying_rent__Median_dollars/A._2013_VALUE__Owner_occupied_units__Median_dollars)*1200 as numeric), 4) _2013_rent_per_price,
round(cast((E._2014_GROSS_RENT__Occupied_units_paying_rent__Median_dollars/A._2014_VALUE__Owner_occupied_units__Median_dollars)*1200 as numeric), 4) _2014_rent_per_price,
round(cast((E._2015_GROSS_RENT__Occupied_units_paying_rent__Median_dollars/A._2015_VALUE__Owner_occupied_units__Median_dollars)*1200 as numeric), 4) _2015_rent_per_price,
round(cast((E._2016_GROSS_RENT__Occupied_units_paying_rent__Median_dollars/A._2016_VALUE__Owner_occupied_units__Median_dollars)*1200 as numeric), 4) _2016_rent_per_price,
round(cast((E._2017_GROSS_RENT__Occupied_units_paying_rent__Median_dollars/B._2017_VALUE__Owner_occupied_units__Median_dollars)*1200 as numeric), 4) _2017_rent_per_price,
round(cast((E._2018_GROSS_RENT__Occupied_units_paying_rent__Median_dollars/B._2018_VALUE__Owner_occupied_units__Median_dollars)*1200 as numeric), 4) _2018_rent_per_price,
round(cast((E._2019_GROSS_RENT__Occupied_units_paying_rent__Median_dollars/B._2019_VALUE__Owner_occupied_units__Median_dollars)*1200 as numeric), 4) _2019_rent_per_price,
round(cast((E._2021_GROSS_RENT__Occupied_units_paying_rent__Median_dollars/B._2021_VALUE__Owner_occupied_units__Median_dollars)*1200 as numeric), 4) _2021_rent_per_price
from acs_1_housing_city_2016 A
join acs_1_housing_city_2021 B on A.name = B.name
join (select D.Name, D.state, D.city, 
C._2013_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
C._2014_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
C._2015_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
C._2016_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
D._2017_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
D._2018_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
D._2019_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
D._2021_GROSS_RENT__Occupied_units_paying_rent__Median_dollars
from acs_1_housing_city_2016 C
join acs_1_housing_city_2021 D on C.name = D.name) E
on B.name = E.name
where A._2013_VALUE__Owner_occupied_units__Median_dollars != 0
and B.name in 
(
	select
		name
	from
		acs_1_demographic_city_2021
	where
		"_2021_sex_and_age__total_population" > 500000)
)


CREATE OR REPLACE view rent_per_housing_price_city_viz as (
SELECT name, state, city,
       unnest(array['2013', '2014', '2015', '2016', '2017', '2018', '2019', '2021']) AS year,
       unnest(array["_2013_rent_per_price" , "_2014_rent_per_price","_2015_rent_per_price", "_2016_rent_per_price", 
       "_2017_rent_per_price", "_2018_rent_per_price", "_2019_rent_per_price", "_2021_rent_per_price"]) AS rent_per_price
FROM rent_per_housing_price_city_check
ORDER BY name
)


-- census_tract
-- FL
create or replace view rent_per_housing_price_census_tract_fl_viz as (
select B."name", B.state, B.county, B.tract, 
 round(cast((A._gross_rent__occupied_units_paying_rent__median_dollars / A._value__owner_occupied_units__median_dollars)*1200 as numeric), 4) _2016_roi,
 round(cast((B._gross_rent__occupied_units_paying_rent__median_dollars / B._value__owner_occupied_units__median_dollars)*1200 as numeric), 4) _2021_roi
from acs_5_housing_census_tract_fl_2016 A
join acs_5_housing_census_tract_fl_2021 B on A.name = B."name"
where A._value__owner_occupied_units__median_dollars != 0 and B._value__owner_occupied_units__median_dollars != 0
)

-- CA
create or replace view rent_per_housing_price_census_tract_ca_viz as (
select B."name", B.state, B.county, B.tract,
 round(cast((A._gross_rent__occupied_units_paying_rent__median_dollars / A._value__owner_occupied_units__median_dollars)*1200 as numeric), 4) _2016_roi,
 round(cast((B._gross_rent__occupied_units_paying_rent__median_dollars / B._value__owner_occupied_units__median_dollars)*1200 as numeric), 4) _2021_roi
from acs_5_housing_census_tract_ca_2016 A
join acs_5_housing_census_tract_ca_2021 B on A.name = B."name"
where A._value__owner_occupied_units__median_dollars != 0 and B._value__owner_occupied_units__median_dollars != 0
)

-- MI
create or replace view rent_per_housing_price_census_tract_mi_viz as (
select B."name", B.state, B.county, B.tract,
 round(cast((A._gross_rent__occupied_units_paying_rent__median_dollars / A._value__owner_occupied_units__median_dollars)*1200 as numeric), 4) _2016_roi,
 round(cast((B._gross_rent__occupied_units_paying_rent__median_dollars / B._value__owner_occupied_units__median_dollars)*1200 as numeric), 4) _2021_roi
from acs_5_housing_census_tract_mi_2016 A
join acs_5_housing_census_tract_mi_2021 B on A.name = B."name"
where A._value__owner_occupied_units__median_dollars != 0 and B._value__owner_occupied_units__median_dollars != 0
)


-- NC
create or replace view rent_per_housing_price_census_tract_nc_viz as (
select B."name", B.state, B.county, B.tract,
 round(cast((A._gross_rent__occupied_units_paying_rent__median_dollars / A._value__owner_occupied_units__median_dollars)*1200 as numeric), 4) _2016_roi,
 round(cast((B._gross_rent__occupied_units_paying_rent__median_dollars / B._value__owner_occupied_units__median_dollars)*1200 as numeric), 4) _2021_roi
from acs_5_housing_census_tract_nc_2016 A
join acs_5_housing_census_tract_nc_2021 B on A.name = B."name"
where A._value__owner_occupied_units__median_dollars != 0 and B._value__owner_occupied_units__median_dollars != 0
)

-- TX
create or replace view rent_per_housing_price_census_tract_tx_viz as (
select B."name", B.state, B.county, B.tract,
 round(cast((A._gross_rent__occupied_units_paying_rent__median_dollars / A._value__owner_occupied_units__median_dollars)*1200 as numeric), 4) _2016_roi,
 round(cast((B._gross_rent__occupied_units_paying_rent__median_dollars / B._value__owner_occupied_units__median_dollars)*1200 as numeric), 4) _2021_roi
from acs_5_housing_census_tract_tx_2016 A
join acs_5_housing_census_tract_tx_2021 B on A.name = B."name"
where A._value__owner_occupied_units__median_dollars != 0 and B._value__owner_occupied_units__median_dollars != 0
)



--##########################################################################################################################################################################
--4. The reason you can double the rent in Jacksonville Florida every 10 years
create or replace view income_metro_politan_check as (
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
  B.cp03_2021_062e as median_household_income_2021,
  round(cast(((A.cp03_2014_062e - A.cp03_2013_062e) / A.cp03_2013_062e) as numeric), 4) as _2013_2014_income_change,
  round(cast(((A.cp03_2015_062e - A.cp03_2014_062e) / A.cp03_2014_062e) as numeric), 4) as _2014_2015_income_change,
  round(cast(((A.cp03_2016_062e - A.cp03_2015_062e) / A.cp03_2015_062e) as numeric), 4) as _2015_2016_income_change,
  round(cast(((B.cp03_2017_062e - A.cp03_2016_062e) / A.cp03_2016_062e) as numeric), 4) as _2016_2017_income_change,
  round(cast(((B.cp03_2018_062e - B.cp03_2017_062e) / B.cp03_2017_062e) as numeric), 4) as _2017_2018_income_change,
  round(cast(((B.cp03_2019_062e - B.cp03_2018_062e) / B.cp03_2018_062e) as numeric), 4) as _2018_2019_income_change,
  round(cast(((B.cp03_2021_062e - B.cp03_2019_062e) / B.cp03_2019_062e) as numeric), 4) as _2019_2021_income_change,
  round(cast(((B.cp03_2021_062e - A.cp03_2013_062e) / A.cp03_2013_062e) as numeric), 4) as _2013_2021_income_change  
from 
  acs_1_economic_metro_politan_2016 A 
  join acs_1_economic_metro_politan_2021 B on A.metro_politan_area = B.metro_politan_area 
where 
  A.cp03_2013_062e != 0 
  and B.cp03_2017_062e != 0 
  and B.metro_politan_area in (
    select 
      metro_politan_area 
    from 
      acs_1_demographic_metro_politan_2021 
    where 
      "_2021_sex_and_age__total_population" > 500000
  )
)


create or replace
view income_city_check as (
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
	B.cp03_2021_062e as median_household_income_2021,
	round(cast(((A.cp03_2014_062e - A.cp03_2013_062e) / A.cp03_2013_062e) as numeric),
	4) as _2013_2014_income_change,
	round(cast(((A.cp03_2015_062e - A.cp03_2014_062e) / A.cp03_2014_062e) as numeric),
	4) as _2014_2015_income_change,
	round(cast(((A.cp03_2016_062e - A.cp03_2015_062e) / A.cp03_2015_062e) as numeric),
	4) as _2015_2016_income_change,
	round(cast(((B.cp03_2017_062e - A.cp03_2016_062e) / A.cp03_2016_062e) as numeric),
	4) as _2016_2017_income_change,
	round(cast(((B.cp03_2018_062e - B.cp03_2017_062e) / B.cp03_2017_062e) as numeric),
	4) as _2017_2018_income_change,
	round(cast(((B.cp03_2019_062e - B.cp03_2018_062e) / B.cp03_2018_062e) as numeric),
	4) as _2018_2019_income_change,
	round(cast(((B.cp03_2021_062e - B.cp03_2019_062e) / B.cp03_2019_062e) as numeric),
	4) as _2019_2021_income_change,
	round(cast(((B.cp03_2021_062e - A.cp03_2013_062e) / A.cp03_2013_062e) as numeric),
	4) as _2013_2021_income_change
from
	acs_1_economic_city_2016 A
join acs_1_economic_city_2021 B on
	A.name = B.name
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
)

create or replace view income_census_tract_fl_check as (
  select
	B.name,
	B.state,
	B.county,
	B.tract,
	A.dp03_0062e as median_household_income_2016,
	(A.dp03_0062e * 1.15) as inflation_adjusted_income_2016,
	B.dp03_0062e as median_household_income_2021,
	round(cast(((B.dp03_0062e - A.dp03_0062e) / A.dp03_0062e) as numeric),
	4) as _2016_2021_income_change
  from 
    acs_5_economic_census_tract_fl_2016 A 
  join acs_5_economic_census_tract_fl_2021 B on A.name = B.name
  where A.dp03_0062e != 0
)

create or replace view income_census_tract_ca_check as (
  select
	B.name,
	B.state,
	B.county,
	B.tract,
	A.dp03_0062e as median_household_income_2016,
	(A.dp03_0062e * 1.15) as inflation_adjusted_income_2016,
	B.dp03_0062e as median_household_income_2021,
	round(cast(((B.dp03_0062e - A.dp03_0062e) / A.dp03_0062e) as numeric),
	4) as _2016_2021_income_change
  from 
    acs_5_economic_census_tract_ca_2016 A 
  join acs_5_economic_census_tract_ca_2021 B on A.name = B.name
  where A.dp03_0062e != 0
)

create or replace view income_census_tract_mi_check as (
  select
	B.name,
	B.state,
	B.county,
	B.tract,
	A.dp03_0062e as median_household_income_2016,
	(A.dp03_0062e * 1.15) as inflation_adjusted_income_2016,
	B.dp03_0062e as median_household_income_2021,
	round(cast(((B.dp03_0062e - A.dp03_0062e) / A.dp03_0062e) as numeric),
	4) as _2016_2021_income_change
  from 
    acs_5_economic_census_tract_mi_2016 A 
  join acs_5_economic_census_tract_mi_2021 B on A.name = B.name
  where A.dp03_0062e != 0
)

create or replace view income_census_tract_nc_check as (
  select
	B.name,
	B.state,
	B.county,
	B.tract,
	A.dp03_0062e as median_household_income_2016,
	(A.dp03_0062e * 1.15) as inflation_adjusted_income_2016,
	B.dp03_0062e as median_household_income_2021,
	round(cast(((B.dp03_0062e - A.dp03_0062e) / A.dp03_0062e) as numeric),
	4) as _2016_2021_income_change
  from 
    acs_5_economic_census_tract_nc_2016 A 
  join acs_5_economic_census_tract_nc_2021 B on A.name = B.name
  where A.dp03_0062e != 0
)

create or replace view income_census_tract_tx_check as (
  select
	B.name,
	B.state,
	B.county,
	B.tract,
	A.dp03_0062e as median_household_income_2016,
	(A.dp03_0062e * 1.15) as inflation_adjusted_income_2016,
	B.dp03_0062e as median_household_income_2021,
	round(cast(((B.dp03_0062e - A.dp03_0062e) / A.dp03_0062e) as numeric),
	4) as _2016_2021_income_change
  from 
    acs_5_economic_census_tract_tx_2016 A 
  join acs_5_economic_census_tract_tx_2021 B on A.name = B.name
  where A.dp03_0062e != 0
)

    
  
create or replace view c_roi_income_census_tract_fl_viz as (
select
  	A.*,
    B._2016_roi, 
    B._2021_roi
  from 
    income_census_tract_fl_check A 
  join
  	rent_per_housing_price_census_tract_fl_viz B
  on A.name = B.name
)

create or replace view c_roi_income_census_tract_ca_viz as (
select
  	A.*,
    B._2016_roi, 
    B._2021_roi
  from 
    income_census_tract_ca_check A 
  join
  	rent_per_housing_price_census_tract_ca_viz B
  on A.name = B.name
)

create or replace view c_roi_income_census_tract_mi_viz as (
select
  	A.*,
    B._2016_roi, 
    B._2021_roi
  from 
    income_census_tract_mi_check A 
  join
  	rent_per_housing_price_census_tract_mi_viz B
  on A.name = B.name
)

create or replace view c_roi_income_census_tract_nc_viz as (
select
  	A.*,
    B._2016_roi, 
    B._2021_roi
  from 
    income_census_tract_nc_check A 
  join
  	rent_per_housing_price_census_tract_nc_viz B
  on A.name = B.name
)

create or replace view c_roi_income_census_tract_tx_viz as (
select
  	A.*,
    B._2016_roi, 
    B._2021_roi
  from 
    income_census_tract_tx_check A 
  join
  	rent_per_housing_price_census_tract_tx_viz B
  on A.name = B.name
)



--##########################################################################################################################################################################
-- 5. Housing Price Trend
-- Metro politan level 2013 housing price, 2021 housing price. income level. increase for housing, income.

create or replace view housing_price_metro_politan_check as (
select
	B.name,
	B.metro_politan_area,
	A._2013_VALUE__Owner_occupied_units__Median_dollars,
	A._2014_VALUE__Owner_occupied_units__Median_dollars,
	A._2015_VALUE__Owner_occupied_units__Median_dollars,
	A._2016_VALUE__Owner_occupied_units__Median_dollars,
	B._2017_VALUE__Owner_occupied_units__Median_dollars,
	B._2018_VALUE__Owner_occupied_units__Median_dollars,
	B._2019_VALUE__Owner_occupied_units__Median_dollars,
	B._2021_VALUE__Owner_occupied_units__Median_dollars,
	round(cast(((A._2014_VALUE__Owner_occupied_units__Median_dollars - A._2013_VALUE__Owner_occupied_units__Median_dollars) / A._2013_VALUE__Owner_occupied_units__Median_dollars) as numeric),
	4) as _2013_2014_housing_price_change,
	round(cast(((A._2015_VALUE__Owner_occupied_units__Median_dollars - A._2014_VALUE__Owner_occupied_units__Median_dollars) / A._2014_VALUE__Owner_occupied_units__Median_dollars) as numeric),
	4) as _2014_2015_housing_price_change,
	round(cast(((A._2016_VALUE__Owner_occupied_units__Median_dollars - A._2015_VALUE__Owner_occupied_units__Median_dollars) / A._2015_VALUE__Owner_occupied_units__Median_dollars) as numeric),
	4) as _2015_2016_housing_price_change,
	round(cast(((B._2017_VALUE__Owner_occupied_units__Median_dollars - A._2016_VALUE__Owner_occupied_units__Median_dollars) / A._2016_VALUE__Owner_occupied_units__Median_dollars) as numeric),
	4) as _2016_2017_housing_price_change,
	round(cast(((B._2018_VALUE__Owner_occupied_units__Median_dollars - B._2017_VALUE__Owner_occupied_units__Median_dollars) / B._2017_VALUE__Owner_occupied_units__Median_dollars) as numeric),
	4) as _2017_2018_housing_price_change,
	round(cast(((B._2019_VALUE__Owner_occupied_units__Median_dollars - B._2018_VALUE__Owner_occupied_units__Median_dollars) / B._2018_VALUE__Owner_occupied_units__Median_dollars) as numeric),
	4) as _2018_2019_housing_price_change,
	round(cast(((B._2021_VALUE__Owner_occupied_units__Median_dollars - B._2019_VALUE__Owner_occupied_units__Median_dollars) / B._2019_VALUE__Owner_occupied_units__Median_dollars) as numeric),
	4) as _2019_2021_housing_price_change,
	round(cast(((B._2021_VALUE__Owner_occupied_units__Median_dollars - A._2013_VALUE__Owner_occupied_units__Median_dollars) / A._2013_VALUE__Owner_occupied_units__Median_dollars) as numeric),
	4) as _2013_2021_housing_price_change
from
	acs_1_housing_metro_politan_2016 A
join acs_1_housing_metro_politan_2021 B
on A.metro_politan_area = B.metro_politan_area
)

select * from housing_price_metro_politan_check where metro_politan_area  in (
select metro_politan_area from population_metro_politan_check where _2021_sex_and_age__total_population > 500000
)

select * from population_metro_politan_check

create or replace
view c_roi_housing_price_msa_viz as (
select
	A.*,
	B."_2013_rent_per_price",
	B."_2014_rent_per_price",
	B."_2015_rent_per_price",
	B."_2016_rent_per_price",
	B."_2017_rent_per_price",
	B."_2018_rent_per_price",
	B."_2019_rent_per_price",
	B."_2021_rent_per_price"
from
	housing_price_metro_politan_check A
join rent_per_housing_price_metro_politan_check B
on
	A.metro_politan_area = B.metro_politan_area
)


create or replace view housing_price_city_check as (
select
	B.name,
	B.state,
	B.city,
	A._2013_VALUE__Owner_occupied_units__Median_dollars,
	A._2014_VALUE__Owner_occupied_units__Median_dollars,
	A._2015_VALUE__Owner_occupied_units__Median_dollars,
	A._2016_VALUE__Owner_occupied_units__Median_dollars,
	B._2017_VALUE__Owner_occupied_units__Median_dollars,
	B._2018_VALUE__Owner_occupied_units__Median_dollars,
	B._2019_VALUE__Owner_occupied_units__Median_dollars,
	B._2021_VALUE__Owner_occupied_units__Median_dollars,
	round(cast(((A._2014_VALUE__Owner_occupied_units__Median_dollars - A._2013_VALUE__Owner_occupied_units__Median_dollars) / A._2013_VALUE__Owner_occupied_units__Median_dollars) as numeric),
	4) as _2013_2014_housing_price_change,
	round(cast(((A._2015_VALUE__Owner_occupied_units__Median_dollars - A._2014_VALUE__Owner_occupied_units__Median_dollars) / A._2014_VALUE__Owner_occupied_units__Median_dollars) as numeric),
	4) as _2014_2015_housing_price_change,
	round(cast(((A._2016_VALUE__Owner_occupied_units__Median_dollars - A._2015_VALUE__Owner_occupied_units__Median_dollars) / A._2015_VALUE__Owner_occupied_units__Median_dollars) as numeric),
	4) as _2015_2016_housing_price_change,
	round(cast(((B._2017_VALUE__Owner_occupied_units__Median_dollars - A._2016_VALUE__Owner_occupied_units__Median_dollars) / A._2016_VALUE__Owner_occupied_units__Median_dollars) as numeric),
	4) as _2016_2017_housing_price_change,
	round(cast(((B._2018_VALUE__Owner_occupied_units__Median_dollars - B._2017_VALUE__Owner_occupied_units__Median_dollars) / B._2017_VALUE__Owner_occupied_units__Median_dollars) as numeric),
	4) as _2017_2018_housing_price_change,
	round(cast(((B._2019_VALUE__Owner_occupied_units__Median_dollars - B._2018_VALUE__Owner_occupied_units__Median_dollars) / B._2018_VALUE__Owner_occupied_units__Median_dollars) as numeric),
	4) as _2018_2019_housing_price_change,
	round(cast(((B._2021_VALUE__Owner_occupied_units__Median_dollars - B._2019_VALUE__Owner_occupied_units__Median_dollars) / B._2019_VALUE__Owner_occupied_units__Median_dollars) as numeric),
	4) as _2019_2021_housing_price_change,
	round(cast(((B._2021_VALUE__Owner_occupied_units__Median_dollars - A._2013_VALUE__Owner_occupied_units__Median_dollars) / A._2013_VALUE__Owner_occupied_units__Median_dollars) as numeric),
	4) as _2013_2021_housing_price_change
from
	acs_1_housing_city_2016 A
join acs_1_housing_city_2021 B
on A.name = B.name
)

create or replace
view c_roi_housing_price_city_viz as (
select
	A.*,
	B."_2013_rent_per_price",
	B."_2014_rent_per_price",
	B."_2015_rent_per_price",
	B."_2016_rent_per_price",
	B."_2017_rent_per_price",
	B."_2018_rent_per_price",
	B."_2019_rent_per_price",
	B."_2021_rent_per_price"
from
	housing_price_city_check A
join rent_per_housing_price_city_check B
on
	A.name = B.name
)

--CA
create or replace view c_roi_income_housing_price_ca as (
select
	B.name,
	B.state,
	B.county,
	B.tract,
	A._value__owner_occupied_units__median_dollars as median_housing_price_2016,
	B._value__owner_occupied_units__median_dollars as median_housing_price_2021,
	round(cast(((B._value__owner_occupied_units__median_dollars - A._value__owner_occupied_units__median_dollars) / A._value__owner_occupied_units__median_dollars) as numeric),
	4) as _2016_2021_housing_price_change,
	C.median_household_income_2016,
	C.inflation_adjusted_income_2016,
	C.median_household_income_2021,
	C._2016_2021_income_change,
	C._2016_roi,
	C._2021_roi
from
	acs_5_housing_census_tract_ca_2016 A
join acs_5_housing_census_tract_ca_2021 B on
	A.name = B.name
join c_roi_income_census_tract_ca_viz C
on B.name = C.name
where
	A._value__owner_occupied_units__median_dollars != 0
	and B._value__owner_occupied_units__median_dollars != 0
)

-- FL
create or replace view c_roi_income_housing_price_fl as (
select
	B.name,
	B.state,
	B.county,
	B.tract,
	A._value__owner_occupied_units__median_dollars as median_housing_price_2016,
	B._value__owner_occupied_units__median_dollars as median_housing_price_2021,
	round(cast(((B._value__owner_occupied_units__median_dollars - A._value__owner_occupied_units__median_dollars) / A._value__owner_occupied_units__median_dollars) as numeric),
	4) as _2016_2021_housing_price_change,
	C.median_household_income_2016,
	C.inflation_adjusted_income_2016,
	C.median_household_income_2021,
	C._2016_2021_income_change,
	C._2016_roi,
	C._2021_roi
from
	acs_5_housing_census_tract_fl_2016 A
join acs_5_housing_census_tract_fl_2021 B on
	A.name = B.name
join c_roi_income_census_tract_fl_viz C
on B.name = C.name
where
	A._value__owner_occupied_units__median_dollars != 0
	and B._value__owner_occupied_units__median_dollars != 0
)

-- MI
create or replace view c_roi_income_housing_price_mi as (
select
	B.name,
	B.state,
	B.county,
	B.tract,
	A._value__owner_occupied_units__median_dollars as median_housing_price_2016,
	B._value__owner_occupied_units__median_dollars as median_housing_price_2021,
	round(cast(((B._value__owner_occupied_units__median_dollars - A._value__owner_occupied_units__median_dollars) / A._value__owner_occupied_units__median_dollars) as numeric),
	4) as _2016_2021_housing_price_change,
	C.median_household_income_2016,
	C.inflation_adjusted_income_2016,
	C.median_household_income_2021,
	C._2016_2021_income_change,
	C._2016_roi,
	C._2021_roi
from
	acs_5_housing_census_tract_mi_2016 A
join acs_5_housing_census_tract_mi_2021 B on
	A.name = B.name
join c_roi_income_census_tract_mi_viz C
on B.name = C.name
where
	A._value__owner_occupied_units__median_dollars != 0
	and B._value__owner_occupied_units__median_dollars != 0
)

-- NC
create or replace view c_roi_income_housing_price_nc as (
select
	B.name,
	B.state,
	B.county,
	B.tract,
	A._value__owner_occupied_units__median_dollars as median_housing_price_2016,
	B._value__owner_occupied_units__median_dollars as median_housing_price_2021,
	round(cast(((B._value__owner_occupied_units__median_dollars - A._value__owner_occupied_units__median_dollars) / A._value__owner_occupied_units__median_dollars) as numeric),
	4) as _2016_2021_housing_price_change,
	C.median_household_income_2016,
	C.inflation_adjusted_income_2016,
	C.median_household_income_2021,
	C._2016_2021_income_change,
	C._2016_roi,
	C._2021_roi
from
	acs_5_housing_census_tract_nc_2016 A
join acs_5_housing_census_tract_nc_2021 B on
	A.name = B.name
join c_roi_income_census_tract_nc_viz C
on B.name = C.name
where
	A._value__owner_occupied_units__median_dollars != 0
	and B._value__owner_occupied_units__median_dollars != 0
)


-- TX
create or replace view c_roi_income_housing_price_tx as (
select
	B.name,
	B.state,
	B.county,
	B.tract,
	A._value__owner_occupied_units__median_dollars as median_housing_price_2016,
	B._value__owner_occupied_units__median_dollars as median_housing_price_2021,
	round(cast(((B._value__owner_occupied_units__median_dollars - A._value__owner_occupied_units__median_dollars) / A._value__owner_occupied_units__median_dollars) as numeric),
	4) as _2016_2021_housing_price_change,
	C.median_household_income_2016,
	C.inflation_adjusted_income_2016,
	C.median_household_income_2021,
	C._2016_2021_income_change,
	C._2016_roi,
	C._2021_roi
from
	acs_5_housing_census_tract_tx_2016 A
join acs_5_housing_census_tract_tx_2021 B on
	A.name = B.name
join c_roi_income_census_tract_tx_viz C
on B.name = C.name
where
	A._value__owner_occupied_units__median_dollars != 0
	and B._value__owner_occupied_units__median_dollars != 0
)

--##########################################################################################################################################################################
-- 6. Housing Price Trend
create or replace view c_roi_housinig_price_income_msa as (
select A.*,
B.median_household_income_2013,
B.median_household_income_2014,
B.median_household_income_2015,
B.median_household_income_2016,
B.median_household_income_2017,
B.median_household_income_2018,
B.median_household_income_2019,
B.median_household_income_2021,
B._2013_2014_income_change,
B._2014_2015_income_change,
B._2015_2016_income_change,
B._2016_2017_income_change,
B._2017_2018_income_change,
B._2018_2019_income_change,
B._2019_2021_income_change,
B._2013_2021_income_change
from c_roi_housing_price_msa_viz A
join
income_metro_politan_check B
on
A.metro_politan_area = B.metro_politan_area
)

create or replace
view c_roi_housinig_price_income_adj_msa as (
select
	A.*,
	round(cast((A.median_household_income_2013 / B._2013_average_income) as numeric), 4) as _2013_income_scaled,
	round(cast((A.median_household_income_2021 / B._2021_average_income) as numeric), 4) as _2021_income_scaled,
	round(cast((A._2013_VALUE__Owner_occupied_units__Median_dollars / B._2013_average_housing_price) as numeric), 4) as _2013_housing_price_scaled,
	round(cast((A._2021_VALUE__Owner_occupied_units__Median_dollars / B._2021_average_housing_price) as numeric), 4) as _2021_housing_price_scaled
from
	c_roi_housinig_price_income_msa A,
	(
	select
		avg(median_household_income_2013) as _2013_average_income,
		avg(median_household_income_2021) as _2021_average_income,
		avg(_2013_VALUE__Owner_occupied_units__Median_dollars) as _2013_average_housing_price,
		avg(_2021_VALUE__Owner_occupied_units__Median_dollars) as _2021_average_housing_price
	from
		c_roi_housinig_price_income_msa
) B
)

create or replace
view c_roi_housinig_price_income_city as (
select
	A.*,
	B.median_household_income_2013,
	B.median_household_income_2014,
	B.median_household_income_2015,
	B.median_household_income_2016,
	B.median_household_income_2017,
	B.median_household_income_2018,
	B.median_household_income_2019,
	B.median_household_income_2021,
	B._2013_2014_income_change,
	B._2014_2015_income_change,
	B._2015_2016_income_change,
	B._2016_2017_income_change,
	B._2017_2018_income_change,
	B._2018_2019_income_change,
	B._2019_2021_income_change,
	B._2013_2021_income_change
from
	c_roi_housing_price_city_viz A
join
income_city_check B
on
	A.name = B.name
)


create or replace
view c_roi_housinig_price_income_adj_city as (
select
	A.*,
	round(cast((A.median_household_income_2013 / B._2013_average_income) as numeric), 4) as _2013_income_scaled,
	round(cast((A.median_household_income_2021 / B._2021_average_income) as numeric), 4) as _2021_income_scaled,
	round(cast((A._2013_VALUE__Owner_occupied_units__Median_dollars / B._2013_average_housing_price) as numeric), 4) as _2013_housing_price_scaled,
	round(cast((A._2021_VALUE__Owner_occupied_units__Median_dollars / B._2021_average_housing_price) as numeric), 4) as _2021_housing_price_scaled
from
	c_roi_housinig_price_income_city A,
	(
	select
		avg(median_household_income_2013) as _2013_average_income,
		avg(median_household_income_2021) as _2021_average_income,
		avg(_2013_VALUE__Owner_occupied_units__Median_dollars) as _2013_average_housing_price,
		avg(_2021_VALUE__Owner_occupied_units__Median_dollars) as _2021_average_housing_price
	from
		c_roi_housinig_price_income_city
) B
)


-- SF County
create or replace
view c_roi_income_housing_price_adj_sf_ca as (
select
	A.*,
	round(cast((A.median_household_income_2016 / B._2016_average_income) as numeric), 4) as _2016_income_scaled,
	round(cast((A.median_household_income_2021 / B._2021_average_income) as numeric), 4) as _2021_income_scaled,
	round(cast((A.median_housing_price_2016 / B._2016_average_housing_price) as numeric), 4) as _2016_housing_price_scaled,
	round(cast((A.median_housing_price_2021 / B._2021_average_housing_price) as numeric), 4) as _2021_housing_price_scaled
from
	c_roi_income_housing_price_ca A,
	(
	select
		avg(median_household_income_2016) as _2016_average_income,
		avg(median_household_income_2021) as _2021_average_income,
		avg(median_housing_price_2016) as _2016_average_housing_price,
		avg(median_housing_price_2021) as _2021_average_housing_price
	from
		c_roi_income_housing_price_ca
	where county = '075'
) B
where A.county = '075'
)


-- Detroit (Wayne) County
create or replace
view c_roi_income_housing_price_adj_detroit_mi as (
select
	A.*,
	round(cast((A.median_household_income_2016 / B._2016_average_income) as numeric), 4) as _2016_income_scaled,
	round(cast((A.median_household_income_2021 / B._2021_average_income) as numeric), 4) as _2021_income_scaled,
	round(cast((A.median_housing_price_2016 / B._2016_average_housing_price) as numeric), 4) as _2016_housing_price_scaled,
	round(cast((A.median_housing_price_2021 / B._2021_average_housing_price) as numeric), 4) as _2021_housing_price_scaled
from
	c_roi_income_housing_price_mi A,
	(
	select
		avg(median_household_income_2016) as _2016_average_income,
		avg(median_household_income_2021) as _2021_average_income,
		avg(median_housing_price_2016) as _2016_average_housing_price,
		avg(median_housing_price_2021) as _2021_average_housing_price
	from
		c_roi_income_housing_price_mi
	where county = '163'
) B
where A.county = '163'
)


--Charlotte, Mecklenburg County
create or replace
view c_roi_income_housing_price_adj_charlotte_nc as (
select
	A.*,
	round(cast((A.median_household_income_2016 / B._2016_average_income) as numeric), 4) as _2016_income_scaled,
	round(cast((A.median_household_income_2021 / B._2021_average_income) as numeric), 4) as _2021_income_scaled,
	round(cast((A.median_housing_price_2016 / B._2016_average_housing_price) as numeric), 4) as _2016_housing_price_scaled,
	round(cast((A.median_housing_price_2021 / B._2021_average_housing_price) as numeric), 4) as _2021_housing_price_scaled
from
	c_roi_income_housing_price_nc A,
	(
	select
		avg(median_household_income_2016) as _2016_average_income,
		avg(median_household_income_2021) as _2021_average_income,
		avg(median_housing_price_2016) as _2016_average_housing_price,
		avg(median_housing_price_2021) as _2021_average_housing_price
	from
		c_roi_income_housing_price_nc
	where county = '119'
) B
where A.county = '119'
)

--Dallas, Fortworth County
create or replace
view c_roi_income_housing_price_adj_dallas_tx as (
select
	A.*,
	round(cast((A.median_household_income_2016 / B._2016_average_income) as numeric), 4) as _2016_income_scaled,
	round(cast((A.median_household_income_2021 / B._2021_average_income) as numeric), 4) as _2021_income_scaled,
	round(cast((A.median_housing_price_2016 / B._2016_average_housing_price) as numeric), 4) as _2016_housing_price_scaled,
	round(cast((A.median_housing_price_2021 / B._2021_average_housing_price) as numeric), 4) as _2021_housing_price_scaled
from
	c_roi_income_housing_price_tx A,
	(
	select
		avg(median_household_income_2016) as _2016_average_income,
		avg(median_household_income_2021) as _2021_average_income,
		avg(median_housing_price_2016) as _2016_average_housing_price,
		avg(median_housing_price_2021) as _2021_average_housing_price
	from
		c_roi_income_housing_price_tx
	where county = '113'
) B
where A.county = '113'
)


select * from c_roi_income_housing_price_tx


create 
or replace
view c_housing_price_city_viz as (
select
	name,
	state,
	city,
	unnest(
      array[ '2013',
	'2014',
	'2015',
	'2016',
	'2017',
	'2018',
	'2019',
	'2021' ]
    ) as year,
	unnest(
      array["_2013_value__owner_occupied_units__median_dollars",
	"_2014_value__owner_occupied_units__median_dollars",
	"_2015_value__owner_occupied_units__median_dollars",
	"_2016_value__owner_occupied_units__median_dollars",
	"_2017_value__owner_occupied_units__median_dollars",
	"_2018_value__owner_occupied_units__median_dollars",
	"_2019_value__owner_occupied_units__median_dollars",
	"_2021_value__owner_occupied_units__median_dollars"]
    ) as change
from
	housing_price_city_check
order by
	name
)

--##########################################################################################################################################################################
--8. Is Your Potential Real Estate Investment Priced Right? Ensuring Your Real Estate Investment Fits the Right Price Range
 select A.Name, A.state, A.city, 'less_than_50,000' as price_range,
A._2013_VALUE__Owner_occupied_units__Less_than_$50000 as _2013_price,
 A._2014_VALUE__Owner_occupied_units__Less_than_$50000 as _2014_price,
 A._2015_VALUE__Owner_occupied_units__Less_than_$50000 as _2015_price,
 A._2016_VALUE__Owner_occupied_units__Less_than_$50000 as _2016_price,
 B._2017_VALUE__Owner_occupied_units__Less_than_$50000 as _2017_price,
 B._2018_VALUE__Owner_occupied_units__Less_than_$50000 as _2018_price,
 B._2019_VALUE__Owner_occupied_units__Less_than_$50000 as _2019_price,
 B._2021_VALUE__Owner_occupied_units__Less_than_$50000 as _2021_price
 from acs_1_housing_city_2016 A
 join acs_1_housing_city_2021 B on A.name = B.name
 union
 select A.Name, A.state, A.city, '50,000_to_99,999' as price_range, 
 A._2013_VALUE__Owner_occupied_units__$50000_to_$99999 as _2013_price,
 A._2014_VALUE__Owner_occupied_units__$50000_to_$99999 as _2014_price,
 A._2015_VALUE__Owner_occupied_units__$50000_to_$99999 as _2015_price,
 A._2016_VALUE__Owner_occupied_units__$50000_to_$99999 as _2016_price,
 B._2017_VALUE__Owner_occupied_units__$50000_to_$99999 as _2017_price,
 B._2018_VALUE__Owner_occupied_units__$50000_to_$99999 as _2018_price,
 B._2019_VALUE__Owner_occupied_units__$50000_to_$99999 as _2019_price,
 B._2021_VALUE__Owner_occupied_units__$50000_to_$99999 as _2021_price
 from acs_1_housing_city_2016 A
 join acs_1_housing_city_2021 B on A.name = B.name
 union
 select A.Name, A.state, A.city, '100,000_to_149,999' as price_range, 
 A._2013_VALUE__Owner_occupied_units__$100000_to_$149999 as _2013_price,
 A._2014_VALUE__Owner_occupied_units__$100000_to_$149999 as _2014_price,
 A._2015_VALUE__Owner_occupied_units__$100000_to_$149999 as _2015_price,
 A._2016_VALUE__Owner_occupied_units__$100000_to_$149999 as _2016_price,
 B._2017_VALUE__Owner_occupied_units__$100000_to_$149999 as _2017_price,
 B._2018_VALUE__Owner_occupied_units__$100000_to_$149999 as _2018_price,
 B._2019_VALUE__Owner_occupied_units__$100000_to_$149999 as _2019_price,
 B._2021_VALUE__Owner_occupied_units__$100000_to_$149999 as _2021_price
 from acs_1_housing_city_2016 A
 join acs_1_housing_city_2021 B on A.name = B.name
 union
 select A.Name, A.state, A.city, '150,000_to_199,999' as price_range, 
 A._2013_VALUE__Owner_occupied_units__$150000_to_$199999 as _2013_price,
 A._2014_VALUE__Owner_occupied_units__$150000_to_$199999 as _2014_price,
 A._2015_VALUE__Owner_occupied_units__$150000_to_$199999 as _2015_price,
 A._2016_VALUE__Owner_occupied_units__$150000_to_$199999 as _2016_price,
 B._2017_VALUE__Owner_occupied_units__$150000_to_$199999 as _2017_price,
 B._2018_VALUE__Owner_occupied_units__$150000_to_$199999 as _2018_price,
 B._2019_VALUE__Owner_occupied_units__$150000_to_$199999 as _2019_price,
 B._2021_VALUE__Owner_occupied_units__$150000_to_$199999 as _2021_price
 from acs_1_housing_city_2016 A
 join acs_1_housing_city_2021 B on A.name = B.name
 union
 select A.Name, A.state, A.city, '200,000_to_299,999' as price_range, 
 A._2013_VALUE__Owner_occupied_units__$200000_to_$299999 as _2013_price,
 A._2014_VALUE__Owner_occupied_units__$200000_to_$299999 as _2014_price,
 A._2015_VALUE__Owner_occupied_units__$200000_to_$299999 as _2015_price,
 A._2016_VALUE__Owner_occupied_units__$200000_to_$299999 as _2016_price,
 B._2017_VALUE__Owner_occupied_units__$200000_to_$299999 as _2017_price,
 B._2018_VALUE__Owner_occupied_units__$200000_to_$299999 as _2018_price,
 B._2019_VALUE__Owner_occupied_units__$200000_to_$299999 as _2019_price,
 B._2021_VALUE__Owner_occupied_units__$200000_to_$299999 as _2021_price
 from acs_1_housing_city_2016 A
 join acs_1_housing_city_2021 B on A.name = B.name
 union
 select A.Name, A.state, A.city, '300,000_to_499,999' as price_range, 
 A._2013_VALUE__Owner_occupied_units__$300000_to_$499999 as _2013_price,
 A._2014_VALUE__Owner_occupied_units__$300000_to_$499999 as _2014_price,
 A._2015_VALUE__Owner_occupied_units__$300000_to_$499999 as _2015_price,
 A._2016_VALUE__Owner_occupied_units__$300000_to_$499999 as _2016_price,
 B._2017_VALUE__Owner_occupied_units__$300000_to_$499999 as _2017_price,
 B._2018_VALUE__Owner_occupied_units__$300000_to_$499999 as _2018_price,
 B._2019_VALUE__Owner_occupied_units__$300000_to_$499999 as _2019_price,
 B._2021_VALUE__Owner_occupied_units__$300000_to_$499999 as _2021_price
 from acs_1_housing_city_2016 A
 join acs_1_housing_city_2021 B on A.name = B.name
 union
 select A.Name, A.state, A.city, '500,000_to_999,999' as price_range, 
 A._2013_VALUE__Owner_occupied_units__$500000_to_$999999 as _2013_price,
 A._2014_VALUE__Owner_occupied_units__$500000_to_$999999 as _2014_price,
 A._2015_VALUE__Owner_occupied_units__$500000_to_$999999 as _2015_price,
 A._2016_VALUE__Owner_occupied_units__$500000_to_$999999 as _2016_price,
 B._2017_VALUE__Owner_occupied_units__$500000_to_$999999 as _2017_price,
 B._2018_VALUE__Owner_occupied_units__$500000_to_$999999 as _2018_price,
 B._2019_VALUE__Owner_occupied_units__$500000_to_$999999 as _2019_price,
 B._2021_VALUE__Owner_occupied_units__$500000_to_$999999 as _2021_price
 from acs_1_housing_city_2016 A
 join acs_1_housing_city_2021 B on A.name = B.name
 union
 select A.Name, A.state, A.city, '1,000,000_and_more' as price_range, 
 A._2013_VALUE__Owner_occupied_units__$1000000_or_more as _2013_price,
 A._2014_VALUE__Owner_occupied_units__$1000000_or_more as _2014_price,
 A._2015_VALUE__Owner_occupied_units__$1000000_or_more as _2015_price,
 A._2016_VALUE__Owner_occupied_units__$1000000_or_more as _2016_price,
 B._2017_VALUE__Owner_occupied_units__$1000000_or_more as _2017_price,
 B._2018_VALUE__Owner_occupied_units__$1000000_or_more as _2018_price,
 B._2019_VALUE__Owner_occupied_units__$1000000_or_more as _2019_price,
 B._2021_VALUE__Owner_occupied_units__$1000000_or_more as _2021_price
 from acs_1_housing_city_2016 A
 join acs_1_housing_city_2021 B on A.name = B.name

 
 
create or replace view housing_price_proportion_census_tract_fl_viz as (
select C.* from (
 select A.Name, A.state, A.county, A.tract, '1_Less_than_50000' as price_range, 
A."_value__owner_occupied_units__less_than_$50000" as number_of_housing_2016, B."_value__owner_occupied_units__less_than_$50000" as number_of_housing_2021
from acs_5_housing_census_tract_fl_2016  A
join acs_5_housing_census_tract_fl_2021 B on A.name = B.name
union
select A.Name, A.state, A.county, A.tract, '2_50000_to_99999' as price_range, 
A."_value__owner_occupied_units__$50000_to_$99999" as number_of_housing_2016 , B."_value__owner_occupied_units__$50000_to_$99999" as number_of_housing_2021
from acs_5_housing_census_tract_fl_2016  A
join acs_5_housing_census_tract_fl_2021 B on A.name = B.name
union
select A.Name, A.state, A.county, A.tract, '3_100000_to_149999' as price_range, 
A."_value__owner_occupied_units__$100000_to_$149999" as number_of_housing_2016, B."_value__owner_occupied_units__$100000_to_$149999" as number_of_housing_2021
from acs_5_housing_census_tract_fl_2016  A
join acs_5_housing_census_tract_fl_2021 B on A.name = B.name
union
select A.Name, A.state, A.county, A.tract, '4_150000_to_199999' as price_range, 
A."_value__owner_occupied_units__$150000_to_$199999"  as number_of_housing_2016, B."_value__owner_occupied_units__$150000_to_$199999" as number_of_housing_2021
from acs_5_housing_census_tract_fl_2016  A
join acs_5_housing_census_tract_fl_2021 B on A.name = B.name
union
select A.Name, A.state, A.county, A.tract, '5_200000_to_299999' as price_range, 
A."_value__owner_occupied_units__$200000_to_$299999"  as number_of_housing_2016, B."_value__owner_occupied_units__$200000_to_$299999" as number_of_housing_2021
from acs_5_housing_census_tract_fl_2016  A
join acs_5_housing_census_tract_fl_2021 B on A.name = B.name
union
select A.Name, A.state, A.county, A.tract, '6_300000_to_499999' as price_range, 
A."_value__owner_occupied_units__$300000_to_$499999"  as number_of_housing_2016, B."_value__owner_occupied_units__$300000_to_$499999"  as number_of_housing_2021
from acs_5_housing_census_tract_fl_2016  A
join acs_5_housing_census_tract_fl_2021 B on A.name = B.name
union
select A.Name, A.state, A.county, A.tract, '7_500000_to_999999' as price_range, 
A."_value__owner_occupied_units__$500000_to_$999999"  as number_of_housing_2016, B."_value__owner_occupied_units__$500000_to_$999999"  as number_of_housing_2021
from acs_5_housing_census_tract_fl_2016  A
join acs_5_housing_census_tract_fl_2021 B on A.name = B.name
union
select A.Name, A.state, A.county, A.tract, '8_1000000_and_more' as price_range, 
A."_value__owner_occupied_units__$1000000_or_more"  as number_of_housing_2016, B."_value__owner_occupied_units__$1000000_or_more"  as number_of_housing_2021
from acs_5_housing_census_tract_fl_2016  A
join acs_5_housing_census_tract_fl_2021 B on A.name = B.name
) C
order by C.name, C.price_range
)


-- FL
create or replace
view c_roi_income_housing_price_unit_fl as (
select
	E.*,
	C._2016_housing_units,
	C._2021_housing_units,
	C.housing_unit_change
from
	c_roi_income_housing_price_fl E
join
    (
	select
		A."name",
		A.state,
		A.county,
		A.tract,
		A."_total_housing_units_x" as _2016_housing_units,
		B."_total_housing_units_x" as _2021_housing_units,
		round(cast(((B._total_housing_units_x - A._total_housing_units_x)/ A._total_housing_units_x)* 100 as numeric),
		4) as housing_unit_change
	from
		acs_5_housing_census_tract_fl_2016 A
	join
        acs_5_housing_census_tract_fl_2021 B 
            on
		A.name = B."name") C 
        on
	E.name = C.name 
	)


--##########################################################################################################################################################################
-- 6. Is your neighborhood renter friendly? Hidden figures to consider when investing
select A.Name, A.state, A.city, A._2013_Rental_vacancy_rate, A._2014_Rental_vacancy_rate, 
 A._2015_Rental_vacancy_rate, A._2016_Rental_vacancy_rate,
 B._2017_Total_housing_units__Rental_vacancy_rate,
 B._2018_Total_housing_units__Rental_vacancy_rate, B._2019_Total_housing_units__Rental_vacancy_rate,
 B._2021_Total_housing_units__Rental_vacancy_rate
 from acs_1_housing_city_2016 A
 join acs_1_housing_city_2021 B on A.name = B.name
 
 select A.Name, A.state, A.city, A._2013_Occupied_housing_units__Renter_occupied,
 A._2014_Occupied_housing_units__Renter_occupied,
 A._2015_Occupied_housing_units__Renter_occupied,
 A._2016_Occupied_housing_units__Renter_occupied,
 B._2017_Occupied_housing_units__Renter_occupied,
 B._2018_Occupied_housing_units__Renter_occupied, B._2019_Occupied_housing_units__Renter_occupied,
 B._2021_Occupied_housing_units__Renter_occupied
 from acs_1_housing_city_2016 A
 join acs_1_housing_city_2021 B on A.name = B.name
 
 
-- census_tract
create or replace view rent_vacancy_census_tract_fl_viz as ( select
    D.*,
    C.rental_vacancy_rate_2016,
    C.rental_vacancy_rate_2021,
    C.rent_occupied_rate_2016,
    C.rent_occupied_rate_2021 
from
    housing_price_census_tract_fl_viz D 
join
    (select
        A.Name,
        A.state,
        A.county,
        A.tract,
        round(cast(A."_rental_vacancy_rate" as numeric), 3) as rental_vacancy_rate_2016,
        round(cast(B."_total_housing_units__rental_vacancy_rate" as numeric), 3) as rental_vacancy_rate_2021,
        round(cast((A."_occupied_housing_units__renter_occupied" / A."_occupied_housing_units")*100 as numeric), 2) rent_occupied_rate_2016,
        A."_occupied_housing_units" as renter_occupied_housing_unit_2016,
        round(cast((B."_occupied_housing_units__renter_occupied" / B."_occupied_housing_units")*100 as numeric), 2) rent_occupied_rate_2021,
        B."_occupied_housing_units" as renter_occupied_housing_unit_2021 
    from
        acs_5_housing_census_tract_fl_2016 A 
    join
        acs_5_housing_census_tract_fl_2021 B 
            on A.name = B.name) C 
            on C.name = D.name )

select * from rent_vacancy_census_tract_fl_viz


--TX
create or replace view rent_vacancy_census_tract_tx_viz as ( select
    D.*,
    C.rental_vacancy_rate_2016,
    C.rental_vacancy_rate_2021,
    C.rent_occupied_rate_2016,
    C.rent_occupied_rate_2021 
from
    housing_price_census_tract_tx_viz D 
join
    (select
        A.Name,
        A.state,
        A.county,
        A.tract,
        round(cast(A."_rental_vacancy_rate" as numeric), 3) as rental_vacancy_rate_2016,
        round(cast(B."_total_housing_units__rental_vacancy_rate" as numeric), 3) as rental_vacancy_rate_2021,
        round(cast((A."_occupied_housing_units__renter_occupied" / A."_occupied_housing_units")*100 as numeric), 2) rent_occupied_rate_2016,
        A."_occupied_housing_units" as renter_occupied_housing_unit_2016,
        round(cast((B."_occupied_housing_units__renter_occupied" / B."_occupied_housing_units")*100 as numeric), 2) rent_occupied_rate_2021,
        B."_occupied_housing_units" as renter_occupied_housing_unit_2021 
    from
        acs_5_housing_census_tract_tx_2016 A 
    join
        acs_5_housing_census_tract_tx_2021 B 
            on A.name = B.name) C 
            on C.name = D.name )

            
            
select * from rent_vacancy_census_tract_tx_viz

--CA
create or replace view rent_vacancy_census_tract_ca_viz as (
select D.*, C.rental_vacancy_rate_2016, C.rental_vacancy_rate_2021, C.rent_occupied_rate_2016, C.rent_occupied_rate_2021 from housing_price_census_tract_ca_viz D
join (select A.Name, A.state, A.county, A.tract, 
round(cast(A."_rental_vacancy_rate" as numeric), 3) as rental_vacancy_rate_2016,
round(cast(B."_total_housing_units__rental_vacancy_rate" as numeric), 3) as rental_vacancy_rate_2021,
round(cast((A."_occupied_housing_units__renter_occupied" / A."_occupied_housing_units")*100 as numeric), 2) rent_occupied_rate_2016, 
A."_occupied_housing_units" as renter_occupied_housing_unit_2016,
round(cast((B."_occupied_housing_units__renter_occupied" / B."_occupied_housing_units")*100 as numeric), 2) rent_occupied_rate_2021,
B."_occupied_housing_units" as renter_occupied_housing_unit_2021
from acs_5_housing_census_tract_ca_2016 A
join acs_5_housing_census_tract_ca_2021 B
on A.name = B.name) C
on C.name = D.name
)

select * from rent_vacancy_census_tract_ca_viz

-- rent propertion
create or replace view rent_price_proportion_census_tract_fl_viz as (
select C.* from (
 select A.Name, A.state, A.county, A.tract, '1_Less_than_500' as rent_range, 
A._gross_rent__occupied_units_paying_rent__less_than_$500 as number_of_housing_2016, B."_gross_rent__occupied_units_paying_rent__less_than_$500" as number_of_housing_2021
from acs_5_housing_census_tract_fl_2016  A
join acs_5_housing_census_tract_fl_2021 B on A.name = B.name
union
select A.Name, A.state, A.county, A.tract, '2_500_to_999' as rent_range, 
A."_gross_rent__occupied_units_paying_rent__$500_to_$999" as number_of_housing_2016 , B."_gross_rent__occupied_units_paying_rent__$500_to_$999" as number_of_housing_2021
from acs_5_housing_census_tract_fl_2016  A
join acs_5_housing_census_tract_fl_2021 B on A.name = B.name
union
select A.Name, A.state, A.county, A.tract, '3_1000_to_1499' as rent_range, 
A."_gross_rent__occupied_units_paying_rent__$1000_to_$1499" as number_of_housing_2016, B."_gross_rent__occupied_units_paying_rent__$1000_to_$1499" as number_of_housing_2021
from acs_5_housing_census_tract_fl_2016  A
join acs_5_housing_census_tract_fl_2021 B on A.name = B.name
union
select A.Name, A.state, A.county, A.tract, '4_1500_to_1999' as rent_range, 
A."_gross_rent__occupied_units_paying_rent__$1500_to_$1999"  as number_of_housing_2016, B."_gross_rent__occupied_units_paying_rent__$1500_to_$1999" as number_of_housing_2021
from acs_5_housing_census_tract_fl_2016  A
join acs_5_housing_census_tract_fl_2021 B on A.name = B.name
union
select A.Name, A.state, A.county, A.tract, '5_2000_to_2499' as rent_range, 
A."_gross_rent__occupied_units_paying_rent__$2000_to_$2499"  as number_of_housing_2016, B."_gross_rent__occupied_units_paying_rent__$2000_to_$2499" as number_of_housing_2021
from acs_5_housing_census_tract_fl_2016  A
join acs_5_housing_census_tract_fl_2021 B on A.name = B.name
union
select A.Name, A.state, A.county, A.tract, '6_2500_to_2999' as rent_range, 
A."_gross_rent__occupied_units_paying_rent__$2500_to_$2999"  as number_of_housing_2016, B."_gross_rent__occupied_units_paying_rent__$2500_to_$2999"  as number_of_housing_2021
from acs_5_housing_census_tract_fl_2016  A
join acs_5_housing_census_tract_fl_2021 B on A.name = B.name
union
select A.Name, A.state, A.county, A.tract, '7_3000_and_more' as rent_range, 
A."_gross_rent__occupied_units_paying_rent__$3000_or_more"  as number_of_housing_2016, B."_gross_rent__occupied_units_paying_rent__$3000_or_more"  as number_of_housing_2021
from acs_5_housing_census_tract_fl_2016  A
join acs_5_housing_census_tract_fl_2021 B on A.name = B.name
) C
where C.county = '031'
order by C.name
)



-- Rent turn over
create or replace view tenants_turnover_census_tract_fl_viz as (
select C.*, (D._2016_leaving_tenants_rate / C.rent_occupied_rate_2016)*100 as _2016_tenants_turnover, 
(D._2021_leaving_tenants_rate / C.rent_occupied_rate_2021)*100 as _2021_tenants_turnover
from rent_vacancy_census_tract_fl_viz C
join (
select B.name, B.State, B.County, B.tract, (1 - (A."_residence_1_year_ago__population_1_year_up__same_house" / A."_residence_1_year_ago__population_1_year_up")) as _2016_leaving_tenants_rate,
(1 - (B."_residence_1_year_ago__population_1_year_up__same_house" / B."_residence_1_year_ago__population_1_year_up")) as _2021_leaving_tenants_rate
from acs_5_social_census_tract_fl_2016 A
join acs_5_social_census_tract_fl_2021 B on A.name = B.name
where A._residence_1_year_ago__population_1_year_up != 0) D
on C.name = D.name
)


create or replace view tenants_turnover_census_tract_tx_viz as (
select C.*, (D._2016_leaving_tenants_rate / C.rent_occupied_rate_2016)*100 as _2016_tenants_turnover, 
(D._2021_leaving_tenants_rate / C.rent_occupied_rate_2021)*100 as _2021_tenants_turnover
from rent_vacancy_census_tract_tx_viz C
join (
select B.name, B.State, B.County, B.tract, (1 - (A."_residence_1_year_ago__population_1_year_up__same_house" / A."_residence_1_year_ago__population_1_year_up")) as _2016_leaving_tenants_rate,
(1 - (B."_residence_1_year_ago__population_1_year_up__same_house" / B."_residence_1_year_ago__population_1_year_up")) as _2021_leaving_tenants_rate
from acs_5_social_census_tract_tx_2016 A
join acs_5_social_census_tract_tx_2021 B on A.name = B.name
where A._residence_1_year_ago__population_1_year_up != 0) D
on C.name = D.name
)


select * from tenants_turnover_census_tract_tx_viz


select * from tenants_turnover_census_tract_fl_viz

--##########################################################################################################################################################################

select C.name, 
C.state, 
C.county, 
C.tract, 
C.median_household_income_2016, 
C.median_household_income_2021, 
D.median_rent_2016, 
D.median_rent_2021, 
D._2016_ROI, 
D._2021_ROI, 
D.rent_vacancy_2016, 
D.rent_vacancy_2021, 
D.occupied_housing_unit_2016, 
D.renter_occupied_ratio_2016, 
D.occupied_housing_unit_2021, 
D.renter_occupied_ratio_2021 
from 
  (
    select 
      A.name, 
      A.state, 
      A.county, 
      A.tract, 
      B.dp03_0062e as median_household_income_2016, 
      A.dp03_0062e as median_household_income_2021, 
      ROUND(
        cast(
          (
            (
              (A.dp03_0062e - B.dp03_0062e) / B.dp03_0062e
            ) * 100
          ) as numeric
        ), 
        4
      ) as price_increase 
    from 
      acs_5_economic_census_tract_fl_2021 A 
      join acs_5_economic_census_tract_fl_2016 B on A.name = B.name 
    where 
      A.county = '031' 
      and B.dp03_0062e != 0
  ) C 
  join (
    select 
      A."name", 
      A.state, 
      A.county, 
      A.tract, 
      A._gross_rent__occupied_units_paying_rent__median_dollars as median_rent_2016, 
      A._rental_vacancy_rate as rent_vacancy_2016, 
      B._gross_rent__occupied_units_paying_rent__median_dollars as median_rent_2021, 
      B."_total_housing_units__rental_vacancy_rate" as rent_vacancy_2021, 
      ROUND(
        cast(
          (
            A._gross_rent__occupied_units_paying_rent__median_dollars / A._value__owner_occupied_units__median_dollars
          ) * 1200 as numeric
        ), 
        4
      ) _2016_ROI, 
      ROUND(
        cast(
          (
            B._gross_rent__occupied_units_paying_rent__median_dollars / B._value__owner_occupied_units__median_dollars
          ) * 1200 as numeric
        ), 
        4
      ) _2021_ROI, 
      A."_occupied_housing_units_x" as occupied_housing_unit_2016, 
      ROUND(
        cast(
          (
            A."_occupied_housing_units__renter_occupied" / A."_occupied_housing_units_x"
          ) * 100 as numeric
        ), 
        4
      ) renter_occupied_ratio_2016, 
      B."_occupied_housing_units_x" as occupied_housing_unit_2021, 
      ROUND(
        cast(
          (
            B."_occupied_housing_units__renter_occupied" / B."_occupied_housing_units_x"
          ) * 100 as numeric
        ), 
        4
      ) renter_occupied_ratio_2021 
    from 
      acs_5_housing_census_tract_fl_2016 A 
      join acs_5_housing_census_tract_fl_2021 B on A.name = B."name" 
    where 
      A._value__owner_occupied_units__median_dollars != 0 
      and B._value__owner_occupied_units__median_dollars != 0 
      and A.county = '031'
  ) D on C.name = D.name;

--##########################################################################################################################################################################
-- 8. MISC
--##########################################################################################################################################################################
select
	avg(C."_2013_population_per_units") as _2013,
	avg(C."_2014_population_per_units") as _2014,
	avg(C."_2015_population_per_units") as _2015,
	avg(C."_2016_population_per_units") as _2016,
	avg(C."_2017_population_per_units") as _2017,
	avg(C."_2018_population_per_units") as _2018,
	avg(C."_2019_population_per_units") as _2019,
	avg(C."_2021_population_per_units") as _2021
from
	(
	select
		*
	from
		population_per_unit_metro_politan_check
) C


select
	avg(C."_2013_population_per_units") as _2013,
	avg(C."_2014_population_per_units") as _2014,
	avg(C."_2015_population_per_units") as _2015,
	avg(C."_2016_population_per_units") as _2016,
	avg(C."_2017_population_per_units") as _2017,
	avg(C."_2018_population_per_units") as _2018,
	avg(C."_2019_population_per_units") as _2019,
	avg(C."_2021_population_per_units") as _2021
from
	(
	select
		*
	from
		population_per_unit_city_check
  ) C






	select
		name,
		"_2021_value__owner_occupied_units__median_dollars"
	from
		acs_1_housing_metro_politan_2021
		select
			name,
			"_2021_value__owner_occupied_units__median_dollars"
		from
			acs_1_housing_city_2021
			select
				avg(housing_price_change)
			from
				tenants_turnover_census_tract_tx_viz
				select
					B.name,
					ROUND(cast(((B."_2021_value__owner_occupied_units__median_dollars" - A."_2016_value__owner_occupied_units__median_dollars")/ A."_2016_value__owner_occupied_units__median_dollars" )* 100 as numeric),
					4) as
median_housing_price_change_2016_2021
				from
					acs_1_housing_metro_politan_2016 A
				join acs_1_housing_metro_politan_2021 B
on
					A.metro_politan_area = B.metro_politan_area
				where
					B.metro_politan_area in 
(
					select
						metro_politan_area
					from
						population_metro_politan_check
					where
						"_2021_sex_and_age__total_population" > 500000)
					select
						avg(C.median_housing_price_change_2016_2021)
					from
						(
						select
							B.name,
							ROUND(cast(((B."_2021_value__owner_occupied_units__median_dollars" - A."_2016_value__owner_occupied_units__median_dollars")/ A."_2016_value__owner_occupied_units__median_dollars" )* 100 as numeric),
							4) as
median_housing_price_change_2016_2021
						from
							acs_1_housing_metro_politan_2016 A
						join acs_1_housing_metro_politan_2021 B
on
							A.metro_politan_area = B.metro_politan_area
						where
							B.metro_politan_area in 
(
							select
								metro_politan_area
							from
								population_metro_politan_check
							where
								"_2021_sex_and_age__total_population" > 500000)) C
						select
							avg(median_housing_price_change_2016_2021)
						from
							()
							select
								B.name,
								ROUND(cast(((B."_2021_value__owner_occupied_units__median_dollars" - A."_2016_value__owner_occupied_units__median_dollars")/ A."_2016_value__owner_occupied_units__median_dollars" )* 100 as numeric),
								4) as
median_housing_price_change_2016_2021
							from
								acs_1_housing_city_2016 A
							join acs_1_housing_city_2021 B
on
								A.name = B.name
							where
								B.name in 
(
								select
									name
								from
									population_city_check
								where
									"_2021_sex_and_age__total_population" > 500000)
								select
									avg(C.median_housing_price_change_2016_2021)
								from
									(
									select
										B.name,
										ROUND(cast(((B."_2021_value__owner_occupied_units__median_dollars" - A."_2016_value__owner_occupied_units__median_dollars")/ A."_2016_value__owner_occupied_units__median_dollars" )* 100 as numeric),
										4) as
median_housing_price_change_2016_2021
									from
										acs_1_housing_city_2016 A
									join acs_1_housing_city_2021 B
on
										A.name = B.name
									where
										B.name in 
(
										select
											name
										from
											population_city_check
										where
											"_2021_sex_and_age__total_population" > 500000)
) C
									select
										*
									from
										population_per_unit_city_check
									where
									
									
									
select
	B.name,
	B.state,
	B.county,
	B.tract,
	A._value__owner_occupied_units__median_dollars as median_housing_price_2016,
	B._value__owner_occupied_units__median_dollars as median_housing_price_2021,
from
	acs_5_housing_census_tract_tx_2016 A
join acs_5_housing_census_tract_tx_2021 B on
	A.name = B.name
where
	A._value__owner_occupied_units__median_dollars != 0
	and B._value__owner_occupied_units__median_dollars != 0
	and B.county = '075'
	

	
	select * from rent_per_housing_price_city_check rphpcc 
	
	select * from housing_price_city_viz

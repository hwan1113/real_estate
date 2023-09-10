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
				
--##########################################################################################################################################################################
--4. The reason you can double the rent in Jacksonville Florida every 10 years
create or replace view income_metro_politan_viz as (
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
      metro_politan_area 
    from 
      acs_1_demographic_metro_politan_2021 
    where 
      "_2021_sex_and_age__total_population" > 500000
  )
)


create or replace
view income_city_viz as (
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


create 
or replace view c_roi_income_census_tract_fl_viz as (
  select 
    B.name, 
    B.state, 
    B.county, 
    B.tract, 
    A.dp03_0062e as median_household_income_2016,
    (A.dp03_0062e * 1.15) as inflation_adjusted_income_2016,
    B.dp03_0062e as median_household_income_2021, 
    D._2016_roi, 
    D._2021_roi 
  from 
    acs_5_economic_census_tract_fl_2016 A 
    join acs_5_economic_census_tract_fl_2021 B on A.name = B.name 
    join (
      select 
        * 
      from 
        rent_per_housing_price_census_tract_fl_viz
    ) D on B.name = D.name
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

create or replace view c_roi_housing_price_census_tract_ca_viz as (
select
	B.name,
	B.state,
	B.county,
	B.tract,
	A._value__owner_occupied_units__median_dollars as median_housing_price_2016,
	B._value__owner_occupied_units__median_dollars as median_housing_price_2021,
	round(cast(((B._value__owner_occupied_units__median_dollars - A._value__owner_occupied_units__median_dollars) / A._value__owner_occupied_units__median_dollars) as numeric),
	4) as _2016_2021_housing_price_change,
	C."_2016_roi",
	C."_2021_roi" 
from
	acs_5_housing_census_tract_ca_2016 A
join acs_5_housing_census_tract_ca_2021 B on
	A.name = B.name
join rent_per_housing_price_census_tract_ca_viz C
on B.name = C.name
where
	A._value__owner_occupied_units__median_dollars != 0
	and B._value__owner_occupied_units__median_dollars != 0
)


--##########################################################################################################################################################################
-- 6. Housing Price Trend













select 
avg(C.median_household_income_2013) as _2013_average_income,
avg(C.median_household_income_2021) as _2021_average_income,
avg(A._2013_VALUE__Owner_occupied_units__Median_dollars) as _2013_average_housing_price,
avg(B._2021_VALUE__Owner_occupied_units__Median_dollars) as _2021_average_housing_price
from acs_1_housing_metro_politan_2016 A 
join acs_1_housing_metro_politan_2021 B
on A.metro_politan_area = B.metro_politan_area
join income_metro_politan_viz C
on B.metro_politan_area  = C.metro_politan_area





create or replace view housing_price_metro_politan_viz as (
select 
C.name,
C.metro_politan_area,
C.median_household_income_2013,
round(cast(((C.median_household_income_2013 - 55056)/55056) as numeric), 4) as _2013_difference_in_income,
C.median_household_income_2014,
C.median_household_income_2015,
C.median_household_income_2016,
C.median_household_income_2017,
C.median_household_income_2018,
C.median_household_income_2019,
C.median_household_income_2021,
round(cast(((C.median_household_income_2021 - 71445)/71445) as numeric), 4) as _2021_difference_in_income,
round(cast(((C.median_household_income_2021 - C.median_household_income_2013) / C.median_household_income_2013) as numeric), 4) as _2013_2021_income_change,
A._2013_VALUE__Owner_occupied_units__Median_dollars,
round(cast(((A._2013_VALUE__Owner_occupied_units__Median_dollars - 195415)/195415) as numeric), 4) as _2013_difference_in_housing_price,
A._2014_VALUE__Owner_occupied_units__Median_dollars,
A._2015_VALUE__Owner_occupied_units__Median_dollars,
A._2016_VALUE__Owner_occupied_units__Median_dollars,
B._2017_VALUE__Owner_occupied_units__Median_dollars,
B._2018_VALUE__Owner_occupied_units__Median_dollars,
B._2019_VALUE__Owner_occupied_units__Median_dollars,
B._2021_VALUE__Owner_occupied_units__Median_dollars,
round(cast(((B._2021_VALUE__Owner_occupied_units__Median_dollars - 315560)/315560) as numeric), 4) as _2021_difference_in_housing_price,
round(cast(((B._2021_VALUE__Owner_occupied_units__Median_dollars - A._2013_VALUE__Owner_occupied_units__Median_dollars) / A._2013_VALUE__Owner_occupied_units__Median_dollars) as numeric), 4) as _2013_2021_housing_price_change
from acs_1_housing_metro_politan_2016 A 
join acs_1_housing_metro_politan_2021 B
on A.metro_politan_area = B.metro_politan_area
join income_metro_politan_viz C
on B.metro_politan_area  = C.metro_politan_area
)



 
select 
avg(C.median_household_income_2013) as _2013_average_income,
avg(C.median_household_income_2021) as _2021_average_income,
avg(A._2013_VALUE__Owner_occupied_units__Median_dollars) as _2013_average_housing_price,
avg(B._2021_VALUE__Owner_occupied_units__Median_dollars) as _2021_average_housing_price
from acs_1_housing_city_2016 A 
join acs_1_housing_city_2021 B
on A.name = B.name
join income_city_viz C
on B.name  = C.name

create or replace view housing_price_city_viz as (
select 
C.name,
C.state,
C.city,
C.median_household_income_2013,
round(cast(((C.median_household_income_2013 - 50497)/50497) as numeric), 4) as _2013_difference_in_income,
C.median_household_income_2014,
C.median_household_income_2015,
C.median_household_income_2016,
C.median_household_income_2017,
C.median_household_income_2018,
C.median_household_income_2019,
C.median_household_income_2021,
round(cast(((C.median_household_income_2021 - 68607)/68607) as numeric), 4) as _2021_difference_in_income,
round(cast(((C.median_household_income_2021 - C.median_household_income_2013) / C.median_household_income_2013) as numeric), 4) as _2013_2021_income_change,
A._2013_VALUE__Owner_occupied_units__Median_dollars,
round(cast(((A._2013_VALUE__Owner_occupied_units__Median_dollars - 231694)/231694) as numeric), 4) as _2013_difference_in_housing_price,
A._2014_VALUE__Owner_occupied_units__Median_dollars,
A._2015_VALUE__Owner_occupied_units__Median_dollars,
A._2016_VALUE__Owner_occupied_units__Median_dollars,
B._2017_VALUE__Owner_occupied_units__Median_dollars,
B._2018_VALUE__Owner_occupied_units__Median_dollars,
B._2019_VALUE__Owner_occupied_units__Median_dollars,
B._2021_VALUE__Owner_occupied_units__Median_dollars,
round(cast(((B._2021_VALUE__Owner_occupied_units__Median_dollars - 406047)/406047) as numeric), 4) as _2021_difference_in_housing_price,
round(cast(((B._2021_VALUE__Owner_occupied_units__Median_dollars - A._2013_VALUE__Owner_occupied_units__Median_dollars) / A._2013_VALUE__Owner_occupied_units__Median_dollars) as numeric), 4) as _2013_2021_housing_price_change
from acs_1_housing_city_2016 A 
join acs_1_housing_city_2021 B
on A.name = B.name
join income_city_viz C
on B.name  = C.name
)

select * from housing_price_city_viz


-- SF County
select
	avg(A.dp03_0062e) as _2016_average_income,
	avg(B.dp03_0062e) as _2021_average_income
from
	acs_5_economic_census_tract_ca_2016 A
join acs_5_economic_census_tract_ca_2021 B on
	A.name = B.name
where
	A.dp03_0062e != 0
	and B.dp03_0062e != 0
	and B.county = '075'



select
	B.name,
	B.state,
	B.county,
	B.tract,
	A.dp03_0062e as median_household_income_2016,
	round(cast(((A.dp03_0062e - 92686)/92686) as numeric), 4) as _2016_difference_in_income,
	B.dp03_0062e as median_household_income_2021,
	round(cast(((B.dp03_0062e - 132327)/132327) as numeric), 4) as _2021_difference_in_income
from
	acs_5_economic_census_tract_ca_2016 A
join acs_5_economic_census_tract_ca_2021 B on
	A.name = B.name
where
	A.dp03_0062e != 0
	and B.dp03_0062e != 0
	and B.county = '075'

select
	avg(A._value__owner_occupied_units__median_dollars) as _2016_average_housing_price,
	avg(B._value__owner_occupied_units__median_dollars) as _2021_average_housing_price
from
	acs_5_housing_census_tract_ca_2016 A
join acs_5_housing_census_tract_ca_2021 B on
	A.name = B.name
where
	A._value__owner_occupied_units__median_dollars != 0
	and B._value__owner_occupied_units__median_dollars != 0
	and B.county = '075'

	
select
	B.name,
	B.state,
	B.county,
	B.tract,
	A._value__owner_occupied_units__median_dollars as median_housing_price_2016,
	round(cast(((A._value__owner_occupied_units__median_dollars - 940309)/940309) as numeric), 4) as _2016_difference_in_housing_price,
	B._value__owner_occupied_units__median_dollars as median_housing_price_2021,
	round(cast(((B._value__owner_occupied_units__median_dollars - 1284098)/1284098) as numeric), 4) as _2021_difference_in_housing_price
from
	acs_5_housing_census_tract_ca_2016 A
join acs_5_housing_census_tract_ca_2021 B on
	A.name = B.name
where
	A._value__owner_occupied_units__median_dollars != 0
	and B._value__owner_occupied_units__median_dollars != 0
	and B.county = '075'
	

	
create or replace view housing_price_census_tract_ca_viz as (
select
	B.name,
	B.state,
	B.county,
	B.tract,
	A.dp03_0062e as median_household_income_2016,
	round(cast(((A.dp03_0062e - 92686)/92686) as numeric), 4) as _2016_difference_in_income,
	B.dp03_0062e as median_household_income_2021,
	round(cast(((B.dp03_0062e - 132327)/132327) as numeric), 4) as _2021_difference_in_income,
	E.median_housing_price_2016,
	E._2016_difference_in_housing_price,
	E.median_housing_price_2021,
	E._2021_difference_in_housing_price
from
	acs_5_economic_census_tract_ca_2016 A
join acs_5_economic_census_tract_ca_2021 B on
	A.name = B.name
join (select
	D.name,
	D.state,
	D.county,
	D.tract,
	C._value__owner_occupied_units__median_dollars as median_housing_price_2016,
	round(cast(((C._value__owner_occupied_units__median_dollars - 940309)/940309) as numeric), 4) as _2016_difference_in_housing_price,
	D._value__owner_occupied_units__median_dollars as median_housing_price_2021,
	round(cast(((D._value__owner_occupied_units__median_dollars - 1284098)/1284098) as numeric), 4) as _2021_difference_in_housing_price
from
	acs_5_housing_census_tract_ca_2016 C
join acs_5_housing_census_tract_ca_2021 D on
	C.name = D.name
where
	C._value__owner_occupied_units__median_dollars != 0
	and D._value__owner_occupied_units__median_dollars != 0) E
on B.name = E.name
where
	A.dp03_0062e != 0
	and B.dp03_0062e != 0
	and B.county = '075'
)

select * from housing_price_city_viz


create 
or replace
view housing_price_city_timeline_viz as (
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
	housing_price_city_viz
order by
	name
)

select * from rent_per_housing_price_metro_politan_viz

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

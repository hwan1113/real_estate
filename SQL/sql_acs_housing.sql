--##########################################################################################################################################################################
-- rent_per_housing_price
--##########################################################################################################################################################################

-- final
 select A.Name, A.state, A.city, 
 round(cast((E._2013_GROSS_RENT__Occupied_units_paying_rent__Median_dollars/A._2013_VALUE__Owner_occupied_units__Median_dollars)*1200 as numeric), 4) _2013_value,
 round(cast((E._2014_GROSS_RENT__Occupied_units_paying_rent__Median_dollars/A._2014_VALUE__Owner_occupied_units__Median_dollars)*1200 as numeric), 4) _2014_value,
 round(cast((E._2015_GROSS_RENT__Occupied_units_paying_rent__Median_dollars/A._2015_VALUE__Owner_occupied_units__Median_dollars)*1200 as numeric), 4) _2015_value,
 round(cast((E._2016_GROSS_RENT__Occupied_units_paying_rent__Median_dollars/A._2016_VALUE__Owner_occupied_units__Median_dollars)*1200 as numeric), 4) _2016_value,
 round(cast((E._2017_GROSS_RENT__Occupied_units_paying_rent__Median_dollars/B._2017_VALUE__Owner_occupied_units__Median_dollars)*1200 as numeric), 4) _2017_value,
 round(cast((E._2018_GROSS_RENT__Occupied_units_paying_rent__Median_dollars/B._2018_VALUE__Owner_occupied_units__Median_dollars)*1200 as numeric), 4) _2018_value,
 round(cast((E._2019_GROSS_RENT__Occupied_units_paying_rent__Median_dollars/B._2019_VALUE__Owner_occupied_units__Median_dollars)*1200 as numeric), 4) _2019_value,
 round(cast((E._2021_GROSS_RENT__Occupied_units_paying_rent__Median_dollars/B._2021_VALUE__Owner_occupied_units__Median_dollars)*1200 as numeric), 4) _2021_value
 from acs_1_housing_city_2016 A
 join acs_1_housing_city_2021 B on A.name = B.name
 join (select C.Name, C.state, C.city, C._2013_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
 C._2014_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
 C._2015_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
 C._2016_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
 D._2017_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
 D._2018_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
 D._2019_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
 D._2021_GROSS_RENT__Occupied_units_paying_rent__Median_dollars
 from acs_1_housing_city_2016 C
 join acs_1_housing_city_2021 D on C.name = D.name) E
 on A.name = E.name
 where A._2013_VALUE__Owner_occupied_units__Median_dollars != 0


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

-- census_tract
select A."name", A.state, A.county, A.tract, 
 round(cast((A._gross_rent__occupied_units_paying_rent__median_dollars / A._value__owner_occupied_units__median_dollars)*1200 as numeric), 4) _2016_value,
 round(cast((B._gross_rent__occupied_units_paying_rent__median_dollars / B._value__owner_occupied_units__median_dollars)*1200 as numeric), 4) _2021_value
from acs_5_housing_census_tract_fl_2016 A
join acs_5_housing_census_tract_fl_2021 B
on A.name = B."name"
where A._value__owner_occupied_units__median_dollars != 0 and B._value__owner_occupied_units__median_dollars != 0 and A.county = '031'


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
 
-- census_tract
select A.name, A.state, A.county, A.tract, A."_total_housing_units_x" as total_housing_unit_2016, B."_total_housing_units_x" as total_housing_unit_2021 from 
acs_5_housing_census_tract_fl_2016 A join acs_5_housing_census_tract_fl_2021 B
on A.name = B.name
where A.county = '031'

--##########################################################################################################################################################################
-- vacancy rate
--##########################################################################################################################################################################
-- final
 select A.Name, A.state, A.city, 'housing vacancy' as vacancy_type, A._2013_Homeowner_vacancy_rate as _2013_Rental_vacancy_rate,
 A._2014_Homeowner_vacancy_rate as _2014_Rental_vacancy_rate,
 A._2015_Homeowner_vacancy_rate as _2015_Rental_vacancy_rate,
 A._2016_Homeowner_vacancy_rate as _2016_Rental_vacancy_rate,
 B._2017_Total_housing_units__Homeowner_vacancy_rate,
 B._2018_Total_housing_units__Homeowner_vacancy_rate, B._2019_Total_housing_units__Homeowner_vacancy_rate,
 B._2021_Total_housing_units__Homeowner_vacancy_rate
 from acs_1_housing_city_2016 A
 join acs_1_housing_city_2021 B on A.name = B.name
 union
 select A.Name, A.state, A.city, 'rental vacancy' as vacancy_type, A._2013_Rental_vacancy_rate, A._2014_Rental_vacancy_rate, 
 A._2015_Rental_vacancy_rate, A._2016_Rental_vacancy_rate,
 B._2017_Total_housing_units__Rental_vacancy_rate,
 B._2018_Total_housing_units__Rental_vacancy_rate, B._2019_Total_housing_units__Rental_vacancy_rate,
 B._2021_Total_housing_units__Rental_vacancy_rate
 from acs_1_housing_city_2016 A
 join acs_1_housing_city_2021 B on A.name = B.name
 
-- census_tract
select A.Name, A.state, A.county, A.tract, 
round(cast(A."_rental_vacancy_rate" as numeric), 3) as rental_vacancy_rate_2016,
round(cast(B."_total_housing_units__rental_vacancy_rate" as numeric), 3) as rental_vacancy_rate_2021
from acs_5_housing_census_tract_fl_2016 A
join acs_5_housing_census_tract_fl_2021 B
on A.name = B.name
where A.county = '031'
order by A.name

 
 
 
 
 --##########################################################################################################################################################################
-- Housing price proportion
--##########################################################################################################################################################################
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
where C.county = '031'
order by C.name, C.price_range

--##########################################################################################################################################################################
-- Duplex location
--##########################################################################################################################################################################
-- census_tract
select A.name, A.state, A.county, A.tract, A."_total_housing_units__2_units" as duplex_2016, B."_total_housing_units__2_units" as duplex_2021  from acs_5_housing_census_tract_fl_2016 A
join acs_5_housing_census_tract_fl_2021 B
on A.name = B."name"
where A.county = '031'
order by B."_total_housing_units__2_units" desc

--##########################################################################################################################################################################
-- Housing price detail
--##########################################################################################################################################################################
-- final 
select A.Name, A.state, A.city, A._2013_VALUE__Owner_occupied_units__Median_dollars,
 A._2014_VALUE__Owner_occupied_units__Median_dollars,
 A._2015_VALUE__Owner_occupied_units__Median_dollars,
 A._2016_VALUE__Owner_occupied_units__Median_dollars,
 B._2017_VALUE__Owner_occupied_units__Median_dollars,
 B._2018_VALUE__Owner_occupied_units__Median_dollars,
 B._2019_VALUE__Owner_occupied_units__Median_dollars,
 B._2021_VALUE__Owner_occupied_units__Median_dollars
 from acs_1_housing_city_2016 A
 join acs_1_housing_city_2021 B on A.name = B.name
 
--##########################################################################################################################################################################
-- Rent price detail
--##########################################################################################################################################################################
-- final
 select A.Name, A.state, A.city, A._2013_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
 A._2014_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
 A._2015_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
 A._2016_GROSS_RENT__Occupied_units_paåying_rent__Median_dollars,
 B._2017_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
 B._2018_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
 B._2019_GROSS_RENT__Occupied_units_paying_rent__Median_dollars,
 B._2021_GROSS_RENT__Occupied_units_paying_rent__Median_dollars
 from acs_1_housing_city_2016 A
 join acs_1_housing_city_2021 B on A.name = B.name


--########################################################################################################################################################################## 
-- Moving trend
--##########################################################################################################################################################################
-- final
 select A.Name, A.state, A.city, A._2021_Occupied_housing_units__Moved_in_2019_or_later
from acs_1_housing_city_2021 A


--##########################################################################################################################################################################
-- renter-occupied
--##########################################################################################################################################################################
-- final
 select A.Name, A.state, A.city, A._2013_Occupied_housing_units__Renter_occupied,
 A._2014_Occupied_housing_units__Renter_occupied,
 A._2015_Occupied_housing_units__Renter_occupied,
 A._2016_Occupied_housing_units__Renter_occupied,
 B._2017_Occupied_housing_units__Renter_occupied,
 B._2018_Occupied_housing_units__Renter_occupied, B._2019_Occupied_housing_units__Renter_occupied,
 B._2021_Occupied_housing_units__Renter_occupied
 from acs_1_housing_city_2016 A
 join acs_1_housing_city_2021 B on A.name = B.name
 
-- census tract
select A.Name, A.state, A.county, A.tract,
round(cast((A."_occupied_housing_units__renter_occupied" / A."_occupied_housing_units")*100 as numeric), 2) rent_occupied_rate_2016, 
A."_occupied_housing_units" as occupied_housing_unit_2016,
round(cast((B."_occupied_housing_units__renter_occupied" / B."_occupied_housing_units")*100 as numeric), 2) rent_occupied_rate_2021,
B."_occupied_housing_units" as occupied_housing_unit_2021
from acs_5_housing_census_tract_fl_2016 A
join acs_5_housing_census_tract_fl_2021 B
on A.name = B.name
where A."_occupied_housing_units" != 0 and A.county = '031'
 

--##########################################################################################################################################################################
-- years built
--##########################################################################################################################################################################

 --census_tract
 
 
 --##########################################################################################################################################################################
-- Rent proportion
 --##########################################################################################################################################################################

 
 

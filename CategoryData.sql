use covid19;

select * from district_dataframe;

with cte1 as (select district_code, tested, deceased, population_m, (tested/population_m) as test_ratio  
from district_dataframe 
where tested <> 0 and population_m <> 0) 
select *, case 
when  test_ratio > 0  and test_ratio <= 0.1 then 'Category A'
when  test_ratio > 0.1 and test_ratio <= 0.3 then 'Category B'
when  test_ratio > 0.3 and test_ratio <= 0.5 then 'Category C'
when  test_ratio > 0.5 and test_ratio <= 0.75 then  'Category D'
else 'Category E' end as Category from cte1 
where test_ratio < 1
order by district_code 


-- - Category A: 0.05 ≤ tr ≤ 0.1
-- - Category B: 0.1 < tr ≤ 0.3
-- - Category C: 0.3 < tr ≤ 0.5
-- - Category D: 0.5 < tr ≤ 0.75
-- - Category E: 0.75 < tr ≤ 1.0

with cte as (select district_code, confirmed_d7 , population_m ,(vaccinated1_d7 + vaccinated2_d7) as Vaccinated 
from district_dataframe having confirmed_d7 > 0  and Vaccinated > 0 and population_m>0) 
select *, Vaccinated/ population_m * 100 as Vaccinaion_rate from cte 

with cte as (select district_code, confirmed_d7 , population_m , vaccinated2_d7
from district_dataframe having confirmed_d7 > 0  and Vaccinated2_d7 > 0 and population_m>0) 
select *, vaccinated2_d7/ population_m * 100 as Vaccinaion_rate from cte 

select * from karnataka order by dates;



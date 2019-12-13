#For each title type, find the amount that made negative earnings, 0-$1M, then  $1-$3M, and then $3M and above

CREATE VIEW v_title_financials AS
select  distinct tb.title_type,
count(case when (f.box_office-f.budget)<0 then 1 end) as num_negative_earnings,
count(case when (f.box_office-f.budget)>0 and (f.box_office-f.budget)<1000000 then 1 end) as earners_0to1M,
count(case when (f.box_office-f.budget)>1000000 and (f.box_office-f.budget)<3000000 then 1 end) as earners_1to3M,
count(case when (f.box_office-f.budget)>3000000 then 1 end) as earners_above3M
from title_basics tb join title_financials f on f.title_id=tb.title_id
group by tb.title_type;


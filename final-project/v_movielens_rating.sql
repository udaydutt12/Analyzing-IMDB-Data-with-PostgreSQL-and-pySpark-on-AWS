CREATE VIEW v_movielens_rating AS
select tb.start_year as year, min(movielens_rating) as min_rating, max(movielens_rating) as max_rating
from title_ratings tr join title_basics tb on tr.title_id=tb.title_id
group by start_year
order by start_year;
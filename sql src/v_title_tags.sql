/* Find the number of imdb entries with ratings above 8 for each tag */

create view v_title_tags as
select tt.tag, count(*) as number_of_occurences, sum(tr.average_rating)/count(*) as average_rating
from title_tags tt join title_basics tb on tb.title_id=tt.title_id
join title_ratings tr on tb.title_id=tr.title_id
where tr.average_rating>8
group by tt.tag;
CREATE TABLE Title_Rating_Facts_Appalling
AS (select tb.title_type, tb.start_year, tg.genre, count(*) as appalling_titles
from title_basics tb full outer join title_genres tg on tb.title_id = tg.title_id
full outer join title_ratings tr on tr.title_id=tb.title_id
where tr.average_rating <= 2.0
group by tb.title_type, tg.genre, tb.start_year
order by tb.start_year, tb.title_type, tg.genre);

UPDATE Title_Rating_Facts_Appalling
set genre = 'NoGenre'
where genre is null;

CREATE TABLE Title_Rating_Facts_Average
AS (select tb.title_type, tb.start_year, tg.genre, count(*) as average_titles
from title_basics tb full outer join title_genres tg on tb.title_id = tg.title_id
full outer join title_ratings tr on tr.title_id=tb.title_id
where tr.average_rating > 2.0 and tr.average_rating < 8
group by tb.title_type, tg.genre, tb.start_year
order by tb.start_year, tb.title_type, tg.genre);

UPDATE Title_Rating_Facts_Average
set genre = 'NoGenre'
where genre is null;

CREATE TABLE Title_Rating_Facts_Outstanding
AS (select tb.title_type, tb.start_year, tg.genre, count(*) as outstanding_titles
from title_basics tb full outer join title_genres tg on tb.title_id = tg.title_id
full outer join title_ratings tr on tr.title_id=tb.title_id
where tr.average_rating >= 8
group by tb.title_type, tg.genre, tb.start_year
order by tb.start_year, tb.title_type, tg.genre);

UPDATE Title_Rating_Facts_Outstanding
set genre = 'NoGenre'
where genre is null;

CREATE TABLE Title_Rating_Facts
as (select distinct ave.title_type, ave.start_year, ave.genre, appalling_titles, average_titles, outstanding_titles
from title_rating_facts_average ave full outer join Title_Rating_Facts_Outstanding out
	on ave.title_type=out.title_type and ave.start_year=out.start_year and ave.genre=out.genre
full outer join Title_Rating_Facts_Appalling app
	on ave.title_type=app.title_type and ave.start_year=app.start_year and ave.genre=app.genre
order by ave.start_year, ave.title_type, ave.genre);

UPDATE Title_Rating_Facts
set appalling_titles = 0
where appalling_titles is null;

UPDATE Title_Rating_Facts
set average_titles = 0
where average_titles is null;

UPDATE Title_Rating_Facts
set outstanding_titles = 0
where outstanding_titles is null;

delete from Title_Rating_Facts
where start_year is null;

alter table Title_Rating_Facts
add primary key (title_type, start_year, genre);

CREATE VIEW v_outstanding_titles_by_year_genre AS
select start_year, genre, count(outstanding_titles)
from Title_Rating_Facts
where start_year>=1930
group by start_year, genre
having count(outstanding_titles)>0
order by start_year, genre
limit 100;
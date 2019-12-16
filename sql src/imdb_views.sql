CREATE VIEW v_average_movie_ratings AS
select start_year as year, avg(tr.average_rating) as average_rating
from title_basics tb join title_ratings tr on tb.title_id = tr.title_id
where start_year between 1950 and 2000
and title_type = 'movie'
group by start_year
order by start_year;

CREATE MATERIALIZED VIEW v_genre_ratings AS
select genre, avg(tr.average_rating) as average_rating
from title_basics tb join title_ratings tr on tb.title_id = tr.title_id
join title_genres tg on tg.title_id = tb.title_id
group by genre
having avg(tr.average_rating) >= 5
order by avg(tr.average_rating) desc;

CREATE MATERIALIZED VIEW v_writers_work AS
select pb.primary_name, count(*)
from person_basics pb join writers w on pb.person_id=w.person_id
join title_episodes te on w.title_id=te.title_id
join title_basics tb on tb.title_id=te.parent_title_id
group by pb.primary_name
having count(*) >= 1000;

CREATE MATERIALIZED VIEW v_dead_stars AS
select primary_name as star_name, count(*) as title_count
from person_basics pb join stars on pb.person_id=stars.person_id
left join title_basics tb on tb.title_id=stars.title_id
where death_year is not null
group by star_name
having count(*)=1
order by title_count;


CREATE MATERIALIZED VIEW v_amt_principals AS
select pp.profession as profession, start_year as year, count(*) as tot_principals
from title_basics tb left join principals p on tb.title_id=p.title_id
join person_professions pp on p.person_id=pp.person_id
where start_year=2015
group by profession, year
order by year;


CREATE MATERIALIZED VIEW v_composer_ratings AS
select pb.primary_name, avg(tr.average_rating)
from person_basics pb join stars s on pb.person_id = s.person_id
join person_professions pp on pp.person_id = s.person_id
join title_basics tb on tb.title_id = s.title_id
join title_ratings tr on tr.title_id = tb.title_id
where pp.profession = 'composer'
group by pb.primary_name
having avg(tr.average_rating) > 9
order by avg(tr.average_rating);
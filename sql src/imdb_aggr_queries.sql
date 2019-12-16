/* Query 1: Average the ratings of the movies that came out each year between 1950 - 2000 */

select start_year as year, avg(tr.average_rating) as average_rating
from title_basics tb join title_ratings tr on tb.title_id = tr.title_id
where start_year between 1950 and 2000
and title_type = 'movie'
group by start_year
order by start_year;

/* Query 2: Find out which genres have an average rating of at least 5 */

select genre, avg(tr.average_rating) as average_rating
from title_basics tb join title_ratings tr on tb.title_id = tr.title_id
join title_genres tg on tg.title_id = tb.title_id
group by genre
having avg(tr.average_rating) >= 5
order by avg(tr.average_rating) desc;

/* Query 3: Find every writer that contributed to at least 1000 episodes of any show they worked on */

select pb.primary_name, count(*)
from person_basics pb join writers w on pb.person_id=w.person_id
join title_episodes te on w.title_id=te.title_id
join title_basics tb on tb.title_id=te.parent_title_id
group by pb.primary_name
having count(*) >= 1000;

/*Query 4: Find all dead people that were Stars, while alive, in 1 title, and the number of titles they worked in. */

select primary_name as star_name, count(*) as title_count
from person_basics pb join stars on pb.person_id=stars.person_id
left join title_basics tb on tb.title_id=stars.title_id
where death_year is not null
group by star_name
having count(*)=1
order by title_count;

/*Query 5: List the number of principals each profession had in the year 2015 */

select pp.profession as profession, start_year as year, count(*) as tot_principals
from title_basics tb left join principals p on tb.title_id=p.title_id
join person_professions pp on p.person_id=pp.person_id
where start_year=2015
group by profession, year
order by year;

/* Query 6: Find the average for each composer's average_rating and list those that are above 9 */

select pb.primary_name, avg(tr.average_rating)
from person_basics pb join stars s on pb.person_id = s.person_id
join person_professions pp on pp.person_id = s.person_id
join title_basics tb on tb.title_id = s.title_id
join title_ratings tr on tr.title_id = tb.title_id
where pp.profession = 'composer'
group by pb.primary_name
having avg(tr.average_rating) > 9
order by avg(tr.average_rating);
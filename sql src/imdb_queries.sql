/* Query 1: Find Tom Cruise's movies and sort by rating */

select tb.title_id, tb.primary_title, tb.start_year, tr.average_rating
from title_basics tb join principals p on tb.title_id = p.title_id
join person_basics pb on pb.person_id = p.person_id 
join title_ratings tr on tr.title_id = tb.title_id
where pb.primary_name = 'Tom Cruise'
and tb.title_type = 'movie'
and tb.start_year is not null
order by tr.average_rating desc;

/* Query 2: Find every season and episode of Seinfeld */

select tb.primary_title, te.season_num, te.episode_num, tr.average_rating
from title_basics tb join title_episodes te on tb.title_id = te.parent_title_id
join title_ratings tr on tr.title_id = tb.title_id
where tb.primary_title = 'Seinfeld'
order by season_num, episode_num;

/* Query 3: Shows over 2 seasons long with ratings above 7.5, ordered by primary title*/
select tr.average_rating, tb.primary_title, te.season_num 
from title_episodes te join title_basics tb on te.title_id=tb.title_id
join title_ratings tr on tb.title_id=tr.title_id
where te.season_num>2
and tr.average_rating>7.5
order by tb.primary_title;

/* Query 4: Find movies directed by Quentin Tarantino ordered from lowest to highest */

select pb.primary_name, tb.primary_title, tr.average_rating
from person_basics pb join directors d on pb.person_id = d.person_id
join title_basics tb on tb.title_id = d.title_id
join title_ratings tr on tr.title_id = tb.title_id
where pb.primary_name = 'Quentin Tarantino' and tb.title_type = 'movie'
order by tr.average_rating asc;

/* Query 5: Find every movie Ben Affleck produced, wrote, and starred in */

select pb.primary_name, pp.profession, tb.primary_title, tb.start_year
from person_basics pb join person_professions pp on pb.person_id = pp.person_id
join writers w on pb.person_id = w.person_id
join title_basics tb on tb.title_id = w.title_id
where pb.primary_name = 'Ben Affleck'
order by tb.primary_title;

/* Query 6: Find every profession Danny Devito has had */

select pb.primary_name, pp.profession
from person_basics pb join person_professions pp on pb.person_id = pp.person_id
where pb.primary_name = 'Danny DeVito';

/*Query 7: Find all dead people that were Stars while alive, ordered by name...include the primary title*/

select pb.primary_name, tb.primary_title
from person_basics pb join stars on pb.person_id=stars.person_id
join title_basics tb on tb.title_id=stars.title_id
where pb.death_year is not null
order by pb.primary_name;

/*Query 8: Find writers with imdb shows with runtime over 60 minutes in the genre of Comedy*/

select pb.primary_name, tb.primary_title, tb.runtime_minutes,tg.genre
from person_basics pb join writers on pb.person_id=writers.person_id
join title_basics tb on writers.title_id=tb.title_id
join title_genres tg on tg.title_id=tb.title_id
where tb.runtime_minutes>60 
and tg.genre='Comedy';

/*Query 9: Find all the stars of shows with ratings below 7, order by rating*/

select pb.primary_name, tb.primary_title, tr.average_rating
from person_basics pb join stars on stars.person_id=pb.person_id
join title_basics tb on tb.title_id=stars.title_id
join title_ratings tr on tr.title_id=tb.title_id
where tr.average_rating<7
order by tr.average_rating;

/*Query 10:Find all non-adult Movies from the year 2015 with over 300 votes*/

select tb.primary_title, tr.num_votes,tb.is_adult
from title_basics tb join title_ratings tr on tr.title_id=tb.title_id
where tb.title_type='movie'
and tb.is_adult='false'
and tb.start_year=2015
and tr.num_votes>300;

/*Query 11: Find all documentaries with over 1000 votes*/

select tb.primary_title, tr.num_votes,tg.genre
from title_basics tb join title_ratings tr on tr.title_id=tb.title_id
join title_genres tg on tg.title_id=tb.title_id
where tg.genre='Documentary'
and tr.num_votes>1000
order by tg.genre;

/*Query 12:Find all shows greater than 8.0 rating that lasted more than 5 years and is already done, ordered by start year*/

select tb.primary_title, tr.average_rating, tb.start_year, tb.end_year
from title_basics tb join title_ratings tr on tb.title_id=tr.title_id
where tb.end_year is not null
and tb.end_year-tb.start_year>5
and tr.average_rating>8.0
order by tb.start_year;

/*QUery 13: Find all living directors of movies with over 3000 votes*/
select pb.primary_name, tb.primary_title, tr.num_votes
from person_basics pb join directors on directors.person_id=pb.person_id
join title_basics tb on directors.title_id=tb.title_id
join title_ratings tr on tr.title_id=tb.title_id
where tr.num_votes>3000 
and tb.title_type='movie'
and pb.death_year is null;

/*Query 14: Find all shows where the writer is also the director*/

select tb.primary_title
from title_basics tb join directors d on d.title_id=tb.title_id
join person_basics pb on pb.person_id=d.person_id
join writers w on w.person_id=pb.person_id;

/*Query 15:Find all Thrillers with over 10000 votes, but average rating under 5.0 , order by primary name*/ 

select tb.primary_title, tr.num_votes, tr.average_rating, tg.genre
from title_basics tb join title_ratings tr on tr.title_id=tb.title_id
join title_genres tg on tg.title_id=tb.title_id
where tr.num_votes>10000
and tr.average_rating<5.0
and tg.genre='Thriller'
order by tb.primary_title;

/* Query 16: Find the ratings of Bruce Willis' comedy movies */

select tb.primary_title, tg.genre, tr.average_rating
from person_basics pb join principals p on pb.person_id = p.person_id
join title_basics tb on tb.title_id = p.title_id
join title_genres tg on tg.title_id = tb.title_id
join title_ratings tr on tr.title_id = tb.title_id
where pb.primary_name = 'Bruce Willis'
and tb.title_type = 'movie'
and tg.genre = 'Comedy'
order by tr.average_rating;

/* Query 17: Find every movie Matthew McConaughey did within three years after graduating */

select distinct tb.primary_title, tb.start_year, tr.average_rating
from person_basics pb join principals p on pb.person_id = p.person_id
join title_basics tb on tb.title_id = p.title_id
join title_ratings tr on tr.title_id = tb.title_id
where pb.primary_name = 'Matthew McConaughey'
and tb.title_type = 'movie'
and tb.start_year <= 1996
order by tb.start_year;

/* Query 18: Find every composer who composed for a project with a rating >7.5 */

select pb.primary_name, tb.primary_title, pp.profession, tr.average_rating
from person_basics pb join stars s on pb.person_id = s.person_id
join person_professions pp on pp.person_id = s.person_id
join title_basics tb on tb.title_id = s.title_id
join title_ratings tr on tr.title_id = tb.title_id
where pp.profession = 'composer'
and tr.average_rating >= 7.5;

/* Query 19: Find every action movie released in the 80's with a rating above 8 */

select tb.primary_title, tg.genre, tr.average_rating
from title_basics tb join title_genres tg on tb.title_id = tg.title_id
join title_ratings tr on tb.title_id = tr.title_id
where tb.start_year >= 1980
and tb.start_year <= 1990
and tb.title_type = 'movie'
and tr.average_rating >= 8
and tg.genre = 'Action';

/* Query 20: Find every director that directed a sci-fi movie before 1970 */

select pb.primary_name, tb.primary_title, tb.start_year, tg.genre
from person_basics pb join directors d on pb.person_id = d.person_id
join title_basics tb on tb.title_id = d.title_id
join title_genres tg on tb.title_id = tg.title_id
and tb.start_year <= 1970
and tb.title_type = 'movie'
and tg.genre = 'Sci-Fi'
order by tb.start_year asc;
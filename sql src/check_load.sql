select pb.primary_name, pp.profession
from person_basics pb join person_professions pp on pb.person_id = pp.person_id
where pb.primary_name = 'Danny DeVito';

select tb.primary_title, tg.genre, tr.average_rating
from person_basics pb join principals p on pb.person_id = p.person_id
join title_basics tb on tb.title_id = p.title_id
join title_genres tg on tg.title_id = tb.title_id
join title_ratings tr on tr.title_id = tb.title_id
where pb.primary_name = 'Bruce Willis'
and tb.title_type = 'movie'
and tg.genre = 'Comedy'
order by tr.average_rating;

select tb.primary_title, tr.num_votes,tg.genre
from title_basics tb join title_ratings tr on tr.title_id=tb.title_id
join title_genres tg on tg.title_id=tb.title_id
where tg.genre='Documentary'
and tr.num_votes>1000
order by tg.genre;

select tb.primary_title
from title_basics tb join directors d on d.title_id=tb.title_id
join person_basics pb on pb.person_id=d.person_id
join writers w on w.person_id=pb.person_id;

select tb.primary_title, te.season_num, te.episode_num, tr.average_rating
from title_basics tb join title_episodes te on tb.title_id = te.parent_title_id
join title_ratings tr on tr.title_id = tb.title_id
where tb.primary_title = 'Seinfeld'
order by season_num, episode_num;

select pb.primary_name, tb.primary_title, pp.profession, tr.average_rating
from person_basics pb join stars s on pb.person_id = s.person_id
join person_professions pp on pp.person_id = s.person_id
join title_basics tb on tb.title_id = s.title_id
join title_ratings tr on tr.title_id = tb.title_id
where pp.profession = 'composer'
and tr.average_rating >= 7.5;
/*Number of singers w/songs from movies over 3 min, by gender*/

CREATE VIEW v_songs_over_three_minutes AS
select gender, count(gender) as number_over_three_min, avg(song_duration)
from songs s join title_songs ts on ts.song_id=s.song_id
join singer_songs ss on ss.song_id=s.song_id
join person_basics pb on pb.person_id=ss.person_id
where song_duration>3
group by gender;
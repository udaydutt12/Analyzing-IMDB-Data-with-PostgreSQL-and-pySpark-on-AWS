CREATE TABLE Singer_Songs(  
	person_id varchar(10),
	song_id varchar(10),
	primary key(person_id, song_id),
	foreign key(person_id) references person_basics(person_id),
	foreign key(song_id) references songs(song_id)
);

CREATE TABLE temp_Singer_Songs(  
	person_id varchar(10),
	song_id varchar(10),
	primary key(person_id, song_id)
);

\copy temp_singer_songs from C:/Users/Abel/Documents/cinemalytics/singer_songs.csv (header TRUE, format csv, delimiter ',', null '', encoding 'UTF8');

insert into singer_songs
select tss.person_id, tss.song_id
from temp_singer_songs tss join person_basics pb on tss.person_id=pb.person_id
join songs s on s.song_id=tss.song_id;
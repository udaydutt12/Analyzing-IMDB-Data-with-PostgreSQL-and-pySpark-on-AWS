CREATE TABLE Title_Songs(  
	title_id varchar(10),
	song_id varchar(10),
	primary key(title_id, song_id),
	foreign key(title_id) references title_basics(title_id),
	foreign key(song_id) references songs(song_id)
);

CREATE TABLE temp_title_songs_csv(  
	song_id varchar(10),
	movie_id varchar(12),
	primary key(song_id, movie_id)
);

\copy temp_title_songs_csv from C:/Users/Abel/Documents/cinemalytics/title_songs.csv (header TRUE, format csv, delimiter ',', null '', encoding 'UTF8');

CREATE TABLE temp_titles_csv(  
	movie_id varchar(10),
	imdb_id varchar(10),
	primary_title varchar(300),
	original_title varchar(300),
	genre varchar(15),
	release_year int,
	primary key(movie_id)
);

\copy temp_titles_csv from C:/Users/Abel/Documents/cinemalytics/titles.csv (header TRUE, format csv, delimiter ',', null '', encoding 'UTF8');

insert into title_songs
select imdb_id, song_id
from temp_title_songs_csv ttsc join temp_titles_csv ttc on ttsc.movie_id = ttc.movie_id
join title_basics tb on ttc.imdb_id = tb.title_id
where song_id is not null and imdb_id is not null;
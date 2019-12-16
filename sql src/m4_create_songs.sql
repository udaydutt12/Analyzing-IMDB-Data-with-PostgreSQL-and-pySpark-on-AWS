CREATE TABLE Songs(  
	song_id varchar(10),
	song_title varchar(300),
	song_duration numeric(5, 2),
	primary key(song_id)
);

\copy songs from C:/Users/Abel/Desktop/cinemalytics/songs.csv (header TRUE, format csv, delimiter ',', null '', encoding 'UTF8');
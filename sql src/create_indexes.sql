create index primary_title_index on title_basics (upper(primary_title));

create index title_idx_no_tv on title_basics (upper(primary_title)) 
	where title_type != 'tvEpisode';

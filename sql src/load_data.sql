\copy person_basics from C:/Users/Abel/Desktop/pg/person_basics.csv (header TRUE, format csv, delimiter ',', null '', encoding 'UTF8');
\copy title_basics from C:/Users/Abel/Desktop/pg/title_basics.csv (header TRUE, format csv, delimiter ',', null '', encoding 'UTF8');
\copy title_genres from C:/Users/Abel/Desktop/pg/title_genres.csv (header TRUE, format csv, delimiter ',', null '', encoding 'UTF8');
\copy title_episodes from C:/Users/Abel/Desktop/pg/title_episodes.csv (header TRUE, format csv, delimiter ',', null '', encoding 'UTF8');
\copy title_ratings from C:/Users/Abel/Desktop/pg/title_ratings.csv (header TRUE, format csv, delimiter ',', null '', encoding 'UTF8');
\copy person_professions from C:/Users/Abel/Desktop/pg/person_professions.csv (header TRUE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy principals from 'C:/Users/Abel/Desktop/split_principals/xaa' (header TRUE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy principals from 'C:/Users/Abel/Desktop/split_principals/xab' (header FALSE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy principals from 'C:/Users/Abel/Desktop/split_principals/xac' (header FALSE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy principals from 'C:/Users/Abel/Desktop/split_principals/xad' (header FALSE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy principals from 'C:/Users/Abel/Desktop/split_principals/xae' (header FALSE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy principals from 'C:/Users/Abel/Desktop/split_principals/xaf' (header FALSE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy principals from 'C:/Users/Abel/Desktop/split_principals/xag' (header FALSE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy principals from 'C:/Users/Abel/Desktop/split_principals/xah' (header FALSE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy principals from 'C:/Users/Abel/Desktop/split_principals/xai' (header FALSE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy principals from 'C:/Users/Abel/Desktop/split_principals/xaj' (header FALSE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy principals from 'C:/Users/Abel/Desktop/split_principals/xak' (header FALSE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy principals from 'C:/Users/Abel/Desktop/split_principals/xal' (header FALSE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy principals from 'C:/Users/Abel/Desktop/split_principals/xam' (header FALSE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy stars from 'C:/Users/Abel/Desktop/split_stars/xaa' (header TRUE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy stars from 'C:/Users/Abel/Desktop/split_stars/xab' (header FALSE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy stars from 'C:/Users/Abel/Desktop/split_stars/xac' (header FALSE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy stars from 'C:/Users/Abel/Desktop/split_stars/xad' (header FALSE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy stars from 'C:/Users/Abel/Desktop/split_stars/xae' (header FALSE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy stars from 'C:/Users/Abel/Desktop/split_stars/xaf' (header FALSE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy stars from 'C:/Users/Abel/Desktop/split_stars/xag' (header FALSE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy writers from 'C:/Users/Abel/Desktop/split_writers/xaa' (header TRUE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy writers from 'C:/Users/Abel/Desktop/split_writers/xab' (header TRUE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy directors from 'C:/Users/Abel/Desktop/split_directors/xaa' (header TRUE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy directors from 'C:/Users/Abel/Desktop/split_directors/xab' (header TRUE, format csv, delimiter ',', null '', encoding 'UTF8');
alter table person_basics add column gender varchar(1);

create table temp_persons(
	person_id varchar(10) primary key,
	primary_name varchar(110),
	gender varchar(1),
	dob varchar(50)
);

\copy temp_persons from C:/Users/Abel/Documents/cinemalytics/persons.csv (header TRUE, format csv, delimiter ',', null '', encoding 'UTF8');

update temp_persons set dob=0 where dob is null;

create table temp_persons_fixed_date(
	person_id varchar(10) primary key,
	primary_name varchar(110),
	gender varchar(1),
	year int
);

insert into temp_persons_fixed_date
select person_id, primary_name, gender, substr(dob, 1, 4)::integer
from temp_persons;

insert into person_basics (person_id, primary_name, birth_year, gender)
select distinct tpfd.person_id, primary_name, year, gender
from temp_persons_fixed_date tpfd join temp_singer_songs tss on tpfd.person_id=tss.person_id;
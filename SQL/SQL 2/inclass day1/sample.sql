create schema if not exists AirLine;
use air_line;

create table airline_details
	(
flight_id varchar(10) not null,
name varchar(20),
country varchar(20) not null check (country in ('UK','USA','India','Canada','Singapore')),
primary key(flight_id),
unique(name)
		);
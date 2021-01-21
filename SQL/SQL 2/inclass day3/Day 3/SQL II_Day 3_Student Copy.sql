# Datasets used: AirlineDetails.csv, passengers.csv and senior_citizen.csv
-- -----------------------------------------------------
-- Schema Airlines
-- -----------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- 1. Create a table Airline_Details. Follow the instructions given below: 
-- -- Q1. Values in the columns Flight_ID should not be null.
-- -- Q2. Each name of the airline should be unique.
-- -- Q3. No country other than United Kingdom, USA, India, Canada and Singapore should be accepted
-- -- Q4. Assign primary key to Flight_ID
-- ---------------------------------------------------------------------------------------------------------------------------------------------------

create schema if not exists AirLine;
use airline;

CREATE TABLE airline_details (
    flight_id VARCHAR(10) NOT NULL,
    name VARCHAR(20),
    country VARCHAR(20) NOT NULL CHECK (country IN ('UK' , 'USA', 'India', 'Canada', 'Singapore')),
    PRIMARY KEY (flight_id),
    UNIQUE (name)
);

-- 2. Create a table Passengers. Follow the instructions given below: 
-- -- Q1. Values in the columns Traveller_ID and PNR should not be null.
-- -- Q2. Only passengers having age greater than 18 are allowed.
-- -- Q3. Assign primary key to Traveller_ID

-- Questions for table Passengers:  
-- -- Q3. PNR status should be unique and should not be null.
-- -- Q4. Flight Id should not be null.
-- ---------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE passengers (
    traveller_id VARCHAR(10) NOT NULL,
    pnr VARCHAR(10) NOT NULL,
    age INT CHECK (age > 18),
    flight_id VARCHAR(10) NOT NULL,
    UNIQUE (pnr),
    PRIMARY KEY (traveller_id),
    FOREIGN KEY (flight_id)
        REFERENCES airline_details (flight_id)
);

-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- 5. Create a table Senior_Citizen_Details. Follow the instructions given below: 
-- -- Q1. Column Traveller_ID should not contain any null value.
-- -- Q2. Assign primary key to Traveller_ID
-- -- Q3. Assign foreign key constraint on Traveller_ID such that if any row from passenger table is updated, then the Senior_Citizen_Details table should also get updated.
-- -- --  Also deletion of any row from passenger table should not be allowed.
-- ---------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE senioor_citizen_details (
    traveller_id VARCHAR(10) NOT NULL,
    PRIMARY KEY (traveller_id),
    FOREIGN KEY (traveller_id)
        REFERENCES passengers (traveller_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- -----------------------------------------------------
-- Table Senior_Citizen_Details
-- -- Q6. Create a new column Age in Passengers table that takes values greater than 18. 
 
 alter table senioor_citizen_details
 add age int check (age > 18);
 
-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- 7. Create a table books. Follow the instructions given below: 
-- -- Columns: books_no, description, author_name, cost
-- -- Qa. The cost should not be less than or equal to 0.
-- -- Qb. The cost column should not be null.
-- -- Qc. Assign a primary key to the column books_no.
-- ---------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE books (
    book_no VARCHAR(10) NOT NULL,
    description VARCHAR(50) NOT NULL,
    author_name VARCHAR(10) NOT NULL,
    cost INT NOT NULL CHECK (cost > 0),
    PRIMARY KEY (book_no)
);

# Q8. Update the table 'books' such that the values in the columns 'description' and author' must be unique.

alter table books
add unique(description,author);

-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- 9. Create a table bike_sales. Follow the instructions given below: 
-- -- Columns: id, product, quantity, release_year, release_month
-- -- Q1. Assign a primary key to ID. Also the id should auto increment.
-- -- Q2. None of the columns should be left null.
-- -- Q3. The release_month should be between 1 and 12 (including the boundries i.e. 1 and 12).
-- -- Q4. The release_year should be between 2000 and 2010.
-- -- Q5. The quantity should be greater than 0.

CREATE TABLE bike_sales (
    id INT NOT NULL AUTO_INCREMENT,
    product VARCHAR(10) NOT NULL,
    quantity INT NOT NULL CHECK (quantity != 0),
    release_year INT NOT NULL CHECK (release_year > 2000
        AND release_year < 2010),
    release_month INT NOT NULL CHECK (release_month > 0 AND release_month < 13),
    PRIMARY KEY (id)
);

alter table bike_sales
modify product varchar(20) not null;
-- --------------------------------------------------------------------------
-- Use the following comands to insert the values in the table bike_sales
/*('1','Pulsar','1','2001','7');
('2','yamaha','3','2002','3');
('3','Splender','2','2004','5');
('4','KTM','2','2003','1');
('5','Hero','1','2005','9');
('6','Royal Enfield','2','2001','3');
('7','Bullet','1','2005','7');
('8','Revolt RV400','2','2010','7');
('9','Jawa 42','1','2011','5');*/
-- --------------------------------------------------------------------------
insert into bike_sales values('1','Pulsar','1','2001','7');
insert into bike_sales values('2','yamaha','3','2002','3');
insert into bike_sales values('3','Splender','2','2004','5');
insert into bike_sales values('4','KTM','2','2003','1');
insert into bike_sales values('5','Hero','1','2005','9');
insert into bike_sales values('6','Royal Enfield','2','2001','3');
insert into bike_sales values('7','Bullet','1','2005','7');
insert into bike_sales values('8','Revolt RV400','2','2010','7');
insert into bike_sales values('9','Jawa 42','1','2011','5');


# Use bank_inventory, cricket_1 and cricket_2 tables from Online_Day1_InClass and Online_Day2_InClass to solve the queries.

# # Question 1:
# Q1.Write MySQL query to find highest priced product

SELECT 
    product, MAX(estimate_sale_price)
FROM
    bank_inventory;

# Question 2:

# Q2.Write MySQL query to find third lowest run scorer.

SELECT 
    player_name, runs
FROM
    cricket_1 
UNION SELECT 
    player_name, runs
FROM
    cricket_2
ORDER BY runs
LIMIT 1 OFFSET 2;

# Question 3:
# Q3. Write MySQL query to find player_ID and Player_name which contains “D”.

SELECT 
    player_id, player_name
FROM
    cricket_1
WHERE
    player_name LIKE '%d%' 
UNION SELECT 
    player_id, player_name
FROM
    cricket_2
WHERE
    player_name LIKE '%d%';

# Question 4:

# Q4.Write MySQL query to extract Player_Name whose name is having second character as 'R'

SELECT 
    player_name
FROM
    cricket_1
WHERE
    player_name LIKE '_r%' 
UNION SELECT 
    player_name
FROM
    cricket_2
WHERE
    player_name LIKE '_r%';

# Question 5:

# Q5.Write MySQL query to extract Player_Name whose name whose popularity is grater than 10 or charisma is greater than 50
# from tables cricket_1 and cricket_2 using set operator

SELECT 
    player_name, popularity
FROM
    cricket_1
WHERE
    popularity > 10 
UNION SELECT 
    player_name, charisma
FROM
    cricket_2
WHERE
    charisma > 50;

/* Prerequisites */
-- Use the bank_inventory table from Online_Day1_Inclass file to answer the below questions
use bank;
# Question 6:
# 6) Display the Geo_locations in capital letters from the table Bank_Holiday.

SELECT 
    UPPER(geo_location)
FROM
    bank_inventory;

# Question 7:
# 7) Display the position of occurance of the string ‘City’ in the column  Geo_location from the table Bank_Inventory.

SELECT 
    POSITION('city' IN geo_location) AS position_
FROM
    bank_inventory;

# Question 8:
# 8) Display the column Quantity from the table Bank_Inventory by applying the below formatting: 
-- a) convert the data type from numeric to character 
-- b) Pad the column with 0's  

SELECT 
    LPAD(CONVERT( quantity , CHAR), 7, '0') AS quan
FROM
    bank_inventory;

# To answer 9th question there are few prerquisites to be followed
# PRE - REQUISITE:
Insert into bank_Inventory values ( 'MaxGain',    6 , 220.39, 4690.67, 4890 , 'Riverdale-village' ) ;
Insert into bank_Inventory values ( 'SuperSave', 7 , 290.30, NULL, 3200.13 ,'Victoria-Town') ;

# Question 9:
# 9) Display the column Geo_location by replacing the underscores with spaces (" ").

SELECT 
    REPLACE(geo_location, '-', ' ') AS geo_loc
FROM
    bank_inventory;

-- Use the cricket2 table to answer the below questions

# Question 10:

# Q10. Display the columns Player_Name, charisma and Runs by combining into a single comma seperated output. (Name the column as : 'Details')

SELECT 
    CONCAT(CONCAT(player_name, ',', charisma),
            ',',
            runs) AS Delta
FROM
    cricket_2;
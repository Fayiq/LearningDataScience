# Pre-Requsites
# Assuming Candidates are familiar with “Group by” and “Grouping functions” because these are used along with JOINS in the questionnaire. 



Table Definitions:

1. BANK_CUSTOMER - Details of Customers of the Bank
2. BANK_CUSTOMER_EXPORT - Details of Customers of the Bank - to be used only when explicitly asked.
3. Bank_Account_Details - Account Details of the customers along with ADD on cards. One customer can have multiple details for Savings deposits, Recurring deposits, Credit Cards and Add on credit cards.
4. Bank_Account_Relationship_Details - Details of secondary accounts linked to primary accounts.
5. BANK_ACCOUNT_TRANSACTION - Details of the transactions.
6. BANK_CUSTOMER_MESSAGES - Details of Messages sent to customers after a transaction takes place.
7. BANK_INTEREST_RATE - Current interest rates for savings, RD and other accounts.
8. Bank_Holidays - Details of Bank Holidays.


# Create below DB objects 
use Inclass;
CREATE TABLE BANK_CUSTOMER (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(20),
    Address VARCHAR(20),
    state_code VARCHAR(3),
    Telephone VARCHAR(10)
);
				
INSERT INTO BANK_CUSTOMER VALUES (123001,"Oliver", "225-5, Emeryville", "CA" , "1897614500");
INSERT INTO BANK_CUSTOMER VALUES (123002,"George", "194-6,New brighton","MN" , "1897617000");
INSERT INTO BANK_CUSTOMER VALUES (123003,"Harry", "2909-5,walnut creek","CA" , "1897617866");
INSERT INTO BANK_CUSTOMER VALUES (123004,"Jack", "229-5, Concord",  	"CA" , "1897627999");
INSERT INTO BANK_CUSTOMER VALUES (123005,"Jacob", "325-7, Mission Dist","SFO", "1897637000");
INSERT INTO BANK_CUSTOMER VALUES (123006,"Noah", "275-9, saint-paul" ,  "MN" , "1897613200");
INSERT INTO BANK_CUSTOMER VALUES (123007,"Charlie","125-1,Richfield",   "MN" , "1897617666");
INSERT INTO BANK_CUSTOMER VALUES (123008,"Robin","3005-1,Heathrow", 	"NY" , "1897614000");



CREATE TABLE BANK_CUSTOMER_EXPORT (
    customer_id CHAR(10) PRIMARY KEY,
    customer_name CHAR(20),
    Address CHAR(20),
    state_code CHAR(3),
    Telephone CHAR(10)
);
    
INSERT INTO BANK_CUSTOMER_EXPORT VALUES ("123001 ","Oliver", "225-5, Emeryville", "CA" , "1897614500") ;
INSERT INTO BANK_CUSTOMER_EXPORT VALUES ("123002 ","George", "194-6,New brighton","MN" , "189761700");


#Bank_Account_details table

CREATE TABLE Bank_Account_Details (
    Customer_id INT,
    Account_Number VARCHAR(19) PRIMARY KEY,
    Account_type VARCHAR(25),
    Balance_amount INT,
    Account_status VARCHAR(10),
    Relationship_type VARCHAR(1)
);

ALTER TABLE Bank_Account_Details ADD FOREIGN KEY (Customer_id) REFERENCES bank_customer(Customer_id);

INSERT INTO Bank_Account_Details  VALUES (123001, "4000-1956-3456",  "SAVINGS" , 200000 ,"ACTIVE","P");
INSERT INTO Bank_Account_Details  VALUES (123001, "5000-1700-3456", "RECURRING DEPOSITS" ,9400000 ,"ACTIVE","S");  
INSERT INTO Bank_Account_Details  VALUES (123002, "4000-1956-2001",  "SAVINGS", 400000 ,"ACTIVE","P");
INSERT INTO Bank_Account_Details  VALUES (123002, "5000-1700-5001",  "RECURRING DEPOSITS" ,7500000 ,"ACTIVE","S");
INSERT INTO Bank_Account_Details  VALUES (123003, "4000-1956-2900",  "SAVINGS" ,750000,"INACTIVE","P");
INSERT INTO Bank_Account_Details  VALUES (123004, "5000-1700-6091", "RECURRING DEPOSITS" ,7500000 ,"ACTIVE","S");
INSERT INTO Bank_Account_Details  VALUES (123004, "4000-1956-3401",  "SAVINGS" , 655000 ,"ACTIVE","P");
INSERT INTO Bank_Account_Details  VALUES (123005, "4000-1956-5102",  "SAVINGS" , 300000 ,"ACTIVE","P");
INSERT INTO Bank_Account_Details  VALUES (123006, "4000-1956-5698",  "SAVINGS" , 455000 ,"ACTIVE" ,"P");
INSERT INTO Bank_Account_Details  VALUES (123007, "5000-1700-9800",  "SAVINGS" , 355000 ,"ACTIVE" ,"P");
INSERT INTO Bank_Account_Details  VALUES (123007, "4000-1956-9977",  "RECURRING DEPOSITS" , 7025000,"ACTIVE" ,"S");
INSERT INTO Bank_Account_Details  VALUES (123007, "9000-1700-7777-4321",  "Credit Card"	,0  ,"INACTIVE", "P");
INSERT INTO Bank_Account_Details  VALUES (123007, '5900-1900-9877-5543', "Add-on Credit Card" ,   0   ,"ACTIVE", "S");
INSERT INTO Bank_Account_Details  VALUES (123008, "5000-1700-7755",  "SAVINGS"   	,0   	,"INACTIVE","P");
INSERT INTO Bank_Account_Details  VALUES (123006, '5800-1700-9800-7755', "Credit Card"   ,0   	,"ACTIVE", "P");
INSERT INTO Bank_Account_Details  VALUES (123006, '5890-1970-7706-8912', "Add-on Credit Card"   ,0   	,"ACTIVE", "S");
INSERT INTO Bank_Account_Details VALUES (123004,'5000-1700-7791','RECURRING DEPOSITS',40000,'ACTIVE','S');



# CREATE TABLE Bank_Account_Relationship_Details

CREATE TABLE Bank_Account_Relationship_Details (
    Customer_id INT,
    Account_Number VARCHAR(19) PRIMARY KEY,
    Account_type VARCHAR(25),
    Linking_Account_Number VARCHAR(19)
);

ALTER TABLE Bank_Account_Relationship_Details ADD FOREIGN KEY (Customer_id) REFERENCES bank_customer(Customer_id);
ALTER TABLE Bank_Account_Relationship_Details ADD FOREIGN KEY (Linking_Account_Number) REFERENCES bank_account_details(Account_Number);

								
INSERT INTO Bank_Account_Relationship_Details  VALUES (123001, "4000-1956-3456",  "SAVINGS" , NULL);
INSERT INTO Bank_Account_Relationship_Details  VALUES (123001, "5000-1700-3456",  "RECURRING DEPOSITS" , "4000-1956-3456");  
INSERT INTO Bank_Account_Relationship_Details  VALUES (123002, "4000-1956-2001",  "SAVINGS" , NULL );
INSERT INTO Bank_Account_Relationship_Details  VALUES (123002, "5000-1700-5001",  "RECURRING DEPOSITS" , "4000-1956-2001" );
INSERT INTO Bank_Account_Relationship_Details  VALUES (123003, "4000-1956-2900",  "SAVINGS" , NULL );
INSERT INTO Bank_Account_Relationship_Details  VALUES (123004, "5000-1700-6091",  "RECURRING DEPOSITS" , "4000-1956-2900" );
INSERT INTO Bank_Account_Relationship_Details  VALUES (123004, "5000-1700-7791",  "RECURRING DEPOSITS" , "4000-1956-2900" );
INSERT INTO Bank_Account_Relationship_Details  VALUES (123007, "5000-1700-9800",  "SAVINGS" , NULL);
INSERT INTO Bank_Account_Relationship_Details  VALUES (123007, "4000-1956-9977",  "RECURRING DEPOSITS" , "5000-1700-9800" );
INSERT INTO Bank_Account_Relationship_Details  VALUES (NULL, "9000-1700-7777-4321",  "Credit Card" , "5000-1700-9800" );
INSERT INTO Bank_Account_Relationship_Details  VALUES (NULL, '5900-1900-9877-5543', 'Add-on Credit Card', '9000-1700-7777-4321' );
INSERT INTO Bank_Account_Relationship_Details  VALUES (NULL, '5800-1700-9800-7755', 'Credit Card', '4000-1956-5698' );
INSERT INTO Bank_Account_Relationship_Details  VALUES (NULL, '5890-1970-7706-8912', 'Add-on Credit Card', '5800-1700-9800-7755' );


# CREATE TABLE BANK_ACCOUNT_TRANSACTION

CREATE TABLE BANK_ACCOUNT_TRANSACTION (
    Account_Number VARCHAR(19),
    Transaction_amount DECIMAL(18 , 2 ),
    Transcation_channel VARCHAR(18),
    Province VARCHAR(3),
    Transaction_Date DATE
);

ALTER TABLE Bank_Account_Transaction ADD FOREIGN KEY (Account_number) REFERENCES Bank_Account_Details(Account_Number);


INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "4000-1956-3456",  -2000, "ATM withdrawl" , "CA", "2020-01-13");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "4000-1956-2001",  -4000, "POS-Walmart"   , "MN", "2020-02-14");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "4000-1956-2001",  -1600, "UPI transfer"  , "MN", "2020-01-19");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "4000-1956-2001",  -6000, "Bankers cheque", "CA", "2020-03-23");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "4000-1956-2001",  -3000, "Net banking"   , "CA", "2020-04-24");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "4000-1956-2001",  23000, "cheque deposit", "MN", "2020-03-15");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "5000-1700-6091",  40000, "ECS transfer"  , "NY", "2020-02-19");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "5000-1700-7791",  40000, "ECS transfer"  , "NY", "2020-02-19");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "4000-1956-3401",   8000, "Cash Deposit"  , "NY", "2020-01-19");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "4000-1956-5102",  -6500, "ATM withdrawal" , "NY", "2020-03-14");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "4000-1956-5698",  -9000, "Cash Deposit"  , "NY", "2020-03-27");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "4000-1956-9977",  50000, "ECS transfer"  , "NY", "2020-01-16");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "9000-1700-7777-4321",  -5000, "POS-Walmart", "NY", "2020-02-17");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "9000-1700-7777-4321",  -8000, "Shopping Cart", "MN", "2020-03-13");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "9000-1700-7777-4321",  -2500, "Shopping Cart", "MN", "2020-04-21");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "5800-1700-9800-7755", -9000, "POS-Walmart","MN", "2020-04-13");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( '5890-1970-7706-8912', -11000, "Shopping Cart" , "NY" , "2020-03-12") ;



# CREATE TABLE BANK_CUSTOMER_MESSAGES

CREATE TABLE BANK_CUSTOMER_MESSAGES (
    Event VARCHAR(24),
    Customer_message VARCHAR(75),
    Notice_delivery_mode VARCHAR(15)
);


INSERT INTO BANK_CUSTOMER_MESSAGES VALUES ( "Adhoc", "All Banks are closed due to announcement of National strike", "mobile" ) ;
INSERT INTO BANK_CUSTOMER_MESSAGES VALUES ( "Transaction Limit", "Only limited withdrawals per card are allowed from ATM machines", "mobile" );


INSERT INTO `bank_account_transaction`(`Account_Number`, `Transaction_amount`, `Transcation_channel`, `Province`, `Transaction_Date`) VALUES
('4000-1956-9977' ,    10000.00     ,'ECS transfer',     'MN' ,    '2020-02-16' ) ;

-- inserted for queries after 17th  
INSERT INTO `bank_account_transaction`(`Account_Number`, `Transaction_amount`, `Transcation_channel`, `Province`, `Transaction_Date`) VALUES
('4000-1956-9977' ,    40000.00     ,'ECS transfer',     'MN' ,    '2020-03-18' ) ;

INSERT INTO `bank_account_transaction`(`Account_Number`, `Transaction_amount`, `Transcation_channel`, `Province`, `Transaction_Date`) VALUES
('4000-1956-9977' ,    60000.00     ,'ECS transfer',     'MN' ,    '2020-04-18' ) ;

INSERT INTO `bank_account_transaction`(`Account_Number`, `Transaction_amount`, `Transcation_channel`, `Province`, `Transaction_Date`) VALUES
('4000-1956-9977' ,    20000.00     ,'ECS transfer',     'MN' ,    '2020-03-20' ) ;

-- inserted for queries after 24th 

INSERT INTO `bank_account_transaction`(`Account_Number`, `Transaction_amount`, `Transcation_channel`, `Province`, `Transaction_Date`) VALUES
('4000-1956-9977' ,    49000.00     ,'ECS transfer',     'MN' ,    '2020-06-18' ) ;




# CREATE TABLE BANK_INTEREST_RATE

CREATE TABLE BANK_INTEREST_RATE (
    account_type VARCHAR(24) PRIMARY KEY,
    interest_rate DECIMAL(4 , 2 ),
    month VARCHAR(2),
    year VARCHAR(4)
)	;

INSERT  INTO BANK_INTEREST_RATE VALUES ( "SAVINGS" , 0.04 , '02' , '2020' );
INSERT  INTO BANK_INTEREST_RATE VALUES ( "RECURRING DEPOSITS" , 0.07, '02' , '2020' );
INSERT  INTO BANK_INTEREST_RATE VALUES   ( "PRIVILEGED_INTEREST_RATE" , 0.08 , '02' , '2020' );

# Bank_holidays:

CREATE TABLE Bank_Holidays (
    Holiday DATE PRIMARY KEY,
    Start_time DATETIME,
    End_time TIMESTAMP
);

Insert into bank_holidays values ( '2020-05-20','2020-05-20','2020-05-20' ) ;

Insert into bank_holidays values( '2020-03-13' ,'2020-03-13' ,'2020-03-13' ) ;





############################################ Questions ############################################


# Question 1:
# 1) Print credit card transactions with sum of transaction_amount on all Fridays and sum of transaction_amount on all other days. 

SELECT 
    a.Account_Number,
    a.Account_type,
    SUM(b.Transaction_amount) friday,
    SUM(c.Transaction_amount) other_days
FROM
    bank_account_details a
        JOIN
    bank_account_transaction b ON a.Account_Number = b.Account_Number
        AND DAYNAME(b.Transaction_Date) = 'Friday'
        AND a.Account_type LIKE '%credit%'
        JOIN
    bank_account_transaction c ON b.Account_Number = c.Account_Number
        AND DAYNAME(c.Transaction_Date) = 'Friday'
GROUP BY a.Account_Number , a.Account_type , DATE_FORMAT(b.Transaction_Date, '%Y-%m');

# Question 2:
# 2) Show the details of credit cards along with the aggregate transaction amount during holidays  and non holidays. 

SELECT 
    a.Account_Number,
    ab.Account_type,
    a.Transaction_Date,
    a.Transaction_amount amount,
    SUM(abc.Transaction_amount) non_holiday
FROM
    bank_account_transaction a
        JOIN
    bank_holidays b ON a.Transaction_Date = b.Holiday
        JOIN
    bank_account_details ab ON a.Account_Number = ab.Account_Number
        AND ab.Account_type LIKE '%credit%'
        JOIN
    bank_account_transaction abc ON ab.Account_Number = abc.Account_Number
        AND abc.Transaction_Date <> b.Holiday
GROUP BY a.Account_Number , ab.Account_type , a.Transaction_Date
HAVING ABS(a.Transaction_amount) > ABS(SUM(abc.Transaction_amount));

# Question 3:
# 3) Generate a report to Send Ad-hoc holiday greetings - “Happy Holiday” for all transactions occurred during Holidays in 3rd month.

SELECT 
    bcm.event AS event_name,
    bcm.customer_message AS msg,
    bh.holiday AS holiday
FROM
    bank_customer_messages bcm
        CROSS JOIN
    bank_holidays bh
WHERE
    bcm.event = 'adhoc'
        AND MONTH(bh.holiday) = 3;

# Question 4:
# 4) Calculate the Bank accrued interest with respect to their RECURRING DEPOSITS  for any deposits older than 30 days . 

# Note: Accrued interest calculation =  transaction_amount * interest_rate 
-- fields/tables:   interest_rate @bank_interest_rate table 
--                  transaction_amount @bank_account_transaction 
 
 # Pre-requisite Use bank schema tables from Online_Day7_Takehome to solve the queries.

SELECT 
    b.Account_Number,
    c.Transaction_Date,
    SUM(c.Transaction_amount * 0.07) AS interest
FROM
    bank_account_relationship_details a
        JOIN
    bank_account_relationship_details b ON a.Account_Number = b.Linking_Account_Number
        AND a.Account_type <> b.Account_type
        AND b.Account_type LIKE '%recurr%'
        JOIN
    bank_account_transaction c ON b.Account_Number = c.Account_Number
        AND (c.Transcation_channel LIKE '%ecs%'
        OR c.Transcation_channel LIKE '%deposit%')
GROUP BY b.Account_Number
HAVING DATEDIFF(CURDATE(), c.Transaction_Date) > 30;

# Question 5:
# 5) Display the Savings Account number whose corresponding Credit cards and  AddonCredit card transactions have occured more than one time .

SELECT 
    a.Account_Number,
    a.Account_type,
    b.Linking_Account_Number,
    b.Account_type,
    COUNT(c.Transaction_amount) AS cunt
FROM
    bank_account_relationship_details a
        JOIN
    bank_account_relationship_details b ON a.Account_Number = b.Linking_Account_Number
        AND b.Account_type LIKE '%credit%'
        JOIN
    bank_account_transaction c ON b.Account_Number = c.Account_Number
GROUP BY a.Account_Number , a.Account_type , b.Linking_Account_Number , b.Account_type
HAVING COUNT(c.Transaction_amount) > 1;  

# Question 6:
# 6) Display the Savings Account number whose corresponding AddonCredit card transactions have occured atleast once. 

SELECT 
    a.Account_Number,
    a.Account_type,
    b.Linking_Account_Number,
    b.Account_type,
    COUNT(c.Transaction_amount) AS cunt
FROM
    bank_account_relationship_details a
        JOIN
    bank_account_relationship_details b ON a.Account_Number = b.Linking_Account_Number
        AND b.Account_type LIKE '%add%'
        JOIN
    bank_account_transaction c ON b.Account_Number = c.Account_Number
GROUP BY a.Account_Number , a.Account_type , b.Linking_Account_Number , b.Account_type
HAVING COUNT(c.Transaction_amount) >= 1;

# Question 7:
# 7) Print the customer_id and length of customer_id using Natural join on  Tables :  bank_customer  and  bank_customer_export 
# Note: Do not use table alias to refer to column names.

SELECT 
    customer_id, LENGTH(customer_id)
FROM
    bank_customer_export
        NATURAL JOIN
    bank_customer;

# Question 8:
# 8) Print customer_id, customer_name and other common columns  from both the Tables :  bank_customer & bank_customer_export without missing any matching customer_id key column records. 
-- Note: refer datatype conversion if found any missing records

select a.customer_id, a.customer_name 
from bank_customer_export a natural inner join bank_customer b;


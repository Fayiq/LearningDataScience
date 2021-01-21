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

CREATE TABLE BANK_ACCOUNT_TRANSACTION 
(  
Account_Number VARCHAR(19),
Transaction_amount Decimal(18,2) , 
Transcation_channel VARCHAR(18) ,
Province varchar(3) , 
Transaction_Date Date
) ;

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

CREATE TABLE BANK_CUSTOMER_MESSAGES 
(  
Event VARCHAR(24),
Customer_message VARCHAR(75),
Notice_delivery_mode VARCHAR(15)) ;


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

CREATE TABLE BANK_INTEREST_RATE(  
account_type varchar(24)PRIMARY KEY,
interest_rate decimal(4,2),
month varchar(2),
year  varchar(4)
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
# 1) Print customer Id, customer name and average account_balance maintained by each customer for all 
# of his/her accounts in the bank.

SELECT 
    bc.customer_id, bc.customer_name, bad.balance_amount
FROM
    bank_customer bc
        JOIN
    bank_account_details bad ON bc.customer_id = bad.customer_id
GROUP BY bc.customer_id;

# Question 2:
# 2) Print customer_id , account_number and balance_amount for all the accounts.
# for account_type = "Credit Card" apply the condition that if balance_amount is nil then assign transaction_amount 

SELECT 
    customer_id,
    ba.account_number,
    CASE
        WHEN
            account_type LIKE '%credit%'
                AND IFNULL(balance_amount, 0) = 0
        THEN
            transaction_amount
        ELSE balance_amount
    END AS 'balance_amount'
FROM
    bank_account_details ba
        JOIN
    bank_account_transaction bat ON ba.account_number = bat.account_number;

# Question 3:
# 3) Print account_number and balance_amount , transaction_amount,Transaction_Date from Bank_Account_Details and 
# bank_account_transaction for all the transactions occurred during march,2020 and april, 2020

SELECT 
    bad.account_number,
    bad.balance_amount,
    bat.transaction_amount,
    bat.transaction_date
FROM
    bank_account_details bad
        JOIN
    bank_account_transaction bat ON bad.account_number = bat.account_number
WHERE
    YEAR(bat.transaction_date) = 2020
        AND MONTH(transaction_date) IN (03 , 04);

# Question 4:
# 4) Print all the customer ids, account number,  balance_amount, transaction_amount , Transaction_Date 
# from bank_customer, Bank_Account_Details and bank_account_transaction tables where excluding 
# all of their transactions in march, 2020  month


SELECT 
    bad.customer_id,
    bad.account_number,
    bad.balance_amount,
    bat.transaction_amount,
    bat.transaction_date
FROM
    bank_account_details bad
        JOIN
    bank_account_transaction bat ON bad.account_number = bat.account_number
WHERE
    MONTH(bat.transaction_date) != 03;

# Question 5:
# 5) Print the customer ids, account_number, balance_amount,transaction_amount ,transaction_date who did transactions 
# during the first quarter. Do not display the accounts if they have not done any transactions in the first quarter.

SELECT 
    bad.customer_id,
    bad.account_number,
    bad.balance_amount,
    bat.transaction_amount,
    bat.transaction_date
FROM
    bank_account_details bad
        JOIN
    bank_account_transaction bat ON bad.account_number = bat.account_number
WHERE
    MONTH(bat.transaction_date) IN (01 , 02, 03);

# Question 6:
# 6) Print account_number, Event and Customer_message from BANK_CUSTOMER_MESSAGES and Bank_Account_Details to 
# display an “Adhoc" Event for all customers who have  “SAVINGS" account_type account.

SELECT 
    bad.account_number, bcm.event, bcm.customer_message
FROM
    bank_account_details bad
        CROSS JOIN
    bank_customer_messages bcm
WHERE
    bcm.event = 'adhoc'
        AND account_type = 'savings';

# Question 7:
# 7) Print all the Customer_ids, Account_Number, Account_type, and display deducted balance_amount by  
# subtracting only negative transaction_amounts for Relationship_type =
#  "P" ( P - means  Primary , S - means Secondary ) .

SELECT 
    Customer_id,
    bad.Account_Number,
    Account_type,
    CASE
        WHEN transaction_amount < 0 THEN balance_Amount + transaction_amount
        ELSE balance_amount
    END AS 'new_balance'
FROM
    bank_account_details bad
        JOIN
    bank_account_transaction bat ON bad.account_number = bat.account_number
WHERE
    Relationship_type = 'P';


# Question 8:
# a) Display records of All Accounts , their Account_types, the balance amount.
# b) Along with first step, Display other columns with corresponding linking account number, account types 

SELECT 
    bad.account_number,
    bad.account_type,
    bad.balance_amount,
    bar.account_number,
    bar.account_type
FROM
    bank_account_details bad
        JOIN
    bank_account_relationship_details bar ON bad.account_number = bar.linking_account_number;

# Question 9:
# a) Display records of All Accounts , their Account_types, the balance amount.
# b) Along with first step, Display other columns with corresponding linking account number, account types 
# c) After retrieving all records of accounts and their linked accounts, display the  
# transaction amount of accounts appeared  in another column.

SELECT 
    bad.account_number,
    bad.account_type,
    bad.balance_amount,
    bar.account_number,
    bar.account_type,
    bat.transaction_amount
FROM
    bank_account_details bad
        JOIN
    bank_account_relationship_details bar ON bad.account_number = bar.linking_account_number
        JOIN
    bank_account_transaction bat ON bad.account_number = bat.account_number;

# Question 10:
# 10) Display all account holders from Bank_Accounts_Details table who have “Add-on Credit Cards" and “Credit cards" 

SELECT 
    *
FROM
    bank_account_details
WHERE
    account_type LIKE '%credit%';

# Question 11:
# 11)  Display  records of “SAVINGS” accounts linked with “Credit card" account_type and its credit
# aggregate sum of transaction amount.

# Ref: Use bank_Account_Details for Credit card types
		#Check linking relationship in bank_transaction_relationship_details.
        # Check transaction_amount in bank_account_transaction. 

SELECT 
    bar.Account_number,
    bar.account_type,
    bad.account_number AS 'savings_Account_no',
    SUM(transaction_Amount)
FROM
    bank_account_relationship_details bar
        JOIN
    bank_account_details bad ON bad.account_number = bar.linking_account_number
        JOIN
    bank_Account_transaction bat ON bar.account_number = bat.account_number
WHERE
    bar.account_type = 'Credit Card'
GROUP BY bar.Account_number , bar.account_type , bad.account_number;

# Question 12:
# 12) Display all type of “Credit cards”  accounts including linked “Add-on Credit Cards" 
# type accounts with their respective aggregate sum of transaction amount.

# Ref: Check Bank_Account_Details_table for all types of credit card.
        # Check transaction_amount in bank_account_transaction. 

SELECT 
    bad.account_number AS PRI_ACCNO,
    bad.account_type AS PRI_ACCTYP,
    bar.account_number AS LNK_ACCNO,
    bar.account_type AS LNK_ACCTYP,
    SUM(bat.transaction_amount) AS AGG_TRANSAC
FROM
    bank_account_details AS bad
        JOIN
    bank_account_relationship_details AS bar ON bad.account_number = bar.linking_account_number
        JOIN
    bank_account_transaction AS bat ON bad.account_number = bat.account_number
WHERE
    bad.account_type LIKE '%credit%'
        AND bar.account_type LIKE '%credit%'
GROUP BY PRI_ACCNO , PRI_ACCTYP , LNK_ACCNO , LNK_ACCTYP;

# Question 13:
# 13) Display “SAVINGS” accounts and their corresponding aggregate sum of transaction amount 
# of all recurring deposits

SELECT 
    bad.account_number AS acc_nmbr,
    bad.account_type AS acc_type,
    SUM(bat.transaction_amount) AS sum_transaction
FROM
    bank_account_details bad
        JOIN
    bank_account_transaction bat ON bad.account_number = bat.account_number
WHERE
    bad.account_type LIKE '%saving%'
GROUP BY bad.account_number;

# Question 14:
# 14) Display recurring deposits and their transaction amounts in  Feb 2020  along with 
# associated SAVINGS account_number , balance. 

SELECT 
    bad.account_number AS acc_nmbr,
    bad.account_type AS acc_type,
    bad.balance_amount AS acc_bal,
    bat.transaction_amount AS trans_amnt,
    bat.transaction_date AS trans_date
FROM
    bank_account_details bad
        JOIN
    bank_account_transaction bat ON bad.account_number = bat.account_number
WHERE
    bad.account_type LIKE '%savings%'
        AND YEAR(bat.transaction_date) = 2020
        AND MONTH(bat.transaction_date) = 02
GROUP BY bad.account_number;

# Question 15:
# 15) Display every account's total no of transactions for every year and each month.

SELECT 
    bad.account_number AS acc_nmbr,
    bad.account_type AS acc_type,
    COUNT(YEAR(bat.transaction_date)) AS no_of_transaction_year,
    COUNT(MONTH(bat.transaction_date)) AS no_of_transaction_month
FROM
    bank_account_details bad
        JOIN
    bank_account_transaction bat ON bat.account_number = bad.account_number
GROUP BY bad.account_number;

# Question 16:
# 16) Compare the aggregate sum transaction amount of Feb2020 month versus Jan2020 Month for each account number.
-- Display account_number, transaction_amount , 
-- sum of feb month transaction amount ,
-- sum of Jan month transaction amount , 
 
 SELECT 
    bat1.account_number,
    SUM(bat1.transaction_amount) AS Jan_transaction,
    SUM(bat2.transaction_amount) AS Feb_transaction
FROM
    bank_account_transaction bat1
        JOIN
    bank_account_transaction bat2 ON bat1.account_number = bat2.account_number
WHERE
    MONTH(bat1.transaction_date) = 1
        AND MONTH(bat2.transaction_date) = 2
GROUP BY bat1.account_number;
 
# Question 17:
# 17) Display the customer names who have all three account types - 
# savings, recurring and credit card account holders.

SELECT 
    bc.customer_name, bc.customer_id, bad.account_type
FROM
    bank_customer bc
        JOIN
    bank_account_details bad ON bad.customer_id = bc.customer_id 
WHERE
    bad.account_type LIKE '%saving%'
        AND bad.account_type LIKE '%recurring%'
        AND bad.account_type LIKE '%credit%'
GROUP BY bc.customer_name;

# Question 18:
# 18) Display savings accounts and its corresponding Recurring deposits transactions that are occuring more than 4 times.

SELECT 
    bad.account_number AS acc_nmbr,
    bad.account_type AS acc_type,
    CASE
        WHEN COUNT(bat.transcation_channel) > 4 THEN bat.transcation_channel
    END AS transaction_channel
FROM
    bank_account_details bad
        JOIN
    bank_account_transaction bat ON bat.account_number = bad.account_number
WHERE
    bad.account_type LIKE '%saving%';

# Question 19:
# 19) Display savings accounts and its recurring deposits account with their aggregate 
# transactions per month occurs in 3 different months.

SELECT 
    bad.account_number AS acc_nmbr,
    bad.account_type AS acc_type,
    CASE
        WHEN COUNT(MONTH(bat.transaction_date)) > 3 THEN SUM(bat.transaction_amount)
    END AS agg_transac_amnt
FROM
    bank_account_details bad
        JOIN
    bank_account_transaction bat ON bat.account_number = bad.account_number
WHERE
    bad.account_type LIKE '%saving%';

# Question 20:
# 20) Find the no. of transactions of credit cards including add-on Credit Cards

SELECT 
    bad.account_number AS pri_acc_nmbr,
    COUNT(bad.account_type) AS pri_acc_count,
    bar.account_number AS lnk_acc_nmbr,
    COUNT(bar.account_type) AS lnk_acc_count,
    (COUNT(bad.account_type) + COUNT(bar.account_type)) AS total_count
FROM
    bank_account_details bad
        JOIN
    bank_account_relationship_details bar ON bar.linking_account_number = bad.account_number
WHERE
    bad.account_type LIKE '%credit%'
        AND bar.account_type LIKE '%add%'
GROUP BY pri_acc_nmbr;
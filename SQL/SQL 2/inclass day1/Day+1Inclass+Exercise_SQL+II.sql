# Dataset used: titanic_ds.csv
# Use subqueries for every question

use sql2inclass1;

#Q1. Display the first_name, last_name, passenger_no , fare of the passenger who paid less than the  maximum fare. (20 Row)

SELECT 
    CONCAT(first_name, ' ', last_name) AS PName,
    passenger_no AS PNO,
    fare
FROM
    titanic_ds
WHERE
    fare < (SELECT 
            MAX(fare)
        FROM
            titanic_ds);

#Q2. Retrieve the first_name, last_name and fare details of those passengers who paid fare greater than average fare. (11 Rows)

SELECT 
    CONCAT(first_name, ' ', last_name) AS PName,
    passenger_no AS PNO,
    fare
FROM
    titanic_ds
WHERE
    fare < (SELECT 
            AVG(fare)
        FROM
            titanic_ds);

#Q3. Display the first_name ,sex, age, fare and deck_number of the passenger equals to passenger number 7 but exclude passenger number 7.(3 Rows)

SELECT 
    first_name, sex, age, fare
FROM
    titanic_ds
WHERE
    (sex , deck_number) IN (SELECT 
            sex, deck_number
        FROM
            titanic_ds
        WHERE
            passenger_no = 7);
 
#Q4. Display first_name,embark_town where deck is equals to the deck of embark town ends with word 'town' (7 Rows)

SELECT 
    first_name, embark_town
FROM
    titanic_ds
WHERE
    deck IN (SELECT 
            deck
        FROM
            titanic_ds
        WHERE
            embark_town LIKE '%town');


# Dataset used: youtube_11.csv

#Q5. Display the video Id and the number of likes of the video that has got less likes than maximum likes(10 Rows)

SELECT 
    video_id, likes
FROM
    youtube_11
WHERE
    likes < (SELECT 
            MAX(likes)
        FROM
            youtube_11);

#Q6. Write a query to print video_id and channel_title where trending_date is equals to the trending_date of  category_id 1(5 Rows)

SELECT 
    video_id, channel_title
FROM
    youtube_11
WHERE
    trending_date IN (SELECT 
            trending_date
        FROM
            youtube_11
        WHERE
            Category_id = 1);

#Q7. Write a query to display the publish date, trending date ,views and description where views are more than views of Channel 'vox'.(7 Rows))

SELECT 
    publish_date, trending_date, views, description
FROM
    youtube_11
WHERE
    views > (SELECT 
            views
        FROM
            youtube_11
        WHERE
            Channel_Title LIKE 'vox');

#Q8. Write a query to display the channel_title, publish_date and the trending_date having category id in between 9 to Maximum category id .
# Do not use Max function(3 Rows)

SELECT 
    channel_title, publish_date, trending_date
FROM
    youtube_11
WHERE
    trending_date IN (SELECT 
            Trending_Date
        FROM
            youtube_11
        WHERE
            Category_id BETWEEN 9 AND (SELECT 
                    category_id
                FROM
                    youtube_11
                ORDER BY Category_id DESC
                LIMIT 1));

#Q9. Write a query to display channel_title, video_id and number of view of the video that has received more than  mininum views. (10 Rows)

SELECT 
    channel_title, video_id, views
FROM
    youtube_11
WHERE
    views > (SELECT 
            MIN(views)
        FROM
            youtube_11);

# Database used: db1 (db1.sql file provided)

#Q10. Get those order details whose amount is greater than 100,000 and got cancelled(1 Row))

SELECT 
    o.ordernumber,
    o.orderdate,
    o.shippeddate,
    o.status,
    o.comments,
    o.customernumber,
    amount
FROM
    orders o
        JOIN
    customers c ON o.customernumber = c.customernumber
        JOIN
    payments p ON c.customernumber = p.customernumber
WHERE
    p.amount > 100000
        AND o.status LIKE '%cancelled%'
GROUP BY o.ordernumber;

#Q11. Get employee details who shipped an order within a time span of two days from order date (15 Rows)

SELECT DISTINCT
    (k.ename)
FROM
    (SELECT 
        o.ordernumber,
            (o.shippeddate - o.orderdate) AS d2d,
            e.employeenumber,
            CONCAT(e.firstname, ' ', e.lastname) AS ename
    FROM
        orders o
    JOIN customers c ON o.customernumber = c.customernumber
    JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
    WHERE
        (o.shippeddate - o.orderdate) <= 2
    GROUP BY o.ordernumber) k;

#Q12. Get product name , product line , product vendor of products that got cancelled(53 Rows)
 
SELECT 
    p.productname AS PName,
    p.productline AS Pline,
    p.productvendor AS PVendor
FROM
    products p
        JOIN
    orderdetails od ON p.productcode = od.productcode
        JOIN
    orders o ON od.ordernumber = o.ordernumber
WHERE
    o.status LIKE '%cance%'
GROUP BY pname , pline;
 
#Q13. Get customer full name along with phone number ,address , state, country, who's order was resolved(4 Rows)
 
 SELECT 
    *
FROM
    (SELECT 
        c.customerName AS CName,
            c.phone AS CPhone,
            CONCAT(addressLine1, ' ', addressLine2) AS CAdd,
            c.state AS State,
            c.country AS Country,
            o.status AS stat
    FROM
        orders o
    JOIN (SELECT 
        *
    FROM
        customers) c ON o.customernumber = c.customernumber
    WHERE
        o.status LIKE '%resol%') h;
 
#Q14. Display those customers who ordered product of price greater than average price of all products(98 Rows)
 
 SELECT 
    j.cname, j.onum, j.amnt
FROM
    (SELECT 
        o.ordernumber AS onum,
            p.amount AS amnt,
            c.customername AS cname,
            c.customernumber AS cnum
    FROM
        payments p
    JOIN customers c ON p.customernumber = c.customernumber
    JOIN orders o ON c.customernumber = o.customernumber
    GROUP BY o.ordernumber) j
WHERE
    j.amnt > (SELECT 
            AVG(msrp)
        FROM
            products)
GROUP BY j.cname;
 
#Q15. Get office deatils of employees who work in the same city where their customers reside(5 Rows)

SELECT 
    e.employeenumber,
    CONCAT(e.firstname, ' ', e.lastname) AS ename,
    o.city AS ecity,
    c.customername,
    c.city
FROM
    employees e
        JOIN
    offices o ON e.officecode = e.officecode
        JOIN
    customers c ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE
    o.city = c.city
GROUP BY e.employeenumber;
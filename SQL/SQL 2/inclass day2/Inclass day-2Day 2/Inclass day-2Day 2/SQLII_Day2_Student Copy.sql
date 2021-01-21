use sql2inclass2;

-- --------------------------------------------------------------
# Dataset Used: wine.csv
-- --------------------------------------------------------------

SELECT * FROM wine;

# Q1. Rank the winery according to the quality of the wine (points).-- Should use dense rank

select winery,points, dense_rank() over(order by points)
from wine;

# Q2. Give a dense rank to the wine varities on the basis of the price.

select variety,price, dense_rank() over(partition by variety order by price)
from wine;

# Q3. Use aggregate window functions to find the average of points for each row within its partition (country). 
-- -- Also arrange the result in the descending order by country.

select *,avg(points) over(partition by country order by points)
from wine
group by country;

-----------------------------------------------------------------
# Dataset Used: students.csv
-- --------------------------------------------------------------

# Q4. Rank the students on the basis of their marks subjectwise.

select *,rank() over(partition by subject order by marks) as crank,
avg(marks) over(partition by subject order by marks) as avgmarks
from students;

# Q5. Provide the new roll numbers to the students on the basis of their names alphabetically.

select name,row_number() over(order by name) as 'new_rollnumber'
from students;

# Q6. Use the aggregate window functions to display the sum of marks in each row within its partition (Subject).

select name,sum(marks) over(order by subject desc) as 'total-marks'
from students;

# Q7. Display the records from the students table where partition should be done 
-- on subjects and use sum as a window function on marks, 
-- -- arrange the rows in unbounded preceding manner.

select subject, marks ,sum(marks) over(partition by subject order by marks rows unbounded preceding)
from students;

# Q8. Find the dense rank of the students on the basis of their marks subjectwise. Store the result in a new table 'Students_Ranked'

create table Students_Ranked as (select name,sum(marks), dense_rank() over(order by sum(marks) desc)
from students
group by name);	

-----------------------------------------------------------------
# Dataset Used: website_stats.csv and web.csv
-----------------------------------------------------------------
# Q9. Show day, number of users and the number of users the next day (for all days when the website was used)

select website_id,day,no_users,lead(no_users,1) over(partition by website_id order by day) as 'users-next-day'
from website_stats;

# Q10. Display the difference in ad_clicks between the current day and the next day for the website 'Olympus'

SELECT 
  day,no_users,lead(no_users,1) over(partition by website_id order by day) as 'users-next-day'
FROM
    website_stats
WHERE
    website_id = (SELECT 
            id
        FROM
            web
        WHERE
            name LIKE '%oly%');

# Q11. Write a query that displays the statistics for website_id = 3 such that for each row, show the day, the number of users and the smallest number of users ever.

SELECT 
    day, no_users, MIN(no_users) over()
FROM
    website_stats
WHERE
    website_id = 3;

# Q12. Write a query that displays name of the website and it's launch date. The query should also display the date of recently launched website in the third column.

select name,launch_date,max(launch_date) over()
from web;

-----------------------------------------------------------------
# Dataset Used: play_store.csv and sale.csv
-----------------------------------------------------------------
# Q13. Write a query thats orders games in the play store into three buckets as per editor ratings received  

select name,genre,editor_rating,ntile(3) over(order by editor_rating desc)
from play_store;

# Q14. Write a query that displays the name of the game, the price, the sale date and the 4th column should display 
# the sales consecutive number i.e. ranking of game as per the sale took place, so that the latest game sold gets number 1. Order the result by editor's rating of the game

select ps.name, s.price, s.date, row_number() over(order by date desc) as 'latest game sold rank'
from play_store ps
join sale s on ps.id = s.id
group by name;

# Q15. Write a query to display games which were both recently released and recently updated. For each game, show name, 
#date of release and last update date, as well as their rank
#Hint: use ROW_NUMBER(), sort by release date and then by update date, both in the descending order

select name,released,updated, row_number() over(order by released desc, updated desc)
from play_store;

-----------------------------------------------------------------
# Dataset Used: movies.csv, customers.csv, ratings.csv, rent.csv
-----------------------------------------------------------------
# Q16. Write a query that displays basic movie informations as well as the previous rating provided by customer for that same movie 
# make sure that the list is sorted by the id of the reviews.

select r.id, m.title, r.rating, lag(r.rating) over(partition by m.id order by r.id) by_customer
from ratings r, movies m
where r.movie_id = m.id;

# Q17. For each movie, show the following information: title, genre, average user rating for that movie 
# and its rank in the respective genre based on that average rating in descending order (so that the best movies will be shown first).

with subquerry as (
select m.title, m.genre, avg(r.rating) as avg
from ratings r, movies m
where r.movie_id = m.id
group by m.title,m.genre
)
select title,genre,avg, rank() over(partition by genre order by avg desc) rank_
from subquerry;


# Q18. For each rental date, show the rental_date, the sum of payment amounts (column name payment_amounts) from rent 
#on that day, the sum of payment_amounts on the previous day and the difference between these two values.



use ipl;

## 1. Show the percentage of wins of each bidder in the order of highest to lowest percentage.

SELECT 
    g.bidder_id,
    ((j.won / COUNT(g.bid_status)) * 100) AS 'Win Percentage'
FROM
    ipl_bidding_details g,
    (SELECT 
        bidder_id, COUNT(bid_status) AS won
    FROM
        ipl_bidding_details
    WHERE
        bid_status LIKE 'won'
    GROUP BY bidder_id) j
WHERE
    g.bidder_id = j.bidder_id
GROUP BY g.bidder_id
ORDER BY ((j.won / COUNT(g.bid_status)) * 100) DESC;

##2. Display the number of matches conducted at each stadium with stadium name, city from the database.

SELECT 
    ips.stadium_id,
    ips.stadium_name,
    ips.city,
    j.nom AS 'No:of matches played in the stadium'
FROM
    ipl_stadium ips,
    (SELECT 
        stadium_id, COUNT(stadium_id) AS nom
    FROM
        ipl_match_schedule
    GROUP BY stadium_id) j
WHERE
    ips.STADIUM_ID = j.stadium_id
GROUP BY stadium_id;

## 3. In a given stadium, what is the percentage of wins by a team which has won the toss?

SELECT 
    is1.stadium_name,
    CASE
        WHEN im.toss_winner = im.match_winner THEN ((COUNT(im.match_winner) / COUNT(im.toss_winner)) * 100)
    END AS 'percentage of winning'
FROM
    ipl_stadium is1
        JOIN
    ipl_match_schedule ims ON is1.stadium_id = ims.stadium_id
        JOIN
    ipl_match im ON ims.match_id = im.match_id
GROUP BY is1.stadium_name;

## 4. Show the total bids along with bid team and team name.

SELECT 
    ipd1.bidder_name AS 'Bidder Name',
    it.team_name AS 'Team Name',
    COUNT(ipd2.bid_team) AS 'no:of times bidder bid on the team'
FROM
    ipl_bidder_details ipd1,
    ipl_bidding_details ipd2,
    ipl_team it
WHERE
    ipd1.bidder_id = ipd2.bidder_id
        AND ipd2.bid_team = it.team_id
GROUP BY ipd1.bidder_name , it.team_name;

## 5. Show the team id who won the match as per the win details.

SELECT 
    ipd.bid_team AS 'Team IDs of teams who won the match as per the win details'
FROM
    ipl_bidding_details ipd
        JOIN
    ipl_match_schedule ims ON ipd.schedule_id = ims.schedule_id
        JOIN
    ipl_match im ON ims.match_id = im.match_id
WHERE
    ipd.bid_status LIKE 'won'
        AND ipd.bid_team = im.match_winner
GROUP BY ipd.bid_team;

## 6. Display total matches played, total matches won and total matches lost by team along with its team name.

SELECT 
    it.team_name AS 'Team Name',
    SUM(its.matches_played) AS 'Total Matches Played',
    SUM(its.matches_won) AS 'Matches Won',
    SUM(its.matches_lost) AS 'Matches Lost'
FROM
    ipl_team it
        JOIN
    ipl_team_standings its ON it.team_id = its.team_id
GROUP BY it.team_name;      

## 7. Display the bowlers for Mumbai Indians team.

SELECT 
    ip.player_name AS 'Bowlers for Mumbai Indians'
FROM
    ipl_player ip
        JOIN
    ipl_team_players itp ON ip.player_id = itp.player_id
        JOIN
    ipl_team it ON itp.team_id = it.team_id
WHERE
    it.team_name LIKE '%mumbai%'
        AND itp.player_role LIKE 'bowler'
GROUP BY ip.player_name;

## 8. How many all-rounders are there in each team, Display the teams with more than 4 all-rounder in descending order.

SELECT 
    it.team_name as 'Teams with more than 4 all-rounders'
FROM
    ipl_team it
        JOIN
    ipl_team_players itp ON it.team_id = itp.team_id
WHERE
    itp.player_role LIKE '%all%'
GROUP BY it.team_name
HAVING COUNT(itp.player_id) > 4
ORDER BY COUNT(itp.player_id) DESC;
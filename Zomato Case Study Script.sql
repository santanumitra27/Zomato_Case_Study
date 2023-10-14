create database Zomato_Case_Business;
use Zomato_Case_Business;

select * from country_code;
select * from zomato_data_details;


ALTER TABLE country_code
CHANGE COLUMN `ï»¿Country_Code` `Country_code` int;




-- 	Help Zomato to find the best restaurant with the rating above 4.5 and rating text is excellent 

select Restaurant_Name, Aggregate_rating as Rating, Rating_text
from zomato_data_details
where Aggregate_rating > 4.5 and rating_text = 'Excellent';

-- 	Help Zomato in identifying the cities with poor Restaurant ratings

SELECT city, AVG(Aggregate_rating) AS average_rating
FROM zomato_data_details
GROUP BY city
HAVING average_rating < 3.0
ORDER BY average_rating;

-- 	Mr.roy is looking for a restaurant in kolkata which provides online delivery. Help him choose the best restaurant

select city, has_online_delivery, Aggregate_rating
from zomato_data_details
where city = 'Kolkata' and has_online_delivery = 'Yes' 
order by Aggregate_rating desc
LIMIT 1;

-- 	Help Peter in finding the best rated Restaurant for dining in New Delhi

select city, restaurant_name, aggregate_rating
from zomato_data_details
where city = 'New Delhi'
order by Aggregate_rating desc
LIMIT 1;

-- 	Enlist most affordable (Avg cost for twos) and highly rated restaurants city wise

SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

select aggregate_rating, avg_cost_for_two, city
from zomato_data_details
where avg_cost_for_two < '1500'
order by aggregate_rating desc
limit 1;

-- 	Help Zomato in identifying the restaurants with poor offline services

SET sql_mode = '';

select aggregate_rating, Has_Table_booking, Restaurant_ID, Restaurant_Name
from zomato_data_details
where has_table_booking = 'Yes' and aggregate_rating < 3
Group by Restaurant_ID
order by aggregate_rating asc;

-- 	Help zomato in identifying those cities which have atleast 3 restaurants with ratings >= 4.9, In case there are two cities with the same result, sort them in alphabetical order.

select aggregate_rating, restaurant_ID, city
from zomato_data_details
where aggregate_rating >= '4.9'
group by city
having count(*) >= 3;

-- Second way to do this problem solve 

SELECT city
FROM (
    SELECT city, COUNT(*) AS restaurant_count
    FROM zomato_data_details
    WHERE aggregate_rating >= 4.9
    GROUP BY city
    HAVING restaurant_count >= 3
) AS city_counts
ORDER BY city;

-- 	List the two top 5 restaurants with highest rating with maximum votes.

select max(votes) as max_votes, Restaurant_ID, Aggregate_rating
from zomato_data_details
group by aggregate_rating
order by max_votes desc
limit 5;

-- 	Group the restaurants basis the average cost for two into: Luxurious Expensive, Very Expensive, Expensive, High, Medium High, Average.

SELECT
    Restaurant_name, Avg_cost_for_two,
    CASE
        WHEN (Avg_cost_for_two) >= 1000 THEN 'Luxurious Expensive'
        WHEN (Avg_cost_for_two) >= 700 THEN 'Very Expensive'
        WHEN (Avg_cost_for_two) >= 500 THEN 'Expensive'
        WHEN (Avg_cost_for_two) >= 300 THEN 'High'
        WHEN (Avg_cost_for_two) >= 150 THEN 'Medium High'
        ELSE 'Average'
    END AS cost_category
FROM
    zomato_data_details
GROUP BY
    restaurant_name;

--  What are the top 5 countries with most restaurants linked with Zomato?

select country, count(*) as Total_Restaurants
from country_code c
left join zomato_data_details z on c.country_code = z.country_code
group by country
order by Total_Restaurants desc
limit 5;



































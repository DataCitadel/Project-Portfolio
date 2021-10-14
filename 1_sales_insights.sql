-- Answer the questions from the Sales team in this file.

-- Active Cities
SELECT 
    city
FROM
    grp_member
WHERE
    member_status = 'active'
GROUP BY CITY;
-- This query was done to display each city, only once, where there are active members present. 
SELECT 
    city, state
FROM
    city
WHERE
    city NOT IN (SELECT 
            city
        FROM
            grp_member
        WHERE
            member_status = 'active');
-- This query was done to exclude cities that do have active members within the available data and only display the cities that have no active members listed. 
/* 1. What cities have active memmbers?
The cities that have active members are San Franscisco, New York, Chicago, West New York, West Chicago, North Chicago, Chicago Heights, East Chicago, and Chicago Bridge.
2. Are there cities listted in the city table with no active mambers? If so, what state are those cities in?
Yes, there are three cities in the city table that do not have active members. They are in the states NY, MN, and CA.  */
-- Groups
SELECT 
    Join_mode, COUNT(join_mode)
FROM
    grp
GROUP BY join_mode;
-- This query sorted the statuses of different groups by grouping and counting their status within the grp table. The three statusses are open, closed, and [waiting for] approval.
/* 1. How many groups are currently open, waiting for approval, and/or closed?
There are 3602 groups open, 723 waiting for approval, and 15 that are closed. */
-- Categories
SELECT 
    Category_name, COUNT(group_name) 
FROM
    category
        JOIN
    grp ON category.category_id = grp.category_id
GROUP BY category_name
ORDER BY COUNT(group_name) desc
LIMIT 5;
-- This query finds top five categories of groups and displays how many groups are in each category.
SELECT 
    Category_name, COUNT(group_name) 
FROM
    category
        JOIN
    grp ON category.category_id = grp.category_id
GROUP BY category_name
ORDER BY COUNT(group_name) asc
LIMIT 5;
-- This query finds the five categories of groups that contain the least number of groups and then displays how many groups are in each category.
/* 1. What are the five categories that contain the most groups? 
   What are the five categories that contain the least number of groups?
The five categories that contain the most groups are Tech, Career & Business, Socializing, Health & Wellbeing,and Language & Ethnic Identity. 
The five cateogories with the least groups are Paranormal, Cars & Motorcycles, Sci-Fi & Fantasy, Lifestyle, and Fashion and Beauty. */


SELECT 
    COUNT(DISTINCT (member_id)) all_members
FROM
    grp_member;
-- This query was made to produce the number of total unique members that are a part of LetsMeet.
SELECT 
    (chicago_members / all_members * 100) Percentage_of_members_in_Chicago
FROM
    (SELECT 
        COUNT(DISTINCT (member_id)) all_members
    FROM
        grp_member) AS allmembers,
    (SELECT 
        COUNT(DISTINCT (member_id)) chicago_members
    FROM
        grp_member
    WHERE
        city = 'chicago') AS chicagomembers;
-- This query returns a percentage, labelled as Percentage_of_members_in_Chicago, of how many unique LetsMeet members are present in Chicago.	
/*  1. How many members are there?
There are 39980 members in total.
2. What percentage of members are in chicago?
21.2% of all members are in chicago. */


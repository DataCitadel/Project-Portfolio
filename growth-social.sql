SELECT 
    YEAR(MIN(joined)), COUNT(DISTINCT (member_id))
FROM
    grp_member
GROUP BY YEAR(joined)
ORDER BY YEAR(joined) ASC;
-- I wrote this query to find out how many brand new letsmeet members had joined any group per year. 
SELECT 
    city
FROM
    grp_member
GROUP BY city;
-- this query was ran multiple times to check on progress as I updated the city names.
set sql_safe_updates=0;
-- this was done to allow updates on the table as im doing permanent changes. 
UPDATE grp_member 
SET 
    city = 'Chicago'
WHERE
    LOWER(city) IN ('east chicago' , 'west chicago',
        'north chicago',
        'chicago heights',
        'chicago ridge',
        'chicago');
-- this query was done to rename the smaller cities in the vicinity of Chicago as just Chicago
UPDATE grp_member 
SET 
    city = 'San Francisco'
WHERE
    city IN ('San Francisco' , 'South San Francisco');
-- this query was done to rename the smaller cities in the vicinity of San Francisco as only San Francisco
UPDATE grp_member 
SET 
    city = 'New York'
WHERE
    city IN ('New York' , 'West New York');
-- this query was done to rename the smaller cities in the vicinity of Chicago as just New York
set sql_safe_updates=1;
-- this was done to lock updates to the table after making needed changes
SELECT 
    YEAR(MIN(joined)), COUNT(DISTINCT (member_id))
FROM
    grp_member
WHERE
    city = 'Chicago'
GROUP BY YEAR(joined)
ORDER BY YEAR(joined) ASC;
-- this grouped unique new members per year for LetsMeet for Chicago
SELECT 
    YEAR(MIN(joined)), COUNT(DISTINCT (member_id))
FROM
    grp_member
WHERE
    city = 'New York'
GROUP BY YEAR(joined)
ORDER BY YEAR(joined) ASC;
-- this grouped unique new members per year for LetsMeet for New York
SELECT 
    YEAR(MIN(joined)), COUNT(DISTINCT (member_id))
FROM
    grp_member
WHERE
    city = 'San Francisco'
GROUP BY YEAR(joined)
ORDER BY YEAR(joined) ASC;
-- this grouped unique new members per year for LetsMeet for San Francisco
SELECT 
    MONTH(MIN(joined)), COUNT(DISTINCT (member_id))
FROM
    grp_member
WHERE
    YEAR(joined) = 2017
GROUP BY MONTH(joined)
ORDER BY MONTH(joined) ASC
-- this query grouped the amount of new members that joined for the year of 2017 by month

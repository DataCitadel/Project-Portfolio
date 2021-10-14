SELECT 
    COUNT(rating),
    CASE
        WHEN rating BETWEEN 1 AND 1.99 THEN '1-1.99'
        WHEN rating BETWEEN 2 AND 2.99 THEN '2-2.99'
        WHEN rating BETWEEN 3 AND 3.99 THEN '3-3.99'
        WHEN rating BETWEEN 4 AND 4.99 THEN '4-4.99'
        WHEN rating = 5 THEN '5'
        ELSE 'No Rating'
    END AS Rating_Score
FROM
    grp
GROUP BY Rating_Score
ORDER BY Rating_Score;
-- This query was done to categorize the ratings into groups of scores using CASE
SELECT 
    group_name,
    members
FROM
    grp
WHERE
    rating = 5
ORDER BY members DESC;
-- This query was done to locate the groups with the max rating score that also have the most members, sorted from most to least. 
(SELECT 
    group_name, category_name, city
FROM
    grp
        JOIN
    city ON grp.city_id = city.city_id
        JOIN
    category ON grp.category_id = category.category_id
WHERE
    rating = 5 AND city = 'New York'
ORDER BY members DESC
LIMIT 3) UNION (SELECT 
    group_name, category_name, city
FROM
    grp
        JOIN
    city ON grp.city_id = city.city_id
        JOIN
    category ON grp.category_id = category.category_id
WHERE
    rating = 5 AND city = 'San Francisco'
ORDER BY members DESC
LIMIT 1) UNION (SELECT 
    group_name, category_name, city
FROM
    grp
        JOIN
    city ON grp.city_id = city.city_id
        JOIN
    category ON grp.category_id = category.category_id
WHERE
    rating = 5 AND city = 'Chicago'
ORDER BY members DESC
LIMIT 1);
-- This query's purpose was to find the top 3 cities in new york, top city in san francisco, and top city in chicago with the most members and max rating.

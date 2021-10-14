SELECT 
    event_name
FROM
    event
WHERE
    LOWER(event_name) LIKE '%toastmaster%';
-- this query was done to find all events that include the name "toastmaster"
SELECT 
    city, event_name
FROM
    grp
        JOIN
    event ON grp.group_id = event.group_id
        JOIN
    city ON grp.city_id = city.city_id
WHERE
    LOWER(event_name) LIKE '%toastmaster%';
-- This query was done to show all event names including the name "toastmaster" and the city they are located in
SELECT 
    city, COUNT(event_name)
FROM
    grp
        JOIN
    event ON grp.group_id = event.group_id
        JOIN
    city ON grp.city_id = city.city_id
WHERE
    LOWER(event_name) LIKE '%toastmaster%'
GROUP BY city;
-- this query was done to count the number of "toastmaster" events and group them by city.

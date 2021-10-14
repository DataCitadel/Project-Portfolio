-- venue_
SELECT 
    *
FROM
    venue_;
-- this query was done to show all columns in the table
SELECT 
    zip, COUNT(zip)
FROM
    venue_
GROUP BY zip
ORDER BY COUNT(zip) DESC;
-- I was looking for zip code hotspots, and came across something a little more interesting instead. There is an enormous amount of zip codes that are invalid and coded as 1 or -1. 
SELECT 
    (invalid_zip / valid_zip * 100) AS percentage_of_invalid_zip_codes
FROM
    (SELECT 
        zip, COUNT(zip) AS invalid_zip
    FROM
        venue_
    WHERE
        zip IN (1 , - 1)) AS a,
    (SELECT 
        COUNT(zip) valid_zip
    FROM
        venue_) AS b;
-- This query was done to check what percentage of invalid zip codes, with a value of 1 or -1, were contained within all zip codes within the venue_ table. 
/* The zipcodes present in LetsMeet data presents an error that might be causing an under-utilization of the service.
Almost half, 46.7% of the data in the venue_ table contains invalid zip codes listed as either 1 or -1 instead of a full five digit zip code. This could prove a hindrance for indivduals searching for venues by a certain zip code or looking for things nearby to them. Not only would this make potential events invisible to some of the members, it is also not good for LetsMeet stakeholders overall. It would be best to sort the erroneous zip code situation as soon as possible. */

-- grp
SELECT 
    *
FROM
    grp;
-- this query was done to show all columns in the table grp
SELECT 
    who, COUNT(who)
FROM
    grp
GROUP BY who
ORDER BY COUNT(who) DESC;
-- This query finds what the people in a group are called or known as and counts the occurence
/* The 'who' column is heavily filled with groups calling the people inside of them members. It is obvious that everyone inside a group is a member therefore this generic answer should not be allowed as a classification because it presents a descriptor that really says nothing at all. It would be difficult for, let's say a person who defines themself as a hiker, to easily find a group based of hikers based on that criteria that lables themselves as just members. It would be best practice to suggest putting actual useful descriptions by the group coordinator or creator */

-- grp_member
select * from grp_member;
-- this query was done to get overview of grp_member table
SELECT 
    *
FROM
    grp_member
WHERE
    member_status <> 'active';
-- This query shows what the data of people without active member status looks like.
SELECT 
    *, (inactive_members + active_members) AS total_members
FROM
    (SELECT 
        COUNT(DISTINCT (member_id)) AS inactive_members
    FROM
        grp_member
    WHERE
        member_status <> 'active') AS a,
    (SELECT 
        COUNT(DISTINCT (member_id)) AS active_members
    FROM
        grp_member
    WHERE
        member_status = 'active') AS b;
-- this query showed how many members have an active status and how many do not
/* There are only a small handful of members that do not have active status, 39 out of a total of 39980.
 All of these accounts joined during a relatively small window frame from november 20th 2017 to december 2nd 2017. All of the members' status says prereg, yet they still belong to a group. It could be possible that the members encountered some type of error while they were making their accounts or joining. There is no member_name or hometown associated with any of the member_id present an errory seems likely to explain this finding. There are also only two member statuses in the data, stuck in prereg or active. */

SELECT 
    *
FROM
    city;
-- This query was done to get an overview of data in the table. 
SELECT 
    *
FROM
    (SELECT 
        SUM(member_count) other_cities
    FROM
        city
    WHERE
        city NOT IN ('Chicago' , 'San Francisco', 'New York')) AS a,
    (SELECT 
        SUM(member_count) three_main_citites
    FROM
        city
    WHERE
        city IN ('Chicago' , 'San Francisco', 'New York')) AS b;
-- This query lets me compare the number of members outside of the big three cities against the number of members that are inside the big three. 
/* In the US, LetsMeet has only 10 other cities that it is present in aside from the three largest cities in terms of members, which are the cities where LetsMeet describes that it is located in within the project overview. Furthermore, aside from the states that those three cities reside in, there are three more states where there are members of LetsMeet which include IN, MN, and NJ. LetsMeet is very early in its expansion process and has a lot of ground to cover even in other cities very close to where it is currently mainly located in, as the member counts are very low outside the cities. Relative to the data available, negligible amounts of expansion have taken place. Based on the current trend of cities, LetsMeet could look into expannding into other major metropolitan areas, such as Houston, Texas or Atlanta, Georgia.  */

SELECT 
    *
FROM
    event;
-- this query lets me see an overview of the table named event
SELECT 
    event_name, city, yes_rsvp_count
FROM
    event
        JOIN
    venue_ ON event.venue_id = venue_.venue_id
WHERE
    city = 'San Francisco'
ORDER BY yes_rsvp_count DESC
LIMIT 5;
-- this query was done to see what the top five most RSVP'd events in san francisco, was limited to five because i was search to for top three events that looked like they happen on a regular and frequent basis. The second and forth events did not meet this criteria. 
/* If a Letsmeet member finds themselves in San Fransciso for the weekend, they can try out one of the some of the most popular events in the city, which is "Friday Night Drinks" or they can participate in "Friday Night Drinks with International Travelers and Locals". Events containing alcohol seem to a be a city favorite, so San Francisco is great to be a member of LetsMeet in if drinking is a favored social activity. 
If a person is looking for something calmer and more professional, they can advance their careers or socialize with relatable peers at "Network After Work at Redford". San Franscisco has popular events that can have a little something for anyone looking to socialize! */

-- category
SELECT 
    *
FROM
    category;
-- this query lets me see an overview of the table named category.
SELECT 
    category.category_id, category_name, COUNT(grp.category_id)
FROM
    category
        JOIN
    grp ON category.category_id = grp.category_id
GROUP BY category.category_id
ORDER BY COUNT(grp.category_id) DESC;
-- this query was done to find which group categories are most prevalent in the data available within all of the provided LetsMeet data.
/* The top three categories of groups present in the data are Tech, Career & Business, and Socializing. This could be an oppoortunity for LetsMeet to capitalize upon this metric and advertize or promote these kinds of groups, or shift focus of what exactly LetsMeet wants its image to be longterm. Furthermore, these topics seem generally relatable to everyone where they may have a place to fit in or contribute. It is far more encompassing than the least common category, which is Paranormal. 

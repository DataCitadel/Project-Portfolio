ALTER TABLE venue_
	DROP COLUMN  address_2,
    DROP COLUMN  country,
    DROP COLUMN  distance;
/* 
This query deletes redudant columns from the venue_ table. They can be found in the city table. I dropped column address_2 from the  venue_ table because
all of the values are null. Additionally, I am dropping the country and distance columns becuase they are already present in the city table.
*/
ALTER TABLE event
	DROP COLUMN  utc_offset,
    DROP COLUMN maybe_rsvp_count;
/*  
This query drops columns full of irrelevant data present in the event table. I dropped the maybe_rsvp_count and utc_offset columns from the event table
as they contributed nothing of value to the data, as the data was zeroes all the way down or of no value for the purposes of the table, respectively. 
*/
CREATE TABLE IF NOT EXISTS group_sign_ups 
	SELECT DISTINCT 
		group_id, 
		member_id,
		joined 
	FROM
		grp_member;
-- this creattes the new groupo_sign_ups table to break up old grp_member table for the purpose of allowing a primary key
CREATE TABLE IF NOT EXISTS members 
	SELECT DISTINCT
		member_id,
		member_name,
		city,
		country,
		hometown,
		member_status 
	FROM
		grp_member;
-- this query created the new members table where information relevant to the members that joined letsmeet is included. 
ALTER TABLE members
	ADD PRIMARY KEY (member_id);
-- added a primary key to the memebers table
ALTER TABLE group_sign_ups
	ADD FOREIGN KEY (member_id)
    REFERENCES members(member_id);
-- add a foreign key to create a link between the members and group_sign_
ALTER TABLE group_sign_ups
	ADD FOREIGN KEY (group_id)
    REFERENCES grp(group_id);
-- this adds a foreign key to the group_sign_ups table to connect it to the grp table. 
DROP TABLE grp_member;
-- this deletes the orginal table that the two new tables came from, in pursuit of normalizing the data. 

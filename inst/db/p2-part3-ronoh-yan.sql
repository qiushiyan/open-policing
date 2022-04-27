-- Anne J Ronoh & Quishi Yan
-- anne.j.ronoh@vanderbilt.edu
-- qiushi.yan@vanderbilt.edu
-- Project 2 Final Submission

# Create a database.
DROP DATABASE IF EXISTS stanford_policing;
CREATE DATABASE stanford_policing;

# Create a table structure (mega table) that is appropriately matched to the data file
USE stanford_policing;
DROP TABLE IF  EXISTS nashvilledata;

CREATE TABLE nashvilledata(
	raw_row_number MEDIUMTEXT DEFAULT NULL, 
    date VARCHAR(200) DEFAULT NULL, 
    time VARCHAR(200) DEFAULT NULL, 
    location VARCHAR(200) DEFAULT NULL, 
    lat VARCHAR(200) DEFAULT NULL, 
    lng VARCHAR(200) DEFAULT NULL, 
	precinct VARCHAR(200) DEFAULT NULL,
    reporting_area VARCHAR(200) DEFAULT NULL,
    zone VARCHAR(200) DEFAULT NULL, 
    subject_age VARCHAR(200) DEFAULT NULL, 
    subject_race VARCHAR(200) DEFAULT NULL,
    subject_sex VARCHAR(200) DEFAULT NULL,
    officer_id_hash VARCHAR(200) DEFAULT NULL,
	type VARCHAR(200) DEFAULT NULL, 
    violation MEDIUMTEXT DEFAULT NULL, 
    arrest_made VARCHAR(200) DEFAULT NULL, 
    citation_issued VARCHAR(200) DEFAULT NULL, 
    warning_issued VARCHAR(200) DEFAULT NULL, 
    outcome VARCHAR(200) DEFAULT NULL, 
    contraband_found VARCHAR(200) DEFAULT NULL, 
    contraband_drugs VARCHAR(200) DEFAULT NULL,
    contraband_weapons VARCHAR(200) DEFAULT NULL,
    frisk_performed VARCHAR(200) DEFAULT NULL, 
    search_conducted VARCHAR(200) DEFAULT NULL, 
    search_person VARCHAR(200) DEFAULT NULL, 
    search_vehicle VARCHAR(200) DEFAULT NULL, 
    search_basis VARCHAR(200) DEFAULT NULL, 
    reason_for_stop VARCHAR(200) DEFAULT NULL, 
    vehicle_registration_state VARCHAR(200) DEFAULT NULL,
    notes MEDIUMTEXT DEFAULT NULL,
    raw_verbal_warning_issued VARCHAR(200) DEFAULT NULL,
    raw_written_warning_issued VARCHAR(200) DEFAULT NULL,
    raw_traffic_citation_issued VARCHAR(200) DEFAULT NULL,
    raw_misd_state_citation_issued VARCHAR(200) DEFAULT NULL,
    raw_suspect_ethnicity VARCHAR(200) DEFAULT NULL,
    raw_driver_searched VARCHAR(200) DEFAULT NULL, 
    raw_passenger_searched VARCHAR(200) DEFAULT NULL,
    raw_search_consent VARCHAR(200) DEFAULT NULL, 
    raw_search_arrest VARCHAR(200) DEFAULT NULL, 
    raw_search_warrant VARCHAR(200) DEFAULT NULL,
    raw_search_inventory VARCHAR(200) DEFAULT NULL, 
    raw_search_plain_view VARCHAR(200) DEFAULT NULL
);

# Load the data into the table in MySQL
# The CSV file has fields enclosed by ‘$’ and separated by ‘;’
LOAD DATA INFILE '/Users/qiushi/workspace/dsi-courses/data/tn_nashville.csv' IGNORE
	INTO TABLE nashvilledata
	FIELDS TERMINATED BY ',' ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;
    

## let us make a copy of the megatable to add all columns with wrong row entries

DROP TABLE IF EXISTS megatable_copy;
CREATE TABLE megatable_copy(
	raw_row_number MEDIUMTEXT DEFAULT NULL, 
    date VARCHAR(200) DEFAULT NULL, 
    time VARCHAR(200) DEFAULT NULL, 
    location VARCHAR(200) DEFAULT NULL, 
    lat VARCHAR(200) DEFAULT NULL, 
    lng VARCHAR(200) DEFAULT NULL, 
	precinct VARCHAR(200) DEFAULT NULL,
    reporting_area VARCHAR(200) DEFAULT NULL,
    zone VARCHAR(200) DEFAULT NULL, 
    subject_age VARCHAR(200) DEFAULT NULL, 
    subject_race VARCHAR(200) DEFAULT NULL,
    subject_sex VARCHAR(200) DEFAULT NULL,
    officer_id_hash VARCHAR(200) DEFAULT NULL,
	type VARCHAR(200) DEFAULT NULL, 
    violation MEDIUMTEXT DEFAULT NULL, 
    arrest_made VARCHAR(200) DEFAULT NULL, 
    citation_issued VARCHAR(200) DEFAULT NULL, 
    warning_issued VARCHAR(200) DEFAULT NULL, 
    outcome VARCHAR(200) DEFAULT NULL, 
    contraband_found VARCHAR(200) DEFAULT NULL, 
    contraband_drugs VARCHAR(200) DEFAULT NULL,
    contraband_weapons VARCHAR(200) DEFAULT NULL,
    frisk_performed VARCHAR(200) DEFAULT NULL, 
    search_conducted VARCHAR(200) DEFAULT NULL, 
    search_person VARCHAR(200) DEFAULT NULL, 
    search_vehicle VARCHAR(200) DEFAULT NULL, 
    search_basis VARCHAR(200) DEFAULT NULL, 
    reason_for_stop VARCHAR(200) DEFAULT NULL, 
    vehicle_registration_state VARCHAR(200) DEFAULT NULL,
    notes MEDIUMTEXT DEFAULT NULL,
    raw_verbal_warning_issued VARCHAR(200) DEFAULT NULL,
    raw_written_warning_issued VARCHAR(200) DEFAULT NULL,
    raw_traffic_citation_issued VARCHAR(200) DEFAULT NULL,
    raw_misd_state_citation_issued VARCHAR(200) DEFAULT NULL,
    raw_suspect_ethnicity VARCHAR(200) DEFAULT NULL,
    raw_driver_searched VARCHAR(200) DEFAULT NULL, 
    raw_passenger_searched VARCHAR(200) DEFAULT NULL,
    raw_search_consent VARCHAR(200) DEFAULT NULL, 
    raw_search_arrest VARCHAR(200) DEFAULT NULL, 
    raw_search_warrant VARCHAR(200) DEFAULT NULL,
    raw_search_inventory VARCHAR(200) DEFAULT NULL, 
    raw_search_plain_view VARCHAR(200) DEFAULT NULL
);

INSERT IGNORE INTO megatable_copy(raw_row_number, date, time, location, lat, lng, precinct,
		reporting_area, zone, subject_age, subject_race, subject_sex, officer_id_hash,
        type, violation, arrest_made, citation_issued, warning_issued, outcome, 
        contraband_found, contraband_drugs, contraband_weapons, frisk_performed,
		search_conducted, search_person, search_vehicle, search_basis, reason_for_stop,
        vehicle_registration_state, notes, raw_verbal_warning_issued, raw_written_warning_issued,
		raw_traffic_citation_issued, raw_misd_state_citation_issued, raw_suspect_ethnicity,
		raw_driver_searched, raw_passenger_searched, raw_search_consent, raw_search_arrest, 
		raw_search_warrant, raw_search_inventory, raw_search_plain_view)
SELECT *
FROM nashvilledata 
WHERE location = '2ND AV, , TN,' OR location = 'WALTER DAVIS, , TN,'
	OR location = 'RURAL HILL , , TN, 37013' OR location = 'RURAL HILL, , TN, 37013'
	OR location = 'WALTER S DAVIS, , TN,'
    OR location = 'E 37212 37212 WEST WEST, 37212, TN, WEST END'
	OR location = 'DONELSON PIKE, UNDEFINED, TN, undefined'
    OR location = '37207 37207, , TN, WEAKLEY'
    OR location = '37206 37206, , TN, 15TH'
    OR location = '858 WEST TRINITY LANE, NASHVILLE, TN, 372-7'
    OR location = '37207 37207, , TN, HART'
    OR location = '3 S 37221 37205, 37205, TN, LN'
    OR location = '333 RIOC VISTA PKE, , TN, Q'
    OR location = '2804 WESTWOOD AVE, NASH,  TN, TN'
    OR location = '1823 14TH AVE N, NASHVILLE,  TN, TN'
    OR location = 'I24E, MM 47/0,  , TN,'
    OR location = 'MURPHY RD, & 3801, NASHVILLE, TN,'
    OR location = 'HEIMAN, D, BA, TODD'
    OR precinct = 'U' OR zone = '413N' OR zone = '515K' OR zone = 'UNK' OR officer_id_hash = 'NA'
    OR raw_verbal_warning_issued = 36.120201
    OR raw_verbal_warning_issued = 36.1361675
    OR raw_verbal_warning_issued = 36.15230379999999
    OR raw_verbal_warning_issued = 36.16907379999999
    OR raw_verbal_warning_issued = 36.2056553
    OR raw_written_warning_issued = - 86.7162455
    OR raw_written_warning_issued = - 86.7430262
    OR raw_written_warning_issued = - 86.78869739999998
    OR raw_written_warning_issued = - 86.7974334
    OR raw_written_warning_issued = - 86.8095974
	OR raw_traffic_citation_issued = 2
	OR raw_traffic_citation_issued = 6
	OR raw_traffic_citation_issued = 8
	OR raw_misd_state_citation_issued = 1411
	OR raw_misd_state_citation_issued = 5325
	OR raw_misd_state_citation_issued = 5523
	OR raw_misd_state_citation_issued = 6913
	OR raw_misd_state_citation_issued = 8323
	OR raw_misd_state_citation_issued = 'N'
	OR raw_suspect_ethnicity = 217
	OR raw_suspect_ethnicity = 615
	OR raw_suspect_ethnicity = 811
	OR raw_suspect_ethnicity = 823
	OR raw_suspect_ethnicity = 'FALSE'
	OR raw_suspect_ethnicity = 'H|N|H'
	OR raw_suspect_ethnicity = 'H|N|N|N|N'
	OR raw_suspect_ethnicity = 'H|N|N|N|N'
	OR raw_suspect_ethnicity = 'N|U'
	OR raw_suspect_ethnicity = 'N|H|H'
	OR raw_suspect_ethnicity = 'N|U|U'
	OR raw_suspect_ethnicity = 'U|N'
	OR raw_driver_searched = 20
	OR raw_driver_searched = 21
	OR raw_driver_searched = 41
	OR raw_driver_searched = 45
	OR raw_driver_searched = 56
	OR raw_driver_searched = 'NA'
	OR raw_passenger_searched = 'black'
	OR raw_passenger_searched = 'NA'
	OR raw_passenger_searched = 'white'
	OR raw_search_consent = 'female'
	OR raw_search_consent = 'male'
	OR raw_search_consent = 'NA'
	OR raw_search_arrest = '19615fa2af'
	OR raw_search_arrest = '23e9d21d94'
	OR raw_search_arrest = '392b1090b2'
	OR raw_search_arrest = '583d36a9fd'
	OR raw_search_arrest = '8e6e05f1aa'
	OR raw_search_arrest = 'NA'
	OR raw_search_warrant = 'vehicular'
	OR raw_search_inventory = 'moving traffic violation'
	OR raw_search_inventory = 'NA'
	OR raw_search_inventory = 'parking violation'
	OR raw_search_inventory = 'vehicle equipment violation'
	OR raw_search_plain_view = 'NA'
	OR raw_search_plain_view = '';	
    

#delete from megatable with conditions as above
DELETE IGNORE
FROM nashvilledata
WHERE location = '2ND AV, , TN,' OR location = 'WALTER DAVIS, , TN,'
	OR location = 'RURAL HILL , , TN, 37013' OR location = 'RURAL HILL, , TN, 37013'
	OR location = 'WALTER S DAVIS, , TN,' 
    OR location = 'E 37212 37212 WEST WEST, 37212, TN, WEST END'
	OR location = 'DONELSON PIKE, UNDEFINED, TN, undefined'
    OR location = '37207 37207, , TN, WEAKLEY'
    OR location = '37206 37206, , TN, 15TH'
    OR location = '858 WEST TRINITY LANE, NASHVILLE, TN, 372-7'
    OR location = '37207 37207, , TN, HART'
    OR location = '3 S 37221 37205, 37205, TN, LN'
    OR location = '333 RIOC VISTA PKE, , TN, Q'
    OR location = '2804 WESTWOOD AVE, NASH,  TN, TN'
    OR location = '1823 14TH AVE N, NASHVILLE,  TN, TN'
    OR location = 'I24E, MM 47/0,  , TN,'
    OR location = 'MURPHY RD, & 3801, NASHVILLE, TN,'
    OR location = 'HEIMAN, D, BA, TODD'
	OR precinct = 'U' OR zone = '413N' OR zone = '515K' OR zone = 'UNK' OR officer_id_hash = 'NA'
    OR raw_verbal_warning_issued = 36.120201
    OR raw_verbal_warning_issued = 36.1361675
    OR raw_verbal_warning_issued = 36.15230379999999
    OR raw_verbal_warning_issued = 36.16907379999999
    OR raw_verbal_warning_issued = 36.2056553
    OR raw_written_warning_issued = - 86.7162455
    OR raw_written_warning_issued = - 86.7430262
    OR raw_written_warning_issued = - 86.78869739999998
    OR raw_written_warning_issued = - 86.7974334
    OR raw_written_warning_issued = - 86.8095974
	OR raw_traffic_citation_issued = 2
	OR raw_traffic_citation_issued = 6
	OR raw_traffic_citation_issued = 8
	OR raw_misd_state_citation_issued = 1411
	OR raw_misd_state_citation_issued = 5325
	OR raw_misd_state_citation_issued = 5523
	OR raw_misd_state_citation_issued = 6913
	OR raw_misd_state_citation_issued = 8323
	OR raw_misd_state_citation_issued = 'N'
	OR raw_suspect_ethnicity = 217
	OR raw_suspect_ethnicity = 615
	OR raw_suspect_ethnicity = 811
	OR raw_suspect_ethnicity = 823
	OR raw_suspect_ethnicity = 'FALSE'
	OR raw_suspect_ethnicity = 'H|N|H'
	OR raw_suspect_ethnicity = 'H|N|N|N|N'
	OR raw_suspect_ethnicity = 'H|N|N|N|N'
	OR raw_suspect_ethnicity = 'N|U'
	OR raw_suspect_ethnicity = 'N|H|H'
	OR raw_suspect_ethnicity = 'N|U|U'
	OR raw_suspect_ethnicity = 'U|N'
	OR raw_driver_searched = 20
	OR raw_driver_searched = 21
	OR raw_driver_searched = 41
	OR raw_driver_searched = 45
	OR raw_driver_searched = 56
	OR raw_driver_searched = 'NA'
	OR raw_passenger_searched = 'black'
	OR raw_passenger_searched = 'NA'
	OR raw_passenger_searched = 'white'
	OR raw_search_consent = 'female'
	OR raw_search_consent = 'male'
	OR raw_search_consent = 'NA'
	OR raw_search_arrest = '19615fa2af'
	OR raw_search_arrest = '23e9d21d94'
	OR raw_search_arrest = '392b1090b2'
	OR raw_search_arrest = '583d36a9fd'
	OR raw_search_arrest = '8e6e05f1aa'
	OR raw_search_arrest = 'NA'
	OR raw_search_warrant = 'vehicular'
	OR raw_search_inventory = 'moving traffic violation'
	OR raw_search_inventory = 'NA'
	OR raw_search_inventory = 'parking violation'
	OR raw_search_inventory = 'vehicle equipment violation'
	OR raw_search_plain_view = 'NA'
	OR raw_search_plain_view = '';	
    
-- update statement to megatable to convert NA time values and lat and lng
UPDATE nashvilledata
SET time = '00:00:00'
WHERE time = 'NA';

UPDATE nashvilledata
SET lat = 00.000000000000000
WHERE lat = 'NA';

UPDATE nashvilledata
SET lng = 00.000000000000000
WHERE lng = 'NA';


-- decompose the clean megatable into the following tables 

-- creating persons table
DROP TABLE IF EXISTS persons_info; 
CREATE TABLE persons_info(
	raw_row_number INT UNSIGNED AUTO_INCREMENT, -- raw row number can not be negative and will be unique
	subject_age TINYINT UNSIGNED, -- age cannot be negative
    subject_race VARCHAR(50), -- consider asian/pacific islander as a race entry
    subject_sex VARCHAR(6),  -- * NA female is 6 characters, there are some NA values too
    PRIMARY KEY (raw_row_number) -- raw row number is unique for all stops and can be used to identify all of the information in this table 
);

-- inserting data from nashvilledata into persons table 
INSERT IGNORE INTO persons_info(raw_row_number, subject_age, subject_race, subject_sex)
SELECT raw_row_number, subject_age, subject_race, subject_sex
FROM nashvilledata;



-- creating stop_location table
DROP TABLE IF EXISTS stop_location;
CREATE TABLE stop_location(
    street_address VARCHAR(50), -- street names can be varying length, but assuming that they will not be longer than 50 characters
    city VARCHAR(30), -- city names can be varying length, but assuming that they will not be longer than 30 characters
    state VARCHAR(20), -- state names can be varying length, but assuming that they will not be longer than 20 characters
    zipcode INT UNSIGNED, -- zip code cannot be negative
    lat DECIMAL(18, 15), -- latitudes contains upto 15 decimal places
    lng DECIMAL(18, 15), -- longitude contains upto 15 decimal places
    PRIMARY KEY (zipcode,street_address, city, state) -- location determines the specific area where a police stopped a person 
);


-- inserting data from nashvilledata into stop_location table
-- first we create a function to split location into 4 parts
-- found this function on stackoverflow
CREATE FUNCTION SPLIT_STR(
		x VARCHAR(255),
		delim VARCHAR(12),
		pos INT)
RETURNS VARCHAR(255)
RETURN REPLACE(SUBSTRING(SUBSTRING_INDEX(x, delim, pos),
       CHAR_LENGTH(SUBSTRING_INDEX(x, delim, pos -1)) + 1),
       delim, "");

-- inserting data from nashvilledata into stop_location table
INSERT IGNORE INTO stop_location(street_address, city, state, zipcode, lat, lng)       
SELECT DISTINCT
        SPLIT_STR(location,', ',1) as street_address,
        SPLIT_STR(location,', ',2) as city,
        SPLIT_STR(location,',',3) as state,
        SPLIT_STR(location,', ',4) as zipcode,
        lat,
        lng
FROM nashvilledata;

-- creating stops_info table
DROP TABLE IF EXISTS stops_info;
CREATE TABLE stops_info(
	raw_row_number INT UNSIGNED AUTO_INCREMENT, -- raw row number can not be negative and will be unique
	date DATE, -- date that police stopped happened
    time TIME, --  time that police stopped happened 
    zipcode INT UNSIGNED, -- zip code cannot be negative
	precinct VARCHAR(5), -- * NA, integer values
    reporting_area VARCHAR(5), -- * NA, integer values
    zone VARCHAR(5), -- * NA, integer values
	officer_id_hash VARCHAR(200), -- officer_id_hash can be varying length, but assuming that they will not be longer than 200  characters
    PRIMARY KEY (raw_row_number),
    CONSTRAINT fk_raw_row_number FOREIGN KEY (raw_row_number)
		REFERENCES persons_info (raw_row_number)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
	CONSTRAINT fk_zipcode FOREIGN KEY (zipcode)
		REFERENCES stop_location (zipcode)
		ON DELETE CASCADE -- if raw row number and location are deleted in persons and stop_location data, it will be deleted here too
		ON UPDATE CASCADE -- if raw row number and location are updated in persons and stop_location data, it will be updated here too

);

-- inserting data from nashvilledata into stops_info table 
INSERT IGNORE INTO stops_info(raw_row_number, date, time, zipcode, precinct, 
		reporting_area, zone, officer_id_hash)
SELECT DISTINCT raw_row_number, CAST(date AS DATE) AS date, CAST(time AS TIME) AS date, 
		SPLIT_STR(location,', ',4) AS zipcode, precinct, reporting_area, zone, officer_id_hash
FROM nashvilledata;

-- creating reason_violation table
DROP TABLE IF EXISTS reason_violation;
CREATE TABLE reason_violation(
	reason_for_stop VARCHAR(50), -- reason_for_stop can be varying length, but assuming that they will not be longer than 50 characters
    violation VARCHAR(50), -- violation can be varying length, but assuming that they will not be longer than 50 characters
	outcome VARCHAR(8), -- outcome will have a max length of 8 (citation, arrest, warning, NA)
    PRIMARY KEY (violation, outcome) -- composite key to identify one column (reason_for_stop)
);

-- inserting data from nashvilledata into reason_violation table 
INSERT INTO reason_violation (reason_for_stop, violation, outcome)
SELECT DISTINCT reason_for_stop, violation, outcome
FROM nashvilledata;

-- create after_stop_actions table
DROP TABLE IF EXISTS after_stop_actions;
CREATE TABLE after_stop_actions(
	raw_row_number INT UNSIGNED AUTO_INCREMENT,
	type CHAR(9), -- vehicular is 9 characters long
    arrest_made CHAR(5), -- * NA true/false is 5 characters at most
    citation_issued CHAR(5), -- * NA true/false is 5 characters at most
    warning_issued CHAR(5), -- * NA true/false is 5 characters at most
    violation VARCHAR(50), -- violation can be varying length, but assuming that they will not be longer than 50 characters
    contraband_found CHAR(5), -- * NA true/false is 5 characters at most
    contraband_drugs CHAR(5), -- * NA true/false is 5 characters at most
    contraband_weapons CHAR(5), -- * NA true/false is 5 characters at most
    frisk_performed CHAR(5), -- *NA true/false is 5 characters at most
    search_conducted CHAR(5), -- *NA true/false is 5 characters at most
    search_person CHAR(5), --  * NA true/false is 5 characters at most
    search_vehicle CHAR(5), -- * NA true/false is 5 characters at most
    search_basis VARCHAR(20), -- * NA search_basis can be varying length, but assuming that they will not be longer than 20 characters
    vehicle_registration_state CHAR(2), -- state abbreviations are of length 2
    notes TEXT, -- useful for storing larger text strings like notes
    PRIMARY KEY (raw_row_number),
    CONSTRAINT fk_raw_row_number_2 FOREIGN KEY (raw_row_number)
		REFERENCES persons_info (raw_row_number)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
	CONSTRAINT fk_violation FOREIGN KEY (violation)
		REFERENCES reason_violation(violation)
		ON DELETE CASCADE -- if raw row number and violation are deleted in persons and stop_location data, it will be deleted here too        
		ON UPDATE CASCADE -- if raw row number and violation are deleted in persons and stop_location data, it will be deleted here too

);

-- inserting data from nashvilledata into after_stop_actions table 
INSERT IGNORE INTO after_stop_actions(raw_row_number, type, arrest_made, citation_issued, 
		warning_issued, violation, contraband_found, contraband_drugs, contraband_weapons, frisk_performed,
		search_conducted, search_person, search_vehicle, search_basis, vehicle_registration_state,
        notes)
SELECT raw_row_number, type, arrest_made, citation_issued, warning_issued, violation, contraband_found, 
		contraband_drugs, contraband_weapons, frisk_performed, search_conducted, search_person, 
        search_vehicle, search_basis, vehicle_registration_state, notes
FROM nashvilledata;

-- creating raw_info table
DROP TABLE IF EXISTS raw_info;
CREATE TABLE raw_info (
	raw_row_number INT UNSIGNED AUTO_INCREMENT,
	raw_verbal_warning_issued CHAR(5), -- * NA true/false is 5 characters at most
    raw_written_warning_issued CHAR(5), -- * NA true/false is 5 characters at most
    raw_traffic_citation_issued CHAR(5), -- * NA true/false is 5 characters at most
    raw_misd_state_citation_issued CHAR(5), -- * NA true/false is 5 characters at most
    raw_suspect_ethnicity VARCHAR(10), -- * NA consider latino, hispanic, unknown
    raw_driver_searched CHAR(5), -- * NA true/false is 5 characters at most
    raw_passenger_searched CHAR(5), -- * NA true/false is 5 characters at most
    raw_search_consent CHAR(5), -- * NA true/false is 5 characters at most
    raw_search_arrest CHAR(5), -- * NA true/false is 5 characters at most
    raw_search_warrant CHAR(5), -- * NA true/false is 5 characters at most
    raw_search_inventory CHAR(5), -- * NA true/false is 5 characters at most
    raw_search_plain_view CHAR(5), -- * NA true/false is 5 characters at most
    PRIMARY KEY (raw_row_number),
    CONSTRAINT fk_raw_row_number_3 FOREIGN KEY (raw_row_number)
		REFERENCES persons_info (raw_row_number)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

-- inserting data from nashvilledata into raw_info table 
INSERT IGNORE INTO raw_info(raw_row_number, raw_verbal_warning_issued, raw_written_warning_issued,
		raw_traffic_citation_issued, raw_misd_state_citation_issued, raw_suspect_ethnicity,
		raw_driver_searched, raw_passenger_searched, raw_search_consent, raw_search_arrest, 
		raw_search_warrant, raw_search_inventory, raw_search_plain_view)
SELECT raw_row_number, raw_verbal_warning_issued, raw_written_warning_issued,
		raw_traffic_citation_issued, raw_misd_state_citation_issued, raw_suspect_ethnicity,
		raw_driver_searched, raw_passenger_searched, raw_search_consent, raw_search_arrest, 
		raw_search_warrant, raw_search_inventory, raw_search_plain_view
FROM nashvilledata;


 # Count statements for each of the newly populated tables. 
 SELECT
	(SELECT COUNT(*) FROM persons_info) AS persons,
	(SELECT COUNT(*) FROM stops_info) AS location_info,
	(SELECT COUNT(*) FROM stop_location) AS stop_location,
	(SELECT COUNT(*) FROM reason_violation) AS reason_violation,
	(SELECT COUNT(*) FROM after_stop_actions) AS after_stop_actions,
	(SELECT COUNT(*) FROM raw_info) AS raw_info,
    (SELECT COUNT(*) FROM megatable_copy) AS megatable_copy;

-- create advanced features
-- VIEWS
-- find a list of the possible outcomes after someone is stopped
CREATE OR REPLACE VIEW reason_violation_outcomes AS
SELECT DISTINCT outcome
FROM reason_violation;

SELECT *
FROM reason_violation_outcomes;

-- explore the main reasons why police stop people

CREATE OR REPLACE VIEW top_reason_for_stops AS
SELECT DISTINCT reason_for_stop
FROM reason_violation;

SELECT *
FROM top_reason_for_stops;

-- create a view to allow users to update the after_stop_actions table but 
-- only a few columns of those

CREATE OR REPLACE VIEW new_after_stop_actions AS
SELECT arrest_made, contraband_found, frisk_performed, search_person, search_vehicle
FROM after_stop_actions;

-- TRIGGERS
# check age is a non-negative value
DROP TRIGGER IF EXISTS agecheck;

DELIMITER //
CREATE TRIGGER agecheck
BEFORE INSERT 
ON persons_info
FOR EACH ROW
IF NEW.subject_age < 0 THEN 
SET NEW.subject_age = 0;
END IF //

DELIMITER;

#check zipcode is a 5 digit value
#check zipcode is one of the TN zipcodes before insert
DROP TRIGGER IF EXISTS zipcode_5digit_check;
DELIMITER  //

CREATE TRIGGER zipcode_5digit_check
BEFORE INSERT 
ON stop_location
FOR EACH ROW
BEGIN
	IF NEW.zipcode NOT BETWEEN 00000 AND 99999 THEN
		SIGNAL SQLSTATE '45000'		
		SET MESSAGE_TEXT = 'zipcode must have 5 digits strictly.';
    ELSEIF NEW.zipcode NOT BETWEEN 37010 AND 38589 THEN
		SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'This is not a Tennessee zipcode.';
    END IF;
 END //
 
DELIMITER ;

#trigger before any DELETE is made to table
#record any info DELETED from tables
#first create another table named persons_archives that keeps the information of deleted person.
DROP TABLE IF EXISTS persons_archives; 
CREATE TABLE persons_archives(
	id INT UNSIGNED AUTO_INCREMENT,
	raw_row_number INT UNSIGNED, -- raw row number can not be negative and will be unique
	subject_age TINYINT UNSIGNED, -- age cannot be negative
    subject_race VARCHAR(50), -- consider asian/pacific islander as a race entry
    subject_sex VARCHAR(6),  -- * NA female is 6 characters, there are some NA values too
    deleted_time TIMESTAMP DEFAULT NOW(), -- record the time when delete happened
    PRIMARY KEY (id) -- id is unique for all person info being archived
);

select * from persons_archives;

DROP TRIGGER IF EXISTS before_delete_persons; -- after_delete_persons

DELIMITER //
CREATE TRIGGER before_delete_persons -- after_delete_persons 
BEFORE DELETE  -- maybe change this to after DELETE
ON persons_info
FOR EACH ROW  
BEGIN  
    INSERT INTO persons_archives(id, raw_row_number, subject_age, subject_race, subject_sex)  
    VALUES(default, OLD.raw_row_number, OLD.subject_age, OLD.subject_race, OLD.subject_sex); 
    
END //  
  
DELIMITER ;  

DELETE 
FROM persons_info 
WHERE raw_row_number BETWEEN 1 AND 10; 

SELECT * 
FROM persons_archives; 

#trigger after any UPDATE is made to table
#record any info UPDATED from tables
#first create another table named locations_archives that keeps the information of deleted person.
DROP TABLE IF EXISTS location_archives; 
CREATE TABLE location_archives(
	id INT UNSIGNED AUTO_INCREMENT,
    street_address VARCHAR(50), -- street names can be varying length, but assuming that they will not be longer than 50 characters
    city VARCHAR(30), -- city names can be varying length, but assuming that they will not be longer than 30 characters
    state VARCHAR(20), -- state names can be varying length, but assuming that they will not be longer than 20 characters
    zipcode INT UNSIGNED, -- zip code cannot be negative
    lat DECIMAL(18, 15), -- latitudes contains upto 15 decimal places
    lng DECIMAL(18, 15), -- longitude contains upto 15 decimal places
	deleted_time TIMESTAMP DEFAULT NOW(), -- record the time when update happened
    PRIMARY KEY (id) -- location determines the specific area where a police stopped a person 
);

DROP TRIGGER IF EXISTS after_update_stop_locations;

DELIMITER //
CREATE TRIGGER after_update_stop_locations  
AFTER UPDATE 
ON stop_location
FOR EACH ROW  
BEGIN  
    INSERT INTO location_archives(id, street_address, city, state, zipcode, lat, lng)  
    VALUES(default, OLD.street_address, OLD.city, OLD.state, OLD.zipcode, OLD.lat, OLD.lng); 
    
END //  
  
DELIMITER ;  

UPDATE stop_location
SET state = 'TN'
WHERE state LIKE '%BD%' OR state LIKE '%EE%' 
		OR state LIKE '%T%' OR state LIKE '%TA%' 
        OR state LIKE '%TH%' OR state LIKE '%TL%'
        OR state LIKE '%TM%' OR state LIKE '%TO%'
        OR state LIKE '%TP%' OR state LIKE '%TT%'
        OR state LIKE '%QA%' OR state LIKE '%NX%'
        OR state LIKE '%RH%' OR state LIKE '%NT%'
        OR state LIKE '%NA%' OR state LIKE '%SA%'
        OR state LIKE '%AQ%' OR state LIKE '%FN%'
        OR state LIKE '%BA%' OR state LIKE '%DA%'
        OR state LIKE '%GB%' OR state LIKE '%II%'
        OR state LIKE '%FA%' OR state LIKE '%SP%'
        OR state LIKE '%SJ%' OR state LIKE '%LO%'
        OR state LIKE '%LS%' OR state LIKE '%TE%'; 

SELECT * 
FROM location_archives; 

-- STORED PROCEDURES
-- create person to insert values into persons_info
DROP procedure IF EXISTS create_person; 
DELIMITER // 
CREATE PROCEDURE create_person(IN age TINYINT UNSIGNED, IN race VARChAR(50), IN sex VARCHAR(6))
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET sql_error = TRUE;
    
    START TRANSACTION;
        INSERT INTO persons_info (subject_age, subject_race, subject_sex)
        VALUES (age, race, sex); 

    IF sql_error = FALSE THEN 
		COMMIT;
        SELECT "The transaction was committed." as ret;
	ELSE
		ROLLBACK;
        SELECT ERRORS as error; 
	END IF;
END// 
DELIMITER ;



-- edit person
DROP PROCEDURE IF EXISTS edit_person; 

DELIMITER // 
CREATE PROCEDURE edit_person (
	IN number INT UNSIGNED, 
	IN age TINYINT UNSIGNED, 
    IN race VARChAR(50), 
    IN sex VARCHAR(6)
)
BEGIN
	DECLARE has_person INT UNSIGNED;
	DECLARE sql_error INT DEFAULT FALSE;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET sql_error = TRUE;
	
	SELECT COUNT(*) 
	INTO has_person
	FROM persons_info
	WHERE raw_row_number = number; 
	
	IF has_person = 0 THEN 
		SIGNAL SQLSTATE '45000';  
	END IF;
    
    IF sql_error = TRUE THEN
		ROLLBACK;
		SELECT "Person does not exist." as error;
	ELSE 
		UPDATE persons_info
		SET subject_age = age, subject_race = race, subject_sex = sex
		WHERE raw_row_number = number; 
        COMMIT;
		SELECT 'Edit successful' as ret; 
    END IF;
END // 
DELIMITER ;



DROP procedure IF EXISTS delete_person; 
DELIMITER // 
CREATE PROCEDURE delete_person (
	IN number INT UNSIGNED
)
BEGIN
	DECLARE has_person INT UNSIGNED;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT 'person not exists' as error;
	
    START TRANSACTION;
		SELECT COUNT(*) 
		INTO has_person
		FROM persons_info
		WHERE raw_row_number = number; 
		
		IF has_person = 0 THEN 
			SIGNAL SQLSTATE '45000';
		ELSE
			DELETE FROM persons_info
			WHERE raw_row_number = number;
			SELECT 'deletion successful' as ret; 
			COMMIT; 
	END IF; 
END // 
DELIMITER ;


-- create stop locations to insert values into stop_location
DROP procedure IF EXISTS create_stop_location;  
DELIMITER // 

CREATE PROCEDURE create_stop_location(
	IN city VARCHAR(30), 
    IN lat DECIMAL(18, 15), 
    IN lng DECIMAL(18, 15), 
    IN state VARCHAR(20), 
    IN state_address VARCHAR(50), 
    IN zipcode INT UNSIGNED
)
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET sql_error = TRUE;
    
    START TRANSACTION;
        INSERT INTO stop_location (city, lat, lng, state, state_address, zipcode)
        VALUES (city, lat, lng, state, state_address, zipcode); 
    IF sql_error = FALSE THEN 
		COMMIT;
        SELECT "The transaction was committed." as ret;
	ELSE
		ROLLBACK;
        SELECT ERRORS as error; 
	END IF;
END// 

DELIMITER ;


## stops counts per year, that is, how many stops were recorded in a given year
DROP PROCEDURE IF EXISTS stop_counts_per_year;

DELIMITER //
CREATE PROCEDURE stop_counts_per_year(IN var_year_name INT)
BEGIN
	IF (var_year_name NOT IN (SELECT EXTRACT(year FROM date) AS year
							FROM stops_info
							WHERE EXTRACT(year FROM date) = var_year_name)) THEN
		SIGNAL SQLSTATE '22003'
		SET MESSAGE_TEXT = 'We do not have stops information for that year.',
		MYSQL_ERRNO = 1264;
	ELSE 
		SELECT DISTINCT EXTRACT(year FROM date) as year, COUNT(*) AS total_stop_counts
		FROM stops_info
		WHERE EXTRACT(year FROM date) = var_year_name
        GROUP BY EXTRACT(year FROM date) 
		ORDER BY total_stop_counts DESC;
	END IF;
END //
DELIMITER ;

CALL stop_counts_per_year(2020);
CALL stop_counts_per_year(2019);

# racial proportion by year 

## stop counts over race, that is, how many stops were recorded for each race
CREATE TABLE race_sex_stops AS 
SELECT p.subject_race, subject_sex, COUNT(*) as n 
FROM (
	SELECT raw_row_number 
	FROM stops_info
) s LEFT JOIN (
	SELECT raw_row_number, subject_race, subject_sex 
	FROM persons_info
) p ON s.raw_row_number = p.raw_row_number
GROUP BY p.subject_race, subject_sex;


## how many stops by year and race
DROP PROCEDURE IF EXISTS stops_byyear_byrace;

DELIMITER //
CREATE PROCEDURE stops_byyear_byrace(
		IN var_subject_race VARCHAR(50), 
		IN var_year_name INT)
BEGIN
	IF (var_subject_race NOT IN (SELECT subject_race 
								FROM persons_info 
								WHERE subject_race = var_subject_race)) THEN
		SIGNAL SQLSTATE '22003'
		SET MESSAGE_TEXT = 'We do not have stops information for that race.',
		MYSQL_ERRNO = 1264;
	ELSEIF (var_year_name NOT IN (SELECT EXTRACT(year FROM date) 
								FROM stops_info
                                WHERE EXTRACT(year FROM date) = var_year_name)) THEN
		SIGNAL SQLSTATE '22003'
		SET MESSAGE_TEXT = 'We do not have stops information for that year.',
		MYSQL_ERRNO = 1264;
	ELSE 
		SELECT DISTINCT subject_race, COUNT(*) AS total_stops_count
		FROM nashvilledata
		WHERE EXTRACT(year FROM date) = var_year_name
		GROUP BY subject_race
		ORDER BY total_stops_count DESC;
	END IF;
END //
DELIMITER ;

CALL stops_byyear_byrace('black', 2019);

CREATE TABLE stops_year_race AS 
SELECT t1.year, subject_race, race_total / year_total AS prop
FROM (
	SELECT DISTINCT 
		EXTRACT(year FROM date) AS year, 
		subject_race, 
		COUNT(*) as race_total
	FROM nashvilledata
	WHERE subject_race != "NA"
	GROUP BY subject_race, year
	ORDER BY race_total DESC
) t1 LEFT JOIN (
	SELECT COUNT(*) AS year_total, EXTRACT(year FROM date) AS year
	FROM nashvilledata
	GROUP BY year
) t2 ON t1.year = t2.year;



## proportion of stops by race
DROP PROCEDURE IF EXISTS stop_prop_by_race;

DELIMITER //

CREATE PROCEDURE stop_prop_by_race(IN var_subject_race VARCHAR(50))
BEGIN
	IF (var_subject_race NOT IN (SELECT subject_race 
								FROM persons_info 
								WHERE subject_race = var_subject_race)) THEN
		SIGNAL SQLSTATE '22003'
		SET MESSAGE_TEXT = 'We do not have arrest information for that race.',
		MYSQL_ERRNO = 1264;
	ELSE
		SELECT subject_race, COUNT(subject_race) AS total_stops_by_race,
				(COUNT(subject_race) / (SELECT COUNT(subject_race) FROM nashvilledata)) * 100 AS stop_prop_by_race
		FROM nashvilledata
		GROUP BY subject_race;
	END IF;
END //

DELIMITER ;

CALL stop_prop_by_race('black');

-- explore stops percentage versus population percentage
-- find nashville population data from 2010 to 2019


# arrest percentage by race
DROP PROCEDURE IF EXISTS arrest_percent_by_race;

DELIMITER //

CREATE PROCEDURE arrest_percent_by_race(IN var_subject_race VARCHAR(50))
BEGIN
	IF (var_subject_race NOT IN (SELECT subject_race 
								FROM persons_info
                                #subject_race = ISNULL(LIKE ''%'+var_subject_race+'%'', subject_race) 
								#WHERE subject_race LIKE ('%', var_subject_race, '%') THEN				
								WHERE subject_race = var_subject_race)) THEN
		SIGNAL SQLSTATE '22003'
		SET MESSAGE_TEXT = 'We do not have arrest information for that race.',
		MYSQL_ERRNO = 1264;
	ELSE
		SELECT subject_race, COUNT(subject_race) AS total_arrests_by_race,
				(COUNT(subject_race) / (SELECT COUNT(subject_race) FROM nashvilledata)) * 100 AS arrest_percentage_by_race
		FROM nashvilledata
		WHERE arrest_made = 'TRUE'
		GROUP BY subject_race;
	END IF;
END //

DELIMITER ;

CALL arrest_percent_by_race('black');




CREATE TABLE arrest_prop_race AS 
SELECT subject_race, 
	   SUM(IF(arrest_made = 'TRUE', 1, 0))/ COUNT(subject_race) AS arrest_prop
FROM nashvilledata
WHERE subject_race != "NA"
GROUP BY subject_race;


-- TRANSACTIONS

-- USER PRIVILEGES
#give privilige to add new violation type
#give privilege to delete persons info or update location info
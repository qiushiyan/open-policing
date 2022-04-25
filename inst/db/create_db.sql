-- Anne J Ronoh & Quishi Yan
-- anne.j.ronoh@vanderbilt.edu
-- qiushi.yan@vanderbilt.edu
-- Project 2 part 3

# Create a database.
DROP DATABASE IF EXISTS stanford_policing;
CREATE DATABASE IF NOT EXISTS stanford_policing;

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
LOAD DATA INFILE '~/workspace/dsi-courses/data/tn_nashville.csv' IGNORE
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
	raw_row_number INT UNSIGNED, -- raw row number can not be negative and will be unique
	subject_age TINYINT UNSIGNED, -- * NA age cannot be negative
    subject_race VARCHAR(50), -- consider asian/pacific islander as a race entry
    subject_sex VARCHAR(6),  -- * NA female is 6 characters, there are some NA values too
    PRIMARY KEY (raw_row_number) -- raw row number is unique for all voters and can be used to identify all of the information in this table
);

-- inserting data from nashvilledata into persons table
INSERT IGNORE INTO persons_info(raw_row_number, subject_age, subject_race, subject_sex)
SELECT raw_row_number, subject_age, subject_race, subject_sex
FROM nashvilledata;

-- creating location_info table
DROP TABLE IF EXISTS stop_location;
CREATE TABLE stop_location(
    street_address VARCHAR(50), -- street names can be varying length, but assuming that they will not be longer than 50 characters
    city VARCHAR(20), -- city names can be varying length, but assuming that they will not be longer than 20 characters
    state VARCHAR(20), -- state abbreviations are of length 2
    zipcode VARCHAR(20), -- zip code cannot be negative
    lat DECIMAL(18, 15), -- * NAlatitudes contains upto 15 decimal places
    lng DECIMAL(18, 15), -- * NA longitude contains upto 15 decimal places
    PRIMARY KEY (zipcode,street_address, city, state) -- location determines the specific area where a police stopped a person
);

-- inserting data from nashvilledata into location_info table
-- first we create a function to split location into 4 parts
CREATE FUNCTION SPLIT_STR(
		x VARCHAR(255),
		delim VARCHAR(12),
		pos INT)
RETURNS VARCHAR(255)
RETURN REPLACE(SUBSTRING(SUBSTRING_INDEX(x, delim, pos),
       CHAR_LENGTH(SUBSTRING_INDEX(x, delim, pos -1)) + 1),
       delim, "");

INSERT IGNORE INTO stop_location(street_address, city, state, zipcode, lat, lng)
SELECT DISTINCT
        SPLIT_STR(location,', ',1) as street_address,
        SPLIT_STR(location,', ',2) as city,
        SPLIT_STR(location,',',3) as state,
        SPLIT_STR(location,', ',4) as zipcode,
        lat,
        lng
FROM nashvilledata;



-- creating stop_location table
DROP TABLE IF EXISTS stops_info;
CREATE TABLE stops_info(
	raw_row_number INT UNSIGNED, -- raw row number can not be negative and will be unique
	date DATE, -- date that police stopped happened
    time TIME, --  time that police stopped happened
    zipcode VARCHAR(20), -- zip code cannot be negative
	precinct VARCHAR(5), -- * NA, integer values
    reporting_area VARCHAR(5), -- * NA, integer values
    zone VARCHAR(5), -- * NA, integer values
	officer_id_hash VARCHAR(200), -- officer_id_hash can be varying length, but assuming that they will not be longer than 200  characters
    PRIMARY KEY (raw_row_number),
    #CONSTRAINT fk_raw_row_number FOREIGN KEY (raw_row_number)
		#REFERENCES persons_info (raw_row_number),
	CONSTRAINT fk_zipcode FOREIGN KEY (zipcode)
		REFERENCES stop_location (zipcode)
		ON DELETE CASCADE -- if raw row number and location are deleted in persons and stop_location data, it will be deleted here too
		ON UPDATE CASCADE -- if raw row number and location are updated in persons and stop_location data, it will be updated here too

);

-- inserting data from nashvilledata into stop_location table
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
	raw_row_number INT UNSIGNED,
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
		REFERENCES persons_info (raw_row_number),
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


DROP TABLE IF EXISTS raw_info;
CREATE TABLE raw_info(
	raw_row_number INT UNSIGNED,
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

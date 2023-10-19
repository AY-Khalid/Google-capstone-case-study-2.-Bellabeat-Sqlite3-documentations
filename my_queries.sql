---This is a comprehensive table that combine all other tables
SELECT *
from dailyActivity_merged;

--- count the number of rows 
SELECT count(*)
FROM dailyActivity_merged;

----count the number of distinct ROWS by id's

SELECT count(DISTINCT id)
FROM dailyActivity_merged;

---- create a view to work by extracting the important columns for this analysis

CREATE VIEW daily_activity_new AS 
SELECT id, ActivityDate, TotalSteps, VeryActiveMinutes, FairlyActiveMinutes, LightlyActiveMinutes,SedentaryMinutes,Calories
FROM dailyActivity_merged;

SELECT *
FROM daily_activity_new;

---- check for a null, empty or na VALUES

SELECT * 
FROM daily_activity_new
WHERE id IS NULL AND ActivityDate IS NULL AND TotalSteps IS NULL 
	AND VeryActiveMinutes IS NULL AND FairlyActiveMinutes IS NULL AND LightlyActiveMinutes
	IS NULL AND SedentaryMinutes IS NULL AND Calories IS NULL; ---- No empty, null, na values. Testing for one is sufficient

---- CHECK for data types of each columns

PRAGMA table_info(daily_activity_new);

---- convert data types using the cast funtion and case and store in a new table

DROP TABLE daily_activity;
CREATE TABLE daily_activity AS
SELECT CAST(id AS TEXT) As user_id, CASE
        -- Check for 'MM/DD/YYYY' format
        WHEN LENGTH(ActivityDate) = 10
        AND substr(ActivityDate, 3, 1) = '/'
        AND substr(ActivityDate, 6, 1) = '/'
        THEN substr(ActivityDate, 1, 2) || '-' || substr(ActivityDate, 4, 2) || '-' || substr(ActivityDate, 7, 4)
        
        -- Check for 'M/DD/YYYY' format
        WHEN LENGTH(ActivityDate) = 9
        AND substr(ActivityDate, 2, 1) = '/'
        AND substr(ActivityDate, 5, 1) = '/'
        THEN '0' || substr(ActivityDate, 1, 1) || '-' || substr(ActivityDate, 3, 2) || '-' || substr(ActivityDate, 6, 4)
        
        -- Handle other cases or invalid dates
        ELSE 'Invalid Date'
    END AS Activity_Date, TotalSteps, VeryActiveMinutes, 
	FairlyActiveMinutes, LightlyActiveMinutes, SedentaryMinutes, Calories
FROM daily_activity_new;


--- select the new table
SELECT *
FROM daily_activity;

-----This is how far i can go with sql, the data will be exported to excel for futher analysis. Thank you.



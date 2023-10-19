---- get all the necessary tables

SELECT *
FROM daily_activity_csv; ----daily activities TABLE

SELECT * 
FROM sleepDay_csv; --- sleeping records TABLE

SELECT * 
FROM weightLogInfo_csv; --- weight records TABLE

---- check for data types

PRAGMA table_info(daily_activity_csv);
PRAGMA table_info(sleepDay_csv);
PRAGMA table_info(weightLogInfo_csv);

---- LET'S ANALYZE EACH OF THE TABLE INDIVIDUAL FIRST 

---- daily_activity_csv TABLE
SELECT *
FROM daily_activity_csv;

---- get the number of users
SELECT count(distinct id)
FROM daily_activity_csv;

---- get the maximum of total steps by users
SELECT id, ActivityDate, max(TotalSteps) as highest_steps
FROM daily_activity_csv
GROUP BY id;

--- get the maximum number of Calories burn by users

SELECT id, ActivityDate, max(Calories) as highest_calories
FROM daily_activity_csv
GROUP BY id;

--- check if the date for highest steps equals highest Calories

SELECT id, ActivityDate, max(TotalSteps) as highest_steps, 
	max(Calories) as highest_calories	
FROM daily_activity_csv
WHERE TotalSteps > 0
GROUP BY id, ActivityDate; ---- the query shows that there are days were the users have no
								---- steps but burnt Calories, this was filtered out. but the 
								--- query indicate that the higher the steps the more the calories burnt.

---- calculate the average of steps taken in a day and average of calories burnt.

SELECT day_of_week, round(avg(TotalSteps)) as average_of_steps, round(avg(Calories)) as average_of_calories
FROM daily_activity_csv
GROUP BY day_of_week;

--- calculate the average calories burnt per distance. The TotalDistance and TrackerDistance distance would have been used
---- but it is not clear of what basis was used to measure the distance. i.e, km, m, etc. we therefore make use of the TotalSteps
CREATE TABLE average_calories_per_steps AS
SELECT day_of_week, avg(TotalSteps) as avg_steps, avg(Calories) as avg_calories, avg(Calories)/avg(TotalSteps) as avg_calories_per_step
FROM daily_activity_csv
GROUP BY day_of_week; ---- created a table for further analysis

----- LET'S ANALYZE sleepDay_csv TABLE

SELECT *
FROM sleepDay_csv;

--- let's count each users sleep_remark
SELECT sleep_remark, count(id) as number_of_users
FROM sleepDay_csv
GROUP BY sleep_remark;

---- check for the trends of users during the week, what is their sleeping patterns in each day of the weeks throughout the period;

CREATE TABLE daily_sleeping_patterns AS
SELECT act.id, slp.SleepDate, act.day_of_week, slp.hours_of_sleep, slp.sleep_remark
FROM daily_activity_csv act
JOIN sleepDay_csv slp
	ON act.id = slp.id AND act.ActivityDate = slp.SleepDate
GROUP BY act.id, slp.SleepDate, act.day_of_week, slp.hours_of_sleep;

---- LET'S ANALYZE THE weightLogInfo_csv TABLE

SELECT id, dateMeasured,  BMI, weight_remark
FROM weightLogInfo_csv
WHERE IsManualReport = 'FALSE'
GROUP BY id, dateMeasured;

SELECT id, dateMeasured,  BMI, weight_remark
FROM weightLogInfo_csv
WHERE IsManualReport = 'TRUE'
GROUP BY id, dateMeasured;

---- LET'S CHECK BETWEEN THE MANUAL REPORT AND NO MANUAL REPORT CALORIES BURNT IN A DAY.

DROP TABLE bmi_to_calories; --- just incase there will be a further update
CREATE TABLE bmi_to_calories AS
SELECT act.id, round(avg(wght.BMI)) as avg_BMI, round(avg(act.Calories)) as avg_calories, wght.weight_remark
FROM daily_activity_csv act 
	JOIN weightLogInfo_csv wght ON act.id = wght.id
WHERE wght.IsManualReport = 'FALSE'
GROUP BY act.id
UNION ALL
SELECT act.id, round(avg(wght.BMI)) as avg_BMI, round(avg(act.Calories)) as avg_calories, wght.weight_remark
FROM daily_activity_csv act 
	JOIN weightLogInfo_csv wght ON act.id = wght.id
WHERE wght.IsManualReport = 'TRUE'
GROUP BY act.id; --- this query also shows that their is no correlation between the body mass and the amount of calories burnt in a day.
					---- it also shows that the those with the higher body mass use automatic report.
					
					
----wait! does it mean only 8 users have their weight tested? let's CHECK

SELECT count(distinct id)
FROM weightLogInfo_csv; --- yes, only 8 users have a report of their Weight


--- what if we check, does those with body mass who burnt the highest calories also take the most steps

DROP TABLE avg_bmi_step_calories;
CREATE TABLE avg_bmi_step_calories AS
SELECT act.id, round(avg(wght.BMI)) as avg_BMI, round(avg(act.TotalSteps)) as avg_steps, round(avg(act.Calories)) as avg_calories, wght.weight_remark
FROM daily_activity_csv act 
	JOIN weightLogInfo_csv wght ON act.id = wght.id
WHERE wght.IsManualReport = 'FALSE'
GROUP BY act.id
UNION ALL
SELECT act.id, round(avg(wght.BMI)) as avg_BMI, round(avg(act.TotalSteps)) as avg_steps, round(avg(act.Calories)) as avg_calories, wght.weight_remark
FROM daily_activity_csv act 
	JOIN weightLogInfo_csv wght ON act.id = wght.id
WHERE wght.IsManualReport = 'TRUE'
GROUP BY act.id;

----now let's check if more sleeping hours lead to lesser calories burnt.

DROP TABLE sleep_hours_calories;
CREATE TABLE sleep_hours_calories AS
SELECT slp.id, slp.SleepDate, round(avg(slp.hours_of_sleep)) as avg_hours_slept,
	round(avg(act.Calories)) as avg_calories
FROM daily_activity_csv act
JOIN sleepDay_csv slp ON act.Id = slp.Id
GROUP BY slp.Id;

---- 24 users sleeping habit collected?

SELECT count(distinct id)
FROM sleepDay_csv;

--- out of 33 users
SELECT count(distinct id)
FROM daily_activity_csv;



----- TIME TO CREATE VISUALS. Needed files exported to excel and Dashboards create with Tablea. 
------ More informations on the ReadMe files. 
------- Thanks for stoping by.
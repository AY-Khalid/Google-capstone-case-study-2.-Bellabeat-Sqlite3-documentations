# Google-capstone-case-study-2.-Bellabeat-Sqlite3-documentations

## Author: Anidu Yakubu Khalid
## Position: Junior Data Analyst
## For: Bellabeats
## Last Updated: 19/10/2023


# Business task
To analyse smart device usage data in order to gain insight into how people are already using the Bellabeat smart devices. Then, using this information, make high-level recommendations for how these trends can inform its marketing strategy.

# Key Stakeholders
1. **Urška Sršen:** Bellabeat’s co founder and Chief Creative Officer 
2. **Sando Mur:** Mathematician and Bellabeat cofounder; key member of the Bellabeat executive team.
3. **Bellabeat marketing analytics team:** A team of data analysts responsible for collecting, analysing, and reporting data that helps guide Bellabeat’s marketing strategy.

# Key Questions
1. What are some trends in smart device usage? 
2. How could these trends apply to Bellabeat customers?
3. How could these trends help influence Bellabeat marketing strategy?

# Description of Data Source
**Source:** Bellabeats pointed us to a publicly availble dataset on Kaggle webite.
**Data Availability:**  The data is available for download from a specified location, which is provided in the case study using the following link: https://www.kaggle.com/arashnic/fitbit
**Data Origin:** The dataset is a public dataset from the fitbit fitness tracker made available by Mobius.
**Data Coverage:** The datasets covered only two months for 33 users who gave permission or consent for the collection of their personal tracker data.
**Data Privacy:** Data-privacy is as enshrined in CC0: Public Domain.
Purpose: The data serves as the foundation for conducting an in-depth analysis to identify patterns that exist in users physical activity, heart rate, and sleep monitoring. In order to make their product more adaptive and useful.

## Bias or Integrity Test
The fitbit fitness tracker data is a reliable, original, comprehensive, current, and cited data source that serves as a foundational element for the analysis of bike-sharing trends and customer behavior as outlined in the case study.


# Data Gathering, Organization, Cleaning and Transformation

I used two of the following tools:
## Excel and,
## SQL (sqlite3)

# Excel
1. Data are organized into different files, each of the file were downloaded and stored in my computer local storage folder.
2. The folder was duplicated so as to preserve and protect data integrity.
3. Out of the many files, we find three of the files to be important for this analysis.
   The files are:
   i. dailyActivity_merged.csv
   ii. sleepDay_merged.csv and,
   iii. weightLogInfo_merged.csv
4. All the above files were opened or imported to Excel using power query.
5. Using the power query editor, we formatted the date each of the date columns.
6. Add columns:
   some of the columns added are:
   i. day_of_week: to extract the name of the week each of the activity occured.
   ii. sleep remark: to conditionally identify the users pattens of sleep to discover those who are having bad or good sleeping habit.
   iii. Weight_remark: to also identify users who are overweight and those who have low weight. etc.
7. Each of the files were loaded to excel tables or environment.
8. The dataset were now imported to the SQL for further analysis, that include, Descriptive, Exploratory data analysis (EDA) etc.
9. The SQL quries are in this repo. or click here: https://github.com/AY-Khalid/Google-capstone-case-study-2.-Bellabeat-Sqlite3-documentations/blob/main/queries_for_this_project.sql

# Findings

1. Users with a body mass index (BMI) ranging from 25 to 28 tend to burn the most calories. This suggests that this group of users is highly active, and this conclusion is supported by the finding that they also have the highest average number of steps taken. Therefore, it can be inferred that the more steps a user takes, the more calories they burn, indicating a higher level of physical activity.
2. The analysis also reveals that users who sleep for durations between 5 to 8 hours are more likely to burn more calories. This is because they strike a balance between not getting too little sleep, which can be detrimental, and not oversleeping, which also has its drawbacks.

# Recommendations

1. Develop products tailored for users with a BMI between 25 and 28, promoting active lifestyles.
2. Enhance device features to support balanced sleep patterns of 5 to 8 hours for improved overall well-being.
3. Create features motivating users to meet daily step goals and maintain balanced lifestyles encompassing activity, sleep, and nutrition.

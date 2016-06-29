
The data for the project are sourced from :

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The Variables included:
Activity Levels:  
    WALKING (value 1)
    WALKING_UPSTAIRS (value 2)
    WALKING_DOWNSTAIRS (value 3)
    SITTING (value 4)
    STANDING (value 5)
    LAYING (value 6)
Subject:  1-30 individual subjects monitored
66 Measurments of the original 561 limited to means and standard deviations.


run_analysis.R  
This file creates data from text files from url given by course.
It combines rows and columns and applies names to them.
It extracts measurements on mean and standard deviation, and then uses descriptive activity names for the activities of the data set.
Appropriate labels are given to variable/column names that are less abbreviated.
Finally, the R script calculates means for columns and produce a text file output of that.  











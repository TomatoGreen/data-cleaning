# Getting and Cleaning Data Course project
The R script, run_analysis.R, contains a function, run_analysis, which does below steps,\n
\t1. set work directory\n
\t2. doanload data wearable equiptment data from\n https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip\n
\t3. unzip the data into local data folder\n
\t4. read activity and feature info from text files\n
\t5. get mean and standard deviation feature from feature info\n
\t6. load only mean and standard deviation data from train and test data set and merge them into total data set, which include subject and activity columns\n
\t7. convert total data set subject and activity columns into factors and display readable name with the activity and feature info got from step 4\n
\t8. reshape the the total data set into tidy data set with the average of each mean/standar deviation variable for each activity and each subject\n
\t9. write tidy data set into a text file\n

You can find the result tidy data in tidy.txt file in this repo.

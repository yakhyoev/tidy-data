CODEBOOK 
tidy data set of
MEAN MEASURES of mean and standard deviation variables
Coursera's Getting and Cleaning Data, 5 Jan 2015 class

Said Yakhyoev

This codebook summarizes data from wearable electronics experiment, measuring movements of subjects. The tidy data set is a selection from original dataset of mean and standard deviation variables; Values represent averaged figures of each of 66 variables grouped by subjects and activities of each subject.

original data set: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


Original untidy data:
Number of subjects: 30
Activities: 6 
Variables: 561
Observations: 10299

Tidy data, only mean and standard deviation variables: "new_tidy_dataset.txt" or “new_tidy_dataset.csv” both saved in working directory by r script file
Number of subjects: 30
Activities: 6
Tidy set observations: 180
Tidy set variables: 66 


ORDER OF OPERATIONS
1. Loads original measurements dataset, activity and subject in test and train files
   into respective temp variables test_x, train_x, test_y, train_y, features, subjects

2. combined test and train datasets into respective combined_x, combined_y, and  	activ_labels, subjects variables

3. Searches with grep() for variables names containing strictly ‘mean()’ and ‘std()’ patterns in features variable (containing variables names); 
   saves index of such occurrences in required_vars

4. reformats names of variables in features using gsub, to remove parenthesis and dashes
   from names of variables in order to allow operations;
   Loads these formatted variables names as colnames into combined_x, the main dataset

5. Using index of variables needed(only mean and sd) created at step 3, subsets 
   combined_x for needed variables. stores a new data.frame as combinedX

6. takes column names for later re-use, stores in var_header

7. creates a data frame with a single column and loads activity labels from activ_labels

8. binds subjects, activity and combinedX data.frames into a single data.frame
   with bind_cols; also called combinedX (overrides earlier)

9. re-applies colnames to combined from step 6, except for ‘subject’ and ‘activity’ cols

10. groups data frame combinedX by subject and activity

11. splits into list by subject, created a list of 30 data frames grouped by activity

12. using for loop for each element of list,
    melts each such datasets by activity, applies dcast() to average each measurement
    and recombines into data frame grouped by activity
    adds column on the left with subject #,
    bind each of the 30 of averaged, group data frames into new_tidy_df final dataset

13. write the resulting new_tidy_df into new_tidy_dataset.csv and also new_tidy_dataset.txt files into working directory

A sample of 20 x 8 of tidy set is printing for visualization 



SUBJECTS			ACTIVITY PERFORMED		LABEL

1	volunteer 1		WALKING				self-descriptive
2	volunteer 2..		WALKING_UPSTAIRS
3	.			WALKING_DOWNSTAIRS
4	.			SITTING
5	.			STANDING
6	.			LAYING
7	.	
8	.	
9	.	
10	.	
11	.	
12	.	
13	.	
14	.	
15	.	
16	.	
17	.	
18	.	
19	.	
20	.	
21	.	
22	.	
23	.	
24	.	
25	.	
26	.	
27	.	
28	.	
29	.	
30	volunteer 30


MEASURED VARIABLES
represents mean() of original values

VARIABLES			LABELS

tBodyAcc_mean_X			Time, body accelerometer, mean measure in X vector
tBodyAcc_mean_Y			Time, body accelerometer, mean measure in Y vector
tBodyAcc_mean_Z			Time, body accelerometer, mean measure in Z vector
tGravityAcc_mean_X		Time,  gravity accelerometer, mean measure in X vector
tGravityAcc_mean_Y		Time, gravity accelerometer, mean measure in Y vector
tGravityAcc_mean_Z		Time, gravity accelerometer, mean measure in Z vector
tBodyAccJerk_mean_X		Time, body accelerometer, jerk motion, mean measure in X vector
tBodyAccJerk_mean_Y		Time, body accelerometer, jerk motion, mean measure in Y vector
tBodyAccJerk_mean_Z		Time, body accelerometer, jerk motion, mean measure in Z vector
tBodyGyro_mean_X		Time, body gyroscope, mean measure in X vector
tBodyGyro_mean_Y		Time, body gyroscope, mean measure in Y vector
tBodyGyro_mean_Z		Time, body gyroscope, mean measure in Z vector
tBodyGyroJerk_mean_X		Time, body gyroscope, jerk motion, mean measure in X vector
tBodyGyroJerk_mean_Y		Time, body gyroscope, jerk motion, mean measure in Y vector
tBodyGyroJerk_mean_Z		Time, body gyroscope, jerk motion, mean measure in Z vector
tBodyAccMag_mean		Time, body accelerometerMag, mean measure
tGravityAccMag_mean		Time, gravity accelerometerMag, mean measure
tBodyAccJerkMag_mean		Time, body accelerometer, jerk motionMag, mean measure
tBodyGyroMag_mean		Time, body gyroscopeMag, mean measure
tBodyGyroJerkMag_mean		Time, body gyroscope, jerk motionMag, mean measure
fBodyAcc_mean_X		 	Frequency , body accelerometer, mean measure in X vector
fBodyAcc_mean_Y		 	Frequency, body accelerometer, mean measure in Y vector
fBodyAcc_mean_Z		 	Frequency, body accelerometer, mean measure in Z vector
fBodyAccJerk_mean_X		Frequency, body accelerometer, jerk motion, mean measure in X vector
fBodyAccJerk_mean_Y		Frequency, body accelerometer, jerk motion, mean measure in Y vector
fBodyAccJerk_mean_Z		Frequency, body accelerometer, jerk motion, mean measure in Z vector
fBodyGyro_mean_X		Frequency, body gyroscope, mean measure in X vector
fBodyGyro_mean_Y		Frequency, body gyroscope, mean measure in Y vector
fBodyGyro_mean_Z		Frequency, body gyroscope, mean measure in Z vector
fBodyAccMag_mean		Frequency, body accelerometerMag, mean measure
fBodyBodyAccJerkMag_mean	Frequency, body  body accelerometer, jerk motionMag, mean measure
fBodyBodyGyroMag_mean		Frequency, body  body gyroscopeMag, mean measure
fBodyBodyGyroJerkMag_mean	Frequency, body  body gyroscope, jerk motionMag, mean measure
tBodyAcc_std_X			Time, body accelerometer, standard deviation measure in X vector
tBodyAcc_std_Y			Time, body accelerometer, standard deviation measure in Y vector
tBodyAcc_std_Z			Time, body accelerometer, standard deviation measure in Z vector
tGravityAcc_std_X		Time, gravity accelerometer, standard deviation measure in X vector
tGravityAcc_std_Y		Time, gravity accelerometer, standard deviation measure in Y vector
tGravityAcc_std_Z		Time, gravity accelerometer, standard deviation measure in Z vector
tBodyAccJerk_std_X		Time, body accelerometer, jerk motion, standard deviation measure in X vector
tBodyAccJerk_std_Y		Time, body accelerometer, jerk motion, standard deviation measure in Y vector
tBodyAccJerk_std_Z		Time, body accelerometer, jerk motion, standard deviation measure in Z vector
tBodyGyro_std_X			Time, body gyroscope, standard deviation measure in X vector
tBodyGyro_std_Y			Time, body gyroscope, standard deviation measure in Y vector
tBodyGyro_std_Z			Time, body gyroscope, standard deviation measure in Z vector
tBodyGyroJerk_std_X		Time, body gyroscope, jerk motion, standard deviation measure in X vector
tBodyGyroJerk_std_Y		Time, body gyroscope, jerk motion, standard deviation measure in Y vector
tBodyGyroJerk_std_Z		Time, body gyroscope, jerk motion, standard deviation measure in Z vector
tBodyAccMag_std			Time, body accelerometerMag, standard deviation measure
tGravityAccMag_std		Time, gravity accelerometerMag, standard deviation measure
tBodyAccJerkMag_std		Time, body accelerometer, jerk motionMag, standard deviation measure
tBodyGyroMag_std		Time, body gyroscopeMag, standard deviation measure
tBodyGyroJerkMag_std		Time, body gyroscope, jerk motionMag, standard deviation measure
fBodyAcc_std_X		 	Frequency, body accelerometer, standard deviation measure in X vector
fBodyAcc_std_Y		 	Frequency, body accelerometer, standard deviation measure in Y vector
fBodyAcc_std_Z		 	Frequency, body accelerometer, standard deviation measure in Z vector
fBodyAccJerk_std_X		Frequency, body accelerometer, jerk motion, standard deviation measure in X vector
fBodyAccJerk_std_Y		Frequency, body accelerometer, jerk motion, standard deviation measure in Y vector
fBodyAccJerk_std_Z		Frequency, body accelerometer, jerk motion, standard deviation measure in Z vector
fBodyGyro_std_X		 	Frequency, body gyroscope, standard deviation measure in X vector
fBodyGyro_std_Y		 	Frequency, body gyroscope, standard deviation measure in Y vector
fBodyGyro_std_Z		 	Frequency, body gyroscope, standard deviation measure in Z vector
fBodyAccMag_std		 	Frequency, body accelerometerMag, standard deviation measure
fBodyBodyAccJerkMag_std		Frequency, body  body accelerometer, jerk motionMag, standard deviation measure
fBodyBodyGyroMag_std		Frequency, body  body gyroscopeMag, standard deviation measure
fBodyBodyGyroJerkMag_std	Frequency, body  body gyroscope, jerk motionMag, standard deviation measure		
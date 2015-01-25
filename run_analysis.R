# run_analysis Said Yakhyoev, tidy up exercise data. Getting and Cleaning Data, project course.
# converting personal device data
# please read README.txt, data and script are assumed to be saved on the working directory
# requires, plyr, dplyr, reshape2 packages

##load necessary libraries

library('plyr')
library('dplyr')
library('reshape2')

## load data from text files into local variables

testx <- read.table('./UCI HAR Dataset/test/X_test.txt')   
testy <- read.table('./UCI HAR Dataset/test/y_test.txt')

trainy <- read.table('./UCI HAR Dataset/train/y_train.txt')
trainx <- read.table('./UCI HAR Dataset/train/X_train.txt')

features <- read.table('./UCI HAR Dataset/features.txt')
activ_labels <- read.table('./UCI HAR Dataset/activity_labels.txt')

subjects_test <- read.table('./UCI HAR Dataset/test/subject_test.txt')
subjects_train <- read.table('./UCI HAR Dataset/train/subject_train.txt')

## instruction (1): combines the training and the test sets
## Combined 'test' and 'train' versons of datasets, 

subjects <- rbind(subjects_test,subjects_train)
colnames(subjects) <-'subject'                      # we assign column name 'subject' so we can use it later

combined_y <- bind_rows(testy,trainy)               # combined test and train activity data, in that order
combined_x <- bind_rows(testx,trainx)               # combined test and train measurements data, also in that order


## Select needed variables 
## only those containing mean() and std(), saved their index

vars1 <- grep(c('mean()'),features$V2,fixed = TRUE) # we use grep() to find mean, and sd from features vector
vars2 <- grep('std()',features$V2, fixed = TRUE)
required_vars <- c(vars1, vars2)                    # lets saved the INDEX of such occurences in required_vars


## instruction (3): Prepare descriptive variable names
## variables need re-formatting

formatted_headers <- gsub('\\()','',features$V2) 	# we use gsub to remove '()' and replace '-'
formatted_headers <- gsub('-','_',formatted_headers)# otherise they causes problems
colnames(combined_x) <- formatted_headers     		# load cleaned column names to main dataset


## instruction (2): Extract only the mean and sd measurements,
## as prepared earlier 
combinedX <- combined_x[,required_vars] 			# extract need varibles, and saved as combinedX 
                                                   

## Prepare descriptive activity names to name the activities in the data set
## along combined_y, substitute numbers for descriptive lables

temp <- NULL
for (i in combined_y) { 
    temp <- c(temp, as.character(activ_labels[i,2]))
}
activity <- data.frame(activity = temp)             # create a new data.frame with activities lables


## instruction (5): creates a tidy data set with the average of each variable for each activity and each subject
## Bind prepared subjects, activity and measurements
## into a single data.frame, combinedX

combinedX <- bind_cols(subjects,activity,combinedX)	# combine 'subjects' and 'activity lebels' and 'measurents' 
													# we should have a ready data.frame with all labels
                                                    # and all needed data to perform operations									
var_header <- colnames(combinedX)[3:68]             # we save column names later. extract all column names except subj & activity


## Reshape the data.frame.
## to allow calculations by subject, activites and vars

combinedX <- group_by(combinedX, subject, activity) 	# group by subject and activity assigned earlier,		
subj_split <- split(combinedX,combinedX$subject)        # split by subject into a list of data.frame, to work on each separately
                                                        # we now have a list containing 30 data.frames, each with activity and variables columns
## Perform calculation.
## by performing melt > dcast > recombine into single, tidy data frame

temp <- NULL
temp <-list()
new_tidy_df <- data.frame()

for (i in subj_split){                              # for each data.frame, melt varialbes
    temp <- i %>%
    melt(id.vars = 'activity', measure.vars = var_header) %>%
    dcast(activity ~ variable, mean)                # calculate mean of each measureent and re-cast back
    
    temp<- cbind(subject = i[1,1],temp)             # ADD subject column back, since it was removed when converting into a list,
                                                    # subject lable is derived from list element (i), since it originaly comes from subjects column
    
    new_tidy_df <- rbind(new_tidy_df,temp)          # glue each such averaged dataframe back together as new_tidy_df
                                                    # we now have a clean dataframe, arranged by subject, activity and averaged measurements
}
write.csv(new_tidy_df, file = 'new_tidy_dataset.csv')
print ('sample:')
new_tidy_df[1:20,1:8]                               # see a sample of the new data frame, 180 observations (30 x 6 activities) by 68 variables (subj, act and 66 vars)


# tidy-data
A tidy data set, a shortened, averaged set from a larger set from a wearable computing study of body motions recorded by sumsung smartphones. The original data is from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

This is a coursera 'Getting and Cleaning Data' class of 5 Jan 2015

run_analysis.R loads various data, and processes it produce a tidy, averaged data form a larger file. 
codebook.md includes detailed output information and proceduers performed on the data

The r file assume that that the original files are already downloaded and unzipped into the working directory where the run_analysis.R will be located. 

the output dataset is saved as: both - new_tidy_dataset.csv and new_tidy_dataset.txt files, saved into the working directory. 
the output file is also included in this repo.

packages needed:
plyr
dplyr
reshape2


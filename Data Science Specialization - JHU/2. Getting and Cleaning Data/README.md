# Getting and Cleaning data Course Project

Project from Coursera Getting and Cleaning data course (Data Science Specialization).

## Project description

The purpose of this project is to demonstrate someone's ability to collect, work with, and clean a data set.

The data used for this project represent data collected from the accelerometers from the Samsung Galaxy S smartphone
* Website where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
* Data for the project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The project's objective is to create one R script called run_analysis.R that does the following. 
* 1. Merges the training and the test sets to create one data set.
* 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
* 3. Uses descriptive activity names to name the activities in the data set
* 4. Appropriately labels the data set with descriptive variable names. 
* 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## What you can find on this repository

* CodeBook.md: information about raw and tidy data sets
* README.md: this file to understand the project's purpose
* run_analysis.R: the R script to transform the raw data set into a tidy one
* tidy_data.txt: the tidy data set obtained when running run_analysis R script

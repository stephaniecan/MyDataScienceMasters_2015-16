## Coursera Getting & Cleaning data
## Course Project

## STEP 0: get the data sets

# Download zip file and unzip it
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, dest="datafile.zip", mode='wb')
unzip("datafile.zip", exdir=".")

# View working directory to recognize the new folder and data sets
list.files(".")
list.files("./UCI HAR Dataset")

## STEP 1: Merges the training and the test sets to create one data set

# Get the 'data.table' and 'plyr' package needed later
library(data.table)
library(plyr)

# Set working directory as main UCI HAR Dataset folder to get the data sets
setwd("./UCI HAR Dataset")

# Read and prepare the features and activity labels data sets
feature_names <- read.table("features.txt")
activity_labels <- read.table("activity_labels.txt")

# Read and view the test data sets to get an idea on how to merge them
subject_test <- read.table("./test/subject_test.txt")
X_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")
View(subject_test)
View(X_test)
View(y_test)

# Read and view the train data sets to get an idea on how to merge them
subject_train <- read.table("./train/subject_train.txt")
X_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")
View(subject_train)
View(X_train)
View(y_train)

# Add column name to subject files
names(subject_train) <- "subject_ID"
names(subject_test) <- "subject_ID"

# Add column names to measurement files
names(X_train) <- feature_names$V2
names(X_test) <- feature_names$V2

# Add column name to activity label files
names(y_train) <- "activity"
names(y_test) <- "activity"

# Add column name to activity labels file
colnames(activity_labels) <- c("activity","activitylabel")

# Combine files into one dataset
test_files <- cbind(subject_test, y_test, X_test)
train_files <- cbind(subject_train, y_train, X_train)
data_merged <- rbind(train_files, test_files)
View(data_merged)

## STEP 2: Extracts only the measurements on the mean and 
## standard deviation for each measurement. 

data_merged_mean_std <- data_merged[,grepl("mean|std|subject_ID|activity", names(data_merged))]

## STEP 3: Uses descriptive activity names to name the activities in the data set

data_merged_mean_std <- merge(data_merged_mean_std,activity_labels,by="activitylabel",all.x=TRUE)
data_merged_mean_std <- data_merged_mean_std[,-1]

## STEP 4: Appropriately labels the data set with descriptive variable names

# Create a vector for column names of the merged data
col_names <- colnames(data_merged_mean_std)

for (i in 1:length(col_names)) 
{
  col_names[i] = gsub("\\()","",col_names[i])
  col_names[i] = gsub("-std$","StdDev",col_names[i])
  col_names[i] = gsub("-mean","Mean",col_names[i])
  col_names[i] = gsub("^(t)","time",col_names[i])
  col_names[i] = gsub("^(f)","freq",col_names[i])
  col_names[i] = gsub("([Gg]ravity)","Gravity",col_names[i])
  col_names[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",col_names[i])
  col_names[i] = gsub("[Gg]yro","Gyro",col_names[i])
  col_names[i] = gsub("AccMag","AccMagnitude",col_names[i])
  col_names[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",col_names[i])
  col_names[i] = gsub("JerkMag","JerkMagnitude",col_names[i])
  col_names[i] = gsub("GyroMag","GyroMagnitude",col_names[i])
};

# Assign the new descriptive column names to the final merged data set
colnames(data_merged_mean_std) <- col_names

## STEP 5: From the data set in step 4, creates a second, independent tidy data 
## set with the average of each variable for each activity and each subject

tidy_data <- ddply(data_merged_mean_std, c("subject_ID","activity"), numcolwise(mean))
write.table(tidy_data, file = "tidy_data.txt", row.name=FALSE)
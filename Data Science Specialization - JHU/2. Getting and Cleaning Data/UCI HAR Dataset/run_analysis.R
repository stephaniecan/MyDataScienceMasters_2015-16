# 1. Merges the training and the test sets to create one data set.
library(data.table)
list.files("./train")
list.files("./test")
train_set <- read.table("./train/X_train.txt")
test_set <- read.table("./test/X_test.txt")
train_label <- read.table("./train/y_train.txt")
test_label <- read.table("./test/y_test.txt")
subject_train <- read.table("./train/subject_train.txt")
subject_test <- read.table("./test/subject_test.txt")
activity_labels <- read.table("./activity_labels.txt")
features <- read.table("./features.txt")

# change train and test column names with features
names(train_set) <- features$V2
names(test_set) <- features$V2

# Add class labels and subject data to train and test sets
train_set[,"class"] <- train_label
test_set[,"class"] <- test_label
train_set[,"subject"] <- subject_train
test_set[,"subject"] <- subject_test

# Merge training and test sets and test if merge happened well
merge <- rbind(train_set, test_set)
nrow(train_set)+nrow(test_set)-nrow(merge)

# Matching class labels with the activity names
names(activity_labels) <- c("class","labels")
newmerge <- merge(merge,activity_labels, by.x="class", by.y="class",all=TRUE)

# Checking the merged data
names(newmerge)
summary(newmerge$subject)
summary(newmerge$labels)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

newmerge <- newmerge[,grep("mean|std|labels|subject",names(newmerge)) ]
View(newmerge); names(newmerge)

# 3. Uses descriptive activity names to name the activities in the data set
newmerge$labels <- tolower(newmerge$labels)
newmerge$labels <- gsub("_","",newmerge$labels)

# 4. Appropriately labels the data set with descriptive variable names. 


# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
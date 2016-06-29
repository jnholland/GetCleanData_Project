## You should create one R script called run_analysis.R that does the following.

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


############################################
###### Get, Download, and unzip data
############################################
##  setwd in rstudio menu pulldown 
getwd()
setwd("~/Desktop/DataSciCoursera/C3GetCleanData/Project")
dataset_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dataset_url, destfile="samsung.zip")  ##downloads to setwd
unzip("samsung.zip")  ## exdir="specdata"  creates new folder for unzipped files
files <- list.files("UCI HAR Dataset", full.names=TRUE, recursive=TRUE)


############################################
###### Step 1 Merge train and test data into one data set
############################################

###### create data from text files
activity_test <- read.table("UCI HAR Dataset/test/y_test.txt",header=FALSE)
str(activity_test)
activity_train <- read.table("UCI HAR Dataset/train/y_train.txt",header=FALSE)
str(activity_train)

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt",header=FALSE)
str(subject_test)
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt",header=FALSE)
str(subject_train)

feature_test <- read.table("UCI HAR Dataset/test/X_test.txt",header=FALSE)
str(feature_test)
feature_train <- read.table("UCI HAR Dataset/train/X_train.txt",header=FALSE)
str(feature_train)

###### combine rows and columns and apply names to them
activity <- rbind(activity_train,activity_test)
subject <- rbind(subject_train, subject_test)
feature <- rbind(feature_train,feature_test)

names(activity) <- c("Activity")
names(subject) <- c("Subject")
feature_names <- read.table("UCI HAR Dataset/features.txt",header=FALSE)
names(feature)<- feature_names$V2

###### merge it together
merged1 <- cbind(subject, activity)
merged2 <- cbind(merged1, feature)
str(merged2)



############################################
###### Step 2 Extract measurements on mean and standard deviation
############################################
extracted <- feature_names$V2[grep("mean\\(\\)|std\\(\\)", feature_names$V2)]
str(extracted)

select_features <-c(as.character(extracted), "Subject", "Activity" )
subset_data <-subset(merged2,select=select_features)
str(subset_data)


############################################
###### Step 3. Use descriptive activity names to name the activities in the data set
############################################
activity_names <- read.table("UCI HAR Dataset/activity_labels.txt",header = FALSE)
subset_data$Activity <- factor(subset_data$Activity, levels = activity_names[,1], labels = activity_names[,2])
head(subset_data$Activity)

subset_data$Subject <- as.factor(subset_data$Subject)


############################################
###### Step 4. Appropriately labels the data set with descriptive variable names.
############################################
names(subset_data)<-gsub("^t", "time", names(subset_data))
names(subset_data)<-gsub("^f", "frequency", names(subset_data))
names(subset_data)<-gsub("Acc", "Accelerometer", names(subset_data))
names(subset_data)<-gsub("Gyro", "Gyroscope", names(subset_data))
names(subset_data)<-gsub("Mag", "Magnitude", names(subset_data))
names(subset_data)<-gsub("BodyBody", "Body", names(subset_data))
str(subset_data)


############################################
###### Step 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
############################################
library(plyr)
new_data <- ddply(subset_data, .(Subject, Activity), function(x) colMeans(x[, 1:66]))
write.table(new_data, "tidy.txt", row.name=FALSE)







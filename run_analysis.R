## This project does the following:
##Merges the training and the test sets to create one data set.
##Extracts only the measurements on the mean and standard deviation for each measurement.
## Uses descriptive activity names to name the activities in the data set.
## Appropriately labels the data set with descriptive variable names.
## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


destfile <- "downloaded.zip"

##Set the working directory
setwd("C:/DataScience/GettingAndCleaningData/ProjectAssignment")

##Download the zip file
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile)

## Unzip the zip file
unzip(destfile) 

## Read all the text files 
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
test_subject_id <- read.table("UCI HAR Dataset/test/subject_test.txt")
train_subject_id <- read.table("UCI HAR Dataset/train/subject_train.txt")
test_activity_id <- read.table("UCI HAR Dataset/test/y_test.txt")
train_activity_id <- read.table("UCI HAR Dataset/train/y_train.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt",col.names=c("activity_id","activity_name"))
features <- read.table("UCI HAR Dataset/features.txt")
feature_names <- features[,2]

##Label the dataframes columns in all text files
colnames(X_test)<-feature_names
colnames(X_train) <- feature_names
colnames(test_subject_id) <- "subject_id"
colnames(test_activity_id) <- "activity_id"
colnames(train_subject_id) <- "subject_id"
colnames(train_activity_id) <- "activity_id"

##Combine the test subject id's, the test activity id's and the test data by column bind
Final_test_data <- cbind(test_activity_id,test_subject_id,X_test)

##Combine the train subject id's, the train activity id's and the train data by column bind
Final_train_data <- cbind(train_activity_id,train_subject_id,X_train)

##Combine the test data and the train data into one dataframe
Combined_data <- rbind(Final_train_data, Final_test_data)

##Keep only columns refering to mean() or std() values
mean_col_idx <- grep("mean",names(Combined_data),ignore.case=TRUE)
mean_col_names <- names(Combined_data)[mean_col_idx]
std_col_idx <- grep("std",names(Combined_data),ignore.case=TRUE)
std_col_names <- names(Combined_data)[std_col_idx]
Mean_Stddata <-Combined_data[,c("subject_id","activity_id",mean_col_names,std_col_names)]


##Merge the activities datase with the mean/std values datase to get one dataset with descriptive activity names
Final_Data <- merge(activity_labels,Mean_Stddata,by.x="activity_id",by.y="activity_id",all=TRUE)

##Install the reshape package to use melt and cast functionality
install.packages("reshape2")
library("reshape2")

##Melt the dataset with the descriptive activity names 
Tidy_Data <- melt(Final_Data,id=c("activity_id","activity_name","subject_id"))

##Cast the melted dataset to have average of each variable for each activity and each subject
Final_Tidy_data <- dcast(Tidy_Data,activity_id + activity_name + subject_id ~ variable,mean)

## Copy the data set into Tidy_data.txt
write.table(Final_Tidy_data,"Tidy_data.txt")






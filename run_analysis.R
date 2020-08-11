#Set up

library(dplyr)

#Getting the dataset
zip <- "getdata_projectfiles_UCI HAR Dataset.zip"
if(!file.exists(zip))
    zip_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(zip_url, zip, method="curl")
    
if(!file.exists("UCI HAR Dataset"))
    unzip(zip)

#Dataframe names 
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n", "functions"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")


#Working with the data
#Merging training and test sets 

#Merging rows
X <- rbind(x_test, x_train)
Y <- rbind(y_test, y_train)
Sub <- rbind(subject_test, subject_train)
#Merging cols
merged_test_train <- cbind(Sub, Y, X)

#Getting only mean and std deviation
clean_merged <- merged_test_train %>% select(subject, code, contains("mean"), contains("std"))

#Adding desctiptive names
clean_merged$code <- activity_labels[clean_merged$code, 2]

#Setting activity names
names(clean_merged)[2] = "Activity"
names(clean_merged) <- gsub("Acc", "Accelerometer", names(clean_merged))
names(clean_merged) <- gsub("Gyro", "Gyroscope", names(clean_merged))
names(clean_merged) <- gsub("Mag", "Magnitude", names(clean_merged))
names(clean_merged) <- gsub("^t", "Time", names(clean_merged))
names(clean_merged) <- gsub("^f", "Frequency", names(clean_merged))
names(clean_merged) <- gsub("tBody", "TimeBody", names(clean_merged))
names(clean_merged) <- gsub("-mean()", "Mean", names(clean_merged), ignore.case = TRUE)
names(clean_merged) <- gsub("-std()", "Std", names(clean_merged), ignore.case = TRUE)
names(clean_merged) <- gsub("-freq", "Frequency", names(clean_merged), ignore.case = TRUE)
names(clean_merged) <- gsub("angle", "Angle", names(clean_merged))
names(clean_merged) <- gsub("gravity", "Gravity", names(clean_merged))

#derive a new dataset (avg of each var, act, and sub)
wanted_data <- clean_merged %>%
    group_by(subject, Activity) %>%
    summarize_all(funs(mean))
write.table(wanted_data, "WantedData.txt", row.name = FALSE)


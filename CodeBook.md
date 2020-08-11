
CODE BOOK for run_analysis.R script

This Code Book is for the run_analysis.R script that sets up the data
for it to be handled and then follows the guidelines given in the "Getting and
Cleaning Data Course Project".

1. Set up 
	The dataset is downloaded and extracted in the folder named UCI HAR Dataset

2. Dataframe names
	Each dataframe contained in the UCI HAR Dataset is assigned a name 

	activity_labels <- activity_lablels.txt
		Length: 6 rows, 2 columns
		Contains: list of activities performed when measurements were taken and its labels
	features <- features.txt 
		Length: 561 rows, 2 columns
		Contains: features that come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
	subject_test <- test/subject_test.txt 
		Length: 2947 rows, 1 column
		Contains: test data of observed volunteer test subjects. 9/30 subjects were observed.
	x_test <- test/X_test.txt 
		Length: 2947  rows, 561 columns
		Contains: recorded test data (features)
	y_test <- test/y_test.txt 
		Length: 2947 rows, 1 column
		Contains: activities' code label of the test data 
	subject_train <- train/subject_train.txt
		Length: 7352 rows, 1 column
		Contains: train data of observed volunteer subjects. 21/30 subjects were observed.
	x_train <- train/X_train.txt 
		Length: 7352 rows, 561 columns
		Contains: recorded training data (features)
	y_train <- train/y_train.txt
		Length: 7352 rows, 1 column
		Contains: activities' code label of the training data
 
3. Working with the data: Merging training and test sets
	X is created with the rbind() function, it merges x_test and x_train. 
		X dimensions: 10299 rows, 561 columns
	Y is created with the rbind() function, it merges y_test and y_train.
		Y dimensions: 10299 rows, 1 column
	Sub is created with the rbind() function, it merges subject_test and subject_train.
		Sub dimensions: 10299 rows, 1 column
	merged_test_train is created with the cbind() function, merging Sub, Y and X. 
		merged_test_train dimensions: 10299 rows, 563 columns

4. Getting only mean and std deviation
	clean_merged is created by subsetting merged_test_train, selecting the columns:
	subject, code, and measurements on mean and standard deviation (std).

5. Adding descriptive names 
	Numbers in code column within the clean_merged dataset are replaced with activities, taken from the second column of the activity_labels variable. 
 
6. Setting activity names
	"code" column in clean_merged is renamed as "Activity"
	All "Acc" in column name is changed into "Accelerometer"
	All "Gyro" in column name is changed into "Gyroscope"
	All "Mag" in column name is changed into "Magnitude"
	All "tBody" in column name is changed into "TimeBody"
	All "angle" in column name is changed into "Angle"
	All "gravity" in column name is changed into "Gravity"
	All column names that start with "t" are changed into "Time"
	All column names that start with "f" are changed into "Frequency"

7. Derive a new dataset that contains the average of each variable, activity and subject
	wanted_data is created by summarizing clean_merged, it takes the mean of each variable, activity and subject. 
	It is then grouped by subject and activity. 
	wanted_data is then exported into WantedData.txt file. 
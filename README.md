The run_analysis.R processing takes data collected from the accelerometers from the Samsung Galaxy S smartphone does the following actions:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Processing steps"

1. Read in the names of the activities found in "./UCI_HAR_Dataset/activity_labels.txt", apply the column names "code" and "activity"

2. Read in the names of the  measurements found in "./UCI_HAR_Dataset/features.txt", apply the column names "code" and"measurement"
measurements <- read.table("./UCI_HAR_Dataset/features.txt", sep = " ", 
                    col.names = c("code","measurement"))

3. Read in the training datasets located in the "./UCI_HAR_Dataset/train" directory.
	a. Read in the training subject data found in "./UCI_HAR_Dataset/train/subject_train.txt applying the column name "subject"

	b. Read in the training measurement data found in "./UCI_HAR_Dataset/train/X_train.txt applying the column names as defined in step 2

	c. Read in the training subject data found in "./UCI_HAR_Dataset/train/y_train.txt applying the column name "activity_code"


4. Process and merge the training data
	a. Only the means and standard deviations columns are require, so those column are selected from the training activity data frame

	b. The activity is captured as a code so it is translated to a meaningful name by merging it with the activity names obtaind in step 1

	c. All of the training columns are combined putting subject first, then activity which is followed by all the mean and SD columns


5. Read in the testing datasets located in the "./UCI_HAR_Dataset/train" directory.
	a. Read in the testing subject data found in "./UCI_HAR_Dataset/train/subject_train.txt applying the column name "subject"

	b. Read in the testing measurement data found in "./UCI_HAR_Dataset/train/X_train.txt applying the column names as defined in step 2

	c. Read in the testing subject data found in "./UCI_HAR_Dataset/train/y_train.txt applying the column name "activity_code"


6. Process and merge the testing data
	a. Only the means and standard deviations columns are require, so those column are selected from the testing activity data frame

	b. The activity is captured as a code so it is translated to a meaningful name by merging it with the activity names obtaind in step 1

	c. All of the testing columns are combined putting subject first, then activity which is followed by all the mean and SD columns


7. Combine all rows of the training and testing data into a single data frame.
all_data <- bind_rows(train_data,test_data)

8. to achieve action number 5 above, the resulting data frame was melted by subject and activity

9. The meted data frame was then dcast'ed to a new data frame containing the means of all variables aggregated by subject and activity.


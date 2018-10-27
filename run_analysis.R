library(dplyr)

# Read in the names of the activities and the measurements found in "./UCI_HAR_Dataset"
activity_name <- read.table("./UCI_HAR_Dataset/activity_labels.txt", sep = " ", 
                    col.names = c("code","activity"))
measurements <- read.table("./UCI_HAR_Dataset/features.txt", sep = " ", 
                    col.names = c("code","measurement"))

# Read in training datasets located in the "./UCI_HAR_Dataset/train" directory.
subject_train <- read.table("./UCI_HAR_Dataset/train/subject_train.txt", sep = " ", 
                            col.names = "subject")
# Note: Used the column names as defined in "feature.txt"
measure_train <- read.table("./UCI_HAR_Dataset/train/X_train.txt", sep = "",
                            col.names = measurements[,2])
activity_train <- read.table("./UCI_HAR_Dataset/train/y_train.txt", sep = " ", 
                            col.names = "activity_code")

# Process and merge the training data
#   Only the means and standard deviations columns are require
select_meas_train <- select(measure_train,contains(".mean."),contains("std"))
#   The activity is captured as a code - translate it to a meaningful name
activity_train <- select(merge(activity_train,activity_name,by.x = "activity_code",by.y = "code"),activity)
#   Combine all training columns (subject then activity followed by means and SDs )
train_data <- bind_cols(subject_train,activity_train,select_meas_train)


# Read in testing datasets located in the "./UCI_HAR_Dataset/train" directory.
subject_test <- read.table("./UCI_HAR_Dataset/test/subject_test.txt", sep = " ", 
                            col.names = "subject")
# Note: Used the column names as defined in "feature.txt"
measure_test <- read.table("./UCI_HAR_Dataset/test/X_test.txt", sep = "",
                            col.names = measurements[,2])
activity_test <- read.table("./UCI_HAR_Dataset/test/y_test.txt", sep = " ", 
                             col.names = "activity_code")

# Process and merge the testing data
#   Only the means and standard deviations columns are require
select_meas_test <- select(measure_test,contains(".mean."),contains("std"))
#   The activity is captured as a code - translate it to a meaningful name
activity_test <- select(merge(activity_test,activity_name,by.x = "activity_code",by.y = "code"),activity)
#   Combine all training columns (subject then activity followed by means and SDs )
test_data <- bind_cols(subject_test,activity_test,select_meas_test)

# Combine all rows of the training and testing data into a single data frame.
all_data <- bind_rows(train_data,test_data)

# Melt the resulting data frame by subject and activity

all_data_melt <- melt(all_data,id=c("subject","activity"))

# dcast the melted data frame to calculate the mean of all variables aggregated by 
#       subject and activity

avg_by_subject_activity <- dcast(all_data_melt, subject + activity ~ variable, mean)
# parameter to ease testing (not all data is read in at all times)
# to disable set rows_to_read = -1 -> ignored by read.table
# use only for debugging purposes: not to be altered for creating the requested tidy data sets
rows_to_read <- c(4)
#
# read all datafiles
activity_labels <- read.delim("./activity_labels.txt",sep=" ", header=FALSE,stringsAsFactors=FALSE)
name_meas_src <- read.delim("./features.txt",sep=" ", header=FALSE, stringsAsFactors=FALSE)
# training data set
train_meas_x <- read.table("./train/X_train.txt", header=FALSE, nrows=rows_to_read)
train_activity_y <- read.table("./train/y_train.txt", header=FALSE, nrows=rows_to_read)
train_subject <- read.table("./train/subject_train.txt", header=FALSE, nrows = rows_to_read)
# test data set
test_meas_x <- read.table("./test/X_test.txt", header=FALSE, nrows=rows_to_read)
test_activity_y <- read.table("./test/y_test.txt", sep=" ", header=FALSE, nrows=rows_to_read)
test_subject <- read.table("./test/subject_test.txt", header=FALSE, nrows=rows_to_read)
##
## start data manipulation
##
# get names of measurements as a vector of characters
name_meas <- name_meas_src[,2]
# assign the measurement_names to the 2 data sets
colnames(train_meas_x) <- name_meas
colnames(test_meas_x) <- name_meas
# name the subject dataframe
colnames(train_subject) <- c('Subject_Id')
colnames(test_subject) <- c('Subject_Id')
# add the subjects to the dataset
train_subj_meas <- cbind(train_subject, train_meas_x)
test_subj_meas <- cbind(test_subject, test_meas_x)
# delete intermediate variables
rm(train_subject, train_meas_x, test_subject, test_meas_x)

# before adding the activity to the data set: name the columns for easy merging
names(activity_labels) <- c("Activity_Id", "Activity_Name")
names(train_activity_y) <- "Activity_Id"
names(test_activity_y) <- "Activity_Id"

# add the activity to the datasets
train_act_subj_meas <- cbind(train_activity_y, train_subj_meas)
test_act_subj_meas <- cbind(test_activity_y, test_subj_meas)
# delete the intermediate variables
rm(train_activity_y, train_subj_meas, test_activity_y, test_subj_meas)

# Add the Activity_name to the data sets
train_meas <- merge(activity_labels,train_act_subj_meas, by.x="Activity_Id", by.y="Activity_Id", all=FALSE)
test_meas <- merge(activity_labels, test_act_subj_meas, by.x="Activity_Id", by.y="Activity_Id", all=FALSE)
# delete the intermediate variables
rm(activity_labels, train_act_subj_meas, test_act_subj_meas)

# merge the 2 datasets
merged_meas <- rbind(train_meas, test_meas)
# delete the intermediate variables
rm(train_meas, test_meas)

# apart from "Activty_Name" and "Subject_ID" column, select only columns
# containing "mean" or "std" 
# first determine columns of merged_meas that contain sdt and mean values
cols_to_select <- grepl("mean",names(merged_meas)) | grepl("std", names(merged_meas))
# "Activity_Name" & "Subject" column need to be selected to -> change position 1 & 2 in cols_to_select to TRUE
cols_to_select[2] <- TRUE
cols_to_select[3] <- TRUE

# select matched measurements 
matched_meas <- merged_meas[, cols_to_select]

# write mathed_means to file
write.csv(matched_meas, "./tidy_mean_and_std_measuement_values.csv")

## create tidy dataset with averages for each Activity/Subject combination

# select relevant columns - Activty_Id is no longer needed
to_average <- merged_meas[,2:564]

# calculate column means
averaged_meas_list <- by(to_average[,3:563], simplify = TRUE,  interaction(to_average$Activity_Name, to_average$Subject_Id), function(x) colMeans(x))

# re-create a data.frame
averaged_meas <- data.frame(names(averaged_meas_list), matrix(unlist(averaged_meas_list), length(averaged_meas_list), byrow=TRUE))
names(averaged_meas) <- c("combination_Act_Subj", name_meas)

# write to file
write.csv(averaged_meas,"tidy_average_measurement_values_per_subject_and_activity.csv")





Readme file on run_analysis.R script
====================================

How to Use
----------
1. This script should be placed in the same directory/folder as
the UCI HAR Dataset.
2. Change the working directory of the R environment to this directory/folder. (use the command setwd("[your path"]) -- replace [your path] with the actual location)
3. Run the script by sourcing it. (Use the command source("run_analysis.R")


The UCI HAR Dataset can be downloaded from 
http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip

Information on the data set can be found on:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

Result of script
----------------
When the run_analysis.R script is successfully sourced 2 new files are created:
1. tidy__mean_and_std_measuement_values.csv
2. tidy_average_measurement_values_per_subject_and_activity.csv

Information on the Data and the working of the script
-----------------------------------------------------
More information on the source data, the resulting tidy data files and the method of getting from source to tidy data sets, can be found in the CodeBook.md file that accompanies this script. 

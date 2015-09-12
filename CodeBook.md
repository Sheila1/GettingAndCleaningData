# CookBook
# Input Data

The script run_analysis.R reads the input data from the "UCI HAR Dataset" diectory obtained from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# Output Data
The resulting `tidyDataSet.txt` file Computes the means of the datasets train and test, group by subject/activity.

for more detail about the colunms please read the file "features_info.txt" from "UCI HAR Dataset" Directory)

# Transformations

The script, `run_analysis.R`, does the following,

* Load the files from "UCI HAR Dataset" Directory
* Create a subset Merging the `test` and  `train` files into a single data set and filtering the mean and std variables   
* Computes the means of the single data set group by subject/activity, and export the dataset into a file `tidyDataSet.txt`
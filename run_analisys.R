# Script run_analysis.R for: 
# 1.	Merges the training and the test sets to create one data set.
# 2.	Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3.	Uses descriptive activity names to name the activities in the data set
# 4.	Appropriately labels the data set with descriptive variable names
# 5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#download the file
if (!file.exists("UCI HAR Dataset"))
{
    DireccionURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(DireccionURL,destfile="proyecto.zip")
    unzip("proyecto.zip", files = NULL, list = FALSE, overwrite = TRUE, junkpaths = FALSE, exdir = ".", unzip = "internal", setTimes = FALSE)
}   

#read raw data
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt",header=FALSE)# Links the class labels with their activity name
features <- read.table("./UCI HAR Dataset/features.txt",header=FALSE)#List of all features
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")#Each row identifies the subject who performed the activity for each window sample 
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")#Test set
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")#Test label
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt",header=FALSE)#id of subject 
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt",header=FALSE)#Training set
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt",header=FALSE)#Training labels
colnames(x_test) <- features[,2]
colnames(x_train) <- features[,2]
colnames(subject_test) <- "IdSubject"
colnames(subject_train) <- "IdSubject"
colnames(y_test) <- "IdLabel"
colnames(y_train) <- "IdLabel"

#Extracts the measurements on the mean and standard deviation 
#variable help
MeanStd <- grep(".*mean.*|.*std.*", features[,2])
x_test = x_test[,MeanStd]
x_train = x_train[,MeanStd]

#Merges the training and the test sets to create one data set.
DatosTest <- data.frame(subject_test, y_test, x_test)
DatosTrainning <- data.frame(subject_train,y_train, x_train)

#one data set
OneDataSet<- rbind(DatosTest, DatosTrainning)

# Uses descriptive activity names to name the activities in the data set
DataActivities <- merge(OneDataSet,activity_labels,by.x="IdLabel", by.y="V1", all.x=TRUE)
#Appropriately labels the data set with descriptive variable names
colnames(DataActivities)<- c(colnames(OneDataSet),"Activity")

#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidyData <- aggregate(DataActivities, by = list(DataActivities$Activity, DataActivities$IdSubject), FUN = mean, na.rm = FALSE)

#cleaning columns
tidyData<-tidyData[,c(1:2,5:83)]
#rename columns
setnames(tidyData,"Group.1" ,"Group.Activities" )
#writing data
setnames(tidyData,"Group.2" ,"Group.Subject" )
write.table(tidyData, file="TidyDataSet.txt", col.names=TRUE)

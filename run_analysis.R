## we check for the folder called data and if it doesnt exist we create it
## then we download our zip file into that folder.
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip",method="curl")

## then we unzip our downloaded file
unzip(zipfile="./data/Dataset.zip",exdir="./data")

## lets first get the list of all the files, they are in the UCI~ folder
path_rf <- file.path("./data" , "UCI HAR Dataset")
files<-list.files(path_rf, recursive=TRUE)

## we start reading data from 6 selected files of interest 
## that have the data what we need.
dataActivityTest  <- read.table(file.path(path_rf, "test" , "y_test.txt" ),header = FALSE)
dataActivityTrain <- read.table(file.path(path_rf, "train", "y_train.txt"),header = FALSE)
dataSubjectTrain <- read.table(file.path(path_rf, "train", "subject_train.txt"),header = FALSE)
dataSubjectTest  <- read.table(file.path(path_rf, "test" , "subject_test.txt"),header = FALSE)
dataFeaturesTest  <- read.table(file.path(path_rf, "test" , "X_test.txt" ),header = FALSE)
dataFeaturesTrain <- read.table(file.path(path_rf, "train", "X_train.txt"),header = FALSE)

## we can use str() to look at the properties of the variables we created above.
## wont include that here because it is too long.

## ok now lets merge the training and test sets into one
## according to the 3 variable names; subject, activity and features.
dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
dataActivity<- rbind(dataActivityTrain, dataActivityTest)
dataFeatures<- rbind(dataFeaturesTrain, dataFeaturesTest)

## we then set names or labels into our 3 variables.
names(dataSubject)<-c("subject")
names(dataActivity)<- c("activity")
dataFeaturesNames <- read.table(file.path(path_rf, "features.txt"),head=FALSE)
names(dataFeatures)<- dataFeaturesNames$V2

## this is the magic part. we merge all the columns into one dataframe.
dataCombine <- cbind(dataSubject, dataActivity)
Data <- cbind(dataFeatures, dataCombine)

## we extract and subset the mean and std deviation for each
subdataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]
selectedNames<-c(as.character(subdataFeaturesNames), "subject", "activity" )
Data<-subset(Data,select=selectedNames)

## read descriptive activity names from activity_labels.txt
activityLabels <- read.table(file.path(path_rf, "activity_labels.txt"),header = FALSE)

## lets make features also have descriptive names in their variables
## by replacing them with full descriptive words.
names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))

## we make a new tidy dataset having the average for each activity and subject
## based on the previous data set.
library(plyr);
Data2<-aggregate(. ~subject + activity, Data, mean)
Data2<-Data2[order(Data2$subject,Data2$activity),]
write.table(Data2, file = "tidydata.txt",row.name=FALSE)












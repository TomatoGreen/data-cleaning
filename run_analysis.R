run_analysis<-function(){
  ## set work directory
  wd<-"~/Documents/Coursera/Data Science Specialization/03-Data Cleaning"
  setwd(wd)
  if(!file.exists("courseProjectData")){
    dir.create("courseProjectData")
  }
  
  ## download data and unzip the data to course project data folder
  ## fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  ## filePath <- "./courseProjectData/data.zip"
  ## download.file(fileUrl, destfile=filePath, method="curl")
  ## unzip(filePath, exdir="./courseProjectData", overwrite = TRUE)
  
  ## get activities
  activities <- read.table("./courseProjectData/UCI HAR Dataset/activity_labels.txt")
  activities[,2] <- as.character(activities[,2])
  
  ## get features
  features <- read.table("./courseProjectData/UCI HAR Dataset/features.txt")
  features[,2] <- as.character(features[, 2])
  
  ## get mean and standard deviation variable index and name
  varIndex <- grep(".*mean.*|.*std.*", features[,2])
  varName <- features[varIndex, 2]
  varName <- gsub("-mean", "Mean", varName)
  varName <- gsub("-std", "Std", varName)
  varName <- gsub("[-()]", "", varName)
  
  ## load train data on required variable
  train <- read.table("./courseProjectData/UCI HAR Dataset/train/X_train.txt")[,varIndex]
  trainActivity <- read.table("./courseProjectData/UCI HAR Dataset/train/Y_train.txt")
  trainSubject <- read.table("./courseProjectData/UCI HAR Dataset/train/subject_train.txt")
  train <- cbind(trainSubject, trainActivity, train)
  
  ## load test data on required variable
  test <- read.table("./courseProjectData/UCI HAR Dataset/test/X_test.txt")[,varIndex]
  testActivity <- read.table("./courseProjectData/UCI HAR Dataset/test/Y_test.txt")
  testSubject <- read.table("./courseProjectData/UCI HAR Dataset/test/subject_test.txt")
  test <- cbind(testSubject, testActivity, test)
  
  ## get total dataset
  d <- rbind(train, test)
  colnames(d) <- c("subject", "activity", varName)
  
  ## convert subject and activity into factors and display readable name
  d$subject <- as.factor(d$subject)
  d$activity <- factor(d$activity, levels=activities[,1], labels = activities[,2])
  
  ## reshape data to get tidy data set with the average of each variable for each activity and each subject
  library(reshape2)
  mtd <- melt(d, id=c("subject", "activity"))
  tidyD <- dcast(mtd, subject + activity ~ variable, mean)
  
  write.table(tidyD, "./courseProjectData/tidy.txt", row.names = FALSE, quote = FALSE)
}
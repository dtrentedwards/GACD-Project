
## Run_analysis.R Class Project
## Insure data is in correct place
if (!file.exists("classProject")) {
    dir.create("classProject")
}
list.files("./classProject")

## 1.  Merges the training and the test sets to create one data set
## Read test files
## Read subject_test.txt file
subjecttest <- read.table("./classProject/subject_test.txt",  
                    col.names="subject", 
                    fill=FALSE, 
                    strip.white=TRUE)

## Read subject_train.txt file
subjecttrain <- read.table("./classProject/subject_train.txt",  
                          col.names="subject", 
                          fill=FALSE, 
                          strip.white=TRUE)

## Read y_test.txt file
ytest <- read.table("./classProject/y_test.txt",  
               col.names="activitylabel", 
               fill=FALSE, 
               strip.white=TRUE)


## Read features.txt file and tidy column names for later
features <- read.table("./classProject/features.txt",   
                    sep=" ",
                    fill=FALSE,
                    strip.white = TRUE)
features <- as.character(features[ ,-1])
features <- tolower(features)
features <- gsub("\\(", "", features)
features <- gsub("\\)","", features)
features <- gsub("\\,","", features)
features <- gsub("\\.","", features)
features <- gsub("\\-","", features)

## Step 4.  Describing the feature variables
## Tidy variables to determine if Time or Frequency Domain Signal
features <- gsub("^t", "time", features)
features <- gsub("^f", "frequency", features)

## Resulting Calculations 
features <- gsub("mag", "magnitude", features)

features <- gsub("mad", "medianabsolutederivation", features)
features <- gsub("max", "maximum", features)
features <- gsub("min", "minimum", features)
features <- gsub("sma", "signalmagnitudearea", features)
features <- gsub("igr", "interquartilerange", features)
features <- gsub("arCoefficient", "autoregressioncoefficient", features)
features <- gsub("Maxinds", "maximumindexmagnitude", features)
features <- gsub("meanfreq", "averagefrequency", features)
features <- gsub("arCoefficient", "autoregressioncoefficient", features)

## Update mobile sensor labels
features <- gsub("acc", "accelerometer", features)
features <- gsub("gyro", "gyroscope", features)

## Read X_test.txt file
xtest <- read.table("./classProject/X_test.txt",  
                    col.names=features,   #### use features names here.  
                    fill=FALSE, 
                    strip.white=TRUE)

## Combine xtest and ytest
test <- cbind(subjecttest, ytest, xtest)

## Read train files
## Read y_train.txt file
ytrain <- read.table("./classProject/y_train.txt",  
                    col.names="activitylabel", 
                    fill=FALSE, 
                    strip.white=TRUE)

## Read X_train.txt file
xtrain <- read.table("./classProject/X_train.txt",  
                    col.names=features,   #### use features names here.  
                    fill=FALSE, 
                    strip.white=TRUE)

## Combine xtrain and ytrain
train <- cbind(subjecttrain, ytrain, xtrain)

## Combine test and train files

data <- rbind(test,train)

## Remove partial datasets
remove("test", "train", "xtest", "ytest", "xtrain", "ytrain", "subjecttest", "subjecttrain")

## 2.  Extracts only the measurements on the mean and standard deviation for each measurement
meancol <- grep("mean", colnames(data))
stdcol <- grep("std", colnames(data))
intersect(meancol,stdcol)
col <- c(1:2, meancol, stdcol)

datasub <- subset(data, select=col)

## 3.  Uses descriptive activity names to name the activities in the data set
datasub$activitylabel[datasub$activitylabel==1] <- "walking"
datasub$activitylabel[datasub$activitylabel==2] <- "walkingupstairs"
datasub$activitylabel[datasub$activitylabel==3] <- "walkingdownstairs"
datasub$activitylabel[datasub$activitylabel==4] <- "sitting"
datasub$activitylabel[datasub$activitylabel==5] <- "standing"
datasub$activitylabel[datasub$activitylabel==6] <- "laying"

##  5.  From the data set in step 4, creates a second, independent tidy data set with 
## install.packages("reshape2")
library(reshape2)
datamelt <- melt(datasub, id=c("subject", "activitylabel"))

datacast <- dcast(datamelt, subject + activitylabel ~ variable, mean)
tidydata <- melt(datacast,id=c("subject", "activitylabel"), value.name = "mean")















## 6.  Write code book, similar to the one from Week 1 quiz
####  Write it based on the tidy data set to be uploaded

## 7.  Write Readme.md that shows how I transformed the data
#### Basically the strategy used to go from raw data thru step 5
#### Follow these notes and this will be covered

## 8.  Upload to Github
#### Tough.  Could do the Read.me in markdown in Github
READ.me file for run_analysis.R

The purpose of this readme file is to explain the steps taken in run_analysis.R to convert the UCI HAR Dataset into a tidy dataset.

The objective of the class project was to perform the following steps: 

1.  Merges the training and the test sets to create one data set.
2.  Extracts only the measurements on the mean and standard deviation for each measurement. 
3.  Uses descriptive activity names to name the activities in the data set
4.  Appropriately labels the data set with descriptive variable names. 
5.  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
6.  
Below are the descriptions for each step

**Step 1.  Merges the training and the test sets to create one data set**

The UCI HAR Dataset contained the following relevant unzipped datasets:
-  features.txt:  List of headers for the 561 features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ 
-  subject_test.txt:  List of corresponding results from the subjects in the test set
-  subject_train.txt:  List of corresponding results from the subjects in the train set
-  X_test.txt:  561 feature results from the test set
-  Y_test.txt:  Activity results for test set
-  X_train.txt: 561 feature results from the train set 
-  Y_train.txt:  Activity results for test set
 
In order to merge the training set with the test set, one first must combine the test and train sets independently, the combine the two sets

1.  read in the datasets using the read.table command.  Use the col.names function to preset the column names for the datasets.
2.  Read in the features.txt dataframe, then strip out the first column since it is irrelevant.  This will allow us to use the feature list as the col.names for the x_test and x_train datasets.
3.  This is a good time to clean and tidy the features results by following the 4 key steps to tidy data and removing random characters using gsub commands, lowering all cases using tolower() and expanding on the abbreviations using the gsub command, 
4.  Next read in the X test and train datasets, using features as the column names
5.  Using the cbind command, the complete test and train datasets can be created combining subjecttest, y_test and x_test to create the test dataset, for example.
6.  Next, finish this step by combining the test and training sets using an rbind command.

The resulting dataset, data, creates a dataset with 10299 observations across 563 variables

**2.  Extracts only the measurements on the mean and standard deviation for each measurement.** 

Since we are only concerned with measurements that equal a mean or standard deviation (std), we need to subset based on these columns.  

This is done by first finding only those columns with colnames containing mean (meancol) and those with Standard Deviations (stdcol).  From here, we can subset the data dataset based on these column names using the select function within the subset command.  This results in the datasub dataset with 10299 observations and 75 variables.  
-  A quick note that I found 40 columns dealing with means and 33 columns dealing with standard deviations.  Combining these 73 columns with the subject column and activitylabel column produces the 80 total columns.

**Step 3.  Uses descriptive activity names to name the activities in the data set**
While this isn't the most elegant way to describe the activity labels in the activitylabel column, I used the following command for each activity description repeatedly:

```datasub$activitylabel[datasub$activitylabel==1] <- "walking"```

The above code example shows the code for converting activitylabel 1 to "walking", so I copied that six times to add walkingupstairs, walkingdownstairs, sitting, standing, and laying.

**Step 4.  Appropriately labels the data set with descriptive variable names.**
Again, not the most elegant way to do this, but when I initially read the features.txt dataset into my model, I used  series of gsub commands to remove and replace the unwanted characters, lower all cases, etc.  The following is the code sample I used to achieve this:

```
Tidy variables to determine if Time or Frequency Domain Signal
features <- gsub("^t", "time", features)
features <- gsub("^f", "frequency", features)

Resulting Calculations 
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

Update mobile sensor labels
features <- gsub("acc", "accelerometer", features)
features <- gsub("gyro", "gyroscope", features)
```

**Step 5.  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.**
-  Using the datasub dataset and the reshape2 R Package, I went with a narrow and long tidy dataset.  To achieve this, I first
-  Melted the datasub dataset along using the subject and activitylabel variables as the ID.Variables and combining the remaining 73 variables under the variable column.  This created a dataset that was 751827 observations across 4 variables (subject, activitylabel, variable (melted time and frequency domain measurements) and value (the resulting value per observation.
-  Next, I casted, using the dcast command, a wider dataset and passed the mean function across all observations.  To do this, I casted across the subject, activitylabel and variable columns to produce a dataset that was 180 observations (30 subjects x 6 different activity labels) across 75 variables, but showing the mean for each of the 73 observations across the 180 different combinations of subject and activtylabel.
-  Finally, I created my tidydata dataset by melting the datacast dataset so I returned to the following 4 variables:
  1.  Subject:  Numbes 1-30 for each of the 30 subjects
  2.  Activitylabel:  Column that shows, for each of the 30 subjects, one of 6 activities (walking, sitting, standing, etc.)
  3.  Variable:  Melted variable of the 73 time and frequency domain signals
  4.  Mean Values:  Resulting unique mean values

The final tidy dataset resulted in a dataset of 13140 observations (30 subjects x 6 activitylabels x 73 domain signals) across 4 variables
  



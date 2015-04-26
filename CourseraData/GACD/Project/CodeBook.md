This is the run_analysis.R Code Book, explaining the different variables in the tidydata dataset

The purpose of the code book is the list the variables, the data and the transformations and work performed to clean up this data.

This code book is for the final dataset created called tidydata.

For more information regarding the raw data, please see the following links:
https://www.youtube.com/watch?v=XOEN9W05_4A
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Variables

**Variable:  subject**

Description:  1-30 Integers that uniquely distinguish each of the 30 subjects who participated in this wearable experiment.

Data:  Numbers 1 - 30

Transformations Performed:  None

**Variable:  activitylabel**

Description:  List of the following six activities that each of the 30 subjects were measured on
Activities:

-  Walking
-  Walking Upstairs
-  Walking Downstairs
-  Sitting
-  Standing
-  Laying

Data:  Activity descriptions listed below:

-  walking
-  walkingupstairs
-  walkingdownstairs
-  sitting
-  standing
-  laying

Transformations performed:  

-  The raw data residing in files y_test.txt and y_train.txt were numbers from 1-6 that corresponded to the six various activities.  
-  I converted the numbers back to the actual activities listed above in the data section for this variable

**Variable:  Variables**

Description:  A listing of the 73 different domain signals

Data:  The data listed in this column is made up of 73 unique measurements.  While I'm not going to list all of them here since you can find these in the features.txt file and described in much more detail in the features_info.txt file, I used the following framework to improve the variable names

Data Framework:  each Variables variable was basically created by following these five steps  
1.  (T or F).  Each variable name starts with a T for time domain signal or F for frequency domain signal
2.  Body, Gravity or Angle:  Each variable next lists which type of body linear acceleration, angular velocity or gravity acceleration signal
3.  (Acc or Gyro):  Next, the type of mobile sensor is listed.  Acc = accelerometer or gyro=gyroscope
4.  Next, 2 measurement variables listed below were used to create a unique measurement
  Mean():  average measurement
  Std():  standard deviation
5.  Finally, the axis measured was stated 
-  X:  x-axis
-  y: Y-axis
-  Z:  Z-axis

Transformation:  
-  Cleaned up these variables by expanding the variable name using a gsub command to better communicate what the variable is.
-  Also removed all irrelevant characters from variable names like (, ), -, _, , and .
-  73 variables came form a larger set of 561 variables.  Removed all non-mean and standard deviation measurements

**Variable:  Mean**

Description:  These are the mean calculations for each of the unique combinations of subjects, activity labels and variables

Data:  This is a calculated number 

Transformation:  Calculated the mean for each of the unique combinations made from 30 subjects, 6 activities and 73 mean/std variables



  

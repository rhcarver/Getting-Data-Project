# Codebook for "tidyset.txt"

## Introduction and background
In reviewing the features_info document, we find a few important facts that help to understand the nature 
of the measurements within the original data set. These differences are the basis of the construction of 
variable names in the original data set, and are modified in this codebook.  Specifically:

* the phones have built-in accelerometer and gyroscopes whihc capture data along 3 axes (X, Y, and Z). 
* the raw measurements were sampled at a constant rate of 50 Hz, meaning that they are recorded at regular
  time interval (variables beginning with t in the raw data)
* the raw signals were analyzed (various filters) to remove noise and distinguishe between Body acceleration
  and gravity accerlation (Dody or Gravity in the column name)
* Further computations from the raw data genearated the angular velocity and "Jerk" (defined as the first 
  derivative of acceleration. 
* some of the transformed variables were further analyzed to create a set of frequency domain signals. These 
  variables begin with the letter f in the list below.
  
## Naming conventions in this file

Except for columns 1, 2 and 69 every value in the table is the mean of multiple measures, as specified in the 
project assignment. 

*  Most variables are time domain; those starting with _f_ are frequency domain.
*  Any variable containing a capital _M_ refers to a mean; _S_ refer to a standard deviation
*  All acceleration measures refer either to Body or Gravity
*  The letters Acc in a variable indicate that the source was the phone accelerometer
*  The letters Gyro indicate that the sourece was the gyroscope
*  Mag indicates a computed magnitude (non-axial)
*  Jerk indicates a computed first derivative of accleration


## Data Dictionary  
Many of the following variables are axial (X-, Y-, Z-). In those instances, there is a definition for the X 
direction only. Magnitude variables (ending in "Mag") are non-directional

Column|Variable Name|Comments|
|------|-----|------------|
|1|SubjID|Subject ID number|
|2|ActID|Activity ID number (see last column for descriptor)|
|3|BodyAccM...X|Body acceleration Mean along X axis (next 2 refer to Y and Z)|
|4|BodyAccM...Y||
|5|BodyAccM...Z||
|6|GravAccM...X|Gravity acceleration Mean along X axis|
|7|GravAccM...Y||
|8|GravAccM...Z||
|9|BodyAccJerkM...X|Body acceleration Jerk Mean along X axis|
|10|BodyAccJerkM...Y||
|11|BodyAccJerkM...Z||
|12|BodyGyroM...X|Body Gyro Mean along X-axis|
|13|BodyGyroM...Y||
|14|BodyGyroM...Z||
|15|BodyGyroJerkM...X|Body Gyro Jerk Mean along X-axis|
|16|BodyGyroJerkM...Y||
|17|BodyGyroJerkM...Z||
|18|BodyAccMagM..|Body Acc Magnitude Mean |
|19|GravAccMagM..|Gravity Acc Magnitude Mean |
|20|BodyAccJerkMagM..|Body Acc Jerk Magnitude Mean|
|21|BodyGyroMagM..|Body Gyro Magnitude Mean|
|22|BodyGyroJerkMagM..|Body Gyro Jerk Magnitude Mean|
|23|fBodyAccM...X|Body acceleration Mean along X axis (frequency domain|
|24|fBodyAccM...Y||
|25|fBodyAccM...Z||
|26|fBodyAccJerkM...X|Body acceleration Jerk Mean along X axis (freq) |
|27|fBodyAccJerkM...Y||
|28|fBodyAccJerkM...Z||
|29|fBodyGyroM...X|Body Gyro Mean along X axis (freq) |
|30|fBodyGyroM...Y||
|31|fBodyGyroM...Z||
|32|fBodyAccMagM..|Body Acc Magnitude Mean(freq)|
|33|fBodyBodyAccJerkMagM..|Body Acc Jerk Magnitude Mean(freq)|
|34|fBodyBodyGyroMagM..|{not clear what the double Body indicates}|
|35|fBodyBodyGyroJerkMagM..|{not clear what the double Body indicates}|
|36|BodyAccS...X|Same as columns 3:35, except that remaining columns are for std deviations|
|37|BodyAccS...Y||
|38|BodyAccS...Z||
|39|GravAccS...X||
|40|GravAccS...Y||
|41|GravAccS...Z||
|42|BodyAccJerkS...X||
|43|BodyAccJerkS...Y||
|44|BodyAccJerkS...Z||
|45|BodyGyroS...X||
|46|BodyGyroS...Y||
|47|BodyGyroS...Z||
|48|BodyGyroJerkS...X||
|49|BodyGyroJerkS...Y||
|50|BodyGyroJerkS...Z||
|51|BodyAccMagS..||
|52|GravAccMagS..||
|53|BodyAccJerkMagS..||
|54|BodyGyroMagS..||
|55|BodyGyroJerkMagS..||
|56|fBodyAccS...X||
|57|fBodyAccS...Y||
|58|fBodyAccS...Z||
|59|fBodyAccJerkS...X||
|60|fBodyAccJerkS...Y||
|61|fBodyAccJerkS...Z||
|62|fBodyGyroS...X||
|63|fBodyGyroS...Y||
|64|fBodyGyroS...Z||
|65|fBodyAccMagS..||
|66|fBodyBodyAccJerkMagS..||
|67|fBodyBodyGyroMagS..||
|68|fBodyBodyGyroJerkMagS..||
|69|Activity|Descriptive name of the activity (e.g. Walking, Sitting)|



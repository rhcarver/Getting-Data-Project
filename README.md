# Getting-Data-Project
Required elements for the course project in Getting and Cleaning Data

## Description of my approach to coding the assignment
For this project, I decided to begin by sketching a design for the final result: 
GOAL: a tidy data set with the average of each variable for each activity and each subject.
The measurements for the final data set will be the average (mean) for the means and standard deviations of 
the various measurements. 

Recall that we have 30 subjects, 6 different activities, and more than 60 measurement variables.  Each subject
participated in all 6 activies, and multiple measurements were taken during each activity. Some measurements
were recorded at regular time intevals (features beginning with 't'), while others were derived using a Fast Fourier 
Transformation to recast them as frequency domain signals; these are the features starting with 'f'
This will be yield a data table, with 30 x 6  = 180 rows, and as many columns as measurements summaries of mean and 
standard deviation. 

Hence the result of the script will be a data set with a format like this:
   Subject   Activity   Var1-Mean    Var2-Mean ..... Var(k)-StdDev  Var(k+1)StdDev etc. 
   
Each row will be one subject's mean values for one of the six activities, and each subject will appear in 
six consecutive rows. Recall that each measurement in the raw data files is a normalized measurement (z-score), 
and the final tidy data set will consist of the means of recorded measurements for each subject 

## Plan for pulling the data together (using dplyr)
With the format of the final tidy dataset in mind, the coding strategy involved:
* Invoking the dplyr package, to simplify variable selection and manipulaiton,  modifications of column names,
   and other operations.

The files in the "train" and "test" folders are identical in name and structure, but refer to different groups of 
subjects. In this part of the discussion, I'll focus on the Test data, but each comment refers to both folders.

In the main data folder, *UCI HAR Dataset* we find 2 text files:
* activity labels -- 6 observations of 2 columns, mapping an activity ID code to a named activity (eg. Walking)
* features -- 561 observations of 2 columns, mapping a column number to the descriptor of a particular meassurement
      Note: the naming conventions are a bit daunting, but are fully explained in the features_info.txt file.

In both the *test* and *train* folders, there are three text files needed for this project
* X_ -- the principal data source for the project (see below) n observations of 561 variables.
* y_ -- n observations of 1 variable just identifying the _activity_ by numeric ID code. 
* subject_ -- n observations of 1 variable, just identifying the subject being recorded by numeric ID code. The 
   lists of subjects in the test and train data sets are mutually exclusive. 

The analysis centers around the large data file X_test, containing 561 measurments for each subject's trials 
in the six different activities. The file called "features_info" provides background on these many variables. For this 
analysis, eventually we'll only include those variables (66 in all) that represent the mean or standard deviations of
measurements. 

This large X_test file (and the same for the X_train file) has no row identifiers or column (variable) labels.
Fortunately we have all of the 561 variable names contained in the "features.txt" file, and we also have the descriptors of the activities (coded 1-6) in the "activity_labels.txt" file. 

## Flow of the code:


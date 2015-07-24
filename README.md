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
Starting points:
* Main folder:  activity labels, features
* Train folder: subject, X, y
* Test folder:  subject, X, y (y is the activity)

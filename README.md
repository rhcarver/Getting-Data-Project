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
   SubjID   Activity_ID   Var1-Mean    Var2-Mean ..... Var(k)-StdDev  Var(k+1)StdDev etc.... Activity Name
   
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
To pull all of the data together into a large combined file (step 4) the major chunks of code are as follows:

1.  Preliminaries: invoke dplyr package and set working directory
2.  Read  the Activity labels and list of variable names (features.txt)
3.  create temporary table dataframes (using tbl_df) for the Xdata, subject data and y data. Use the list of Features 
      as column names in the X_data table. 
4.  bind (using mutate) the subject and activity id codes to the main X data. 

   _NOTE: At this point, we have a table of the test data -- all columns._
5. Now repeat steps 3 and 4 for the training data
6. With the two major data frames established, SELECT just those columns containing means or standard deviations 
      once for test data, once for training data. In my understanding of the data, I was looking just for variables 
      with "mean()" or "std()" in the name. The letters 'mean' occur in some other variables as well. Hence, I wanted
      to _exclude_ those particular columns. I achieved this (somewhat inelegantly) with, for example, this bit of 
      code which uses a chained set of intructions to seleect variables with names containing "mean()" or "std()", but 
      exclusing three particular other contexts for the letters 'mean'.

      Comment: tables "s1" and "s2" are the subsets of the orginal data frames, just contianing the SELECTed columns

```
   s1 <- testdata %>%
         select(SubjID, ActID, matches("mean()"), matches("std()")) %>%
         select(-matches("meanfreq")) %>%
         select(-matches("gravityMean")) %>%
         select(-matches("AccMean"))
```
7. At this point, using bind_rows I merged the training and test data tables into one large table of 10,299 rows and 
      68 columns (subject ID, ACtivity ID, and 66 measures). To release some memory, I removed most other ojects
8. I struggled with the decision over column naming. The names provided in the features list, and explained in 
   features.info, are long and ungainly but they do follow a sensible naming convention. They are not quite 
   "natural language" but are intelligible. However, some are so long that they bcome truncated within R.

   So, I made some 'editorial' decisions on variable naming:
   * shorten 'Gravity' to 'Grav'
   * shorten 'mean()' and 'std()' to 'M' and 'S'
   * all features begin with t (for time) or f (frequency). Becuase the large majority begin with 't', I dropped
      the initial t's and left the initial f's, so any variable without a leading f is a time variable.
   * removed the hypthen before X, Y, or Z just to shorten names
 
9.  Prior to computing means of all subject-activity readings, I merged in the descriptive activity names. This appears 
   as the final column in the tidy data set. 
10.  Lastly, I summarized each set of subject-activity measures by taking their means, and wrote out the text file as 
   specified in the assignment. 

Within the concluding comments in the code, I included a template for reading back the data. 

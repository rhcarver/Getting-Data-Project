#####################################################################
##  run_analysis.R  Project for Getting and Cleaning Data course   ##
##  Please see README for discussion of logic and methods          ##
#####################################################################

## Load needed package
library(dplyr)


## Set working directory and Read in activity and feature labels. 
## These will identify the types of activities and the measurements taken.
## Script assumes that within the Working Directory there is a folder
## called Coursera, and within that is a folder called "UCI HAR Dataset"
## now change working directory to the UCI HAR folder

setwd("Coursera/UCI HAR Dataset")

Activity <- tbl_df(read.fwf("activity_labels.txt", 
                     widths = c(2, 16), head = FALSE,
                     col.names = c("ActID", "Activity")))
Features <- read.delim("features.txt", head = FALSE,
                       sep = "")
 

## now begin reading test data as tbl_df
## the raw  data has no column names; here we
## use the labels from the "features.txt" file
testdata <- tbl_df(read.delim("./test/X_test.txt", 
                       header=FALSE, sep="",
                       col.names = Features[,2]))
testsubj <- tbl_df(read.delim("./test/subject_test.txt",
                       head=FALSE, sep="", col.names="SubjID"))
testact <- tbl_df(read.delim("./test/y_test.txt",
                      head=FALSE, sep="", col.names="ActID"))

## now merge in the columns for subject and activity into 
## the main set of measurements

testdata <- mutate(testdata, SubjID=testsubj$SubjID)
testdata <- mutate(testdata, ActID=testact$ActID)

############################################
## All Test data now in tbl_df called "testdata"
## repeat the process for the training data
## result will be in tbl_df called "traindata"
##############################################

traindata <- tbl_df(read.delim("./train/X_train.txt", 
                              header=FALSE, sep="",
                              col.names = Features[,2]))
trainsubj <- tbl_df(read.delim("./train/subject_train.txt",
                              head=FALSE, sep="", col.names="SubjID"))
trainact <- tbl_df(read.delim("./train/y_train.txt",
                             head=FALSE, sep="", col.names="ActID"))

## now merge in the columns for subject and activity into 
## the main set of measurements

traindata <- mutate(traindata, SubjID=trainsubj$SubjID)
traindata <- mutate(traindata, ActID=trainact$ActID)

## Prior to combining the 2 sets of data, SELECT the 
## SubjID, ActID values and subset of columns 
## related to means() and stddevs(). Goal is just to have 2 narrower 
## data sets prior to combining.

s1 <- testdata %>%
      select(SubjID, ActID, matches("mean()"), matches("std()")) %>%
      select(-matches("meanfreq")) %>%
      select(-matches("gravityMean")) %>%
      select(-matches("AccMean")) 
s2 <- traindata %>%
      select(SubjID, ActID, matches("mean()"), matches("std()")) %>%
      select(-matches("meanfreq")) %>%
      select(-matches("gravityMean")) %>%
      select(-matches("AccMean")) 
      

## combine test and training into one "fullset" and remove 
## large objects no longer needed

fullset <- bind_rows(s1, s2)

## remove unneeded files from memory
rm(testdata)
rm(traindata)
rm(Features)
rm(s1)
rm(s2)
rm(testact)
rm(testsubj)
rm(trainact)
rm(trainsubj)

## Now we just have the Activity table and the fullset 
## of combined training and test data
################################################
## Now begin to build more readable variable names
## See README and codebook for detailed discussion


names(fullset) <- sub("Gravity","Grav", names(fullset)) # shorten
names(fullset) <- sub(".mean()","M", names(fullset)) # shorten mean with M
names(fullset) <- sub(".std()","S", names(fullset)) # shorten Std Dev with S
names(fullset) <- sub("t","", names(fullset)) # most measures begin with t
      # because sampled at regular time intervals. No need for t
names(fullset) <- sub("AcID","ActID", names(fullset)) # removing the t changes
      # ActID to AcID. Change it back. 
names(fullset) <- sub("-","", names(fullset)) # remove the hyphen before x, Y, Z


##  Ready to build final tidy dataset of summaries
## First merge the Activity names with the fullset data
merged <- merge(fullset, Activity)


t1 <- merged %>%
      group_by(SubjID) %>%
      group_by(ActID) %>%
      arrange (SubjID, ActID)

tidyset <- t1 %>%
      group_by(SubjID, ActID) %>%
      summarise_each(funs(mean))
                     
# now write out the tidy data set as a csv file
write.table(tidyset, file="tidyset.txt", sep=" ", row.name=FALSE)


######################################################
## template for reading and viewing the file going forward
## Let 'path' represent the directory containing the file 
## this will vary for each user
## Sample code:
##    mydata <- read.table("{path}/tidyset.txt", header=TRUE)
##    View (mydata)


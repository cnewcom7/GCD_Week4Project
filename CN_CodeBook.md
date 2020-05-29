  
This document is the 'code book' for the R-script found alongside in the repo. Each step of the tidying process will be described below. The R-script itself also contains comments describing what each major block of code does throughout and will be similar to what's written here.


## Prior to starting

R and R-studio should be installed already. The 'tidyverse' library package should also be installed to have access to the 'dplyr' package. 


## Data files

The data was provided by the Coursera instructor. It was adapted from the Human Activity Recognition Using Smartphones Dataset (V1.0) from the UCI Machine Learning Repository. The files can be downloaded from the following link: 

``` https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ``` 

For the purposes of this assignment only the following files are required from the zip file:

```activity_labels.txt``` : contains the numeric code conversion key for each of the activities the subjects performed

```features.txt``` : contains information regarding the measurements and the functions applied to them

```./test/X_test.txt``` : contains the raw data for each of the calculations for the 'test' data set

```./test/y_test.txt``` : contains the numeric code for each activity from the 'test' data set

```./test/subject_test.txt``` : contains the numeric identifier for each subject from the 'test' data set

```./train/X_train.txt``` : contains the raw data for each of the calculations for the 'training' data set

```./train/y_train.txt``` : contains the numeric code for each activity from the 'training' data set

```./train/subject_train.txt``` : contains the numeric identifier for each subject from the 'training' data set

## R-Script Description

Note: file locations may need to be adjusted in the R-script as the working directory used may not be exactly what yours is. 
The R-script completes the objectives listed in the assignment guidelines (albeit not entirely in the same order)

## Step 1: Read in raw data files and store them as data tables

```train.Activity ``` : stores the data from 'y_train.txt'

```train.Data``` : stores the data from 'X_train.txt'

```train.Subject``` : stores the data from 'subject_train.txt'

The ```test``` data set is stored in three variables named similarly to the three above, except 'train' is replaced with 'test'. 

```activity.labels``` : stores the conversion key from 'activity_labels.txt'

```features``` : stores the variable names from 'features.txt'


## Step 2: Merge 'training' and 'test' data sets and rename columns and activity IDs


``` merge.Activities``` : stores the merged numerical activity IDs from 'train.Activity' and 'test.Activity'. The numerical values were then converted into actual descriptions using the 'activity.labels' variable

``` merge.Data``` : stores the merged raw data from 'train.Data' and 'test.Data'. Variables names for each column were added using the ```features``` variable and names were converted into valid characters strings.

``` merge.Subjects``` : stores the merged numerical subject IDs from 'train.Subject' and 'test.Subject'

## Step 3: Merge all data together and extract needed data columns

``` Total.Data``` : merges all three tables from Step 2 into a single table

``` Mean.STD.Data ``` : stores only the needed data columns (Activity ID, Subject Number and any raw data columns that contain the string 'mean' or 'std' (standard deviation) ) from the 'Total.Data' table

## Step 4: Calculate the average for all variables for each activity from each subject

``` order.MeanSTD``` : re-orders the 'Mean.STD.Data' variable into groups based off Subject Number and Activity ID

```Avg.SubjAct``` : stores the calculated averages for each variable from the grouped 'order.MeanSTD' data set

## Step 5: Write the tidy data to a new file

```CN_tidydata.txt``` : the outputted text file needed to complete the assignment. It contains 180 total observations across 86 different mean and standard deviation variables (2 additional columns describe the SubjectNumber and ActivityID description). All variable columns are named appropriately and the activites performed have been updated to actual descriptions instead of numerical IDs. 
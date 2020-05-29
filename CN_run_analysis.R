  # Load the tidyverse package which contains dplyr
library(tidyverse)

### Step 1:

# Read in all three files for the 'train' data sets
train.Activity <- read.table('./train/y_train.txt')
train.Data <- read.table('./train/X_train.txt')
train.Subject <- read.table('./train/subject_train.txt')

# Read in all three files for the 'test' data sets
test.Activity <- read.table('./test/y_test.txt')
test.Data <- read.table('./test/X_test.txt')
test.Subject <- read.table('./test/subject_test.txt')

# Read in the files for the 'Activity' key and the IDs for all the features/calculations that were run
activity.labels <- read.table('activity_labels.txt')
features <- read.table('features.txt')

### Step 2:

# Merge the numbers assigned for each 'Activity' from the 'training' and 'test' data sets
# Rename the column from the generic name to 'ActivityID'
# Replace the numeric value for each activity with the true description from the 'activity_labels.txt' file
merge.Activities <- rbind(train.Activity, test.Activity)
colnames(merge.Activities) <- c('ActivityID')
merge.Activities$ActivityID <- activity.labels[merge.Activities$ActivityID, 2]

# Merge the raw numerical data for the 'Training' and 'Test' data sets
# Rename the generic column names to match the features/calcultions from the 'features.txt' file
# Convert all column names to valid names (replaces invalid characters with '.')
merge.Data <- rbind(train.Data, test.Data) 
colnames(merge.Data) <- make.names(names = features$V2, unique = TRUE, allow_ = TRUE)

# Merge the Subject Numbers from the 'training' and 'test' data sets
# Rename its column from the generic assigned name
merge.Subjects <- rbind(train.Subject, test.Subject)
colnames(merge.Subjects) <- c('SubjectNumber')

### Step 3: 

# Combine the Subject Numbers, Activities and the raw data into one data table
# Select out columns for Subject Number, Activities, and the raw data for 'mean' or standard deviation ('std')
Total.Data <- cbind(merge.Subjects, merge.Activities, merge.Data)
Mean.STD.Data <- select(Total.Data, SubjectNumber, ActivityID, contains('mean'), contains('std'))

### Step 4:

# Group the new data table by the SubjectNumber and then the ActivityID for each subject
# Take the average for each feature/calcultion from each Subject for each of the activites they did
order.MeanSTD <- group_by(Mean.STD.Data, SubjectNumber, ActivityID)
Avg.SubjAct <- summarize_all(order.MeanSTD, mean)

### Step 5:

# Create text file with finalized data set
write.table(Avg.SubjAct, file = './Script/CN_tidydata.txt', row.names = FALSE, col.names = TRUE)

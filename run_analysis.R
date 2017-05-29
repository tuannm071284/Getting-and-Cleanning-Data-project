# read X_test.txt into R
x_test <- read.table("E:/Tuan/Data Sci/Get&Cleandata/UCI HAR Dataset/test/X_test.txt")

# read y_test.txt into R
y_test <- read.table("E:/Tuan/Data Sci/Get&Cleandata/UCI HAR Dataset/test/y_test.txt")

# read subject_test.txt into R
subject_test <- read.table("E:/Tuan/Data Sci/Get&Cleandata/UCI HAR Dataset/test/subject_test.txt")

# rename the columns of y_test & subject_test
colnames(y_test)<-"activity"
colnames(subject_test)<-"subject"

#create test dataframe by column-bind subject_test, y_test & x_test
test <- cbind(subject_test,y_test,x_test)

#do the similar things for the train set, we have the train dataframe. 
sub_train <- read.table("E:/Tuan/Data Sci/Get&Cleandata/UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("E:/Tuan/Data Sci/Get&Cleandata/UCI HAR Dataset/train/x_train.txt")
y_train <- read.table("E:/Tuan/Data Sci/Get&Cleandata/UCI HAR Dataset/train/y_train.txt")

colnames(sub_train) <- "subject"
colnames(y_train) <- "activity"

train<-cbind(sub_train,y_train,x_train)

# merge train & test to make one dataframe called raw_data_1
raw_data_1 <- rbind(train,test)

#read the features.txt into R
features <- read.table("E:/Tuan/Data Sci/Get&Cleandata/UCI HAR Dataset/features.txt")

#replace colnames of raw_data_1 by features vector (except subject & activity columns)
c <- as.character(features$V2)
colnames(raw_data_1)[which(names(raw_data_1) != "subject" & names(raw_data_1) != "activity")]<-c

# get the columns which have name contains "mean" or "std"
# create the substet of raw_data_1, which just has "mean" & "std" columns, called raw_data_2
toMatch <- c("mean", "std")
matches <- unique (grep(paste(toMatch,collapse="|"), colnames(raw_data_1)))
matches <- c(1,2,matches)
raw_data_2 <- raw_data_1[,matches]

# replace the activity numbers by the activity names
act_label <- read.table("E:/Tuan/Data Sci/Get&Cleandata/UCI HAR Dataset/activity_labels.txt")#read activity_labels.txt
for(i in 1 : length(raw_data_2$activity))
  {
    raw_data_2$activity[i] = as.character(act_label[raw_data_2$activity[i],2]) 
  }
temp <- raw_data_2
library(dplyr)
tidy = data.frame()

#split temp(raw_data_2) into 30 pieces based on 30 subjects
#in each piece, calculate the means of each column (except subject & activity column) based on activity
#row-bind the results into tidy dataframe
for(i in 1 : 30)
{
  b <- temp[temp$subject == i,]
  tbl_df(b)
  by_act <- group_by(b,activity)
  temp_tidy <-aggregate(.~subject+activity, data=by_act, mean)
  tidy <- rbind(tidy,temp_tidy)
}

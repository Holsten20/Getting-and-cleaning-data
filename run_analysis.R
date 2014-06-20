library(plyr)
library(reshape2)

# Read test data into R
xtest <- read.table("./UCI HAR Dataset/test/X_test.txt",header = FALSE)
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = "Activity_label")
subjecttest <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "Subject")

# Read train data into R.
xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt",header = FALSE)
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt",col.names = "Activity_label")
subjecttrain <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "Subject")


# Read features labels into R. 
features <- read.table("./UCI HAR Dataset/features.txt",)[,"V2"]


# Set descriptive names for all columns in xtest and xtrain datasets.
colnames(xtest) <- features
colnames(xtrain) <- features


# Merge the train and test datasets.
traindata <- cbind(subjecttrain, ytrain, xtrain)
testdata <- cbind(subjecttest, ytest, xtest)
data <- rbind(testdata, traindata)

# Removing characters that are illegal in R names
colnames(data) <- gsub('\\(|\\)',"",names(data), perl = TRUE)
colnames(data) <- gsub('\\-',"",names(data), perl = TRUE)
colnames(data) <- gsub('\\,',"",names(data), perl = TRUE)



# Extracts only columns in data containing measurements on the mean and standard deviation.
meanCol <- grep("[Mm]ean", colnames(data))
stdCol <- grep("[Ss]td", colnames(data))
data2 <- data[ , c(1,2, meanCol, stdCol)]


# Read in activity labels into R.
activities <- read.table("UCI HAR Dataset/activity_labels.txt")

# Set descriptive names for all columns in activities dataset.
colnames(activities) <- c("Activity_label", "Activity")

# Merge activities dataset with  data2 dataset.
data2 <- merge(activities, data2)


# Obtaining the average of each variable for each activity and each subject.
data3 <- ddply(melt(data2, id.vars = c( "Activity", 'Subject')), .(Subject, Activity),summarise, MeanSamples= mean(value))


#Export data into a .txt file.
write.table(data3, "tidydata.txt", sep = "\t")


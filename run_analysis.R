
library(data.table)

# Read test data into R
xtest <- read.table("./UCI HAR Dataset/test/X_test.txt",header = FALSE)
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt",header = FALSE)
subjecttest <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)

# Read train data into R.
xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt",header = FALSE)
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt",header = FALSE)
subjecttrain <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)

# Merge x, y and subject data for both train and test datasets.
xdata <- rbind(xtrain, xtest)
ydata <- rbind(ytrain, ytest)
subject <- rbind(subjecttrain, subjecttest)



# Read features labels into R. 
features <- read.table("./UCI HAR Dataset/features.txt",)[,"V2"]


# Set descriptive names for all columns in xdata, ydata and subject datasets.
colnames(xdata) <- features
colnames(ydata) <- c("act_label")
colnames(subject) <- c("Subject")


# Extracts only columns in xdata containing measurements on the mean and standard deviation.
meanCol <- grep("[Mm]ean", colnames(xdata))
stdCol <- grep("[Ss]td", colnames(xdata))
xdata2 <- xdata[ , c(meanCol, stdCol)]


# Read in activity labels into R.
activities <- read.table("UCI HAR Dataset/activity_labels.txt")

# Set descriptive names for all columns in activities dataset.
colnames(activities) <- c("act_label", "Activity")

# Merge activities dataset with y dataset.
ydata2 <- merge(ydata, activities)

# Merge the xdata, ydata2 and suject datasets.
data1 <- cbind(xdata2, ydata2["Activity"], subject)


# Obtaining the average of each variable for each activity and each subject.
DT <- data.table(data1)
data2 <- DT[, lapply(.SD, mean), by = c("Activity", "Subject")]
data2 <- data2[order(data2$Activity),]


#Export data into a .txt file:
write.table(data2, "tidydata.txt", sep = "\t")


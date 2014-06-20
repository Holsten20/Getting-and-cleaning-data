Getting-and-cleaning-data
=========================

This repository contains the following files:
* README.md
* Codebook.md 
* run_analysis.R
* UCI HAR Dataset
* tidydata.txt
* tidyMean.txt


####run_analysis.R

#####The R script (run_analysis.R) does the following:

 1. Merges the training and the test sets to create one data set.
 2. Extracts only the measurements on the mean and standard deviation for each measurement.
 3. Uses descriptive activity names to name the activities in the data set
 4. Appropriately labels the data set with descriptive activity names.
 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#####Running the script

To run the script, you can clone the repository to your local computer and then copy the UCI HAR Dataset and run_analysis.R script to your R working directory.<br/>
OR download the zip to your local computer and then copy the UCI HAR Dataset and run_analysis.R script to your R working directory. Then source the file locally via
<pre>source (run_analysis.R)
</pre>
This will run the run_analysis.R script, which will read in data from the UCI HAR Dataset and write these files:
* tidydata.txt -- 10.3 Mb, 
* tidyMean.txt -- 7.3 kb, 

The script normally runs for ~30 seconds, but the exact number depends on your system.

For more information about run_analysis, refer to the CodeBook.md

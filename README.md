Getting and Clearing Data Project
=============================
This R script is called run_analysis which clean the data we collected from the accelerometers from the Samsung Galaxy S smartphone by University of California, Irvine. 

The data is stored as a zip file. For this script, you have to unzip the data file, otherwise, it cannot read the data in the file. The defult unzipped file name is "UCI HAR Dateset". 

The script does the followings:

1. It reads the Training set and Test set and combines them into one large set

2. It read the features.txt which contains all features of the data, then it use the features to name the large set.

3. It uses a for loop to find out which column contains the mean and standard diviation for each measurement, and store the column numbers to a vector. 

4. It extracts only the measurements of the mean and standard diviation by using the vector in 3. 

5. It reads the train/subject_train.txt and test/subject_test.txt to get the subjects for the set and combines the subjests to the large set.

6. It reads the train/y_train.txt and test/y_test.txt to get the activitiy lable of the two sets. 

7. It reads the activity_labels.txt to get the activity labels in words, and uses a for loop to replace all activity labels from number to words. 

8. It combines the activity labels and the large set, then it reordes the set by the activity labels and the subject labels.

9. It splits the set by the activity labels and the subject labels, then by using the for loop, it finds the mean values for each measurement with the unique activity and suject and stores the mean values to a data frame called table.

10. It returns table as it is the final clearned data. 

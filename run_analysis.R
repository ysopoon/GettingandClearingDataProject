run_analysis <- function(directory = "./UCI HAR Dataset"){
    library(plyr)
    
    ## read the table of the train set
    filename <- paste(directory, "/train/X_train.txt", sep = "")
    train <- read.table(filename)
    
    ## read the table of the test set
    filename <- paste(directory, "/test/X_test.txt", sep = "")
    test <- read.table(filename)
    
    ## read the lables of each column
    filename <- paste(directory, "/features.txt", sep = "")
    features <- read.table(filename)

    ## merges 2 sets into one set
    data <- rbind(train, test)
    names(data) <- features[,2]
    
    ## check which column contains mean or std of the measurement
    contain <- vector() #create a null vector
    for(i in 1:length(features[,2])){
        if(grepl('-mean()', features[i,2],fixed = TRUE) || grepl("-std()", features[i,2], fixed = TRUE)){
            contain <- c(contain, i)
        } #end of if
    } #end of for
    
    ## Extracts the mean and std for each measurement
    data <- data[,contain]
    
    ## read the subject lables for the set
    filename <- paste(directory, "/train/subject_train.txt", sep = "")
    train_sub <- read.table(filename)
    filename <- paste(directory, "/test/subject_test.txt", sep = "")
    test_sub <- read.table(filename)
    
    ## combind two subjects into one
    subject <- rbind(train_sub, test_sub)
    names(subject) <- "Subject"
    
    ## combind the subject to the left most of the data
    data <- cbind(subject, data)
    
    ## read the activity labels for the two sets
    filename <- paste(directory, "/train/y_train.txt", sep = "")
    trainlb <- read.table(filename, colClasses = "character")
    filename <- paste(directory, "/test/y_test.txt", sep = "")
    testlb <- read.table(filename, colClasses = "character")
    
    ## combind the activity labels of two sets into one
    Activity.Label <- rbind(trainlb, testlb)
    
    ## read the activity name labels
    filename <- paste(directory, "/activity_labels.txt", sep = "")
    labels <- read.table(filename, colClasses = "character")
    
    ## replace the labels with the names
    for(i in 1:length(labels[,1])){
        Activity.Label <- apply(Activity.Label, 1, function(x) replace(x, x == labels[i,1], labels[i,2]))
        Activity.Label <- as.data.frame(Activity.Label)
    } #end of for
    
    ## combind with the label in the leftmost side of data
    data <- cbind(Activity.Label,data)
    data <- arrange(data, data$Activity.Label, data$Subject)
    
    ## create a data frame to store the final tidy data
    table <- data.frame()
    
    ## split the data according to the activity label
    data <- split(data, data$Activity.Label)
    
    ## for each activity, find the mean of each variable and store in the data frame
    for(i in 1:length(data)){
        subdata <- split(data[[i]],data[[i]][[2]])
        for(j in 1:length(subdata)){
            subsubdt <- as.data.frame(subdata[[j]])
            ave <- colMeans(subsubdt[,2:length(subsubdt[1,])])
            table <-
                rbind(table, cbind(Activity = subdata[[j]][[1]][[1]], as.data.frame(t(ave))))
        } #end of inner for
    } #end of for

     table
}

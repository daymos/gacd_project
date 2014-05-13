

                  CODEBOOK
                  
                  Relevant variables:
                  
                  - data1     merged data from test and train
                  - data4     mean and standard deviation for each variable
                  - res     with average values for each activity for each test performer
                  
                  
                  the tidy data set is exported into tidyDataSet.txt in the folder where the script is executed
                  
                  
                  Functioning
                  
                  The script is extensively commented. For detailed information on a specific bit of code please look into the script.
                  Here I describe the general functioning.
                  
                  The code is divided in 5 parts separated by lines of hashtag.
                  
                  The individual  parts performs the following tasks:
                  
                  
                1- Merges the training and the test sets to create one data set.
                2 - Extracts only the measurements on the mean and standard deviation for each measurement. 
                3 - Uses descriptive activity names to name the activities in the data set
                4 - Appropriately labels the data set with descriptive activity names. 
                5 - Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

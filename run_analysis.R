## Hello! Thank you for revewing my work.
## First I read in R all the files that I thought I will need. 
## Every time I made sure I am in the correct working directory. 
> x_test<-read.table("X_test.txt")
> y_test<-read.table("y_test.txt")
> subject_test<-read.table("subject_test.txt")
> x_train<-read.table("X_train.txt")
> y_train<-read.table("y_train.txt")
> subject_train<-read.table("subject_train.txt")
> features<-read.table("features.txt")
## Used a lot of dim() and str() and head() at all steps to see 
## the dimension for all this data.
## Then I rbind() -ed tests with trains, for x, y and subjects
> x<-rbind(x_test, x_train)
> y<-rbind(y_test, y_train)
> subject<-rbind(subject_test, subject_train)
## I decided to colnames(x) with 'features',
## but first made sure 'features is character class.
> feat<-as.character(featuresV2) ## V1 was just 1,2,3,4 ... nevermind
> colnames(x)<-feat
## Then I cbind() -ed x and y and conames() for Y with "Activity"
> xy<-cbind(x,y)
## Then cbind() - ed xy with the subject and colnames() for this new variable.
> DF<-cbind(xy,subject)
> colnames(DF)[563] <-"subject"
## when checked for head(DF) didn't like how it looked. 
## I thought that the subject and activity would look better 
## at the begining of the table. So went reordering the columns 
## (googled how to do it, bien sur)
> DF1<-DF[,c(563,562,1:561)]
## Then I thought that it would be nice to have the name of the activity 
## instead of its number, 
## and it is also the 3rd task 
> DF1$Activity[DF1$Activity == "1"]<-"WALKING"
> DF1$Activity[DF1$Activity == "5"]<-"STANDING"  ## 5 was in the head(DF1$Activity) si I could check
> DF1$Activity[DF1$Activity == "2"]<-"WALKING_UPSTAIRS"
> DF1$Activity[DF1$Activity == "3"]<-"WALKING_DOWNSTAIRS"
> DF1$Activity[DF1$Activity == "4"]<-"SITTING"
> DF1$Activity[DF1$Activity == "6"]<-"LAYING"
## For step 2, to extract mean and std variables I use select()
> DF2<-select(DF1, matches("subject"),matches("Activity"), starts_with("tBodyAcc-mean()-X"),contains("mean"), contains("std"))
## I named the columns with the descriptive variable names before so I will go to step 5
## But before that I decide to save this data frame DF2
> write.table(DF2, file = "DF2", sep = " ", row.names = FALSE)
## At this point I also arranged the data by 'subject'
> DF3<-arrange(DF2, subject)
## Then I create a tidy data set with the average of each variable 
## for each activity and each subject
> DF4<-DF3 %>% group_by(subject, Activity)
> DF5<-DF4 %>% summarise_each(funs(mean))
## Checked the table to see if it is what I was looking for:
> dim(DF5)
## result: [1] 150  88
> head(DF5) [1:5]
## the result was ok:
  subject           Activity tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z
1       1             LAYING         0.2215982      -0.040513953        -0.1132036
2       1            SITTING         0.2706080      -0.009167818        -0.1077547
3       1            WALKING         0.2773308      -0.017383819        -0.1111481
4       1 WALKING_DOWNSTAIRS         0.2891883      -0.009918505        -0.1075662
5       1   WALKING_UPSTAIRS         0.2554617      -0.023953149        -0.0973020
6       2             LAYING         0.2813734      -0.018158740        -0.1072456

## And in the end I saved this new tidy data
> write.table(DF5, file = "DF5", sep = " ", row.names = FALSE)
## The end. Cheers!








library(plyr)
ActivityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
FeatureList <- read.table("UCI HAR Dataset/features.txt")
TrainLabels <- read.table("UCI HAR Dataset/train/y_train.txt")
TrainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
TrainData <- read.table("UCI HAR Dataset/train/x_train.txt")
TestLabels <- read.table("UCI HAR Dataset/test/y_test.txt")
TestSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
TestData <- read.table("UCI HAR Dataset/test/x_test.txt")
names(TrainData) <- FeatureList[,2]
names(TestData) <- FeatureList[,2]
Extract_Cols <- grep("mean|std",names(TrainData))
TrainData <- TrainData[,Extract_Cols]
TestData <- TestData[,Extract_Cols]
Extract_Cols <- grep("Freq",names(TrainData))
Extract_Cols <- Extract_Cols * -1
TrainData <- TrainData[,Extract_Cols]                     
TestData <- TestData[,Extract_Cols] 
BindedTrain <- cbind(TrainSubjects,TrainLabels,TrainData)
BindedTest <- cbind(TestSubjects,TestLabels,TestData)
names(BindedTrain) <- c("Subject_No","Activity_No",names(TrainData))
names(BindedTest) <- c("Subject_No","Activity_No",names(TestData))
names(ActivityLabels) <- c("Activity_No","Activity_Type")
MergeTrain <- merge(BindedTrain,ActivityLabels)
MergeTest <- merge(BindedTest,ActivityLabels)
AllData <- rbind(MergeTrain,MergeTest)
AllData <- AllData[,c(2,69,3:68)]
DataMelt <- melt(AllData,id=c("Subject_No","Activity_Type"),measure.vars=c(names(AllData[,3:68])))
FinalData <- dcast(DataMelt,Subject_No+Activity_Type ~ variable,mean)
write.table(FinalData,"Project_Data.txt",row.names=F)

#0. load original data values of size 10352*17
original <- readRDS("/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/mimic/amino transferase/dataoriginal10352*17.rds")

#1. remove sequences with just 2 non-zero values
count <- 0
for (i in 1:nrow(original)) {
  if (count == 0 & original[i, 5] != 0){
    originaldata <- original[i,]
    count <- 1
  }
  else if (count > 0 & original[i, 5] == 0 & original[i,6] != 0){
    originaldata <- rbind(originaldata, original[i,]) 
  }
  else if(count > 0 & original[i, 5] != 0){
    originaldata <- rbind(originaldata, original[i,]) #5864
  }
}

#1a. to count how many sequences are there for both the diagnoses
sum(originaldata$y_LABEL == 0) #2,103 chronic liver
sum(originaldata$y_LABEL == 1) #3,761 heart failure

#2. to have almost equal size of datasets i.e. to remove 760 values of heart failure 
#2a. create subsets
chronicdata <- subset(originaldata, originaldata$y_LABEL == 0)
heartdata <- subset(originaldata, originaldata$y_LABEL == 1)

#2b. shuffle heartdata
heartdata <- heartdata[sample(nrow(heartdata)),]

#2c. remove 760 observations from heartdata
heartdata <- heartdata[761:3761,] #3,001

#2d. group data
originaldata <- rbind(chronicdata, heartdata)


#3. creating 4 cross validation sets 
#3a. shuffling the final data
dataoriginalShuffle <- originaldata[sample(nrow(originaldata)),]

#3b. creating and saving crossvalidation set 1 (1276 rows)
crossoriginal1 <- dataoriginalShuffle[1:1276,]
write(t(crossoriginal1),"/home/pinkpanther/Documents/Studies/Semester 6 & 7 - Master Thesis/Data/octave/mimic/amino transferase/originalData/crossbetter2original1.csv",ncolumns = 17,sep = ",") #easy to read in matlab/octave
saveRDS(crossoriginal1, "/home/pinkpanther/Documents/Studies/Semester 6 & 7 - Master Thesis/Data/r/mimic/amino transferase/crossbetter2original1.rds") #easier to read in R

#3c. creating and saving crossvalidation set 2 (1276 rows)
crossoriginal2 <- dataoriginalShuffle[1277:2552,]
write(t(crossoriginal2),"/home/pinkpanther/Documents/Studies/Semester 6 & 7 - Master Thesis/Data/octave/mimic/amino transferase/originalData/crossbetter2original2.csv",ncolumns = 17,sep = ",") #easy to read in matlab/octave
saveRDS(crossoriginal2, "/home/pinkpanther/Documents/Studies/Semester 6 & 7 - Master Thesis/Data/r/mimic/amino transferase/crossbetter2original2.rds") #easier to read in R

#3d. creating and saving crossvalidation set 3 (1276 rows)
crossoriginal3 <- dataoriginalShuffle[2553:3828,]
write(t(crossoriginal3),"/home/pinkpanther/Documents/Studies/Semester 6 & 7 - Master Thesis/Data/octave/mimic/amino transferase/originalData/crossbetter2original3.csv",ncolumns = 17,sep = ",") #easy to read in matlab/octave
saveRDS(crossoriginal3, "/home/pinkpanther/Documents/Studies/Semester 6 & 7 - Master Thesis/Data/r/mimic/amino transferase/crossbetter2original3.rds") #easier to read in R

#3e. creating and saving crossvalidation set 4 (1276 rows)
crossoriginal4 <- dataoriginalShuffle[3829:5104,]
write(t(crossoriginal4),"/home/pinkpanther/Documents/Studies/Semester 6 & 7 - Master Thesis/Data/octave/mimic/amino transferase/originalData/crossbetter2original4.csv",ncolumns = 17,sep = ",") #easy to read in matlab/octave
saveRDS(crossoriginal4, "/home/pinkpanther/Documents/Studies/Semester 6 & 7 - Master Thesis/Data/r/mimic/amino transferase/crossbetter2original4.rds") #easier to read in R


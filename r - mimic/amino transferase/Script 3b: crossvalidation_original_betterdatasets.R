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

#2. creating 4 cross validation sets 
#2a. shuffling the final data
dataoriginalShuffle <- originaldata[sample(nrow(originaldata)),]

#2b. creating and saving crossvalidation set 1 (1466 rows)
crossoriginal1 <- dataoriginalShuffle[1:1466,]
write(t(crossoriginal1),"/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/mimic/amino transferase/crossbetteroriginal1.csv",ncolumns = 17,sep = ",") #easy to read in matlab/octave
saveRDS(crossoriginal1, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/mimic/amino transferase/crossbetteroriginal1.rds") #easier to read in R

#2c. creating and saving crossvalidation set 2 (1466 rows)
crossoriginal2 <- dataoriginalShuffle[1467:2932,]
write(t(crossoriginal2),"/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/mimic/amino transferase/crossbetteroriginal2.csv",ncolumns = 17,sep = ",") #easy to read in matlab/octave
saveRDS(crossoriginal2, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/mimic/amino transferase/crossbetteroriginal2.rds") #easier to read in R

#2d. creating and saving crossvalidation set 3 (1466 rows)
crossoriginal3 <- dataoriginalShuffle[2933:4398,]
write(t(crossoriginal3),"/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/mimic/amino transferase/crossbetteroriginal3.csv",ncolumns = 17,sep = ",") #easy to read in matlab/octave
saveRDS(crossoriginal3, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/mimic/amino transferase/crossbetteroriginal3.rds") #easier to read in R

#2e. creating and saving crossvalidation set 4 (1466 rows)
crossoriginal4 <- dataoriginalShuffle[4399:5864,]
write(t(crossoriginal4),"/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/mimic/amino transferase/crossbetteroriginal4.csv",ncolumns = 17,sep = ",") #easy to read in matlab/octave
saveRDS(crossoriginal4, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/mimic/amino transferase/crossbetteroriginal4.rds") #easier to read in R

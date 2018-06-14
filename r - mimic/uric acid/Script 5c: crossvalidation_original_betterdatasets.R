#0. load original data values of size 813*17
original <- readRDS("/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/originalData/original813*17.rds")

#1. remove sequences with just 2 non-zero values
count <- 0
for (i in 1:nrow(original)) {
  if (count == 0 & original[i, 5] != 0){
    originaldata <- original[i,]
    count <- 1
  }
  else if(count > 0 & original[i, 5] != 0){
    originaldata <- rbind(originaldata, original[i,]) #462
  }
}

#2. creating 3 cross validation sets 
#2a. shuffling the final data
dataoriginalShuffle <- originaldata[sample(nrow(originaldata)),]

#2b. creating and saving crossvalidation set 1 (154 rows)
crossoriginal1 <- dataoriginalShuffle[1:154,]
write(t(crossoriginal1),"/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/originalData/crossbetteroriginal1.csv",ncolumns = 17,sep = ",") #easy to read in matlab/octave
saveRDS(crossoriginal1, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/originalData/crossbetteroriginal1.rds") #easier to read in R

#2c. creating and saving crossvalidation set 2 (154 rows)
crossoriginal2 <- dataoriginalShuffle[155:308,]
write(t(crossoriginal2),"/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/originalData/crossbetteroriginal2.csv",ncolumns = 17,sep = ",") #easy to read in matlab/octave
saveRDS(crossoriginal2, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/originalData/crossbetteroriginal2.rds") #easier to read in R

#2d. creating and saving crossvalidation set 3 (154 rows)
crossoriginal3 <- dataoriginalShuffle[309:462,]
write(t(crossoriginal3),"/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/originalData/crossbetteroriginal3.csv",ncolumns = 17,sep = ",") #easy to read in matlab/octave
saveRDS(crossoriginal3, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/originalData/crossbetteroriginal3.rds") #easier to read in R

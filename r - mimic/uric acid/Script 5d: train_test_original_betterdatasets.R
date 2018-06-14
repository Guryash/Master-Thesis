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

#2. creating train and test sets 
#2a. shuffling the final data
dataoriginalShuffle <- originaldata[sample(nrow(originaldata)),]

#5b. creating and saving training set (70% of final data i.e 70% of 813 rows = 569)
trainoriginal <- dataoriginalShuffle[1:323,]
write(t(trainoriginal),"/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/originalData/trainbetteroriginal.csv",ncolumns = 17,sep = ",") #easy to read in matlab/octave
saveRDS(trainoriginal, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/originalData/trainbetteroriginal.rds") #easier to read in R

#5c. creating and saving remaining rows as testing set 
testoriginal <- dataoriginalShuffle[324:462,]
write(t(testoriginal),"/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/originalData/testbetteroriginal.csv",ncolumns = 17,sep = ",") #easy to read in matlab/octave
saveRDS(testoriginal, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/originalData/testbetteroriginal.rds") #easier to read in R

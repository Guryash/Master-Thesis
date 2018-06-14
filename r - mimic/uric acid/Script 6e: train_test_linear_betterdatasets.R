#0. load linear data values of size 813*17
linear <- readRDS("/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/linearData/datalinear813*17.rds")

#1. remove sequences with just 2 non-zero values
count <- 0
for (i in 1:nrow(linear)) {
  if (count == 0 & linear[i, 5] != 0){
    lineardata <- linear[i,]
    count <- 1
  }
  else if(count > 0 & linear[i, 5] != 0){
    lineardata <- rbind(lineardata, linear[i,]) #462
  }
}

#2. creating train and test sets  
#2a. shuffling the final data
datalinearShuffle <- lineardata[sample(nrow(lineardata)),]

#2b. creating and saving training set (70% of final data i.e 70% of 813 rows = 569)
trainlinear <- datalinearShuffle[1:323,]
write(t(trainlinear),"/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/linearData/trainbetterlinear.csv",ncolumns = 17,sep = ",") #easy to read in matlab/octave
saveRDS(trainlinear, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/linearData/trainbetterlinear.rds") #easier to read in R

#2c. creating and saving crossvalidation set 2 (154 rows)
testlinear <- datalinearShuffle[324:462,]
write(t(testlinear),"/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/linearData/testbetterlinear.csv",ncolumns = 17,sep = ",") #easy to read in matlab/octave
saveRDS(testlinear, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/linearData/testbetterlinear.rds") #easier to read in R

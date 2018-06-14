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

#2. creating 3 cross validation sets 
#2a. shuffling the final data
datalinearShuffle <- lineardata[sample(nrow(lineardata)),]

#2b. creating and saving crossvalidation set 1 (154 rows)
crosslinear1 <- datalinearShuffle[1:154,]
write(t(crosslinear1),"/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/linearData/crossbetterlinear1.csv",ncolumns = 17,sep = ",") #easy to read in matlab/octave
saveRDS(crosslinear1, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/linearData/crossbetterlinear1.rds") #easier to read in R

#2c. creating and saving crossvalidation set 2 (154 rows)
crosslinear2 <- datalinearShuffle[155:308,]
write(t(crosslinear2),"/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/linearData/crossbetterlinear2.csv",ncolumns = 17,sep = ",") #easy to read in matlab/octave
saveRDS(crosslinear2, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/linearData/crossbetterlinear2.rds") #easier to read in R

#2d. creating and saving crossvalidation set 3 (154 rows)
crosslinear3 <- datalinearShuffle[309:462,]
write(t(crosslinear3),"/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/linearData/crossbetterlinear3.csv",ncolumns = 17,sep = ",") #easy to read in matlab/octave
saveRDS(crosslinear3, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/linearData/crossbetterlinear3.rds") #easier to read in R

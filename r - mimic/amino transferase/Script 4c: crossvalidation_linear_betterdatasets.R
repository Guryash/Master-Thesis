#0. load linear data values of size 10352*17
linear <- readRDS("/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/mimic/amino transferase/datalinear10352*17.rds")

#1. remove sequences with just 2 non-zero values
count <- 0
for (i in 1:nrow(linear)) {
  if (count == 0 & linear[i, 5] != 0){
    lineardata <- linear[i,]
    count <- 1
  }
  else if(count > 0 & linear[i, 5] != 0){
    lineardata <- rbind(lineardata, linear[i,]) #5864
  }
}

#2. creating 4 cross validation sets 
#2a. shuffling the final data
datalinearShuffle <- lineardata[sample(nrow(lineardata)),]

#2b. creating and saving crossvalidation set 1 (1466 rows)
crosslinear1 <- datalinearShuffle[1:1466,]
write(t(crosslinear1),"/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/mimic/amino transferase/crossbetterlinear1.csv",ncolumns = 17,sep = ",") #easy to read in matlab/octave
saveRDS(crosslinear1, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/mimic/amino transferase/crossbetterlinear1.rds") #easier to read in R

#2c. creating and saving crossvalidation set 2 (1466 rows)
crosslinear2 <- datalinearShuffle[1467:2932,]
write(t(crosslinear2),"/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/mimic/amino transferase/crossbetterlinear2.csv",ncolumns = 17,sep = ",") #easy to read in matlab/octave
saveRDS(crosslinear2, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/mimic/amino transferase/crossbetterlinear2.rds") #easier to read in R

#2d. creating and saving crossvalidation set 3 (1466 rows)
crosslinear3 <- datalinearShuffle[2933:4398,]
write(t(crosslinear3),"/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/mimic/amino transferase/crossbetterlinear3.csv",ncolumns = 17,sep = ",") #easy to read in matlab/octave
saveRDS(crosslinear3, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/mimic/amino transferase/crossbetterlinear3.rds") #easier to read in R

#2e. creating and saving crossvalidation set 4 (1466 rows)
crosslinear4 <- datalinearShuffle[4399:5864,]
write(t(crosslinear4),"/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/mimic/amino transferase/crossbetterlinear4.csv",ncolumns = 17,sep = ",") #easy to read in matlab/octave
saveRDS(crosslinear4, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/mimic/amino transferase/crossbetterlinear4.rds") #easier to read in R

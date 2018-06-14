#1. load original data values of size 813*17
original <- readRDS("/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/originalData/original813*17.rds")

#2. creating 3 cross validation sets 
#2a. shuffling the final data
dataoriginalShuffle <- original[sample(nrow(original)),]

#2b. creating and saving crossvalidation set 1 (271 rows)
crossoriginal1 <- dataoriginalShuffle[1:271,]
write(t(crossoriginal1),"/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/originalData/crossoriginal1.csv",ncolumns = 17,sep = ",") #easy to read in matlab/octave
saveRDS(crossoriginal1, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/originalData/crossoriginal1.rds") #easier to read in R

#2c. creating and saving crossvalidation set 2 (271 rows)
crossoriginal2 <- dataoriginalShuffle[272:542,]
write(t(crossoriginal2),"/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/originalData/crossoriginal2.csv",ncolumns = 17,sep = ",") #easy to read in matlab/octave
saveRDS(crossoriginal2, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/originalData/crossoriginal2.rds") #easier to read in R

#2d. creating and saving crossvalidation set 3 (271 rows)
crossoriginal3 <- dataoriginalShuffle[543:813,]
write(t(crossoriginal3),"/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/originalData/crossoriginal3.csv",ncolumns = 17,sep = ",") #easy to read in matlab/octave
saveRDS(crossoriginal3, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/originalData/crossoriginal3.rds") #easier to read in R

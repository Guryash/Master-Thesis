#1. load linear data values of size 813*17
linear <- readRDS("/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/linearData/datalinear813*17.rds")

#2. creating 3 cross validation sets 
#2a. shuffling the final data
datalinearShuffle <- linear[sample(nrow(linear)),]

#2b. creating and saving crossvalidation set 1 (271 rows)
crosslinear1 <- datalinearShuffle[1:271,]
write(t(crosslinear1),"/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/linearData/crosslinear1.csv",ncolumns = 17,sep = ",") #easy to read in matlab/octave
saveRDS(crosslinear1, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/linearData/crosslinear1.rds") #easier to read in R

#2c. creating and saving crossvalidation set 2 (271 rows)
crosslinear2 <- datalinearShuffle[272:542,]
write(t(crosslinear2),"/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/linearData/crosslinear2.csv",ncolumns = 17,sep = ",") #easy to read in matlab/octave
saveRDS(crosslinear2, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/linearData/crosslinear2.rds") #easier to read in R

#2d. creating and saving crossvalidation set 3 (271 rows)
crosslinear3 <- datalinearShuffle[543:813,]
write(t(crosslinear3),"/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/linearData/crosslinear3.csv",ncolumns = 17,sep = ",") #easy to read in matlab/octave
saveRDS(crosslinear3, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/linearData/crosslinear3.rds") #easier to read in R

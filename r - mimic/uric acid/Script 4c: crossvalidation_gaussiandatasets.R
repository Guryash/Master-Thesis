#1a. load gaussian data values of size 813*16
gaussian <- readRDS("/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/gaussianData/gaussian813*17.rds")

#1b. load leukemia IDs
finalLeukemia <- readRDS("/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/finalLeukemia.rds")


#2. creating 3 cross validation sets 
#3a. shuffling the final data
datagaussianShuffle <- gaussian[sample(nrow(gaussian)),]

#2b. creating and saving crossvalidation set 1 (271 rows)
crossgaussian1 <- datagaussianShuffle[1:271,]
write(t(crossgaussian1),"/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/gaussianData/crossgaussian1.csv",ncolumns = 17,sep = ",") #easy to read in matlab/octave
saveRDS(crossgaussian1, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/gaussianData/crossgaussian1.rds") #easier to read in R

#2c. creating and saving crossvalidation set 2 (271 rows)
crossgaussian2 <- datagaussianShuffle[272:542,]
write(t(crosslinear2),"/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/gaussianData/crossgaussian2.csv",ncolumns = 17,sep = ",") #easy to read in matlab/octave
saveRDS(crosslinear2, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/gaussianData/crossgaussian2.rds") #easier to read in R

#2d. creating and saving crossvalidation set 3 (271 rows)
crossgaussian3 <- datagaussianShuffle[543:813,]
write(t(crossgaussian3),"/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/gaussianData/crossgaussian3.csv",ncolumns = 17,sep = ",") #easy to read in matlab/octave
saveRDS(crossgaussian3, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/gaussianData/crossgaussian3.rds") #easier to read in R

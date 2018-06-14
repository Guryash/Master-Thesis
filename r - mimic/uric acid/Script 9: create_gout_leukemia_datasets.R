#0a. load pre-processed gaussian dataset of size 813*16
datagau <- readRDS("/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/datagau813*16.rds")

#0b. load final gout codes
finalGout <- readRDS("/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/finalGout.rds")

#0c. load final leukemia codes
finalLeukemia <- readRDS("/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/finalLeukemia.rds")

#1. creating gout and leukemia datasets
goutset <- datagau[0,]
leukemiaset <- datagau[0,]

for(i in 1:nrow(finalLeukemia)){
  sample <- subset(datagau, datagau$SUBJECT_ID==finalLeukemia[i,2])
  if (i==1){
    leukemiaset <- sample
  }
  else{
    leukemiaset <- rbind(leukemiaset, sample) #495
  }
  datagau <- subset(datagau, datagau$SUBJECT_ID!=finalLeukemia[i,2])
}

goutset <- datagau #318

#2a. save gout dataset
saveRDS(goutset, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/datagout.rds")
write(t(goutset),"/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/datagout.csv",ncolumns = 16,sep = ",") #easy to read in matlab/octave

#2b. save leukemia dataset
saveRDS(leukemiaset, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/dataleukemia.rds")
write(t(leukemiaset),"/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/dataleukemia.csv",ncolumns = 16,sep = ",") #easy to read in matlab/octave

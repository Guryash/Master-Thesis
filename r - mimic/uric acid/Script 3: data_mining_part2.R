#0a. save final gout codes
saveRDS(finalGout, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/finalGout.rds")

#0b. save final leukemia codes
saveRDS(finalLeukemia, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/finalLeukemia.rds")

#0c. save final diagnoses
saveRDS(finalDiagnoses, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/finalDiagnoses.rds")

#0d. save final uric acid measurements
saveRDS(finalUricAcid, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/finalUricAcid.rds")

#1. add class labels 
exampleAddColumn <- finalUricAcid #sorted uric acid
exampleAddColumn <- cbind(CLASS_LABEL=0,exampleAddColumn)
for (i in 1:nrow(exampleAddColumn)){
  for (j in 1:nrow(finalGout)){
    if (finalGout[j,2]==exampleAddColumn[i,3] && finalGout[j,3]==exampleAddColumn[i,4]){
      exampleAddColumn$CLASS_LABEL[i] <- 'gout'
      print(exampleAddColumn[i,1])
      break
    }
  }
  if(exampleAddColumn[i,1] == 0){
    exampleAddColumn[i,1] <- 'leukemia'
    print(exampleAddColumn[i,1])
  }
}

#2. add time frame to find days
exampleAddColumn <- cbind(TIMEFRAME=0,exampleAddColumn) 
count <- 0
for (i in 1:nrow(exampleAddColumn)){
  if (exampleAddColumn$SUBJECT_ID[i-1] == exampleAddColumn$SUBJECT_ID[i] && i > 1){
    count <- count + 1
    days <- as.Date(exampleAddColumn$CHARTTIME[i]) - as.Date(exampleAddColumn$CHARTTIME[i - count])
    dtime <- strptime(exampleAddColumn$CHARTTIME[i], "%Y-%m-%d %H:%M:%S")
    days <- days + sapply(strsplit(format(dtime, "%H:%M:%S"),":"),function(x) {
      x <- as.numeric(x)
      (x[1]+x[2]/60+x[3]/3600)/24 } )
    exampleAddColumn$TIMEFRAME[i] <- round(days, digits=2)
  }
  else if (exampleAddColumn$SUBJECT_ID[i-1] != exampleAddColumn$SUBJECT_ID[i] && i > 1){
    count <- 0
  }
}

#3. time warping function like in the paper d' = d^a + b where a=3 b=0
exampleAddColumn <- cbind(TIMEWARPING=0,exampleAddColumn) 
for (i in 1:nrow(exampleAddColumn)){
  if (exampleAddColumn$SUBJECT_ID[i-1] == exampleAddColumn$SUBJECT_ID[i] && i > 1){
    distance <- exampleAddColumn$TIMEFRAME[i] - exampleAddColumn$TIMEFRAME[i-1]
    newDistance <- distance^(1/3) + 0
    exampleAddColumn$TIMEWARPING[i] <- round(newDistance, digits=2)
  }
}

#4a. save final dataset
saveRDS(exampleAddColumn, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/uricConcentrations_Timeframe.rds")

#4b. load final dataset
exampleAddColumn <- readRDS("/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/uricConcentrations_Timeframe.rds")




#1a. load the data 
aminotransferaseFinal <- readRDS("/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/mimic/amino transferase/aminotransferaseFinal.rds")

#1b. order according to chartime
aminotransferaseFinal <- aminotransferaseFinal[order(aminotransferaseFinal[,c('SUBJECT_ID')], aminotransferaseFinal[,c('CHARTTIME')]),] #56,321

#2. add Time frame in days
aminotransferaseFinal <- cbind(TIMEFRAME=0,aminotransferaseFinal) 
count <- 0
for (i in 1:nrow(aminotransferaseFinal)){
  if (aminotransferaseFinal$SUBJECT_ID[i-1] == aminotransferaseFinal$SUBJECT_ID[i] && i > 1){
    count <- count + 1
    days <- as.Date(aminotransferaseFinal$CHARTTIME[i]) - as.Date(aminotransferaseFinal$CHARTTIME[i - count])
    dtime <- strptime(aminotransferaseFinal$CHARTTIME[i], "%Y-%m-%d %H:%M:%S")
    days <- days + sapply(strsplit(format(dtime, "%H:%M:%S"),":"),function(x) {
      x <- as.numeric(x)
      (x[1]+x[2]/60+x[3]/3600)/24 } )
    aminotransferaseFinal$TIMEFRAME[i] <- round(days, digits=2)
  }
  else if (aminotransferaseFinal$SUBJECT_ID[i-1] != aminotransferaseFinal$SUBJECT_ID[i] && i > 1){
    count <- 0
  }
}

#3. save data 
saveRDS(aminotransferaseFinal, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/mimic/amino transferase/aminotransferaseFinal_Timeframe.rds")


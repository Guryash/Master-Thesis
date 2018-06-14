#1a. load the data 
aminotransferaseFinal <- readRDS("/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/mimic/amino transferase/lineardata.rds")
diagnosesFinal <- readRDS("/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/mimic/amino transferase/diagnosesFinal.rds")

#1b. number of unique patients and order the data 
diagnosesFinalUnique <- diagnosesFinal[!duplicated(diagnosesFinal[,c('SUBJECT_ID')]),] #8,971

#2. to store alanine aminotransfrase measurements one patient per row
#2a. defining data frame of size of numberofrows(diagnosesFinalUnique)*1 i.e. 8971*1
linearvalues <- matrix(rep(0), nrow=nrow(diagnosesFinalUnique))
linearvalues <- as.data.frame(linearvalues)

#2b. defining variable var to store number of non-zeros columns per row 
var <- matrix(rep(0), nrow=nrow(diagnosesFinalUnique))

#2c. to put only original regression values of 8971 patients in linearvalues frame and to put zeros for the columns of the patients which doesnot have linear values
for (i in 1:nrow(diagnosesFinalUnique)){
  sample <- subset(aminotransferaseFinal, aminotransferaseFinal$SUBJECT_ID==diagnosesFinalUnique[i,2])
  var[i] <- nrow(sample)
  if(ncol(linearvalues) < nrow(sample)){
    temp <- matrix(rep(0), nrow= nrow(linearvalues), ncol = nrow(sample)-ncol(linearvalues))
    temp <- as.data.frame(temp)
    linearvalues <- cbind(linearvalues,temp)
    for (j in 1:nrow(sample)){
      linearvalues[i,j] <- sample[j,1]
    }
  }
  else{
    for (j in 1:nrow(sample)){
      linearvalues[i,j] <- sample[j,1]
    }
  }
}

dim(linearvalues) #dimension of linearvalues 8971*179

#2d. defining temp variable of size 8971*1 to increase the size of linearvalues variable in the step 3 (ceiling function)
temp <- matrix(rep(0), nrow=nrow(diagnosesFinalUnique), ncol=1)
temp <- as.data.frame(temp)

#2e. adding subject id column to the data variable and increasing its size from 8971*179 to 8971*181
linearvalues <- cbind(diagnosesFinalUnique[,2], linearvalues, temp)
colnames(linearvalues) <- c("SUBJECT_ID") #change first column name

#3. slicing 181 columns per row to 16 columns per row where 1st column is subject id and the remaining associated linear regression values
# and for ids with less non-zero values are not spread into multiple rows 
#3a. defining variable var2 to store the number of rows the linear regression values of a patient are fanned-out
var2 <- matrix(rep(0), nrow=nrow(diagnosesFinalUnique))

#3b. slicing of 181 columns in order to increase the number of examples from 8971 to 10352 and to decrease the sample size to 181 to 16
for (i in 1:nrow(diagnosesFinalUnique)){
  sample <- subset(linearvalues, linearvalues$SUBJECT_ID==diagnosesFinalUnique[i,2])
  if (i==1){
    datalinear <- sample[1:16]
    colnames(datalinear) <- c("SUBJECT_ID")
  }
  else if (var[i] < 15){
    temp <- cbind(sample[1:16])
    colnames(temp) <- c("SUBJECT_ID")
    datalinear <- rbind(datalinear, temp)
  }
  else {
    var2[i] <- ceiling(var[i]/15)
    for(k in 1:ceiling(var[i]/15)){
      startcol <- (15*(k-1))+2 
      endcol <- (15*k)+1
      temp <- cbind(sample[1], sample[startcol:endcol])
      colnames(temp) <- c("SUBJECT_ID")
      datalinear <- rbind(datalinear, temp)
      colnames(datalinear) <- c("SUBJECT_ID") # not to get error:- Error in match.names(clabs, names(xi)) : names do not match previous names
    }
  }
}

dim(datalinear) #dimension of originalvalues 10352*16

#3c. change column names
colnames(datalinear) <- c("SUBJECT_ID", 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15)

#4. adding labels to the dataset; '1' for heart failure and '0' for chronic lever
#4a. load leukemia IDs
chronicleverFinal <- readRDS("/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/mimic/amino transferase/chronicleverFinal.rds")

#4b. add new column 'y_LABEL' to datalinear
datalinear <- cbind(y_LABEL=1,datalinear)

#4c. put '0' for 'y_LABEL' if 'SUBJECT_ID' is same as in 'chronicleverFinal' in datalinear
for(i in 1:nrow(datalinear)){
  sample <- subset(chronicleverFinal, chronicleverFinal$SUBJECT_ID==datalinear[i,2])
  if(nrow(sample) != 0){
    datalinear$y_LABEL[i] = 0
  }
}

#4d. saving datanongau of size 10352*17 in RDS format
saveRDS(datalinear, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/mimic/amino transferase/datalinear10352*17.rds")

#5. creating crossvalidation sets 
#5a. shuffling the final data
datalinearShuffle <- datalinear[sample(nrow(datalinear)),]

#5b. creating and saving crossvalidation set 1 (2588 rows)
crosslinear1 <- datalinearShuffle[1:2588,]
write(t(crosslinear1),"/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/mimic/amino transferase/crosslinear1.csv",ncolumns = 17,sep = ",") #easy to read in matlab/octave
saveRDS(crosslinear1, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/mimic/amino transferase/crosslinear1.rds") #easier to read in R

#5c. creating and saving crossvalidation set 2 (2588 rows)
crosslinear2 <- datalinearShuffle[2589:5176,]
write(t(crosslinear2),"/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/mimic/amino transferase/crosslinear2.csv",ncolumns = 17,sep = ",") #easy to read in matlab/octave
saveRDS(crosslinear2, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/mimic/amino transferase/crosslinear2.rds") #easier to read in R

#5d. creating and saving crossvalidation set 3 (2588 rows)
crosslinear3 <- datalinearShuffle[5177:7764,]
write(t(crosslinear3),"/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/mimic/amino transferase/crosslinear3.csv",ncolumns = 17,sep = ",") #easy to read in matlab/octave
saveRDS(crosslinear3, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/mimic/amino transferase/crosslinear3.rds") #easier to read in R

#5e. creating and saving crossvalidation set 4 (2588 rows)
crosslinear4 <- datalinearShuffle[7765:10352,]
write(t(crosslinear4),"/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/mimic/amino transferase/crosslinear4.csv",ncolumns = 17,sep = ",") #easy to read in matlab/octave
saveRDS(crosslinear4, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/mimic/amino transferase/crosslinear4.rds") #easier to read in R


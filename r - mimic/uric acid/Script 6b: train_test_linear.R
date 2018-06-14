#1a. loading data
example <- readRDS("/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/linearData/lineardata.rds")

#1b. defining data frame of size of numberofrows(finalDiagnosesUnique)*1 i.e. 567*1
linearvalues <- matrix(rep(0), nrow=nrow(finalDiagnosesUnique))
linearvalues <- as.data.frame(linearvalues)

#1c. defining variable var to store number of non-zeros columns per row 
var <- matrix(rep(0), nrow=nrow(finalDiagnosesUnique))

#2a. to put only linear regression values of 567 patients in linearvalues frame and to put zeros for the columns of the patients which doesnot have linear values
for (i in 1:nrow(finalDiagnosesUnique)){
  sample <- subset(example, example$SUBJECT_ID==finalDiagnosesUnique[i,2])
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

dim(linearvalues) #dimension of linearvalues 567*145

#2b. defining temp variable of size 567 * 5 to increase the size of linearvalues variable in the step 3 (ceiling function)
temp <- matrix(rep(0), nrow=nrow(finalDiagnosesUnique), ncol=5)
temp <- as.data.frame(temp)

#2c. adding subject id column to the data variable and increasing its size from 567*145 to 567*151
linearvalues <- cbind(finalDiagnosesUnique[,2], linearvalues, temp)
colnames(linearvalues) <- c("SUBJECT_ID") #change first column name

#3. slicing 151 columns per row to 16 columns per row where 1st column is subject id and the remaining associated linear regression values
# and for ids with less non-zero values are not spread into multiple rows 
#3a. defining variable var2 to store the number of rows the linear regression values of a patient are fanned-out
var2 <- matrix(rep(0), nrow=nrow(finalDiagnosesUnique))

#3b. slicing of 151 columns in order to increase the number of examples from 567 to 813 and to decrease the sample size to 151 to 15
for (i in 1:nrow(finalDiagnosesUnique)){
  sample <- subset(linearvalues, linearvalues$SUBJECT_ID==finalDiagnosesUnique[i,2])
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

#3c. change column names
colnames(datalinear) <- c("SUBJECT_ID", 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15)

#4. adding labels to the dataset; '1' for leukemia and '0' for gout
#4a. load leukemia IDs
finalLeukemia <- readRDS("/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/finalLeukemia.rds")

#4b. add new column 'y_LABEL' to datalinear
datalinear <- cbind(y_LABEL=0,datalinear)

#4c. put '1' for 'y_LABEL' if 'SUBJECT_ID' is same as in 'finalLeukemia' in datalinear
for(i in 1:nrow(datalinear)){
  sample <- subset(finalLeukemia, finalLeukemia$SUBJECT_ID==datalinear[i,2])
  if(nrow(sample) != 0){
    datalinear$y_LABEL[i] = 1
  }
}

#4d. saving datalinear of size 813*17 in RDS format
saveRDS(datalinear, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/linearData/datalinear813*17.rds")

#5. creating training and testing sets 
#5a. shuffling the final data
datalinearShuffle <- datalinear[sample(nrow(datalinear)),]

#5b. creating and saving training set (70% of final data i.e 70% of 813 rows = 569)
trainlinear <- datalinearShuffle[1:569,]
write(t(trainlinear),"/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/linearData/trainlinear.csv",ncolumns = 17,sep = ",") #easy to read in matlab/octave
saveRDS(trainlinear, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/linearData/trainlinear.rds") #easier to read in R

#5c. creating and saving remaining rows as testing set 
testlinear <- datalinearShuffle[570:813,]
write(t(testlinear),"/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/linearData/testlinear.csv",ncolumns = 17,sep = ",") #easy to read in matlab/octave
saveRDS(testlinear, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/linearData/testlinear.rds") #easier to read in R



#----------------------
#to see how many 1s are in var
count = 0
for(i in 1:nrow(var)){
  if (var[i] == 1){
    count = count + 1 #259
  }
}

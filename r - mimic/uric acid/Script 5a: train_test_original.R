#1a. loading data
example <- readRDS("/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/gaussianData/gaussianRegression3.rds")

#1b. defining data frame of size of numberofrows(finalDiagnosesUnique)*1 i.e. 567*1
datanongaussian <- matrix(rep(0), nrow=nrow(finalDiagnosesUnique))
datanongaussian <- as.data.frame(datanongaussian)

#1c. defining variable var to store number of non-zeros columns per row 
var <- matrix(rep(0), nrow=nrow(finalDiagnosesUnique))

#2a. to put only nongaussian values of 567 patients in datanongaussian frame and to put zeros for the columns of the patients which doesnot have nongausssian values
for (i in 1:nrow(finalDiagnosesUnique)){
  sample <- subset(example, example$SUBJECT_ID==finalDiagnosesUnique[i,2])
  var[i] <- nrow(sample)
  if(ncol(datanongaussian) < nrow(sample)){
    temp <- matrix(rep(0), nrow= nrow(datanongaussian), ncol = nrow(sample)-ncol(datanongaussian))
    temp <- as.data.frame(temp)
    datanongaussian <- cbind(datanongaussian,temp)
    for (j in 1:nrow(sample)){
      datanongaussian[i,j] <- sample[j,11]
    }
  }
  else{
    for (j in 1:nrow(sample)){
      datanongaussian[i,j] <- sample[j,11]
    }
  }
}

#2b. defining temp variable of size 567 * 5 to increase the size of datanongaussian variable in the next step
temp <- matrix(rep(0), nrow=nrow(finalDiagnosesUnique), ncol=5)
temp <- as.data.frame(temp)

#2c. adding subject id column to the data variable and increasing its size from 567*145 to 567*151
datanongaussian <- cbind(finalDiagnosesUnique[,2], datanongaussian, temp)
colnames(datanongaussian) <- c("SUBJECT_ID") #change first column name

#3. slicing 151 columns per row to 16 columns per row where 1st column is subject id and the remaining associated nongaussian values
# and for ids with less non-zero values are not spread into multiple rows 
#3a. defining variable var2 to store the number of rows the nongaussian values of a patient are fanned-out
var2 <- matrix(rep(0), nrow=nrow(finalDiagnosesUnique))

#3b. slicing of 151 columns in order to increase the number of examples from 567 to 813 and to decrease the sample size to 151 to 15
for (i in 1:nrow(finalDiagnosesUnique)){
  sample <- subset(datanongaussian, datanongaussian$SUBJECT_ID==finalDiagnosesUnique[i,2])
  if (i==1){
    datanongau <- sample[1:16]
    colnames(datanongau) <- c("SUBJECT_ID")
  }
  else if (var[i] < 15){
    temp <- cbind(sample[1:16])
    colnames(temp) <- c("SUBJECT_ID")
    datanongau <- rbind(datanongau, temp)
  }
  else {
    var2[i] <- ceiling(var[i]/15)
    for(k in 1:ceiling(var[i]/15)){
      startcol <- (15*(k-1))+2 
      endcol <- (15*k)+1
      temp <- cbind(sample[1], sample[startcol:endcol])
      colnames(temp) <- c("SUBJECT_ID")
      datanongau <- rbind(datanongau, temp)
      colnames(datanongau) <- c("SUBJECT_ID") # not to get error:- Error in match.names(clabs, names(xi)) : names do not match previous names
    }
  }
}

#3c. change column names
colnames(datanongau) <- c("SUBJECT_ID", 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15)

#4. adding labels to the dataset; '1' for leukemia and '0' for gout
#4a. load leukemia IDs
finalLeukemia <- readRDS("/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/finalLeukemia.rds")

#4b. add new column 'y_LABEL' to datanongau
datanongau <- cbind(y_LABEL=0,datanongau)

#4c. put '1' for 'y_LABEL' if 'SUBJECT_ID' is same as in 'finalLeukemia' in datanongau
for(i in 1:nrow(datanongau)){
  sample <- subset(finalLeukemia, finalLeukemia$SUBJECT_ID==datanongau[i,2])
  if(nrow(sample) != 0){
    datanongau$y_LABEL[i] = 1
  }
}

#4d. saving datanongau of size 813*17 in RDS format
saveRDS(datanongau, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/originalData/original813*17.rds")

#5. creating training and testing sets 
#5a. shuffling the final data
datanongauShuffle <- datanongau[sample(nrow(datanongau)),]

#5b. creating and saving training set (70% of final data i.e 70% of 813 rows = 569)
trainnongau <- datanongauShuffle[1:569,]
write(t(trainnongau),"/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/originalData/trainoriginal.csv",ncolumns = 17,sep = ",") #easy to read in matlab/octave
saveRDS(trainnongau, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/originalData/trainoriginal.rds") #easier to read in R

#5c. creating and saving remaining rows as testing set 
testnongau <- datanongauShuffle[570:813,]
write(t(testnongau),"/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/originalData/testoriginal.csv",ncolumns = 17,sep = ",") #easy to read in matlab/octave
saveRDS(testnongau, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/originalData/testoriginal.rds") #easier to read in R

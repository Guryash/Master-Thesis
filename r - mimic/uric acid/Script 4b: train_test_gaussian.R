#0. load appropiate data
#0a. gaussian values
example <- readRDS("/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/gaussianData/gaussianRegression3.rds")

#0b. finalDiagnoses
finalDiagnoses <- readRDS("/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/finalDiagnoses.rds") #640
finalDiagnosesUnique <- finalDiagnoses[!duplicated(finalDiagnoses[,'SUBJECT_ID']),] #576

#0c. load leukemia IDs
finalLeukemia <- readRDS("/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/finalLeukemia.rds")

  
#1a. defining data frame of size of numberofrows(finalDiagnosesUnique)*1 i.e. 567*1
data <- matrix(rep(0), nrow=nrow(finalDiagnosesUnique))
data <- as.data.frame(data)

#1b. defining variable var to store number of non-zeros columns per row 
var <- matrix(rep(0), nrow=nrow(finalDiagnosesUnique))


#2a. to put only gaussian values of 567 patients in data frame and to put zeros for the columns of the patients which doesnot have gausssian values
for (i in 1:nrow(finalDiagnosesUnique)){
  sample <- subset(example, example$SUBJECT_ID==finalDiagnosesUnique[i,2])
  var[i] <- nrow(sample)
  if(ncol(data) < nrow(sample)){
    temp <- matrix(rep(0), nrow= nrow(data), ncol = nrow(sample)-ncol(data))
    temp <- as.data.frame(temp)
    data <- cbind(data,temp)
    for (j in 1:nrow(sample)){
      data[i,j] <- sample[j,1]
    }
  }
  else{
    for (j in 1:nrow(sample)){
      data[i,j] <- sample[j,1]
    }
  }
}

#2b. defining temp variable of size 567 * 5 to increase the size of data variable in the next step
temp <- matrix(rep(0), nrow=nrow(finalDiagnosesUnique), ncol=5)
temp <- as.data.frame(temp)

#2c. adding subject id column to the data variable and increasing its size from 567*145 to 567*151
data <- cbind(finalDiagnosesUnique[,2], data, temp)
colnames(data) <- c("SUBJECT_ID") #change first column name

#2d. saving the gaussian values data of size 567*151 in RDS format
saveRDS(data, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/gaussianData/gaussian567*151.rds")


#3. slicing 151 columns per row to 16 columns per row where 1st column is subject id and the remaining associated gaussian values
# and for ids with less non-zero values are not spread into multiple rows 
#3a. defining variable var2 to store the number of rows the gaussian values of a patient are fanned-out
var2 <- matrix(rep(0), nrow=nrow(finalDiagnosesUnique))

#3b. slicing of 151 columns in order to increase the number of examples from 567 to 813 and to decrease the sample size to 151 to 15
for (i in 1:nrow(finalDiagnosesUnique)){
  sample <- subset(data, data$SUBJECT_ID==finalDiagnosesUnique[i,2])
  if (i==1){
    datagau <- sample[1:16]
    colnames(datagau) <- c("SUBJECT_ID")
  }
  else if (var[i] < 15){
    temp <- cbind(sample[1:16])
    colnames(temp) <- c("SUBJECT_ID")
    datagau <- rbind(datagau, temp)
  }
  else {
    var2[i] <- ceiling(var[i]/15)
    for(k in 1:ceiling(var[i]/15)){
      startcol <- (15*(k-1))+2 
      endcol <- (15*k)+1
      temp <- cbind(sample[1], sample[startcol:endcol])
      colnames(temp) <- c("SUBJECT_ID")
      datagau <- rbind(datagau, temp)
      colnames(datagau) <- c("SUBJECT_ID") # not to get error:- Error in match.names(clabs, names(xi)) : names do not match previous names
    }
  }
}

#3c. change columnnames
colnames(datagau) <- c("SUBJECT_ID", 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15)


#4a. add new column 'y_LABEL' to datagau
datagau <- cbind(y_LABEL=0,datagau)

#4b. put '1' for 'y_LABEL' if 'SUBJECT_ID' is same as in 'finalLeukemia' in datagau
for(i in 1:nrow(datagau)){
  sample <- subset(finalLeukemia, finalLeukemia$SUBJECT_ID==datagau[i,2])
  if(nrow(sample) != 0){
    datagau$y_LABEL[i] = 1
  }
}

#4c. save gaussian data of size 813*17
saveRDS(datagau, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/gaussianData/gaussian813*17.rds") #easier to read in R


#5. creating training and testing sets 
#5a. shuffling the final data
datagauShuffle <- datagau[sample(nrow(datagau)),]

#5b. creating and saving training set (70% of final data i.e 70% of 813 rows = 569)
traingaussian <- datagauShuffle[1:569,]
write(t(traingaussian),"/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/gaussianData/traingaussian.csv",ncolumns = 17,sep = ",") #easy to read in matlab/octave
#saveRDS(traingaussian, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/gaussianData/traingaussian.rds") #easier to read in R

#5c. creating and saving remaining rows as testing set 
testgaussian <- datagauShuffle[570:813,]
write(t(testgaussian),"/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/gaussianData/testgaussian.csv",ncolumns = 17,sep = ",") #easy to read in matlab/octave
#saveRDS(testgaussian, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/gaussianData/testgaussian.rds") #easier to read in R






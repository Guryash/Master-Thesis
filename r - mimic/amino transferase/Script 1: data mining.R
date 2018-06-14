#1. import required data 
data1 <- read.csv("/home/pinkpanther/Documents/Studies/Master Thesis/Data/datasets/mimic 3/D_ICD_DIAGNOSES.csv")
data2 <- read.csv("/home/pinkpanther/Documents/Studies/Master Thesis/Data/datasets/mimic 3/DIAGNOSES_ICD.csv")
data3 <- read.csv("/home/pinkpanther/Documents/Studies/Master Thesis/Data/datasets/mimic 3/D_LABITEMS.csv")
data4 <- read.csv("/home/pinkpanther/Documents/Studies/Master Thesis/Data/datasets/mimic 3/LABEVENTS.csv")

#2a. values for heart failure
heartfailure <- subset(data2, ICD9_CODE==4280 | ICD9_CODE==4281 | ICD9_CODE==42820 | ICD9_CODE==42821 | 
                     ICD9_CODE==42822 | ICD9_CODE==42823 | ICD9_CODE==42830 | ICD9_CODE==42831 | 
                     ICD9_CODE==42832 | ICD9_CODE==42833 | ICD9_CODE==42840 | ICD9_CODE==42841 |
                     ICD9_CODE==42842 | ICD9_CODE==42843 | ICD9_CODE==4289) #20,676
heartfailureHADM <- heartfailure[!duplicated(heartfailure[,c('HADM_ID')]),] #13,608
heartfailureHADMUnique <- heartfailureHADM[!duplicated(heartfailureHADM[,c('SUBJECT_ID')]),] #10,154

#2b. values for chronic liver
chroniclever <- subset(data2, ICD9_CODE==5712 | ICD9_CODE==5715 | ICD9_CODE==5716 | ICD9_CODE==5718 | 
                         ICD9_CODE==5719 | ICD9_CODE==5728 | ICD9_CODE==5730 | ICD9_CODE==57140 | 
                         ICD9_CODE==57141 | ICD9_CODE==57142 |ICD9_CODE==57149) #3,183
chronicleverHADM <- chroniclever[!duplicated(chroniclever[,c('HADM_ID')]),] #2,882
chronicleverHADMUnique <- chronicleverHADM[!duplicated(chronicleverHADM[,c('SUBJECT_ID')]),] #2,174

#2c. values for ALT 
aminotransferase <- subset(data4, ITEMID==50861) #2,19,462

#3a. order the data according to SUBJECT_ID
heartfailure <- heartfailure[order(heartfailure[,c('SUBJECT_ID')]),] #20,676
chroniclever <- chroniclever[order(chroniclever[,c('SUBJECT_ID')]),] #3,183
aminotransferase <- aminotransferase[order(aminotransferase[,c('SUBJECT_ID')]),] #2,19,462

#3b. number of unique patients
heartfailureUnique <- heartfailure[!duplicated(heartfailure[,c('SUBJECT_ID')]),] #10,154
chronicleverUnique <- chroniclever[!duplicated(chroniclever[,c('SUBJECT_ID')]),] #2,174
aminotransferaseUnique <- aminotransferase[!duplicated(aminotransferase[,c('SUBJECT_ID')]),] #30,211

#3c. number of unique hospital admissions
heartfailureUniqueHADM <- heartfailure[!duplicated(heartfailure[,c('HADM_ID')]),] #13,608
chronicleverUniqueHADM <- chroniclever[!duplicated(chroniclever[,c('HADM_ID')]),] #2,882

#4. find common patients in heartfailureUnique and chronicleverUnique 
#4a. create function
identifyPatients <- function(disease1, disease2){
  count <- 1
  for (i in 1:nrow(disease1)){
    if (count==1)
    {
      temp <- subset(disease2, SUBJECT_ID==disease1[i, 2])
      if (length(temp) != 0){
        result <- temp
        count <- 2
      }
    }
    else{
      temp <- subset(disease2, SUBJECT_ID==disease1[i, 2])
      if (length(temp) != 0){
        result <- rbind(result, temp)
      }
    }
  }
  return(list(result))
}

#4b. call the function
commonPatients <- identifyPatients(chronicleverUnique, heartfailureUnique)
commonPatients <- data.frame(commonPatients) #501

#5. remove commonPatients from heartfailure and chroniclever and unique data objects
#5a. create function 
removeCommonPatients <- function(commonValues, disease){
  count <- 1
  for(i in 1:nrow(commonValues)){
    if (count==1){
      diseaseRemove <- subset(disease, SUBJECT_ID != commonValues[i,2])
      count <- 2
    }
    else{
      diseaseRemove <- subset(diseaseRemove, SUBJECT_ID != commonValues[i,2])
    }
  }
  return(diseaseRemove)
}

#5b. for heartfailure
heartfailureRemove <- removeCommonPatients(commonPatients, heartfailure) #19,487
heartfailureRemoveUniqueHADM <- heartfailureRemove[!duplicated(heartfailureRemove[,c('HADM_ID')]),] #12,837
heartfailureRemoveUnique <- heartfailureRemove[!duplicated(heartfailureRemove[,c('SUBJECT_ID')]),] #9,653

#5c. for chroniclever
chronicleverRemove <- removeCommonPatients(commonPatients, chroniclever) #2,394
chronicleverRemoveUniqueHADM <- chronicleverRemove[!duplicated(chronicleverRemove[,c('HADM_ID')]),] #2,162
chronicleverRemoveUnique <- chronicleverRemove[!duplicated(chronicleverRemove[,c('SUBJECT_ID')]),] #1,673

#6. combining diagnoses
diagnoses <- rbind(heartfailureRemoveUniqueHADM, chronicleverRemoveUniqueHADM) #14,999
diagnosesUnique <- rbind(heartfailureRemoveUnique, chronicleverRemoveUnique) #12,326 #11,328 #11,326

#6a. order the data according to SUBJECT_ID
diagnoses <- diagnoses[order(diagnoses[,c('SUBJECT_ID')]),] #21,881 #14,999
diagnosesUnique <- diagnosesUnique[order(diagnosesUnique[,c('SUBJECT_ID')]),] #12,326 #11,328 #11,326

#7. mine data in alanine aminotransferase for identified patients
#7a. create function
identifyElement <- function(element, diagnose){
  count <- 1
  for (i in 1:nrow(diagnose)){
    if (count==1){
      temp <- subset(element, SUBJECT_ID==diagnose[i,2])
      #if (length(temp) != 0){
        result <- temp
        count <- 2
      #}
    }
    else{
      temp <- subset(element, SUBJECT_ID==diagnose[i,2])
      #if (length(temp) != 0){
        result <- rbind(result, temp)
      #}
    }
    cat(i)
    cat(" ")
  }
  return(list(result))
}

#7b. required data points
aminotransferaseRequired1 <- identifyElement(aminotransferase, diagnosesUnique[1:1000,])
aminotransferaseRequired1 <- data.frame(aminotransferaseRequired1)
aminotransferaseRequired2 <- identifyElement(aminotransferase, diagnosesUnique[1001:5000,])
aminotransferaseRequired2 <- data.frame(aminotransferaseRequired2)
aminotransferaseRequired3 <- identifyElement(aminotransferase, diagnosesUnique[5001:11326,])
aminotransferaseRequired3 <- data.frame(aminotransferaseRequired3)

aminotransferaseRequired <- rbind(aminotransferaseRequired1, aminotransferaseRequired2, aminotransferaseRequired3) #96,661

#7c. to see 96,661 observations belonging to what diagnoses
aminotransferaseChronicEnteries <- identifyElement(aminotransferase, chronicleverRemoveUnique)
aminotransferaseChronicEnteries <- data.frame(aminotransferaseChronicEnteries) #39,621

aminotransferaseHeartEnteries <- identifyElement(aminotransferase, heartfailureRemoveUnique)
aminotransferaseHeartEnteries <- data.frame(aminotransferaseHeartEnteries) #57,040

#7d. splitting data into two groups - one with HADM_ID and one without HADM_ID
aminotransferaseRequiredNull <- aminotransferaseRequired[!complete.cases(aminotransferaseRequired),] #30,221
aminotransferaseRequiredNotNull <- aminotransferaseRequired[complete.cases(aminotransferaseRequired),] #66,440

#7e. to see 66,440 observations belonging to what diagnoses
aminotransferaseChronicEnteries1 <- identifyElement(aminotransferaseRequiredNotNull, chronicleverRemoveUnique)
aminotransferaseChronicEnteries1 <- data.frame(aminotransferaseChronicEnteries1) #27,021

aminotransferaseHeartEnteries1 <- identifyElement(aminotransferaseRequiredNotNull, heartfailureRemoveUnique)
aminotransferaseHeartEnteries1 <- data.frame(aminotransferaseHeartEnteries1) #39,419

#8. find final values of alanine aminotransferase using "aminotransferaseRequiredNotNull" object
#8a. create function
identifyFinalElement<- function(element, diagnose){
  count <- 1
  for (i in 1:nrow(diagnose)){
    if (count==1){
      temp <- subset(element, SUBJECT_ID==diagnose[i,2] & HADM_ID==diagnose[i,3])
      result <- temp
      count <- 2
    }
    else{
      temp <- subset(element, SUBJECT_ID==diagnose[i,2] & HADM_ID==diagnose[i,3])
      result <- rbind(result, temp)
    }
    cat(i)
    cat(" ")
  }
  return(list(result))
}

#8b. final data points
aminotransferaseFinal <- identifyFinalElement(aminotransferaseRequiredNotNull, diagnoses)
aminotransferaseFinal <- data.frame(aminotransferaseFinal) #56,321

#8c. save the data
saveRDS(aminotransferaseFinal, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/mimic/amino transferase/aminotransferaseFinal.rds")

#8d. to see 56,321 observations belonging to what diagnoses
aminotransferaseChronicEnteries2 <- identifyElement(aminotransferaseFinal, chronicleverRemoveUnique)
aminotransferaseChronicEnteries2 <- data.frame(aminotransferaseChronicEnteries2) #23,158

aminotransferaseHeartEnteries2 <- identifyElement(aminotransferaseFinal, heartfailureRemoveUnique)
aminotransferaseHeartEnteries2 <- data.frame(aminotransferaseHeartEnteries2) #33,163

#9. identify final diagnoses
#9a. unique aminotransferaseFinal admissions
aminotransferaseFinalHADM <- aminotransferaseFinal[!duplicated(aminotransferaseFinal[,c('HADM_ID')]),] #11,155

#9b. create function
identifyFinalDiagnoses <- function(element, diagnose){
  count <- 1
  for (i in 1:nrow(element)){
    if (count==1){
      temp <- subset(diagnose, HADM_ID==element[i,3])
      result <- temp
      count <- 2
    }
    else{
      temp <- subset(diagnose, HADM_ID==element[i,3])
      result <- rbind(result, temp)
    }
    cat(i)
    cat(" ")
  }
  return(list(result))
}

#9c. call identifyFinalDiagnoses function
diagnosesFinal <- identifyFinalDiagnoses(aminotransferaseFinalHADM, diagnoses)
diagnosesFinal <- data.frame(diagnosesFinal) #11,155
diagnosesFinalUnique <- diagnosesFinal[!duplicated(diagnosesFinal[,c('SUBJECT_ID')]),] #8,971

#9d. order the diagnosesFinal
diagnosesFinal <- diagnosesFinal[order(diagnosesFinal[,c('SUBJECT_ID')]),]

#9e. save the data
saveRDS(diagnosesFinal, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/mimic/amino transferase/diagnosesFinal.rds")

#10. identify final chronic lever and heart failure patients
#10a. identify chronic lever
chronicleverFinal <- identifyFinalDiagnoses(chronicleverRemoveUniqueHADM, diagnosesFinal)
chronicleverFinal <- data.frame(chronicleverFinal) #2,049
chronicleverFinalUnique <- chronicleverFinal[!duplicated(chronicleverFinal[,c('SUBJECT_ID')]),] #1,596

#10b. identify heart failure
heartfailureFinal <- identifyFinalDiagnoses(heartfailureRemoveUniqueHADM, diagnosesFinal)
heartfailureFinal <- data.frame(heartfailureFinal) #9,106
heartfailureFinalUnique <- heartfailureFinal[!duplicated(heartfailureFinal[,c('SUBJECT_ID')]),] #7,375

#10c. save the data
saveRDS(chronicleverFinal, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/mimic/amino transferase/chronicleverFinal.rds")
saveRDS(heartfailureFinal, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/mimic/amino transferase/heartfailureFinal.rds")



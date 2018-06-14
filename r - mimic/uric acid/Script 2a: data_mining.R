#dataMining

uricAcidItem <- subset(data17, ITEMID==51007 | ITEMID==51105 | ITEMID==51505) #19906 #OR
uricAcidItem1 <- subset(data17, ITEMID==51007) # uric acid
uricAcidItem2 <- subset(data17, ITEMID==51105) # uric acid
uricAcidItem3 <- subset(data17, ITEMID==51505) # uric acid
uricAcidItem4 <- subset(data17, ITEMID==853)
uricAcidItem5 <- subset(data17, ITEMID==6058)
uricAcidItem6 <- subset(data17, ITEMID==1541)
uricAcidItem7 <- subset(data17, ITEMID==225695)

leukemia <- subset(data8, ICD9_CODE==20310 | ICD9_CODE==20312 | ICD9_CODE==20400 | ICD9_CODE==20400 | 
                     ICD9_CODE==20401 | ICD9_CODE==20402 | ICD9_CODE==20410 | ICD9_CODE==20411 | 
                     ICD9_CODE==20412 | ICD9_CODE==20480 | ICD9_CODE==20490 | ICD9_CODE==20500 |
                     ICD9_CODE==20501 | ICD9_CODE==20502 | ICD9_CODE==20510 | ICD9_CODE==20511 | 
                     ICD9_CODE==20512 | ICD9_CODE==20590 | ICD9_CODE==20600 | ICD9_CODE==20722 |
                     ICD9_CODE==20780 | ICD9_CODE==20800 | ICD9_CODE==20890 | ICD9_CODE==20891 |
                     ICD9_CODE=='V1060' | ICD9_CODE=='V1061' | ICD9_CODE=='V1062' | ICD9_CODE=='V1069' |
                     ICD9_CODE=='V166') #627 #OR
leukemia1 <- subset(data8, ICD9_CODE==20310) #3
leukemia2 <- subset(data8, ICD9_CODE==20311) #0
leukemia3 <- subset(data8, ICD9_CODE==20312) #2
leukemia4 <- subset(data8, ICD9_CODE==20400) #39
leukemia5 <- subset(data8, ICD9_CODE==20401) #7
leukemia6 <- subset(data8, ICD9_CODE==20402) #4
leukemia7 <- subset(data8, ICD9_CODE==20410) #184
leukemia8 <- subset(data8, ICD9_CODE==20411) #8
leukemia9 <- subset(data8, ICD9_CODE==20412) #8
leukemia10 <- subset(data8, ICD9_CODE==20420) #0 
leukemia11 <- subset(data8, ICD9_CODE==20421) #0 
leukemia12 <- subset(data8, ICD9_CODE==20422) #0 
leukemia13 <- subset(data8, ICD9_CODE==20480) #1
leukemia14 <- subset(data8, ICD9_CODE==20481) #0 
leukemia15 <- subset(data8, ICD9_CODE==20482) #0 
leukemia16 <- subset(data8, ICD9_CODE==20490) #1
leukemia17 <- subset(data8, ICD9_CODE==20491) #0 
leukemia18 <- subset(data8, ICD9_CODE==20492) #0 
leukemia19 <- subset(data8, ICD9_CODE==20500) #195
leukemia20 <- subset(data8, ICD9_CODE==20501) #30
leukemia21 <- subset(data8, ICD9_CODE==20502) #13
leukemia22 <- subset(data8, ICD9_CODE==20510) #65
leukemia23 <- subset(data8, ICD9_CODE==20511) #7
leukemia24 <- subset(data8, ICD9_CODE==20512) #2
leukemia25 <- subset(data8, ICD9_CODE==20520) #0
leukemia26 <- subset(data8, ICD9_CODE==20521) #0
leukemia27 <- subset(data8, ICD9_CODE==20522) #0
leukemia28 <- subset(data8, ICD9_CODE==20580) #0
leukemia29 <- subset(data8, ICD9_CODE==20581) #0
leukemia30 <- subset(data8, ICD9_CODE==20582) #0 
leukemia31 <- subset(data8, ICD9_CODE==20590) #1
leukemia32 <- subset(data8, ICD9_CODE==20591) #0 
leukemia33 <- subset(data8, ICD9_CODE==20592) #0 
leukemia34 <- subset(data8, ICD9_CODE==20600) #3
leukemia35 <- subset(data8, ICD9_CODE==20601) #0 
leukemia36 <- subset(data8, ICD9_CODE==20602) #0 
leukemia37 <- subset(data8, ICD9_CODE==20610) #0 
leukemia38 <- subset(data8, ICD9_CODE==20611) #0 
leukemia39 <- subset(data8, ICD9_CODE==20612) #0 
leukemia40 <- subset(data8, ICD9_CODE==20620) #0 
leukemia41 <- subset(data8, ICD9_CODE==20621) #0 
leukemia42 <- subset(data8, ICD9_CODE==20622) #0 
leukemia43 <- subset(data8, ICD9_CODE==20680) #0 
leukemia44 <- subset(data8, ICD9_CODE==20681) #0 
leukemia45 <- subset(data8, ICD9_CODE==20682) #0 
leukemia46 <- subset(data8, ICD9_CODE==20690) #0 
leukemia47 <- subset(data8, ICD9_CODE==20691) #0 
leukemia48 <- subset(data8, ICD9_CODE==20692) #0 
leukemia49 <- subset(data8, ICD9_CODE==20700) #0 
leukemia50 <- subset(data8, ICD9_CODE==20701) #0 
leukemia51 <- subset(data8, ICD9_CODE==20702) #0 
leukemia52 <- subset(data8, ICD9_CODE==20720) #0 
leukemia53 <- subset(data8, ICD9_CODE==20721) #0 
leukemia54 <- subset(data8, ICD9_CODE==20722) #1
leukemia55 <- subset(data8, ICD9_CODE==20780) #5
leukemia56 <- subset(data8, ICD9_CODE==20781) #0 
leukemia57 <- subset(data8, ICD9_CODE==20782) #0 
leukemia58 <- subset(data8, ICD9_CODE==20800) #5
leukemia59 <- subset(data8, ICD9_CODE==20801) #0 
leukemia60 <- subset(data8, ICD9_CODE==20802) #0 
leukemia61 <- subset(data8, ICD9_CODE==20810) #0 
leukemia62 <- subset(data8, ICD9_CODE==20811) #0 
leukemia63 <- subset(data8, ICD9_CODE==20812) #0 
leukemia64 <- subset(data8, ICD9_CODE==20820) #0 
leukemia65 <- subset(data8, ICD9_CODE==20821) #0 
leukemia66 <- subset(data8, ICD9_CODE==20822) #0 
leukemia67 <- subset(data8, ICD9_CODE==20880) #0 
leukemia68 <- subset(data8, ICD9_CODE==20881) #0 
leukemia69 <- subset(data8, ICD9_CODE==20882) #0 
leukemia70 <- subset(data8, ICD9_CODE==20890) #6
leukemia71 <- subset(data8, ICD9_CODE==20891) #2
leukemia72 <- subset(data8, ICD9_CODE==20892) #0 
leukemia73 <- subset(data8, ICD9_CODE=='V1060') #5
leukemia74 <- subset(data8, ICD9_CODE=='V1061') #10
leukemia75 <- subset(data8, ICD9_CODE=='V1062') #6
leukemia76 <- subset(data8, ICD9_CODE=='V1063') #0 
leukemia77 <- subset(data8, ICD9_CODE=='V1069') #3
leukemia78 <- subset(data8, ICD9_CODE=='V166') #11

gout <- subset(data8, ICD9_CODE==27400 | ICD9_CODE==27401 | ICD9_CODE==27402 | ICD9_CODE==27403 | 
                 ICD9_CODE==27410 | ICD9_CODE==27419 | ICD9_CODE==27481 | ICD9_CODE==27482 |
                 ICD9_CODE==27489 | ICD9_CODE==2749 | ICD9_CODE=='V775') #2224 #OR
gout1 <- subset(data8, ICD9_CODE==27400) #21
gout2 <- subset(data8, ICD9_CODE==27401) #99
gout3 <- subset(data8, ICD9_CODE==27402) #3
gout4 <- subset(data8, ICD9_CODE==27403) #8
gout5 <- subset(data8, ICD9_CODE==27410) #0
gout6 <- subset(data8, ICD9_CODE==27419) #0
gout7 <- subset(data8, ICD9_CODE==27481) #0
gout8 <- subset(data8, ICD9_CODE==27482) #10
gout9 <- subset(data8, ICD9_CODE==27489) #1
gout10 <- subset(data8, ICD9_CODE==2749) #2082
gout11 <- subset(data8, ICD9_CODE=='V775') #0

#total 2851

gout <- rbind(gout1, gout2, gout3, gout4, gout8, gout9, gout10) #2224
goutUnique <- gout[!duplicated(gout[,c('SUBJECT_ID')]),] #1805
goutUniqueHADM <- gout[!duplicated(gout[,'HADM_ID']),] #2219
goutDuplicatedHADM <- gout[duplicated(gout[,'HADM_ID']),] #5

leukemia <- rbind(leukemia1, leukemia3, leukemia4, leukemia5, leukemia6, leukemia7, leukemia8, leukemia9, leukemia13, leukemia16, leukemia19, leukemia20, leukemia21, leukemia22, leukemia23, leukemia24, leukemia31, leukemia34, leukemia54, leukemia55, leukemia58, leukemia70, leukemia71, leukemia73, leukemia74, leukemia75, leukemia77, leukemia78) # 627
leukemiaUnique <- leukemia[!duplicated(leukemia[,c('SUBJECT_ID')]),] #454
leukemiaUniqueHADM <- leukemia[!duplicated(leukemia[,('HADM_ID')]),] #618
leukemiaDuplicated <- leukemia[duplicated(leukemia[,c('SUBJECT_ID')]),] #173

diagnoses <- rbind(gout, leukemia) # 2851
diagnoses2 <- rbind(goutUniqueHADM, leukemiaUniqueHADM) #2837
diagnoses2Patients <- rbind(goutUnique, leukemiaUnique) #2259
diagnoses2UniqueHADM <- diagnoses2[!duplicated(diagnoses2[,'HADM_ID']),] #2812
diagnosesSort <- diagnoses[order(diagnoses[,c('SUBJECT_ID')]),] # 2851
diagnosesSortUniqueHADM <- diagnosesSort[!duplicated(diagnosesSort[,('HADM_ID')]),] #2812

uricAcidItem <- rbind(uricAcidItem1, uricAcidItem2, uricAcidItem3) # 19906
uricAcidItemSort <- uricAcidItem[order(uricAcidItem[, c('SUBJECT_ID')]),] # 19906
uricAcidItemSortUnique <- uricAcidItemSort[!duplicated(uricAcidItemSort[,c('SUBJECT_ID')]),] #4219 #5186

myFunction <- function(x1, x2){
  count <- 1
  count1 <- 1
  temp <- FALSE
  for (i in 1:nrow(x1)){
    for (j in 1:nrow(x2)){
      if (x1[i, 2] == x2[j, 2]){
        temp <- FALSE
        break
      }
      else{
        temp <- TRUE
      }
    }
    if (temp==TRUE && count==1){
      count <- 2
      result <- rbind(x1[i,])
    }
    else if (temp==TRUE){
      result <- rbind(result, x1[i,])
    }
    else if (temp==FALSE && count1==1){
      count1 <- 2
      result1 <- rbind(x1[i,])
    }
    else{
      result1 <- rbind(result1, x1[i,])
    }
  }
  return(list(result, result1))
}

findCommonPatients <- myFunction(goutUnique, leukemiaUnique) # to identity patients with both the diseases, i.e., gout and leukemia
commonPatientsGouLeu <- data.frame(findCommonPatients[2]) # 30 entries in gout after patients with gout matches with patients with leukemia #25 #22
uncommonPatientsGouLeu <- data.frame(findCommonPatients[1]) # 2194 patients don't match #2194 #1783

removeCommonPatients <- myFunction(diagnosesSort, commonPatientsGouLeu)
diagnosesCommon <- data.frame(removeCommonPatients[2]) #64 #55 #50 #64
diagnosesUncommon <- data.frame(removeCommonPatients[1]) #2787 #2796 #2801 #2787
diagnosesUncommonUniqueHADM <- diagnosesUncommon[!duplicated(diagnosesUncommon[,'HADM_ID']),] #2782 #2787 #2773

#to comfirm above results diagnosesUncommonUniqueHADM = diagnoses_Uncommon
remove_CommonPatients <- myFunction(diagnosesSortUniqueHADM, commonPatientsGouLeu)
diagnoses_Common <- data.frame(remove_CommonPatients[2]) #39 #25 #39
diagnoses_Uncommon <- data.frame(remove_CommonPatients[1]) #2773 #2787 #2773

diagnoses_UncommonUnique_Patients <- diagnosesUncommon[!duplicated(diagnosesUncommon[,'SUBJECT_ID']),] #2215

removeCommonGout <- myFunction(goutUniqueHADM, commonPatientsGouLeu)
goutFinal <- data.frame(removeCommonGout[1]) #2194 #2189
goutFinalPatients <- goutFinal[!duplicated(goutFinal[,'SUBJECT_ID']),] #1787 #1783

removeCommonLeukemia <- myFunction(leukemiaUniqueHADM, commonPatientsGouLeu)
leukemiaFinal <- data.frame(removeCommonLeukemia[1]) #593 #584
leukemiaFinalPatients <- leukemiaFinal[!duplicated(leukemiaFinal[,'SUBJECT_ID']),] #438 #432

idsSeparated <- myFunction(diagnoses_UncommonUnique_Patients, uricAcidItemSortUnique)
idsMatchUricAcid <- data.frame(idsSeparated[2]) #761 #768 #587 #761
idsDontMatchUricAcid <- data.frame(idsSeparated[1]) #1454 #1456 #1628 #1454

findRecords <- function(item, diagnosesId){
  itemTemp <- item
  count <- 1
  for (i in 1:nrow(diagnosesId)){
    for (j in 1:nrow(itemTemp)){
      if (diagnosesId[i,2]==itemTemp[j,2] && count==1){
        count <- 2
        result <- itemTemp[j,]
        #itemTemp <- itemTemp[-c(j),]
      }
      else if (diagnosesId[i,2]==item[j,2]){
        result <- rbind(result, itemTemp[j,])
        #itemTemp <- itemTemp[-c(j),]
      }
    }
  }
  return(result)
}

findTotalDiagnosesPatients <- findRecords(diagnosesUncommonUniqueHADM, idsMatchUricAcid) #769 #1086 #1086 #823 #1076
findTotalDiagnosesPatientsGout <- findRecordsHADM(findTotalDiagnosesPatients, goutFinal) #678
findTotalDiagnosesPatientsLeukemia <- findRecordsHADM(findTotalDiagnosesPatients, leukemiaFinal) #398
findTotalDiagnosesPatientsUnique <- findTotalDiagnosesPatients[!duplicated(findTotalDiagnosesPatients[,'SUBJECT_ID']),] #1086 #587 #761
findTotalDiagnosesPatientsUniqueGout <- findRecordsHADM(findTotalDiagnosesPatientsUnique, goutFinal) #488
findTotalDiagnosesPatientsUniqueLeukemia <- findRecordsHADM(findTotalDiagnosesPatientsUnique, leukemiaFinal) #273
findTotalDiagnosesPatientsUniqueHADM <- findTotalDiagnosesPatients[!duplicated(findTotalDiagnosesPatients[,'HADM_ID']),] #823 #1076
findTotalDiagnosesPatientsSort <- findTotalDiagnosesPatients[order(findTotalDiagnosesPatients[,'SUBJECT_ID'], findTotalDiagnosesPatients[,'HADM_ID']),]

uricAcidItemLeuGouDiagnoses <- findRecords(uricAcidItem, idsMatchUricAcid) #5315 #7076 #7242 #6533 #7076
uricAcidItemLeuGouDiagnosesSort <- uricAcidItemLeuGouDiagnoses[order(uricAcidItemLeuGouDiagnoses[,'SUBJECT_ID'],uricAcidItemLeuGouDiagnoses[,'CHARTTIME']),]

uricAcidItemLeuGouDiagnosesNull <- uricAcidItemLeuGouDiagnoses[!complete.cases(uricAcidItemLeuGouDiagnoses),] #2246 #2519 #2591 #1976 #2519
uricAcidItemLeuGouDiagnosesNotNull <- uricAcidItemLeuGouDiagnoses[complete.cases(uricAcidItemLeuGouDiagnoses),] #4651 #4557 #4557

#adding hadm values to uricAcidItemLeuGouDiagnosesNull -- execute script 2b:

prefinalUricAcid <- rbind(uricAcidItemLeuGouDiagnosesNotNull,uricAcidItemLeuGouDiagnosesNullNotNull) #5745 #5982
prefinalUricAcid <- prefinalUricAcid[order(prefinalUricAcid[,'SUBJECT_ID'],prefinalUricAcid[,'CHARTTIME']),] #sorting

removeValuesDiaUric <- function(diagnosesValues, uricAcidValues){
  tempDiagnoses <- diagnosesValues
  tempUricAcid <- uricAcidValues
  count <- 1
  for (i in 1:nrow(tempUricAcid)){
    for (j in 1:nrow(tempDiagnoses)){
      if ((tempUricAcid[i,2]==tempDiagnoses[j,2]) & (tempUricAcid[i,3]==tempDiagnoses[j,3]) & (count==1)){
        count <- 2
        resultUric <- tempUricAcid[i,]
        resultDiagnose <- tempDiagnoses[j,]
        cat("inside if \n")
        break
      }
      else if (tempUricAcid[i,2]==tempDiagnoses[j,2] & tempUricAcid[i,3]==tempDiagnoses[j,3] & count>1){
        resultUric <- rbind(resultUric, tempUricAcid[i,])
        if (resultDiagnose[nrow(resultDiagnose),] == tempDiagnoses[j,]){
          cat("inside else if \n")
          break
        }
        else{
          resultDiagnose <- rbind(resultDiagnose, tempDiagnoses[j,])
        }
        cat("inside else if \n", tempUricAcid[i,2], tempDiagnoses[j,2])
        break
      }
      else{
        cat("inside else \n", tempUricAcid[i,2], tempDiagnoses[j,2])
      }
    }
  }
  return(list(resultUric, resultDiagnose))
}

finalResultFunctionCall <- removeValuesDiaUric(findTotalDiagnosesPatientsSort,prefinalUricAcid)
finalDiagnoses <-  data.frame(finalResultFunctionCall[2]) #832 #577 #640
finalDiagnosesGout <- findRecordsHADM(finalDiagnoses, goutFinal) #334
finalDiagnosesLeukemia <- findRecordsHADM(finalDiagnoses, leukemiaFinal) #306
finalDiagnosesUnique <- finalDiagnoses[!duplicated(finalDiagnoses[,'SUBJECT_ID']),] #576 #640 #567
finalUricAcid <- data.frame(finalResultFunctionCall[1]) #5428 #5665
finalUricAcid <- finalUricAcid[order(finalUricAcid[,'SUBJECT_ID'],finalUricAcid[,'CHARTTIME']),] #5428 #5665

findRecordsHADM <- function(item, diagnosesId){
  itemTemp <- item
  count <- 1
  for (i in 1:nrow(diagnosesId)){
    for (j in 1:nrow(itemTemp)){
      if (diagnosesId[i,3]==itemTemp[j,3] && count==1){
        count <- 2
        result <- itemTemp[j,]
        break
        #itemTemp <- itemTemp[-c(j),]
      }
      else if (diagnosesId[i,3]==item[j,3]){
        result <- rbind(result, itemTemp[j,])
        break
        #itemTemp <- itemTemp[-c(j),]
      }
    }
  }
  return(result)
}

finalGout <- findRecordsHADM(gout,finalDiagnosesUnique) #289 #334 #311
finalLeukemia <- findRecordsHADM(leukemia,finalDiagnosesUnique) #287 #306 #256


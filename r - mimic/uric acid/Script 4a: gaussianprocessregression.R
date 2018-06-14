#0a. load final diagnoses
finalDiagnoses <- readRDS("/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/finalDiagnoses.rds")
finalDiagnosesUnique <- finalDiagnoses[!duplicated(finalDiagnoses[,'SUBJECT_ID']),]

#0b. installing packages
install.packages("ggplot2") #for plotting data
require(ggplot2)
install.packages("ggpubr") #for ggarrange function
require(ggpubr)
require(MASS) # for multivariate gaussian distribution, ginv

#0c. set seed value
set.seed(3) #doesn't solve any purpose 

#1a. load complete data 
exampleAddColumn <- readRDS("/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/uricConcentrations_Timeframe.rds")
exampleAddColumn <- cbind(GAUSSIANREGRESSION=0, exampleAddColumn) #add coloumn to store gaussian value

#1b. creating covariance function for preprocess gaussian regression
covarianceFunction <- function(t1, t2, variance=3, timescale=2, alpha=3){
  covariance <- matrix(rep(0, length(t1)*length(t2)), nrow=length(t1))
  for (i in 1:nrow(covariance)) {
    for (j in 1:ncol(covariance)) {
      num <- (t1[i]-t2[j])^2
      dem <- 2*alpha*(timescale^2)
      covariance[i,j] <- variance*((1 + (num/dem))^(-alpha))
    }
  }
  #covariance <- round(covariance, digits=2)
  return(covariance)
}

#1c. gaussaían regression
rowcount <- 1
for (i in 1:nrow(finalDiagnosesUnique)){
  sampledata <- subset(exampleAddColumn, exampleAddColumn$SUBJECT_ID==finalDiagnosesUnique[i,2])
  sampleuric <- sampledata$VALUENUM
  sampletimeframe <- sampledata$TIMEFRAME
  co <- covarianceFunction(sampletimeframe, sampletimeframe) #covariance matrix
  prior <- mvrnorm(1, rep(0, nrow(sampledata)), co) #calculating prior 
  invco <- ginv(co) #calculating inverse of covariance matrix
  te <- covarianceFunction(sampletimeframe,prior) #covariance between actual time and prior value
  mean <- t(te)%*%invco%*%sampleuric #calculating posterior mean
  variance <- covarianceFunction(prior,prior) - t(te)%*%invco%*%te #calculating posterior variance
  gau <- mvrnorm(1, mean, variance) #final result, probability density
  for (j in 1:length(gau)){
    exampleAddColumn[rowcount, 1] <- gau[j]
    rowcount <- rowcount + 1
  }
  cat(i, "\n")
}

#1d. plot for one subject_id
sampledata1 <- subset(exampleAddColumn, exampleAddColumn$SUBJECT_ID==23024)
figsampledata <- ggplot(sampledata1, aes(x=TIMEFRAME, y=VALUENUM)) + 
  geom_line(colour="blue") + 
  geom_point(data=sampledata1, aes(x=TIMEFRAME, y=VALUENUM)) +
  scale_y_continuous(lim=c(1.5,8), name="Uric Acid Concentration (mg/dL)") +
  scale_x_continuous(name="Time (days)") +
  ggtitle("Original Data Plot")

figsamplegau <- ggplot(sampledata1, aes(x=TIMEFRAME, y=sampledata1$GAUSSIANREGRESSION)) + 
  geom_line(colour="blue") + 
  geom_point(data=sampledata1, aes(x=TIMEFRAME, y=VALUENUM)) +
  scale_y_continuous(lim=c(1.5,8), name="Uric Acid Concentration (mg/dL)") +
  scale_x_continuous(name="Time (days)") +
  ggtitle("Transformed Data Plot")

ggarrange(figsampledata, figsamplegau, ncol = 2, nrow = 1)

#a different style of plot
a1 <- ggplot() + 
  geom_line(data=sampledata1, aes(x=TIMEFRAME, y=sampledata1$GAUSSIANREGRESSION, colour="orange")) + 
  geom_point(data=sampledata1, aes(x=TIMEFRAME, y=sampledata1$GAUSSIANREGRESSION, colour="orange")) +
  geom_point(data=sampledata1, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) +
  geom_line(data=sampledata1, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) + 
  scale_y_continuous(lim=c(1.5,8), name="Uric Acid (mg/dL)") +
  scale_x_continuous(name="Time (days)") +
  scale_colour_discrete(labels=c("original data", "transformed data")) +
  theme(legend.title=element_blank())

#1e. save final gaussian value
saveRDS(exampleAddColumn, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/gaussianData/gaussianRegression.rds")

#2a. load dataset for second example with different set of values of variance, timescale and alphs
exampleAddColumn1 <- readRDS("/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/uricConcentrations_Timeframe.rds")
exampleAddColumn1 <- cbind(GAUSSIANREGRESSION=0, exampleAddColumn1) #add coloumn to store gaussian value

#2b. new covariance function
covarianceFunction <- function(t1, t2, variance=1, timescale=2, alpha=3){
  covariance <- matrix(rep(0, length(t1)*length(t2)), nrow=length(t1))
  for (i in 1:nrow(covariance)) {
    for (j in 1:ncol(covariance)) {
      num <- (t1[i]-t2[j])^2
      dem <- 2*alpha*(timescale^2)
      covariance[i,j] <- variance*((1 + (num/dem))^(-alpha))
    }
  }
  #covariance <- round(covariance, digits=2)
  return(covariance)
}

#2c. gaussian regression
rowcount <- 1
for (i in 1:nrow(finalDiagnosesUnique)){
  sampledata <- subset(exampleAddColumn1, exampleAddColumn1$SUBJECT_ID==finalDiagnosesUnique[i,2])
  sampleuric <- sampledata$VALUENUM
  sampletimeframe <- sampledata$TIMEFRAME
  co <- covarianceFunction(sampletimeframe, sampletimeframe) #covariance matrix
  prior <- mvrnorm(1, rep(0, nrow(sampledata)), co) #calculating prior 
  invco <- ginv(co) #calculating inverse of covariance matrix
  te <- covarianceFunction(sampletimeframe,prior) #covariance between actual time and prior value
  mean <- t(te)%*%invco%*%sampleuric #calculating posterior mean
  variance <- covarianceFunction(prior,prior) - t(te)%*%invco%*%te #calculating posterior variance
  gau <- mvrnorm(1, mean, variance) #variance=3, timescale=2, alpha=3 #final result, probability density
  for (j in 1:length(gau)){
    exampleAddColumn1[rowcount, 1] <- gau[j]
    rowcount <- rowcount + 1
  }
  cat(i, "\n")
}

#2d. plot for one subject_id
sampledata2 <- subset(exampleAddColumn1, exampleAddColumn1$SUBJECT_ID==23024)
a2 <- ggplot() + 
  geom_line(data=sampledata2, aes(x=TIMEFRAME, y=sampledata2$GAUSSIANREGRESSION, colour="orange")) + 
  geom_point(data=sampledata2, aes(x=TIMEFRAME, y=sampledata2$GAUSSIANREGRESSION, colour="orange")) +
  geom_point(data=sampledata2, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) +
  geom_line(data=sampledata2, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) + 
  scale_y_continuous(lim=c(1.5,8), name="Uric Acid (mg/dL)") +
  scale_x_continuous(name="Time (days)") +
  scale_colour_discrete(labels=c("original data", "transformed data")) +
  theme(legend.title=element_blank())

#2e. save final gaussian value
saveRDS(exampleAddColumn1, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/gaussianData/gaussianRegression1.rds")

#3a. load dataset for second example with different set of values of variance, timescale and alphs
exampleAddColumn2 <- readRDS("/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/uricConcentrations_Timeframe.rds")
exampleAddColumn2 <- cbind(GAUSSIANREGRESSION=0, exampleAddColumn2) #add coloumn to store gaussian value

#3b. new covariance function
covarianceFunction <- function(t1, t2, variance=3, timescale=-2, alpha=1){
  covariance <- matrix(rep(0, length(t1)*length(t2)), nrow=length(t1))
  for (i in 1:nrow(covariance)) {
    for (j in 1:ncol(covariance)) {
      num <- (t1[i]-t2[j])^2
      dem <- 2*alpha*(timescale^2)
      covariance[i,j] <- variance*((1 + (num/dem))^(-alpha))
    }
  }
  #covariance <- round(covariance, digits=2)
  return(covariance)
}

#3c. gaussian regression
rowcount <- 1
for (i in 1:nrow(finalDiagnosesUnique)){
  sampledata <- subset(exampleAddColumn2, exampleAddColumn2$SUBJECT_ID==finalDiagnosesUnique[i,2])
  sampleuric <- sampledata$VALUENUM
  sampletimeframe <- sampledata$TIMEFRAME
  co <- covarianceFunction(sampletimeframe, sampletimeframe) #covariance matrix
  prior <- mvrnorm(1, rep(0, nrow(sampledata)), co) #calculating prior 
  invco <- ginv(co) #calculating inverse of covariance matrix
  te <- covarianceFunction(sampletimeframe,prior) #covariance between actual time and prior value
  mean <- t(te)%*%invco%*%sampleuric #calculating posterior mean
  variance <- covarianceFunction(prior,prior) - t(te)%*%invco%*%te #calculating posterior variance
  gau <- mvrnorm(1, mean, variance) #final result, probability density
  for (j in 1:length(gau)){
    exampleAddColumn2[rowcount, 1] <- gau[j]
    rowcount <- rowcount + 1
  }
  cat(i, "\n")
}

#3d. plot for one subject_id
sampledata3 <- subset(exampleAddColumn2, exampleAddColumn2$SUBJECT_ID==23024)
a3 <- ggplot() + 
  geom_line(data=sampledata3, aes(x=TIMEFRAME, y=sampledata3$GAUSSIANREGRESSION, colour="orange")) + 
  geom_point(data=sampledata3, aes(x=TIMEFRAME, y=sampledata3$GAUSSIANREGRESSION, colour="orange")) +
  geom_point(data=sampledata3, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) +
  geom_line(data=sampledata3, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) + 
  scale_y_continuous(lim=c(1.5,8), name="Uric Acid (mg/dL)") +
  scale_x_continuous(name="Time (days)") +
  scale_colour_discrete(labels=c("original data", "transformed data")) +
  theme(legend.title=element_blank())

#3e. save final gaussian value
saveRDS(exampleAddColumn2, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/gaussianData/gaussianRegression2.rds")

#4a. load dataset for second example with different set of values of variance, timescale and alphs
exampleAddColumn3 <- readRDS("/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/uricConcentrations_Timeframe.rds")
exampleAddColumn3 <- cbind(GAUSSIANREGRESSION=0, exampleAddColumn3) #add coloumn to store gaussian value

#4b. new covariance function
covarianceFunction <- function(t1, t2, variance=1, timescale=2, alpha=2){
  covariance <- matrix(rep(0, length(t1)*length(t2)), nrow=length(t1))
  for (i in 1:nrow(covariance)) {
    for (j in 1:ncol(covariance)) {
      num <- (t1[i]-t2[j])^2
      dem <- 2*alpha*(timescale^2)
      covariance[i,j] <- variance*((1 + (num/dem))^(-alpha))
    }
  }
  #covariance <- round(covariance, digits=2)
  return(covariance)
}

#4c. gaussian regression
rowcount <- 1
for (i in 1:nrow(finalDiagnosesUnique)){
  sampledata <- subset(exampleAddColumn3, exampleAddColumn3$SUBJECT_ID==finalDiagnosesUnique[i,2])
  sampleuric <- sampledata$VALUENUM
  sampletimeframe <- sampledata$TIMEFRAME
  co <- covarianceFunction(sampletimeframe, sampletimeframe) #covariance matrix
  prior <- mvrnorm(1, rep(0, nrow(sampledata)), co) #calculating prior 
  invco <- ginv(co) #calculating inverse of covariance matrix
  te <- covarianceFunction(sampletimeframe,prior) #covariance between actual time and prior value
  mean <- t(te)%*%invco%*%sampleuric #calculating posterior mean
  variance <- covarianceFunction(prior,prior) - t(te)%*%invco%*%te #calculating posterior variance
  gau <- mvrnorm(1, mean, variance) #final result, probability density
  for (j in 1:length(gau)){
    exampleAddColumn3[rowcount, 1] <- gau[j]
    rowcount <- rowcount + 1
  }
  cat(i, "\n")
}

#4d. plot for one subject_id
exampleAddColumn3 <- readRDS("/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/gaussianData/gaussianRegression3.rds")
sampledata <- subset(exampleAddColumn3, exampleAddColumn3$SUBJECT_ID==23024)
figsamplegau <- ggplot() + 
  geom_line(data=sampledata, aes(x=TIMEFRAME, y=sampledata$GAUSSIANREGRESSION, colour="orange")) + 
  geom_point(data=sampledata, aes(x=TIMEFRAME, y=sampledata$GAUSSIANREGRESSION, colour="orange")) +
  geom_point(data=sampledata, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) +
  geom_line(data=sampledata, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) + 
  scale_y_continuous(lim=c(1.5,8), name="Uric Acid Concentration (mg/dL)") +
  scale_x_continuous(name="Time (days)") +
  scale_colour_discrete(labels=c("original data", "transformed data")) +
  theme(legend.title=element_blank()) #so far good result

sampledata0 <- subset(exampleAddColumn3, exampleAddColumn3$SUBJECT_ID==2368)
figsamplegau1 <- ggplot() + 
  geom_line(data=sampledata0, aes(x=TIMEFRAME, y=sampledata0$GAUSSIANREGRESSION, colour="orange")) + 
  geom_point(data=sampledata0, aes(x=TIMEFRAME, y=sampledata0$GAUSSIANREGRESSION, colour="orange")) +
  geom_point(data=sampledata0, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) +
  geom_line(data=sampledata0, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) + 
  scale_y_continuous(lim=c(1.5,8), name="Uric Acid Concentration (mg/dL)") +
  scale_x_continuous(name="Time (days)") +
  scale_colour_discrete(labels=c("original data", "transformed data")) +
  theme(legend.title=element_blank())

ggarrange(figsamplegau, figsamplegau1, ncol = 2, nrow = 1, common.legend = TRUE,  labels = c("Sequence 1", "Sequence 2"))

#4e. save final gaussian value
saveRDS(exampleAddColumn3, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/gaussianData/gaussianRegression3.rds")

#5a. load dataset for second example with different set of values of variance, timescale and alphs
exampleAddColumn4 <- readRDS("/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/uricConcentrations_Timeframe.rds")
exampleAddColumn4 <- cbind(GAUSSIANREGRESSION=0, exampleAddColumn4) #add coloumn to store gaussian value

#5b. new covariance function
covarianceFunction <- function(t1, t2, variance=3, timescale=-1, alpha=3){
  covariance <- matrix(rep(0, length(t1)*length(t2)), nrow=length(t1))
  for (i in 1:nrow(covariance)) {
    for (j in 1:ncol(covariance)) {
      num <- (t1[i]-t2[j])^2
      dem <- 2*alpha*(timescale^2)
      covariance[i,j] <- variance*((1 + (num/dem))^(-alpha))
    }
  }
  #covariance <- round(covariance, digits=2)
  return(covariance)
}

#5c. gaussian regression
rowcount <- 1
for (i in 1:nrow(finalDiagnosesUnique)){
  sampledata <- subset(exampleAddColumn4, exampleAddColumn4$SUBJECT_ID==finalDiagnosesUnique[i,2])
  sampleuric <- sampledata$VALUENUM
  sampletimeframe <- sampledata$TIMEFRAME
  co <- covarianceFunction(sampletimeframe, sampletimeframe) #covariance matrix
  prior <- mvrnorm(1, rep(0, nrow(sampledata)), co) #calculating prior 
  invco <- ginv(co) #calculating inverse of covariance matrix
  te <- covarianceFunction(sampletimeframe,prior) #covariance between actual time and prior value
  mean <- t(te)%*%invco%*%sampleuric #calculating posterior mean
  variance <- covarianceFunction(prior,prior) - t(te)%*%invco%*%te #calculating posterior variance
  gau <- mvrnorm(1, mean, variance) #final result, probability density
  for (j in 1:length(gau)){
    exampleAddColumn4[rowcount, 1] <- gau[j]
    rowcount <- rowcount + 1
  }
  cat(i, "\n")
}

#5d. plot for one subject_id
sampledata4 <- subset(exampleAddColumn4, exampleAddColumn4$SUBJECT_ID==23024)
a4 <- ggplot() + 
  geom_line(data=sampledata4, aes(x=TIMEFRAME, y=sampledata4$GAUSSIANREGRESSION, colour="orange")) + 
  geom_point(data=sampledata4, aes(x=TIMEFRAME, y=sampledata4$GAUSSIANREGRESSION, colour="orange")) +
  geom_point(data=sampledata4, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) +
  geom_line(data=sampledata4, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) + 
  scale_y_continuous(lim=c(1.5,8), name="Uric Acid (mg/dL)") +
  scale_x_continuous(name="Time (days)") +
  scale_colour_discrete(labels=c("original data", "transformed data")) +
  theme(legend.title=element_blank())

#5e. save final gaussian value
saveRDS(exampleAddColumn4, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/gaussianData/gaussianRegression4.rds")

#6a. load dataset for second example with different set of values of variance, timescale and alphs
exampleAddColumn5 <- readRDS("/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/uricConcentrations_Timeframe.rds")
exampleAddColumn5 <- cbind(GAUSSIANREGRESSION=0, exampleAddColumn5) #add coloumn to store gaussian value

#6b. new covariance function
covarianceFunction <- function(t1, t2, variance=3, timescale=-1, alpha=2){
  covariance <- matrix(rep(0, length(t1)*length(t2)), nrow=length(t1))
  for (i in 1:nrow(covariance)) {
    for (j in 1:ncol(covariance)) {
      num <- (t1[i]-t2[j])^2
      dem <- 2*alpha*(timescale^2)
      covariance[i,j] <- variance*((1 + (num/dem))^(-alpha))
    }
  }
  #covariance <- round(covariance, digits=2)
  return(covariance)
}

#6c. gaussian regression
rowcount <- 1
for (i in 1:nrow(finalDiagnosesUnique)){
  sampledata <- subset(exampleAddColumn5, exampleAddColumn5$SUBJECT_ID==finalDiagnosesUnique[i,2])
  sampleuric <- sampledata$VALUENUM
  sampletimeframe <- sampledata$TIMEFRAME
  co <- covarianceFunction(sampletimeframe, sampletimeframe) #covariance matrix
  prior <- mvrnorm(1, rep(0, nrow(sampledata)), co) #calculating prior 
  invco <- ginv(co) #calculating inverse of covariance matrix
  te <- covarianceFunction(sampletimeframe,prior) #covariance between actual time and prior value
  mean <- t(te)%*%invco%*%sampleuric #calculating posterior mean
  variance <- covarianceFunction(prior,prior) - t(te)%*%invco%*%te #calculating posterior variance
  gau <- mvrnorm(1, mean, variance) #final result, probability density
  for (j in 1:length(gau)){
    exampleAddColumn5[rowcount, 1] <- gau[j]
    rowcount <- rowcount + 1
  }
  cat(i, "\n")
}

#6d. plot for one subject_id
sampledata5 <- subset(exampleAddColumn5, exampleAddColumn5$SUBJECT_ID==23024)
a5 <- ggplot() + 
  geom_line(data=sampledata5, aes(x=TIMEFRAME, y=sampledata5$GAUSSIANREGRESSION, colour="orange")) + 
  geom_point(data=sampledata5, aes(x=TIMEFRAME, y=sampledata5$GAUSSIANREGRESSION, colour="orange")) +
  geom_point(data=sampledata5, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) +
  geom_line(data=sampledata5, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) + 
  scale_y_continuous(lim=c(1.5,8), name="Uric Acid (mg/dL)") +
  scale_x_continuous(name="Time (days)") +
  scale_colour_discrete(labels=c("original data", "transformed data")) +
  theme(legend.title=element_blank())

#6e. save final gaussian value
saveRDS(exampleAddColumn5, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/gaussianData/gaussianRegression5.rds")

#7a. load dataset for second example with different set of values of variance, timescale and alphs
exampleAddColumn6 <- readRDS("/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/uricConcentrations_Timeframe.rds")
exampleAddColumn6 <- cbind(GAUSSIANREGRESSION=0, exampleAddColumn6) #add coloumn to store gaussian value

#7b. new covariance function
covarianceFunction <- function(t1, t2, variance=1, timescale=-1, alpha=1){
  covariance <- matrix(rep(0, length(t1)*length(t2)), nrow=length(t1))
  for (i in 1:nrow(covariance)) {
    for (j in 1:ncol(covariance)) {
      num <- (t1[i]-t2[j])^2
      dem <- 2*alpha*(timescale^2)
      covariance[i,j] <- variance*((1 + (num/dem))^(-alpha))
    }
  }
  #covariance <- round(covariance, digits=2)
  return(covariance)
}

#7c. gaussian regression
rowcount <- 1
for (i in 1:nrow(finalDiagnosesUnique)){
  sampledata <- subset(exampleAddColumn6, exampleAddColumn6$SUBJECT_ID==finalDiagnosesUnique[i,2])
  sampleuric <- sampledata$VALUENUM
  sampletimeframe <- sampledata$TIMEFRAME
  co <- covarianceFunction(sampletimeframe, sampletimeframe) #covariance matrix
  prior <- mvrnorm(1, rep(0, nrow(sampledata)), co) #calculating prior 
  invco <- ginv(co) #calculating inverse of covariance matrix
  te <- covarianceFunction(sampletimeframe,prior) #covariance between actual time and prior value
  mean <- t(te)%*%invco%*%sampleuric #calculating posterior mean
  variance <- covarianceFunction(prior,prior) - t(te)%*%invco%*%te #calculating posterior variance
  gau <- mvrnorm(1, mean, variance) #final result, probability density
  for (j in 1:length(gau)){
    exampleAddColumn6[rowcount, 1] <- gau[j]
    rowcount <- rowcount + 1
  }
  cat(i, "\n")
}

#7d. plot for one subject_id
sampledata6 <- subset(exampleAddColumn6, exampleAddColumn6$SUBJECT_ID==23024)
a6 <- ggplot() + 
  geom_line(data=sampledata6, aes(x=TIMEFRAME, y=sampledata6$GAUSSIANREGRESSION, colour="orange")) + 
  geom_point(data=sampledata6, aes(x=TIMEFRAME, y=sampledata6$GAUSSIANREGRESSION, colour="orange")) +
  geom_point(data=sampledata6, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) +
  geom_line(data=sampledata6, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) + 
  scale_y_continuous(lim=c(1.5,8), name="Uric Acid (mg/dL)") +
  scale_x_continuous(name="Time (days)") +
  scale_colour_discrete(labels=c("original data", "transformed data")) +
  theme(legend.title=element_blank()) #not good

#7e. save final gaussian value
saveRDS(exampleAddColumn6, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/gaussianData/gaussianRegression6.rds")

#8a. load dataset for second example with different set of values of variance, timescale and alphs
exampleAddColumn7 <- readRDS("/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/uricConcentrations_Timeframe.rds")
exampleAddColumn7 <- cbind(GAUSSIANREGRESSION=0, exampleAddColumn7) #add coloumn to store gaussian value

#8b. new covariance function
covarianceFunction <- function(t1, t2, variance=1, timescale=-1, alpha=3){
  covariance <- matrix(rep(0, length(t1)*length(t2)), nrow=length(t1))
  for (i in 1:nrow(covariance)) {
    for (j in 1:ncol(covariance)) {
      num <- (t1[i]-t2[j])^2
      dem <- 2*alpha*(timescale^2)
      covariance[i,j] <- variance*((1 + (num/dem))^(-alpha))
    }
  }
  #covariance <- round(covariance, digits=2)
  return(covariance)
}

#8c. gaussian regression
rowcount <- 1
for (i in 1:nrow(finalDiagnosesUnique)){
  sampledata <- subset(exampleAddColumn7, exampleAddColumn7$SUBJECT_ID==finalDiagnosesUnique[i,2])
  sampleuric <- sampledata$VALUENUM
  sampletimeframe <- sampledata$TIMEFRAME
  co <- covarianceFunction(sampletimeframe, sampletimeframe) #covariance matrix
  prior <- mvrnorm(1, rep(0, nrow(sampledata)), co) #calculating prior 
  invco <- ginv(co) #calculating inverse of covariance matrix
  te <- covarianceFunction(sampletimeframe,prior) #covariance between actual time and prior value
  mean <- t(te)%*%invco%*%sampleuric #calculating posterior mean
  variance <- covarianceFunction(prior,prior) - t(te)%*%invco%*%te #calculating posterior variance
  gau <- mvrnorm(1, mean, variance) #final result, probability density
  for (j in 1:length(gau)){
    exampleAddColumn7[rowcount, 1] <- gau[j]
    rowcount <- rowcount + 1
  }
  cat(i, "\n")
}

#8d. plot for one subject_id
sampledata7 <- subset(exampleAddColumn7, exampleAddColumn7$SUBJECT_ID==23024)
a7 <- ggplot() + 
  geom_line(data=sampledata7, aes(x=TIMEFRAME, y=sampledata7$GAUSSIANREGRESSION, colour="orange")) + 
  geom_point(data=sampledata7, aes(x=TIMEFRAME, y=sampledata7$GAUSSIANREGRESSION, colour="orange")) +
  geom_point(data=sampledata7, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) +
  geom_line(data=sampledata7, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) + 
  scale_y_continuous(lim=c(1.5,8), name="Uric Acid (mg/dL)") +
  scale_x_continuous(name="Time (days)") +
  scale_colour_discrete(labels=c("original data", "transformed data")) +
  theme(legend.title=element_blank()) #not good

#8e. save final gaussian value
saveRDS(exampleAddColumn7, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/gaussianData/gaussianRegression7.rds")

#9a. load dataset for second example with different set of values of variance, timescale and alphs
exampleAddColumn8 <- readRDS("/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/uricConcentrations_Timeframe.rds")
exampleAddColumn8 <- cbind(GAUSSIANREGRESSION=0, exampleAddColumn8) #add coloumn to store gaussian value

#9b. new covariance function
covarianceFunction <- function(t1, t2, variance=3, timescale=-3, alpha=3){
  covariance <- matrix(rep(0, length(t1)*length(t2)), nrow=length(t1))
  for (i in 1:nrow(covariance)) {
    for (j in 1:ncol(covariance)) {
      num <- (t1[i]-t2[j])^2
      dem <- 2*alpha*(timescale^2)
      covariance[i,j] <- variance*((1 + (num/dem))^(-alpha))
    }
  }
  #covariance <- round(covariance, digits=2)
  return(covariance)
}

#9c. gaussian regression
rowcount <- 1
for (i in 1:nrow(finalDiagnosesUnique)){
  sampledata <- subset(exampleAddColumn8, exampleAddColumn8$SUBJECT_ID==finalDiagnosesUnique[i,2])
  sampleuric <- sampledata$VALUENUM
  sampletimeframe <- sampledata$TIMEFRAME
  co <- covarianceFunction(sampletimeframe, sampletimeframe) #covariance matrix
  prior <- mvrnorm(1, rep(0, nrow(sampledata)), co) #calculating prior 
  invco <- ginv(co) #calculating inverse of covariance matrix
  te <- covarianceFunction(sampletimeframe,prior) #covariance between actual time and prior value
  mean <- t(te)%*%invco%*%sampleuric #calculating posterior mean
  variance <- covarianceFunction(prior,prior) - t(te)%*%invco%*%te #calculating posterior variance
  gau <- mvrnorm(1, mean, variance) #final result, probability density
  for (j in 1:length(gau)){
    exampleAddColumn8[rowcount, 1] <- gau[j]
    rowcount <- rowcount + 1
  }
  cat(i, "\n")
}

#9d. plot for one subject_id
sampledata8 <- subset(exampleAddColumn8, exampleAddColumn8$SUBJECT_ID==23024)
a8 <- ggplot() + 
  geom_line(data=sampledata8, aes(x=TIMEFRAME, y=sampledata8$GAUSSIANREGRESSION, colour="orange")) + 
  geom_point(data=sampledata8, aes(x=TIMEFRAME, y=sampledata8$GAUSSIANREGRESSION, colour="orange")) +
  geom_point(data=sampledata8, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) +
  geom_line(data=sampledata8, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) + 
  scale_y_continuous(lim=c(1.5,8), name="Uric Acid (mg/dL)") +
  scale_x_continuous(name="Time (days)") +
  scale_colour_discrete(labels=c("original data", "transformed data")) +
  theme(legend.title=element_blank()) #not good

#9e. save final gaussian value
saveRDS(exampleAddColumn8, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/gaussianData/gaussianRegression8.rds")

#cumulative arrangement of graphs
ggarrange(a1, a2, a3, a4, a5, a6, a7, a8, ncol = 3, nrow = 3, common.legend = TRUE,  labels = c("a", "b", "c", "d", "e", "f", "g", "h"))


#10. to plot graphs for different iterations
covarianceFunction <- function(t1, t2, variance=2.7, timescale=1, alpha=0.16){
  covariance <- matrix(rep(0, length(t1)*length(t2)), nrow=length(t1))
  for (i in 1:nrow(covariance)) {
    for (j in 1:ncol(covariance)) {
      num <- (t1[i]-t2[j])^2
      dem <- 2*alpha*(timescale^2)
      covariance[i,j] <- variance*((1 + (num/dem))^(-alpha))
    }
  }
  #covariance <- round(covariance, digits=2)
  return(covariance)
}
rowcount <- 1
for (i in 1:nrow(finalDiagnosesUnique)){
  sampledata <- subset(exampleAddColumn8, exampleAddColumn8$SUBJECT_ID==finalDiagnosesUnique[i,2])
  sampleuric <- sampledata$VALUENUM
  sampletimeframe <- sampledata$TIMEFRAME
  co <- covarianceFunction(sampletimeframe, sampletimeframe) #covariance matrix
  prior <- mvrnorm(1, rep(0, nrow(sampledata)), co) #calculating prior 
  invco <- ginv(co) #calculating inverse of covariance matrix
  te <- covarianceFunction(sampletimeframe,prior) #covariance between actual time and prior value
  mean <- t(te)%*%invco%*%sampleuric #calculating posterior mean
  variance <- covarianceFunction(prior,prior) - t(te)%*%invco%*%te #calculating posterior variance
  gau <- mvrnorm(1, mean, variance) #final result, probability density
  for (j in 1:length(gau)){
    exampleAddColumn8[rowcount, 1] <- gau[j]
    rowcount <- rowcount + 1
  }
  cat(i, "\n")
}

sampledata9 <- subset(exampleAddColumn8, exampleAddColumn8$SUBJECT_ID==23024)
i1 <- ggplot() + 
  geom_line(data=sampledata9, aes(x=TIMEFRAME, y=sampledata9$GAUSSIANREGRESSION, colour="orange")) + 
  geom_point(data=sampledata9, aes(x=TIMEFRAME, y=sampledata9$GAUSSIANREGRESSION, colour="orange")) +
  geom_point(data=sampledata9, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) +
  geom_line(data=sampledata9, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) + 
  scale_y_continuous(lim=c(1.5,8), name="Uric Acid (mg/dL)") +
  scale_x_continuous(name="Time (days)") +
  scale_colour_discrete(labels=c("original data", "transformed data")) +
  theme(legend.title=element_blank())

sampledata10 <- subset(exampleAddColumn8, exampleAddColumn8$SUBJECT_ID==23024)
i2 <- ggplot() + 
  geom_line(data=sampledata10, aes(x=TIMEFRAME, y=sampledata10$GAUSSIANREGRESSION, colour="orange")) + 
  geom_point(data=sampledata10, aes(x=TIMEFRAME, y=sampledata10$GAUSSIANREGRESSION, colour="orange")) +
  geom_point(data=sampledata10, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) +
  geom_line(data=sampledata10, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) + 
  scale_y_continuous(lim=c(1.5,8), name="Uric Acid (mg/dL)") +
  scale_x_continuous(name="Time (days)") +
  scale_colour_discrete(labels=c("original data", "transformed data")) +
  theme(legend.title=element_blank())

sampledata11 <- subset(exampleAddColumn8, exampleAddColumn8$SUBJECT_ID==23024)
i3 <- ggplot() + 
  geom_line(data=sampledata11, aes(x=TIMEFRAME, y=sampledata11$GAUSSIANREGRESSION, colour="orange")) + 
  geom_point(data=sampledata11, aes(x=TIMEFRAME, y=sampledata11$GAUSSIANREGRESSION, colour="orange")) +
  geom_point(data=sampledata11, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) +
  geom_line(data=sampledata11, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) + 
  scale_y_continuous(lim=c(1.5,8), name="Uric Acid (mg/dL)") +
  scale_x_continuous(name="Time (days)") +
  scale_colour_discrete(labels=c("original data", "transformed data")) +
  theme(legend.title=element_blank())

ggarrange(i1, i2, i3, ncol = 3, nrow = 1, common.legend = TRUE,  labels = c("Iteration 1", "Iteration 2", "Iteration 3"))


#11

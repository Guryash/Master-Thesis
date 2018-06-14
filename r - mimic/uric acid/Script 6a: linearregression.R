#0a. installing packages
install.packages("ggplot2") #for plotting data
require(ggplot2)
install.packages("ggpubr") #for ggarrange function
require(ggpubr)


#---------- 1st transformation ----------
#0. load complete data 
example <- readRDS("/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/originalData/original5665*4.rds")
example <- data.frame(example) #change the data type

#1a. check data types in 'example' as factor data type with more than 53 entries cannot be used by randomforest function
str(example)

#1b. change factor data type to numeric
example[,1] <- as.numeric(levels(example[,1]))[example[,1]]
example[,2] <- as.numeric(levels(example[,2]))[example[,2]]
example[,3] <- as.numeric(levels(example[,3]))[example[,3]]
example[,4] <- as.numeric(levels(example[,4]))[example[,4]]

#1c. call linear regression function
lmMod <- lm(VALUENUM ~ ., data=example) 

#1d. use fitted values calculated by the function
example <- cbind(lmMod$fitted.values, example)
colnames(example) <- c("Linear", "TIMEFRAME", "CLASS_LABEL", "SUBJECT_ID", "VALUENUM")

#1e. take 1 sequence to plot the data
sam1 <- subset(example, example$SUBJECT_ID==23024)
lm1 <- ggplot() + 
  geom_point(data=sam1, aes(x=TIMEFRAME, y=VALUENUM, colour="blue")) +
  geom_line(data=sam1, aes(x=TIMEFRAME, y=VALUENUM, colour="blue")) +
  geom_line(data=sam1, aes(x=TIMEFRAME, y=Linear, colour="red")) + 
  geom_point(data=sam1, aes(x=TIMEFRAME, y=Linear, colour="red")) +
  scale_y_continuous(lim=c(1.5,9), name="Uric Acid (mg/dL)") +
  scale_x_continuous(name="Time (days)") +
  scale_colour_discrete(labels=c("original data", "transformed data")) +
  theme(legend.title=element_blank())

#1f. take 2 sequence to plot the data
sam <- subset(example, example$SUBJECT_ID==2368)
lm2 <- ggplot() + 
  geom_line(data=sam, aes(x=TIMEFRAME, y=Linear, colour="orange")) + 
  geom_point(data=sam, aes(x=TIMEFRAME, y=Linear, colour="orange")) +
  geom_point(data=sam, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) +
  geom_line(data=sam, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) + 
  scale_y_continuous(lim=c(1.5,9), name="Uric Acid (mg/dL)") +
  scale_x_continuous(name="Time (days)") +
  scale_colour_discrete(labels=c("original data", "transformed data")) +
  theme(legend.title=element_blank())

#1g. display plots
ggarrange(lm1, lm2, ncol = 2, nrow = 1, common.legend = TRUE,  labels = c("Sequence 1", "Sequence 2"))


#---------- 2nd transformation ----------
#0. load complete data 
example <- readRDS("/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/originalData/original5665*4.rds")
example <- data.frame(example) #change the data type

#2a. check data types in 'example' as factor data type with more than 53 entries cannot be used by randomforest function
str(example)

#2b. change factor data type to numeric if factor
example[,1] <- as.numeric(levels(example[,1]))[example[,1]]
example[,2] <- as.numeric(levels(example[,2]))[example[,2]]
example[,3] <- as.numeric(levels(example[,3]))[example[,3]]
example[,4] <- as.numeric(levels(example[,4]))[example[,4]]

#2c. call linear function
lmMod <- lm(VALUENUM ~ TIMEFRAME , data=example) 

#2d. use fitted values calculated by the function
example <- cbind(lmMod$fitted.values, example)
colnames(example) <- c("Linear", "TIMEFRAME", "CLASS_LABEL", "SUBJECT_ID", "VALUENUM")

#2e. take 1 sequence to plot the data
sam3 <- subset(example, example$SUBJECT_ID==23024)
lm3 <- ggplot() + 
  geom_line(data=sam3, aes(x=TIMEFRAME, y=Linear, colour="orange")) + 
  geom_point(data=sam3, aes(x=TIMEFRAME, y=Linear, colour="orange")) +
  geom_point(data=sam3, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) +
  geom_line(data=sam3, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) + 
  scale_y_continuous(lim=c(1.5,9), name="Uric Acid (mg/dL)") +
  scale_x_continuous(name="Time (days)") +
  scale_colour_discrete(labels=c("original data", "transformed data")) +
  theme(legend.title=element_blank())

#2f. take 2 sequence to plot the data
sam2 <- subset(example, example$SUBJECT_ID==2368)
lm4 <- ggplot() + 
  geom_line(data=sam2, aes(x=TIMEFRAME, y=Linear, colour="orange")) + 
  geom_point(data=sam2, aes(x=TIMEFRAME, y=Linear, colour="orange")) +
  geom_point(data=sam2, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) +
  geom_line(data=sam2, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) + 
  scale_y_continuous(lim=c(1.5,9), name="Uric Acid (mg/dL)") +
  scale_x_continuous(name="Time (days)") +
  scale_colour_discrete(labels=c("original data", "transformed data")) +
  theme(legend.title=element_blank())

#2g. display plots
ggarrange(lm3, lm4, ncol = 2, nrow = 1, common.legend = TRUE,  labels = c("Sequence 1", "Sequence 2"))

#---------- 3rd transformation ----------
#0. load complete data 
example <- readRDS("/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/originalData/original5665*4.rds")
example <- data.frame(example) #change the data type

#3a. check data types in 'example' as factor data type with more than 53 entries cannot be used by randomforest function
str(example)

#3b. change factor data type to numeric if factor
example[,1] <- as.numeric(levels(example[,1]))[example[,1]]
example[,2] <- as.numeric(levels(example[,2]))[example[,2]]
example[,3] <- as.numeric(levels(example[,3]))[example[,3]]
example[,4] <- as.numeric(levels(example[,4]))[example[,4]]

#3c. call linear function
lmMod <- lm(VALUENUM ~ TIMEFRAME + CLASS_LABEL , data=example) 

#3d. use fitted values calculated by the function
example <- cbind(lmMod$fitted.values, example)
colnames(example) <- c("Linear", "TIMEFRAME", "CLASS_LABEL", "SUBJECT_ID", "VALUENUM")

#3e. take 1 sequence to plot the data
sam3 <- subset(example, example$SUBJECT_ID==23024)
lm3 <- ggplot() + 
  geom_line(data=sam3, aes(x=TIMEFRAME, y=Linear, colour="orange")) + 
  geom_point(data=sam3, aes(x=TIMEFRAME, y=Linear, colour="orange")) +
  geom_point(data=sam3, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) +
  geom_line(data=sam3, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) + 
  scale_y_continuous(lim=c(1.5,9), name="Uric Acid (mg/dL)") +
  scale_x_continuous(name="Time (days)") +
  scale_colour_discrete(labels=c("original data", "transformed data")) +
  theme(legend.title=element_blank())

#3f. take 2 sequence to plot the data
sam2 <- subset(example, example$SUBJECT_ID==2368)
lm4 <- ggplot() + 
  geom_line(data=sam2, aes(x=TIMEFRAME, y=Linear, colour="orange")) + 
  geom_point(data=sam2, aes(x=TIMEFRAME, y=Linear, colour="orange")) +
  geom_point(data=sam2, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) +
  geom_line(data=sam2, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) + 
  scale_y_continuous(lim=c(1.5,9), name="Uric Acid (mg/dL)") +
  scale_x_continuous(name="Time (days)") +
  scale_colour_discrete(labels=c("original data", "transformed data")) +
  theme(legend.title=element_blank())

#3g. display plots
ggarrange(lm3, lm4, ncol = 2, nrow = 1, common.legend = TRUE,  labels = c("Sequence 1", "Sequence 2"))

#---------- 4th transformation ----------
#0. load complete data 
example <- readRDS("/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/originalData/original5665*4.rds")
example <- data.frame(example) #change the data type

#4a. check data types in 'example' as factor data type with more than 53 entries cannot be used by randomforest function
str(example)

#4b. change factor data type to numeric if factor
example[,1] <- as.numeric(levels(example[,1]))[example[,1]]
example[,2] <- as.numeric(levels(example[,2]))[example[,2]]
example[,3] <- as.numeric(levels(example[,3]))[example[,3]]
example[,4] <- as.numeric(levels(example[,4]))[example[,4]]

#4c. call linear function
lmMod <- lm(VALUENUM + CLASS_LABEL ~ TIMEFRAME, data=example) 

#4d. use fitted values calculated by the function
example <- cbind(lmMod$fitted.values, example)
colnames(example) <- c("Linear", "TIMEFRAME", "CLASS_LABEL", "SUBJECT_ID", "VALUENUM")

#4e. take 1 sequence to plot the data
sam3 <- subset(example, example$SUBJECT_ID==23024)
lm3 <- ggplot() + 
  geom_line(data=sam3, aes(x=TIMEFRAME, y=Linear, colour="orange")) + 
  geom_point(data=sam3, aes(x=TIMEFRAME, y=Linear, colour="orange")) +
  geom_point(data=sam3, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) +
  geom_line(data=sam3, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) + 
  scale_y_continuous(lim=c(1.5,9), name="Uric Acid (mg/dL)") +
  scale_x_continuous(name="Time (days)") +
  scale_colour_discrete(labels=c("original data", "transformed data")) +
  theme(legend.title=element_blank())

#4f. take 2 sequence to plot the data
sam2 <- subset(example, example$SUBJECT_ID==2368)
lm4 <- ggplot() + 
  geom_line(data=sam2, aes(x=TIMEFRAME, y=Linear, colour="orange")) + 
  geom_point(data=sam2, aes(x=TIMEFRAME, y=Linear, colour="orange")) +
  geom_point(data=sam2, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) +
  geom_line(data=sam2, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) + 
  scale_y_continuous(lim=c(1.5,9), name="Uric Acid (mg/dL)") +
  scale_x_continuous(name="Time (days)") +
  scale_colour_discrete(labels=c("original data", "transformed data")) +
  theme(legend.title=element_blank())

#4g. display plots
ggarrange(lm3, lm4, ncol = 2, nrow = 1, common.legend = TRUE,  labels = c("Sequence 1", "Sequence 2"))


#---------- 5th transformation ----------
#0. load complete data 
example <- readRDS("/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/originalData/original5665*4.rds")
example <- data.frame(example) #change the data type

#5a. check data types in 'example' as factor data type with more than 53 entries cannot be used by randomforest function
str(example)

#5b. change factor data type to numeric if factor
example[,1] <- as.numeric(levels(example[,1]))[example[,1]]
example[,2] <- as.numeric(levels(example[,2]))[example[,2]]
example[,3] <- as.numeric(levels(example[,3]))[example[,3]]
example[,4] <- as.numeric(levels(example[,4]))[example[,4]]

#5c. call linear function
lmMod <- lm(VALUENUM ~ TIMEFRAME, data=example) 

#5d. use fitted values calculated by the function
example <- cbind(lmMod$fitted.values, example)
colnames(example) <- c("Linear", "TIMEFRAME", "CLASS_LABEL", "SUBJECT_ID", "VALUENUM")

#5e. take 1 sequence to plot the data
sam3 <- subset(example, example$SUBJECT_ID==23024)
lm3 <- ggplot() + 
  geom_line(data=sam3, aes(x=TIMEFRAME, y=Linear, colour="orange")) + 
  geom_point(data=sam3, aes(x=TIMEFRAME, y=Linear, colour="orange")) +
  geom_point(data=sam3, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) +
  geom_line(data=sam3, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) + 
  scale_y_continuous(lim=c(1.5,8), name="Uric Acid (mg/dL)") +
  scale_x_continuous(name="Time (days)") +
  scale_colour_discrete(labels=c("original data", "transformed data")) +
  theme(legend.title=element_blank())

#5f. take 2 sequence to plot the data
sam2 <- subset(example, example$SUBJECT_ID==2368)
lm4 <- ggplot() + 
  geom_line(data=sam2, aes(x=TIMEFRAME, y=Linear, colour="orange")) + 
  geom_point(data=sam2, aes(x=TIMEFRAME, y=Linear, colour="orange")) +
  geom_point(data=sam2, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) +
  geom_line(data=sam2, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) + 
  scale_y_continuous(lim=c(1.5,8), name="Uric Acid (mg/dL)") +
  scale_x_continuous(name="Time (days)") +
  scale_colour_discrete(labels=c("original data", "transformed data")) +
  theme(legend.title=element_blank())

#5g. display plots
ggarrange(lm3, lm4, ncol = 2, nrow = 1, common.legend = TRUE,  labels = c("Sequence 1", "Sequence 2"))


#---------- 6ath transformation ----------
#0. load complete data 
example <- readRDS("/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/originalData/original5665*4.rds")
example <- data.frame(example) #change the data type

#6a. check data types in 'example' as factor data type with more than 53 entries cannot be used by randomforest function
str(example)

#6b. change factor data type to numeric if factor
example[,1] <- as.numeric(levels(example[,1]))[example[,1]]
example[,2] <- as.numeric(levels(example[,2]))[example[,2]]
example[,3] <- as.numeric(levels(example[,3]))[example[,3]]
example[,4] <- as.numeric(levels(example[,4]))[example[,4]]

#6c. considering 1 sequence
sample <- subset(example, example$SUBJECT_ID==2368)

#6d. call linear function
lmMod <- lm(VALUENUM  ~ TIMEFRAME, data=sample) 

#6e. use fitted values calculated by the function
sample <- cbind(lmMod$fitted.values, sample)
colnames(sample) <- c("Linear", "TIMEFRAME", "CLASS_LABEL", "SUBJECT_ID", "VALUENUM")

#6f. take 1 sequence to plot the data
lm6 <- ggplot() + 
  geom_line(data=sample, aes(x=TIMEFRAME, y=Linear, colour="orange")) + 
  geom_point(data=sample, aes(x=TIMEFRAME, y=Linear, colour="orange")) +
  geom_point(data=sample, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) +
  geom_line(data=sample, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) + 
  scale_y_continuous(lim=c(1.5,9), name="Uric Acid (mg/dL)") +
  scale_x_continuous(name="Time (days)") +
  scale_colour_discrete(labels=c("original data", "transformed data")) +
  theme(legend.title=element_blank())

#---------- 6bth transformation ----------
#0. load complete data 
example <- readRDS("/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/originalData/original5665*4.rds")
example <- data.frame(example) #change the data type

#6a. check data types in 'example' as factor data type with more than 53 entries cannot be used by randomforest function
str(example)

#6b. change factor data type to numeric if factor
example[,1] <- as.numeric(levels(example[,1]))[example[,1]]
example[,2] <- as.numeric(levels(example[,2]))[example[,2]]
example[,3] <- as.numeric(levels(example[,3]))[example[,3]]
example[,4] <- as.numeric(levels(example[,4]))[example[,4]]

#6c. considering single different sequence
sample <- subset(example, example$SUBJECT_ID==23024)

#6d. call linear function
lmMod <- lm(VALUENUM  ~ TIMEFRAME, data=sample) 

#6e. use fitted values calculated by the function
sample <- cbind(lmMod$fitted.values, sample)
colnames(sample) <- c("Linear", "TIMEFRAME", "CLASS_LABEL", "SUBJECT_ID", "VALUENUM")

#6f. take 1 sequence to plot the data
lm7 <- ggplot() + 
  geom_line(data=sample, aes(x=TIMEFRAME, y=Linear, colour="orange")) + 
  geom_point(data=sample, aes(x=TIMEFRAME, y=Linear, colour="orange")) +
  geom_point(data=sample, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) +
  geom_line(data=sample, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) + 
  scale_y_continuous(lim=c(1.5,9), name="Uric Acid (mg/dL)") +
  scale_x_continuous(name="Time (days)") +
  scale_colour_discrete(labels=c("original data", "transformed data")) +
  theme(legend.title=element_blank())

ggarrange(lm6, lm7, ncol = 2, nrow = 1, common.legend = TRUE,  labels = c("Sequence 1", "Sequence 2"))


#---------- FINAL transformation (6ath and 6bth worked yay!!!) ----------
#0a. load final diagnoses unique
finalDiagnoses <- readRDS("/home/pinkpanther/Documents/Studies/Semester 6 & 7 - Master Thesis/Data/r/mimic/uric acid/finalDiagnoses.rds") #640
finalDiagnoses <- finalDiagnoses[!duplicated(finalDiagnoses[,'SUBJECT_ID']),] #keeping unique values #567

#0b. load complete data 
example <- readRDS("/home/pinkpanther/Documents/Studies/Semester 6 & 7 - Master Thesis/Data/r/mimic/uric acid/originalData/original5665*4.rds")
example <- data.frame(example) #change the data type 

#7a. add new column 'LINEAR' to 'example
example <- cbind(LINEAR=0,example)

#7b. check data types in 'example' as factor data type with more than 53 entries cannot be used by randomforest function
str(example)

#7c. change factor data type to numeric if factor
example[,2] <- as.numeric(levels(example[,2]))[example[,2]]
example[,4] <- as.numeric(levels(example[,4]))[example[,4]]
example[,5] <- as.numeric(levels(example[,5]))[example[,5]]

#7d. linear regression one sequence at a time
count = 0
for (i in 1:nrow(finalDiagnoses)) {
  sample <- subset(example, example$SUBJECT_ID==finalDiagnoses[i,2])
  lmMod <- lm(VALUENUM  ~ TIMEFRAME, data=sample) 
  for (j in 1:nrow(sample)) {
    example[j+count, 1] <- lmMod$fitted.values[j]
  }
  count <- nrow(sample) + count
}

#7e. take 1 sequence to plot the data
sam1 <- subset(example, example$SUBJECT_ID==23024)
lm1 <- ggplot() + 
  geom_line(data=sam1, aes(x=TIMEFRAME, y=LINEAR, colour="orange")) + 
  geom_point(data=sam1, aes(x=TIMEFRAME, y=LINEAR, colour="orange")) +
  geom_point(data=sam1, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) +
  geom_line(data=sam1, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) + 
  scale_y_continuous(lim=c(1,8.5), name="Uric Acid (mg/dL)") +
  scale_x_continuous(name="Time (days)") +
  scale_colour_discrete(labels=c("original data", "transformed data")) +
  theme(legend.title=element_blank())

#7f. take 2 sequence to plot the data
sam2 <- subset(example, example$SUBJECT_ID==2368)
lm2 <- ggplot() + 
  geom_line(data=sam2, aes(x=TIMEFRAME, y=LINEAR, colour="orange")) + 
  geom_point(data=sam2, aes(x=TIMEFRAME, y=LINEAR, colour="orange")) +
  geom_point(data=sam2, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) +
  geom_line(data=sam2, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) + 
  scale_y_continuous(lim=c(1,8.5), name="Uric Acid (mg/dL)") +
  scale_x_continuous(name="Time (days)") +
  scale_colour_discrete(labels=c("original data", "transformed data")) +
  theme(legend.title=element_blank())

#7g. take 3 sequence to plot the data
sam3 <- subset(example, example$SUBJECT_ID==27568)
lm3 <- ggplot() + 
  geom_line(data=sam3, aes(x=TIMEFRAME, y=LINEAR, colour="orange")) + 
  geom_point(data=sam3, aes(x=TIMEFRAME, y=LINEAR, colour="orange")) +
  geom_point(data=sam3, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) +
  geom_line(data=sam3, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) + 
  scale_y_continuous(lim=c(1,8.5), name="Uric Acid (mg/dL)") +
  scale_x_continuous(name="Time (days)") +
  scale_colour_discrete(labels=c("original data", "transformed data")) +
  theme(legend.title=element_blank())

#7h. take 4 sequence to plot the data
sam4 <- subset(example, example$SUBJECT_ID==42589)
lm4 <- ggplot() + 
  geom_line(data=sam4, aes(x=TIMEFRAME, y=LINEAR, colour="orange")) + 
  geom_point(data=sam4, aes(x=TIMEFRAME, y=LINEAR, colour="orange")) +
  geom_point(data=sam4, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) +
  geom_line(data=sam4, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) + 
  scale_y_continuous(lim=c(1,8.5), name="Uric Acid (mg/dL)") +
  scale_x_continuous(name="Time (days)") +
  scale_colour_discrete(labels=c("original data", "transformed data")) +
  theme(legend.title=element_blank())


#7i. display plots
ggarrange(lm1, lm2, lm3, lm4, ncol = 2, nrow = 2, common.legend = TRUE,  labels = c("Sequence 1", "Sequence 2","Sequence 3", "Sequence 4"))

#7j. save the result
saveRDS(example, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/linearData/lineardata.rds") #easier to read in R


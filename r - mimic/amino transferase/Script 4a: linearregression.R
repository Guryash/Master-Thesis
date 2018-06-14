#0a. installing packages
install.packages("ggplot2") #for plotting data
require(ggplot2)
install.packages("ggpubr") #for ggarrange function
require(ggpubr)

#1a. load the data 
aminotransferaseFinal <- readRDS("/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/mimic/amino transferase/aminotransferaseFinal_Timeframe.rds")
diagnosesFinal <- readRDS("/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/mimic/amino transferase/diagnosesFinal.rds")

#1b. number of unique patients and order the data 
diagnosesFinalUnique <- diagnosesFinal[!duplicated(diagnosesFinal[,c('SUBJECT_ID')]),] #8,971

#1c. add new column 'LINEAR' to 'aminotransferaseFinal'
aminotransferaseFinal <- cbind(LINEAR=0,aminotransferaseFinal)

#2. linear regression one sequence at a time
count = 0
for (i in 1:nrow(diagnosesFinalUnique)) {
  sample <- subset(aminotransferaseFinal, aminotransferaseFinal$SUBJECT_ID==diagnosesFinalUnique[i,2])
  lmMod <- lm(VALUENUM  ~ TIMEFRAME, data=sample) 
  for (j in 1:nrow(sample)) {
    aminotransferaseFinal[j+count, 1] <- lmMod$fitted.values[j]
  }
  count <- nrow(sample) + count
}

#3. plot
#3a. take 1 sequence to plot the data
sam1 <- subset(aminotransferaseFinal, aminotransferaseFinal$SUBJECT_ID==9594)#9260
lm1 <- ggplot() + 
  geom_line(data=sam1, aes(x=TIMEFRAME, y=LINEAR, colour="orange")) + 
  geom_point(data=sam1, aes(x=TIMEFRAME, y=LINEAR, colour="orange")) +
  geom_point(data=sam1, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) +
  geom_line(data=sam1, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) + 
  scale_y_continuous(lim=c(15,60), name="Alanine Aminotransferase (IU/L)") +
  scale_x_continuous(name="Time (days)") +
  scale_colour_discrete(labels=c("original data", "transformed data")) +
  theme(legend.title=element_blank())

#3b. take 2 sequence to plot the data
sam2 <- subset(aminotransferaseFinal, aminotransferaseFinal$SUBJECT_ID==26650)
lm2 <- ggplot() + 
  geom_line(data=sam2, aes(x=TIMEFRAME, y=LINEAR, colour="orange")) + 
  geom_point(data=sam2, aes(x=TIMEFRAME, y=LINEAR, colour="orange")) +
  geom_point(data=sam2, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) +
  geom_line(data=sam2, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) + 
  scale_y_continuous(lim=c(15,60), name="Alanine Aminotransferase (IU/L)") +
  scale_x_continuous(name="Time (days)") +
  scale_colour_discrete(labels=c("original data", "transformed data")) +
  theme(legend.title=element_blank())

#3c. take 3 sequence to plot the data
sam3 <- subset(aminotransferaseFinal, aminotransferaseFinal$SUBJECT_ID==90392)
lm3 <- ggplot() + 
  geom_line(data=sam3, aes(x=TIMEFRAME, y=LINEAR, colour="orange")) + 
  geom_point(data=sam3, aes(x=TIMEFRAME, y=LINEAR, colour="orange")) +
  geom_point(data=sam3, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) +
  geom_line(data=sam3, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) + 
  scale_y_continuous(lim=c(15,60), name="Alanine Aminotransferase (IU/L)") +
  scale_x_continuous(name="Time (days)") +
  scale_colour_discrete(labels=c("original data", "transformed data")) +
  theme(legend.title=element_blank())

#3d. take 4 sequence to plot the data
sam4 <- subset(aminotransferaseFinal, aminotransferaseFinal$SUBJECT_ID==25323)
lm4 <- ggplot() + 
  geom_line(data=sam4, aes(x=TIMEFRAME, y=LINEAR, colour="orange")) + 
  geom_point(data=sam4, aes(x=TIMEFRAME, y=LINEAR, colour="orange")) +
  geom_point(data=sam4, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) +
  geom_line(data=sam4, aes(x=TIMEFRAME, y=VALUENUM, colour="green")) + 
  scale_y_continuous(lim=c(15,60), name="Alanine Aminotransferase (IU/L)") +
  scale_x_continuous(name="Time (days)") +
  scale_colour_discrete(labels=c("original data", "transformed data")) +
  theme(legend.title=element_blank())


#3e. display plots
ggarrange(lm1, lm2, lm3, lm4, ncol = 2, nrow = 2, common.legend = TRUE,  labels = c("Sequence 1", "Sequence 2", "Sequence 3", "Sequence 4"))

#3f. save the data
saveRDS(aminotransferaseFinal, "/home/pinkpanther/Documents/Studies/Master Thesis/Data/r/mimic/amino transferase/lineardata.rds") #easier to read in R



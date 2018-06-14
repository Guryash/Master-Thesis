data1Sorted <- data1[order(data1[,c('SUBJECT_ID')]),]
uricAcidItemLeuGouDiagnosesNull<- uricAcidItemLeuGouDiagnosesNull[order(uricAcidItemLeuGouDiagnosesNull[,"SUBJECT_ID"],uricAcidItemLeuGouDiagnosesNull[,"CHARTTIME"]),]

#add missing hadm_id
uricAcidItemLeuGouDiagnosesNull <- uricAcidItemLeuGouDiagnosesNull[!(is.na(uricAcidItemLeuGouDiagnosesNull$VALUENUM)),] #2467 #2467
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==275346, 3] <- 111426 #SUBJECT_ID = 419
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==275373, 3] <- 111426 #SUBJECT_ID = 419
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==275403, 3] <- 111426 #SUBJECT_ID = 419
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==275431, 3] <- 111426 #SUBJECT_ID = 419
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==275462, 3] <- 111426 #SUBJECT_ID = 419
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==275489, 3] <- 111426 #SUBJECT_ID = 419
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==275598, 3] <- 111426 #SUBJECT_ID = 419
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==276325, 3] <- 111426 #SUBJECT_ID = 419
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==276396, 3] <- 111426 #SUBJECT_ID = 419
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==276479, 3] <- 111426 #SUBJECT_ID = 419
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==276524, 3] <- 111426 #SUBJECT_ID = 419
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==276743, 3] <- 148312 #SUBJECT_ID = 419
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==276808, 3] <- 148312 #SUBJECT_ID = 419
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==276871, 3] <- 148312 #SUBJECT_ID = 419
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==276911, 3] <- 148312 #SUBJECT_ID = 419
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==276951, 3] <- 148312 #SUBJECT_ID = 419
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==276998, 3] <- 148312 #SUBJECT_ID = 419
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==277195, 3] <- 148312 #SUBJECT_ID = 419
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==277226, 3] <- 148312 #SUBJECT_ID = 419
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==277258, 3] <- 148312 #SUBJECT_ID = 419
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==277554, 3] <- 148312 #SUBJECT_ID = 419
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==277585, 3] <- 148312 #SUBJECT_ID = 419
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==277624, 3] <- 148312 #SUBJECT_ID = 419
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==277665, 3] <- 148312 #SUBJECT_ID = 419
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==277933, 3] <- 148312 #SUBJECT_ID = 419
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==277967, 3] <- 148312 #SUBJECT_ID = 419
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==278003, 3] <- 148312 #SUBJECT_ID = 419
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==278039, 3] <- 148312 #SUBJECT_ID = 419
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==653, 3] <- 110516
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==852, 3] <- 133054
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==1024, 3] <- 127666
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==1163, 3] <- 127531
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==1036264, 3] <- 197959 #SUBJECT_ID = 1620
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==1036301, 3] <- 197959 #SUBJECT_ID = 1620
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==1036349, 3] <- 197959 #SUBJECT_ID = 1620
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==1036396, 3] <- 197959 #SUBJECT_ID = 1620
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==1036453, 3] <- 197959 #SUBJECT_ID = 1620
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==1036581, 3] <- 197959 #SUBJECT_ID = 1620
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==1036613, 3] <- 197959 #SUBJECT_ID = 1620
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==1036647, 3] <- 197959 #SUBJECT_ID = 1620
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==1036679, 3] <- 197959 #SUBJECT_ID = 1620
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==1037671, 3] <- 122881 #SUBJECT_ID = 1620
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==1037698, 3] <- 122881 #SUBJECT_ID = 1620
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==1037724, 3] <- 122881 #SUBJECT_ID = 1620
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==1037827, 3] <- 122881 #SUBJECT_ID = 1620
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==1037853, 3] <- 122881 #SUBJECT_ID = 1620
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==1037880, 3] <- 122881 #SUBJECT_ID = 1620  
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==1037925, 3] <- 122881 #SUBJECT_ID = 1620
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==2124, 3] <- 195034
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==2368, 3] <- 162120 
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==1655087, 3] <- 197982 #SUBJECT_ID = 2586
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==1655304, 3] <- 197982 #SUBJECT_ID = 2586
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==1655407, 3] <- 197982 #SUBJECT_ID = 2586
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==1655539, 3] <- 154342 #SUBJECT_ID = 2586
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==2953, 3] <- 162049
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==2957, 3] <- 176028
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==3425, 3] <- 133113
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==3639, 3] <- 170356
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==3683, 3] <- 109908
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==3730, 3] <- 138164
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==3839, 3] <- 153261
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==4132, 3] <- 134865
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==2633944, 3] <- 131034 #SUBJECT_ID = 4159
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==4744, 3] <- 137483
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==4828, 3] <- 115113
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==4934, 3] <- 189918
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==4949, 3] <- 193444 
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==5072, 3] <- 115563 
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==3334498, 3] <- 162749 #SUBJECT_ID = 5319
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==3334683, 3] <- 162749 #SUBJECT_ID = 5319
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==3334756, 3] <- 162749 #SUBJECT_ID = 5319
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==3335244, 3] <- 162749 #SUBJECT_ID = 5319
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==3335271, 3] <- 162749 #SUBJECT_ID = 5319
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==3335300, 3] <- 162749 #SUBJECT_ID = 5319
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==3335438, 3] <- 162749 #SUBJECT_ID = 5319
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==3335545, 3] <- 162749 #SUBJECT_ID = 5319
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==3335575, 3] <- 123326 #SUBJECT_ID = 5319
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==3335610, 3] <- 123326 #SUBJECT_ID = 5319
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==3335648, 3] <- 123326 #SUBJECT_ID = 5319
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==3335679, 3] <- 123326 #SUBJECT_ID = 5319
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==3335706, 3] <- 123326 #SUBJECT_ID = 5319
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==5493, 3] <- 140127
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==5573, 3] <- 117657
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==3649977, 3] <- 108018 #SUBJECT_ID = 5774
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==3650008, 3] <- 108018 #SUBJECT_ID = 5774
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==3650069, 3] <- 108018 #SUBJECT_ID = 5774
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==3650105, 3] <- 108018 #SUBJECT_ID = 5774
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==3650146, 3] <- 108018 #SUBJECT_ID = 5774
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==3650359, 3] <- 108018 #SUBJECT_ID = 5774
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==3650402, 3] <- 108018 #SUBJECT_ID = 5774
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==3650456, 3] <- 108018 #SUBJECT_ID = 5774
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==3650478, 3] <- 108018 #SUBJECT_ID = 5774
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==3650500, 3] <- 108018 #SUBJECT_ID = 5774
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==3650531, 3] <- 108018 #SUBJECT_ID = 5774
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==3650596, 3] <- 108018 #SUBJECT_ID = 5774
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==3650757, 3] <- 108018 #SUBJECT_ID = 5774
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==3650813, 3] <- 108018 #SUBJECT_ID = 5774
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==3650862, 3] <- 108018 #SUBJECT_ID = 5774
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==3650930, 3] <- 108018 #SUBJECT_ID = 5774
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==3650961, 3] <- 108018 #SUBJECT_ID = 5774
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==3651026, 3] <- 108018 #SUBJECT_ID = 5774
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==3651067, 3] <- 108018 #SUBJECT_ID = 5774
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==3651098, 3] <- 108018 #SUBJECT_ID = 5774
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==3651129, 3] <- 108018 #SUBJECT_ID = 5774
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==3651270, 3] <- 108018 #SUBJECT_ID = 5774
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==3651325, 3] <- 108018 #SUBJECT_ID = 5774
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==3651369, 3] <- 108018 #SUBJECT_ID = 5774
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==3651474, 3] <- 108018 #SUBJECT_ID = 5774
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==5940, 3] <- 154446
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==6069, 3] <- 173244
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==6109, 3] <- 160391
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==6146, 3] <- 183602
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID ==6181, 3] <- 138616
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==6196, 3] <- 108881
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==6211, 3] <- 133932
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==6304, 3] <- 126719
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==6399, 3] <- 156844
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==6411, 3] <- 128795
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==6652, 3] <- 149265
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==6793, 3] <- 191505
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==7209, 3] <- 173259
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==7299, 3] <- 162018
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==7464, 3] <- 195910  
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==7686, 3] <- 166575
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==7840, 3] <- 190442
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==8014, 3] <- 106602
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==8081, 3] <- 175774
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==8705, 3] <- 189453
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==8749, 3] <- 189168
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==8882, 3] <- 165762
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==9402, 3] <- 171096
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==9544, 3] <- 139648
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==9801, 3] <- 146305
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==10484, 3] <- 113233
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==10515, 3] <- 107232
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==10545, 3] <- 197390
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==10762, 3] <- 118512
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==11216, 3] <- 116130
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==11285, 3] <- 174354
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==11671, 3] <- 133408
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==7284357, 3] <- 168672 #SUBJECT_ID = 11702
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==7284155, 3] <- 171625 #SUBJECT_ID = 11702
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==12419, 3] <- 145251
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==12815, 3] <- 174370
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==12856, 3] <- 143768
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==13019, 3] <- 171359
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==13111, 3] <- 196692
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==13614, 3] <- 183995
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==8537439, 3] <- 130005 #SUBJECT_ID = 13714
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==8537549, 3] <- 169157 #SUBJECT_ID = 13714
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==14180, 3] <- 162841
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==14215, 3] <- 123066
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==14432, 3] <- 166169
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==8997402, 3] <- 113633 #SUBJECT_ID = 14516
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==8998603, 3] <- 167606 #SUBJECT_ID = 14516
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==8998665, 3] <- 167606 #SUBJECT_ID = 14516
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==8998692, 3] <- 167606 #SUBJECT_ID = 14516
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==8998714, 3] <- 167606 #SUBJECT_ID = 14516
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==14759, 3] <- 118840
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==14768, 3] <- 107630
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==14785, 3] <- 148971
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==14797, 3] <- 110326
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==15207, 3] <- 184002
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==15219, 3] <- 157893
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==15311, 3] <- 195196
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==15747, 3] <- 184674
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==15952, 3] <- 156903
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==9978048, 3] <- 182657 #SUBJECT_ID = 16129
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==9978457, 3] <- 182657 #SUBJECT_ID = 16129
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==9978528, 3] <- 182657 #SUBJECT_ID = 16129
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==9978882, 3] <- 152472 #SUBJECT_ID = 16129
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==16186, 3] <- 197085
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==16256, 3] <- 123706
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==16573, 3] <- 184418
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==16577, 3] <- 165419 
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==16605, 3] <- 160759
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==16786, 3] <- 150795
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==16879, 3] <- 123812
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==16949, 3] <- 158603
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==17047, 3] <- 194857
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==17198, 3] <- 157057
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==17382, 3] <- 126181
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==17423, 3] <- 119463
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==17505, 3] <- 109609
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==17683, 3] <- 131755
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==18092, 3] <- 101352
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==18288, 3] <- 198664
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==18654, 3] <- 199327
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==18765, 3] <- 166384
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==18791, 3] <- 179019
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==19142, 3] <- 116155
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==11879791, 3] <- 153745 #SUBJECT_ID = 19164
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==11880158, 3] <- 153745 #SUBJECT_ID = 19164
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==11880233, 3] <- 132656 #SUBJECT_ID = 19164
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==11880302, 3] <- 132656 #SUBJECT_ID = 19164
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==11880318, 3] <- 132656 #SUBJECT_ID = 19164
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==11880346, 3] <- 132656 #SUBJECT_ID = 19164
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==11880359, 3] <- 132656 #SUBJECT_ID = 19164
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==11994518, 3] <- 155858 #SUBJECT_ID = 19334
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==11994552, 3] <- 155858 #SUBJECT_ID = 19334
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==11994587, 3] <- 155858 #SUBJECT_ID = 19334
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==11994617, 3] <- 155858 #SUBJECT_ID = 19334
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==11994976, 3] <- 183582 #SUBJECT_ID = 19334
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==11995028, 3] <- 183582 #SUBJECT_ID = 19334
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==11995075, 3] <- 183582 #SUBJECT_ID = 19334
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==11995123, 3] <- 183582 #SUBJECT_ID = 19334
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==11995168, 3] <- 183582 #SUBJECT_ID = 19334
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==11995215, 3] <- 183582 #SUBJECT_ID = 19334
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==11995264, 3] <- 183582 #SUBJECT_ID = 19334
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==11995317, 3] <- 183582 #SUBJECT_ID = 19334
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==19375, 3] <- 127331
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==19492, 3] <- 142259
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==19553, 3] <- 133617
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==19583, 3] <- 189695
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==19692, 3] <- 126075
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==19833, 3] <- 193540
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==20043, 3] <- 121043
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==20162, 3] <- 106377
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==20345, 3] <- 121239
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==21017, 3] <- 167354
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==21202, 3] <- 190599
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==21574, 3] <- 123207
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==21580, 3] <- 124635
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==21607, 3] <- 174294
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==21726, 3] <- 129501
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==21769, 3] <- 126444
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==22228, 3] <- 145541
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==22844, 3] <- 148584 
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==22856, 3] <- 138134
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==22880, 3] <- 160780
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==22907, 3] <- 131728
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==23024, 3] <- 170431 
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==23046, 3] <- 126437
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==23770, 3] <- 138681
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==24004, 3] <- 124403
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==24553, 3] <- 152313
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==24825, 3] <- 129347
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==24900, 3] <- 180986
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==25104, 3] <- 139180
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==25131, 3] <- 120062
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==25956, 3] <- 188042
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==16231830, 3] <- 149896 #SUBJECT_ID = 26224
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==16233721, 3] <- 149896 #SUBJECT_ID = 26224
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==16233784, 3] <- 149896 #SUBJECT_ID = 26224
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==16233901, 3] <- 149896 #SUBJECT_ID = 26224
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==16234363, 3] <- 149896 #SUBJECT_ID = 26224
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==16234632, 3] <- 149896 #SUBJECT_ID = 26224
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==16234793, 3] <- 149896 #SUBJECT_ID = 26224
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==16237309, 3] <- 128258 #SUBJECT_ID = 26224
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==16237428, 3] <- 128258 #SUBJECT_ID = 26224
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==16237847, 3] <- 128258 #SUBJECT_ID = 26224
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==16238028, 3] <- 128258 #SUBJECT_ID = 26224
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==16238166, 3] <- 128258 #SUBJECT_ID = 26224
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==16238268, 3] <- 128258 #SUBJECT_ID = 26224
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==16239428, 3] <- 128258 #SUBJECT_ID = 26224
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==26258, 3] <- 189646
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==26610, 3] <- 146134
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==26872, 3] <- 154170
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==27100, 3] <- 166427
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==27388, 3] <- 136985
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==27506, 3] <- 122404
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==27925, 3] <- 110816
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==28324, 3] <- 153161
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==28750, 3] <- 161213
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==28801, 3] <- 144188
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==29334, 3] <- 119868
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==29504, 3] <- 117534
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==29728, 3] <- 179225
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==29959, 3] <- 167558
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==97876, 3] <- 166889
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$SUBJECT_ID==98130, 3] <- 179993
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==27813295, 3] <- 143984 #SUBJECT_ID = 99346 
uricAcidItemLeuGouDiagnosesNull[uricAcidItemLeuGouDiagnosesNull$ROW_ID==27813639, 3] <- 177015 #SUBJECT_ID = 99346

uricAcidItemLeuGouDiagnosesNullNotNull <- uricAcidItemLeuGouDiagnosesNull[complete.cases(uricAcidItemLeuGouDiagnosesNull),] #1369 #1425

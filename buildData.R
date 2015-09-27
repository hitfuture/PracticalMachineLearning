library(gtools)
library(knitr)
library(caret)
library(plyr)
library(dplyr)

#cleanData() removes potential predictors that have more than 50% of their values missing.
cleanData <- function (data) {
  obsCount <- nrow(data)
  tnames <- names(data)
  results <- c()
  index <- 1
  for(i in 1:ncol(data)){
    numberOfNAs <-sum(is.na(data[,i]))
    
    if(numberOfNAs > (.5 * obsCount)) {
      results[index] <- (tnames[i])
      index <- index + 1
    }
  }
  
  data <- (data[,setdiff(tnames,results)])
  
  
  return(data)
}

buildData <-function(quickRun =TRUE){
pmltraining <- read.csv("./data/pml-training.csv",na.strings = c("","#DIV/0!","NA"))
#Remove all potential predictors that have high volumes of N/A's
pmltraining <- cleanData(pmltraining)
#The first 7 columns are not predictors - and are instead context related data associated with the study. 
pmltraining <-  pmltraining[,-(1:7)]

pmltesting <-read.csv("./data/pml-testing.csv",na.strings = c("","#DIV/0!","NA"))
#Remove all potential predictors that have high volumes of N/A's
pmltesting <- cleanData(pmltesting)
#The first 7 columns are not predictors - and are instead context related data associated with the study. 
pmltesting <- pmltesting[,-(1:7)]

pmltraining <- pmltraining%>%filter(classe != 4)
pmltraining$classe <- factor(pmltraining$classe)
set.seed(2040)
inTrain <- createDataPartition(y = pmltraining$classe,  p = .75, list = FALSE) 
training <- pmltraining[inTrain,]
validation <- pmltraining[-inTrain,]

if(quickRun) {
  training <- sample_n(training,100)
  validation <- sample_n(validation,100)}
write.csv(training,"./data/training.csv",row.names = FALSE)
write.csv(validation,"./data/validation.csv",row.names = FALSE)
}
## The format of the results 


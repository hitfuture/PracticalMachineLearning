library(testthat)
source("voteForOutcome.R")

validateData <- read.csv("./data/validation.csv")
load("./data/gbmFit_full.RData")
gbm <- fit

result <- predictAll(gbm,data=validateData)
expect_equal(ncol(result),1)
load("./data/svmFit_full.RData")
svm <- fit
result <- predictAll(gbm,svm,data=validateData)
expect_equal(ncol(result),2)

load("./data/rfFit_full.RData")
rf <- fit
result <- predictAll(gbm,svm,rf,data=validateData)
expect_equal(ncol(result),3)
vOutcome <- validateData$classe
weights <- weightsOf(result,vOutcome)
outcome <- voteForOutcome(result,outcome = vOutcome)

expect_equal(nrow(outcome),nrow(result))
confusionMatrix(outcome$outcome,validateData$classe)
svm
gbm
plot(rf$finalModel)
plot(svm)
plot(rf)
plot(gbm)
plot(gbm$finalModel)


rf$finalModel
m <-matrix(runif(15),nrow=5,ncol=3,dimnames = list(c("A","B","C","D","E"),c("svg","rf","gbm")))
mapply(m,exp)

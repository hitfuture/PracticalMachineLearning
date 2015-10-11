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

outcome <- voteForOutcome(result)
expect_equal(nrow(outcome),nrow(result))
confusionMatrix(outcome$outcome,validateData$classe)
svm
gbm
plot(rf$finalModel)
plot(svm)
plot(rf)
plot(gbm)
plot(gbm$finalModel)

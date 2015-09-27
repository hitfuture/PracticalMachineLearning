

buildSvm <- function (quickRun =TRUE,runInParallel=FALSE,cores=4,data) {
  source("runModel.R")
  if(runInParallel) {
    library(doMC)
    registerDoMC(cores = cores)
  }
  
  fitControl <- trainControl(## 10-fold CV
    method = "repeatedcv",
    number = 10,
    verboseIter	= FALSE,
    classProbs = TRUE,
    repeats = 3)
  
  runModel(
    dur <- system.time({ fit <- train(classe ~ ., data = data,
                                           method = "svmRadial",
                                           trControl = fitControl,
                                           verbose = FALSE,
                                           preProc = c("center", "scale"),
                                           tuneLength = 8 )
    
    }),
    "Model svmRadial"
  )

  fileNm <-paste("./data/","svmFit",if(quickRun){"_test"}else{"_full"},".RData",sep = "")
  save(fit,file=fileNm)
  
  modelType = "svmRadial"
  out <- data.frame(model_type=modelType, quickRun,runInParallel,cores,user=dur[1],system=dur[2],elapsed=dur[3])
  write.table(out, "perform.log",append = TRUE,sep=",",row.names=FALSE,col.names = FALSE)
  fit
}

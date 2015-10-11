

buildAda <- function (quickRun =TRUE,runInParallel=FALSE,cores=4,data) {
        source("runModel.R")
        message(paste("quickRun=",quickRun))
        if(runInParallel) {
                library(doMC)
                registerDoMC(cores = cores)
        }
        
        fitControl <- trainControl(## 10-fold CV
                method = "repeatedcv",
                number = 10,
                ## repeated twenty times
                verboseIter	= FALSE,
                #  classProbs = TRUE,
                repeats = 10)
        runModel(dur <- system.time({ fit <- train(classe ~ ., data = data,
                                                   method = "AdaBoost.M1",
                                                   verbose = FALSE #,
  #                                                 trControl = fitControl
        )
        
        }),
        "Ada Boosting Model (ada)"
        ) 
        fileNm <-paste("./data/","adaFit",if(quickRun){"_test"}else{"_full"},".RData",sep = "")
        save(fit,file=fileNm)
        
        modelType = "ada"
        out <- data.frame(model_type=modelType, quickRun,runInParallel,cores,user=dur[1],system=dur[2],elapsed=dur[3])
        write.table(out, "perform.log",append = TRUE,sep=",",row.names=FALSE,col.names = FALSE)
        fit
}

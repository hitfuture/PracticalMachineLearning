#Recursive partitioning for classification

buildRpart<- function (quickRun =TRUE,runInParallel=FALSE,cores=4,data) {
        source("runModel.R")
        message(paste("quickRun=",quickRun))
        if(runInParallel) {
                library(doMC)
                registerDoMC(cores = cores)
        }
        folds=10
        repeats=10
        fitControl <- trainControl(method="repeatedcv",
                                   number=folds,
                                   repeats=repeats,
                                   classProbs=TRUE,
                                   allowParallel=TRUE 
                                  
                                   )
        
        rpart.grid <- expand.grid(.cp=0.2)     

         
        runModel(dur <- system.time({ fit <- train(classe ~ ., data = data,
                                                   method="rpart",metric="ROC",
                                                   tuneLength=10,
                                                   verbose = FALSE,
                                                   trControl = fitControl,
                                                   tuneGrid=rpart.grid
        )
        
        }),
        "Recursive partitioning for classification (rPart)"
        ) 
        fileNm <-paste("./data/","rfFit",if(quickRun){"_test"}else{"_full"},".RData",sep = "")
        save(fit,file=fileNm)
        
        modelType = "rpart"
        out <- data.frame(model_type=modelType, quickRun,runInParallel,cores,user=dur[1],system=dur[2],elapsed=dur[3])
        write.table(out, "perform.log",append = TRUE,sep=",",row.names=FALSE,col.names = FALSE)
        fit
}

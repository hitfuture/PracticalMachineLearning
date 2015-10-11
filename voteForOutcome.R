##Vote for the outcome.  You can also validate
predictAll <- function(...,data,outcome = NULL) {
        arraysOfArgs <- list(...)
        numberOfArgs <- length(arraysOfArgs)
        dots <- substitute(list(...))[-1]
        namesOfArgs <- c(sapply(dots, deparse))
        
        predictionResults <- lapply(arraysOfArgs,predict,newdata = data)
        df <- data.frame(predictionResults)
        names(df) <- namesOfArgs
        df
        
        
}


voteForOutcome <- function(...,weights=1,outcome = NULL) {
        library(tidyr)
        arraysOfArgs <- list(...)
        numberOfArgs <- length(arraysOfArgs)
        if(numberOfArgs == 1) {
                df <- arraysOfArgs[[1]]
                if(class(df)=="data.frame"){
                        
                } else{df <- data.frame(df)}
        
        }  else {
                dots <- substitute(list(...))[-1]
                namesOfArgs <- c(sapply(dots, deparse))
                df <- data.frame(arraysOfArgs)     
                names(df) <- namesOfArgs
        }
        weights <- rep_len(weights,numberOfArgs)
        modelCount <- ncol(df)
        results <- cbind(testObs = as.integer(row.names(df)),df)
        test.results <- results%>%tidyr::gather(key=testObs)
        names(test.results)<- c("testObs","key","value")
        test.results <- test.results%>%dplyr::count(testObs,value)%>%arrange(testObs,desc(n))
        test.results<- test.results[!duplicated(test.results$testObs),]
        vote <- test.results[,2:3]
        vote$perc <-(vote$n/modelCount) 
        names(vote)<-c("outcome","majority.vote.count","majority.vote.%")
        
        results  <- cbind(results ,vote)
        results
        
}

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


voteForOutcome <- function(...,outcome = NULL) {
        library(tidyr)
        arraysOfArgs <- list(...)
        numberOfArgs <- length(arraysOfArgs)
        if(numberOfArgs == 1) {
                df <- arraysOfArgs[[1]]
        
        }  else {
                dots <- substitute(list(...))[-1]
                namesOfArgs <- c(sapply(dots, deparse))
                df <- data.frame(arraysOfArgs)     
                names(df) <- namesOfArgs
        }
        
        modelCount <- ncol(df)
        results <- cbind(testObs = as.integer(row.names(df)),df)
        test.results <- results%>%tidyr::gather(key=testObs)
        names(test.results)<- c("testObs","key","value")
        test.results <- test.results%>%dplyr::count(testObs,value)%>%arrange(testObs,desc(n))
        test.results<- test.results[!duplicated(test.results$testObs),]
        vote <- test.results[,2:3]
        vote$perc <-(vote$n/modelCount) * 100
        names(vote)<-c("Outcome Vote","Majority Vote Count","Majority Vote %")
        
        results  <- cbind(results ,vote)
        results
        
}

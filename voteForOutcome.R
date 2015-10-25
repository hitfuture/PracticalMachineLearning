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


weightsOf <- function (data,actual) {
        require(tidyr)
       totalM <- apply(data, 2,function(x,y) {
                cm <- confusionMatrix(x,reference=y)
                classVals <- cm$byClass[,"Balanced Accuracy"]},y=actual) 
       totalM <- 10^exp(totalM) #Differentiate between values close to .5 vs. 1
       weights <- cbind(class=unique(actual),as.data.frame(totalM))
       weights <- weights%>%gather(class)
       names(weights)<-c("classe","data.source","weight")
       
       weights
       
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
        modelCount <- ncol(df)
       if(!is.null(outcome)) {
               weights <- weightsOf(df,outcome)
      }
        results <- cbind(testObs = as.integer(row.names(df)),df)
        test.results <- results%>%tidyr::gather(key=testObs)
        names(test.results)<- c("testObs","data.source","classe")
        test.results$classe<-as.factor(test.results$classe)
        test.results<-left_join(test.results,weights)
#test.results <- test.results%>%group_by(testObs,value)%>%dplyr::count(testObs,value) #%>%arrange(testObs,desc(n))
        
        test.results <- test.results%>%group_by(testObs,classe)%>%dplyr::summarize(total.weight=sum(weight)) %>%arrange(testObs,desc(total.weight))
        test.results<- test.results[!duplicated(test.results$testObs),]
        vote <- test.results[,2:3]
        #vote$perc <-(vote$n/modelCount) 
        names(vote)<-c("outcome","outcome weight")
        
        results  <- cbind(results ,vote)
        results
        
}

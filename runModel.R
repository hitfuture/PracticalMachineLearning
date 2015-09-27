library(mailR)


secureAuthentication <- function () {
        list(host.name = "smtp.gmail.com", port = 587, 
             user.name="brett.vmail@gmail.com", passwd="ysfwzrcbpzxffcdg",tls=TRUE)
}

sendMessageToMe <- function (subject, body) {
  sender <- "brett.vmail@gmail.com"
  recipients <- c("brett.r.taylor@me.com")
  send.mail(from = sender,
            to = recipients,
            subject=subject,
            body = body,
            smtp = secureAuthentication(),
            authenticate = TRUE,
            send = TRUE,
            debug=FALSE)
}

sendStartMessage <- function (msg) {
  startTime <- paste("Start at",Sys.time())
  message(startTime)
  sendMessageToMe(paste("model execution began at",startTime), msg )
}
sendEndMessage <- function (msg,duration,mod ) {
  endTime <- paste("End at",Sys.time())
  message(endTime)
  timeToExecStr <- if(!exists("duration")) {
    "Execution time unknown"
  } else { paste( "Execution time:",duration[3])}
  modStr <- if(!exists("mod")) {
    "Model not available"
  } else { capture.output( mod)}
  sendMessageToMe(paste("model execution completed at",endTime),paste(msg,timeToExecStr))
}

runModel <- function(expression, description=""){
  mf <- match.call() # makes expr an expression that can be evaluated
  e1 <- parent.frame()
  startTime <- paste("Start at",Sys.time())
  message(startTime)
  sendMessageToMe(paste("model execution began at",startTime), description)
  result <- eval(mf$expression,e1)
  endTime <- paste("End at",Sys.time())
  message(endTime)
  
  sendMessageToMe(paste("model execution completed at",endTime), 
                  paste(description,"summary",
                        paste(capture.output(result),collapse = "")))
  return(result)
}
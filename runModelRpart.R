#runModelRpart.R
library(plyr)
library(dplyr)
source("buildData.R")
fast = FALSE
buildData(quickRun=fast)
message("load buildModelRpart.R")
training <- read.csv("./data/training.csv")
source("buildModelRpart.R")
rPartFit <- buildRpart(quickRun =fast,runInParallel=FALSE,cores=1,data=training)
rPartFit$finalModel
fancyRpartPlot(rPartFit$finalModel)

testing <- read.csv("./data/validation.csv")
results <- predict(rPartFit,newdata = testing)
confusionMatrix(data = results,testing$classe)

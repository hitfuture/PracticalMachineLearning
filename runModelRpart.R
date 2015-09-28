#runModelSvm.R
source("buildData.R")
fast = FALSE
buildData(quickRun=fast)
message("load buildModelRpart.R")
training <- read.csv("./data/training.csv")
source("buildModelRpart.R")
svmFit <- buildRpart(quickRun =fast,runInParallel=TRUE,cores=1,data=training)
svmFit

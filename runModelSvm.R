#runModelSvm.R
source("buildData.R")
fast = FALSE
buildData(quickRun=fast)
message("load buildModelSvm.R")
training <- read.csv("./data/training.csv")
source("buildModelSvm.R")
svmFit <- buildSvm(quickRun =fast,runInParallel=TRUE,cores=1,data=training)
svmFit

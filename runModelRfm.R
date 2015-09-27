#runModelRfm.R
source("buildData.R")
fast = FALSE
buildData(quickRun=fast)
message("load buildModelRfm.R")
#source("buildModelGbm.R")
training <- read.csv("./data/training.csv")
rfmFit <- buildRfm(quickRun =fast,runInParallel=TRUE,cores=4,data=training)
rfmFit
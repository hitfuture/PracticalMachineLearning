#runModels.R
source("buildData.R")
fast = FALSE
buildData(quickRun=fast)
message("load buildModelAda.R")
source("buildModelAda.R")
training <- read.csv("./data/training.csv")
message("run buildAda()")
adaFit <- buildAda(quickRun =fast,runInParallel=FALSE,cores=1,data=training)

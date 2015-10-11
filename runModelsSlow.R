#runModels.R
source("buildData.R")
fast = FALSE
parallel = FALSE
buildData(quickRun=fast)
message("load buildModelGbm.R")
source("buildModelGbm.R")
training <- read.csv("./data/training.csv")
message("run buildGbm()")
gmbFit <- buildGbm(quickRun =fast,runInParallel=parallel,cores=4,data=training)
source("buildModelSvm.R")
svmFit <- buildSvm(quickRun =fast,runInParallel=parallel,cores=4,data=training)
source("buildModelRfm.R")
rfmFit <- buildRfm(quickRun =fast,runInParallel=parallel,cores=4,data=training)

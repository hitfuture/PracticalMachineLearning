#buildModels
source("buildData.R")
fast = FALSE
buildData(quickRun=fast)
message("load buildModelGbm.R")
source("buildModelGbm.R")
training <- read.csv("./data/training.csv")
message("run buildGbm()")
gmbFit <- buildGbm(quickRun =fast,runInParallel=TRUE,cores=4,data=training)
source("buildModelSvm.R")
svmFit <- buildSvm(quickRun =fast,runInParallel=TRUE,cores=4,data=training)
source("buildModelRfm.R")
rfmFit <- buildRfm(quickRun =fast,runInParallel=TRUE,cores=4,data=training)
gmbFit
svmFit
rfmFit
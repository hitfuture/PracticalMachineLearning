#runModelSvm.R
library(plyr)
library(dplyr)
source("buildData.R")
fast = FALSE
buildData(quickRun=fast)
message("load buildModelRpart.R")
training <- read.csv("./data/training.csv")
source("buildModelRpart.R")
rPartFit <- buildRpart(quickRun =fast,runInParallel=FALSE,cores=1,data=training)
rPartFit

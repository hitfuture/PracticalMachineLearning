##Run the RMD file so that it can run in parallel mode.

#This works for the MacBookPro
rmarkdown::render("PredictedModel4.Rmd","word_document",
                  params=list(quickRun=FALSE,
                              runInParallel=FALSE,
                              cores=4))

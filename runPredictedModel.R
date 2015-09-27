##Run the RMD file so that it can run in parallel mode.

#This works for the MacBookPro
rmarkdown::render("PredictedModel2.Rmd","word_document",
                  params=list(quickRun=TRUE,
                              runInParallel=TRUE,
                              cores=5))
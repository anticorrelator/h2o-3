#----------------------------------------------------------------------
# Purpose:  This test exercises the GLM model downloaded as java code.
#
# Notes:    Assumes unix environment.
#           curl, javac, java must be installed.
#           java must be at least 1.6.
#----------------------------------------------------------------------



test.glm.javapredict.airlines <-
function() {

    #----------------------------------------------------------------------
    # Parameters for the test.
    #----------------------------------------------------------------------
    air <- h2o.importFile(locate("smalldata/airlines/allyears2k_headers.zip"))
    s <- h2o.runif(air, seed = 1234)
    training_frame <- air[s <= 0.8,]
    test_frame <- air[s > 0.8,]

    test_file <- paste(sandbox(), "airtest.csv", sep=.Platform$file.sep)
    print("")
    print(paste("WRITING TEST FILE:", test_file))
    print("")
    h2o.exportFile(test_frame, path=test_file, force=TRUE)

    params                 <- list()
    params$x               <- c("Year","Month","DayofMonth","DayOfWeek","CRSDepTime","CRSArrTime","UniqueCarrier",
                                "FlightNum","CRSElapsedTime","AirTime","Origin","Dest","Distance")
    params$y               <- "IsDepDelayed"
    params$family          <- "binomial"
    params$training_frame  <- training_frame

    #----------------------------------------------------------------------
    # Run the test
    #----------------------------------------------------------------------
    doJavapredictTest("glm",test_file,test_frame,params)

}

doTest("GLM test", test.glm.javapredict.airlines)

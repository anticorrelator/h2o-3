


rtest <- function() {

hdfs_name_node = hadoop.namenode()
hdfs_data_file = "/datasets/1Mx2.2k.csv"
#----------------------------------------------------------------------
# Parameters for the test.
#----------------------------------------------------------------------

url <- sprintf("hdfs://%s%s", hdfs_name_node, hdfs_data_file)
parse_time <- system.time(data.hex <- h2o.importFile(url))
print("Time it took to parse")
print(parse_time)

response=1 #1:1000 imbalance
predictors=c(3:ncol(data.hex))

# Start modeling   
# GLM
glm_time <- system.time(mdl.glm <- h2o.glm(x=predictors, y=response, training_frame=data.hex, family = "binomial"))
mdl.glm
print("Time it took to build GLM")
print(glm_time)

}

doTest("Test",rtest)


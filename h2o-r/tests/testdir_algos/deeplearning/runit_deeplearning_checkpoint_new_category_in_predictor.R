


checkpoint.new.category.in.predictor <- function() {

  sv1 <- h2o.uploadFile(locate("smalldata/iris/setosa_versicolor.csv"))
  sv2 <- h2o.uploadFile(locate("smalldata/iris/setosa_versicolor.csv"))
  vir <- h2o.uploadFile(locate("smalldata/iris/virginica.csv"))

  m1 <- h2o.deeplearning(x=c(1,2,3,5),y=4,training_frame=sv1,epochs=100)

  m2 <- h2o.deeplearning(x=c(1,2,3,5),y=4,training_frame=sv2,epochs=200,checkpoint=m1@model_id)

  # attempt to continue building model, but with an expanded categorical predictor domain.
  # this should fail until we figure out proper behavior
  expect_error(m3 <- h2o.deeplearning(x=c(1,2,3,5),y=4,training_frame=vir,epochs=200,checkpoint=m1@model_id))

  
}

doTest("Deep Learning checkpoint with new categoricals", checkpoint.new.category.in.predictor )


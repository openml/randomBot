# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# [*] mlr Wrapper learners
# http://mlr-org.github.io/mlr-tutorial/release/html/wrapper/index.html

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

getPredefinedLearners = function() {

  lrn.rpart = makeLearner("classif.rpart", predict.type = "prob")
  lrn.gbm   = makeLearner("classif.gbm", predict.type = "prob")
  lrn.nb    = makeLearner("classif.naiveBayes", predict.type = "prob")

  # Classifiers that requires imputation
  lrn.kknn = makeImputeWrapper(
    learner = makeLearner("classif.kknn", predict.type = "prob"),
    classes = list(numeric = imputeMedian(), factor = imputeMode()),
    dummy.classes = c("numeric", "factor")
  )

  lrn.svm = makeImputeWrapper(
    learner = makeLearner("classif.svm", predict.type = "prob"),
    classes = list(numeric = imputeMedian(), factor = imputeMode()),
    dummy.classes = c("numeric", "factor")
  )

  lrn.ranger = makeImputeWrapper(
    learner = makeLearner("classif.ranger", predict.type = "prob"),
    classes = list(numeric = imputeMedian(), factor = imputeMode()),
    dummy.classes = c("numeric", "factor")
  )

  lrn.nnet = makeImputeWrapper(
    learner = makeLearner("classif.nnet", predict.type = "prob"),
    classes = list(numeric = imputeMedian(), factor = imputeMode()),
    dummy.classes = c("numeric", "factor")
  )

  # All the learners remove constant and almost constant features
  aux = list(lrn.nb, lrn.rpart, lrn.kknn, lrn.nnet, lrn.svm, lrn.gbm, lrn.ranger)
  learners.list = lapply(aux, makeRemoveConstantFeaturesWrapper, perc = 0.01)

  return(learners.list)
}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

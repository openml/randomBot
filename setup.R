# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# install required packages from CRAN

install.packages(pkgs = c("devtools, RWeka", "e1071", "irace", "checkmate", "BatchExperiments",
  "rpart", "ranger", "gbm", "deepnet", "kknn"))

# install required packages from github repos
library("devtools")

install_github("berndbischl/ParamHelpers", ref = "9d374430701d94639cc78db84f91a0c595927189")
install_github("mlr-org/farff")
install_github("mlr-org/mlr", ref = "e8801bcb5ad1ac7c5fdfc7b862df7eb4c37a698a")
install_github("openml/r", ref = "05b8b97cc5ce6ea1b3f586818cfcf157b16a3cd4")


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

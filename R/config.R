# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# Required packages
library("checkmate")
library("OpenML")
library("mlr")
library("BatchExperiments")

# mlr and OpenML configurations
setOMLConfig(arff.reader = "farff") #"RWeka")
setOMLConfig(confirm.upload = FALSE)
configureMlr(on.learner.error = "warn")
configureMlr(show.info = TRUE)

# Please, replace it by your own OpenML apikey
# saveOMLConfig(apikey = "your openml api key", overwrite = TRUE)
saveOMLConfig(apikey = "76444ac061f2b76258c96f680f0c6ae0", overwrite = TRUE)

# tuning constant
TUNING.CONSTANT = 100

# for debuging while coding
SHOULD.UPLOAD = FALSE #TRUE

# remove tasks (sparse and with more than 5k features)
REMOVE = c(3962, 3964, 3968, 3971, 3972, 3973, 3979, 3992, 3995, 3999, 4000, 7307, 3518, 
  3528, 3531, 3534, 100090, 3019, 3504, 3521, 3524, 3527, 3529, 3536) # 9968)

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

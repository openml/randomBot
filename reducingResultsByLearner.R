# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# * Example:
# devtools::load_all()
# source("reducingResultsByLearner")
# reducingResultsByLearner(lrn = "classif.rpart")
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

reducingResultsByLearner = function(reg, lrn = NULL){

  if(is.null(lrn)) {
    stopf("Please, give a learner name!")
  }
  
  if(!dir.exists("output/")) {
    dir.create(path = "output/", recursive = TRUE)
  }

  df = getJobInfo(reg)
  save(x = df, file = paste0("output/allJobsInfo.RData"))
 
  algos.names = gsub(pattern=".preproc|.imputed", replacement="", x=unique(df$algo))
  if(is.null(lrn) || lrn %nin% algos.names) {
    stopf("There is no results for this learner. Please, provide a valid name.")
  }

  fn.filter = function(job, res){
    algo = gsub(pattern=".preproc|.imputed", replacement="", x=unique(job$algo.id))
    return(algo == lrn)
  }
  sel.ids = filterResults(reg = reg, ids = getJobIds(reg), fun = fn.filter)

  cat(" - ", length(sel.ids), "job(s) was(were) found for learner:\'",lrn,"\'\n")

  par.set = getHyperSpace(learner = makeLearner(lrn), p = 1, n = 100)  
  if(length(par.set$pars) == 0) {
    impute.pars = list()
  } else {
    impute.pars = lapply(par.set$pars, function(par) NA)
  }

  # Also reduce jobs with errors | unfinished
  data = reduceResultsList(reg, ids = sel.ids, impute.val = impute.pars,
   fun = function(aggr, job, res) {
    temp = rbind(data.frame(id = job$id, prob = job$prob.id, algo = job$algo.id,
      repl = job$repl, y = res, stringsAsFactors = FALSE))
    return(temp)
    }
  )

  ret = do.call("rbind", data)
  output.file = paste0(gsub(x = lrn, pattern = "\\.", replacement = "_"), "_space")
  write.csv(x = ret, file = paste0("output/", output.file, ".csv"))
  save(x = ret, file = paste0("output/", output.file, ".RData"))
  return(ret)

}
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

getBatchAlgoWrapper = function(learner) {
    
  function(job, static, dynamic) {

    obj = convertOMLTaskToMlr(static$task) 
    n = mlr::getTaskSize(obj$mlr.task)
    p = mlr::getTaskNFeats(obj$mlr.task)

    par.set  = getHyperSpace(learner = learner, p = p, n = n)
  
    if(length(par.set$pars) != 0) {
      params = ParamHelpers::sampleValue(par.set, trafo = TRUE)
      new.lrn = setHyperPars(learner = learner, par.vals = params)
    } else {
      new.lrn = learner
    }

    oml.run = runTaskMlr(task = static$task, learner = new.lrn) 
    
    run.id = NA  
    if(SHOULD.UPLOAD) {
      run.id = uploadOMLRun(run = oml.run, upload.bmr = TRUE)
      oml.run$run$run.id = run.id
    }
      
    perf = getBMRAggrPerformances(bmr = oml.run$bmr, as.df = TRUE)

    if(length(par.set$pars) == 0) {
      res = cbind(run.id, perf)
    } else {
      res = cbind(run.id, as.data.frame(params), perf)
    }
   
    return(res)
  }
}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

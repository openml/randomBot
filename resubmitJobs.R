# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

resubmitJobs = function(submit.errors = FALSE) {

  devtools::load_all()

  reg = makeExperimentRegistry(
    id = "randomBot", 
    packages = c("ParamHelpers", "mlr", "OpenML"), 
    src.dirs = "R/"
  )

  catf(" * There are remaining jobs or new ones ...")
  if(submit.errors)
    all.jobs = findNotDone(reg)
  else
    all.jobs = setdiff(findNotDone(reg), findErrors(reg))

  res = list(walltime = 60*60*48)
  submitJobs(reg = reg, ids = all.jobs, resources = res, job.delay = TRUE)
  status = waitForJobs(reg = reg, ids = all.jobs)
  catf(" * Done.")

}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

resubmitJobs()

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

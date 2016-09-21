# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

getHyperSpace = function(learner, ...) {

  name = gsub(pattern="classif.|.preproc|.imputed", replacement="", x=learner$id)
  substring(name, 1, 1) = toupper(substring(name, 1, 1)) 
  fn.space = get(paste0("get", name , "Space"))
  par.set = fn.space(...)
  return(par.set)
}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

getRangerSpace = function(...) {
  args = list(...)
  par.set = makeParamSet(
    makeIntegerParam("mtry", lower = round(args$p ^ 0.1), upper = round(args$p ^ 0.9)),
    makeIntegerParam("num.trees", lower = 0, upper=10, trafo = function(x) 2^x)
  )
  return(par.set)
}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

getKknnSpace = function(...) {
  par.set = makeParamSet(
    makeIntegerParam("k", lower = 1, upper = 50, default = 1)
  )
  return(par.set)
}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

getSvmSpace = function(...) {
  par.set = makeParamSet(
    makeDiscreteParam("kernel", values = "radial", default = "radial", tunable = FALSE),
    makeNumericParam("cost" , lower = -12, upper = 12, trafo = function(x) 2^x),
    makeNumericParam("gamma", lower = -12, upper = 12, trafo = function(x) 2^x)
  )
  return(par.set)
}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

getRpartSpace = function(...) {
  args = list(...)
  par.set = makeParamSet(
    makeNumericParam("cp", lower = -4, upper = -1, trafo = function(x) 10^x),
    makeIntegerParam("minsplit", lower = 1, upper = min(7, floor(log2(args$n))), 
      trafo = function(x) 2^x),
    makeIntegerParam("minbucket", lower = 0, upper = min(6, floor(log2(args$n))), 
      trafo = function(x) 2^x)
  )
  return(par.set)  
}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

getGbmSpace = function(...) {
  par.set = makeParamSet(
    makeIntegerParam("n.trees", lower = 500, upper = 10000),
    makeIntegerParam("interaction.depth", lower = 1, upper = 5),
    makeNumericParam("shrinkage", lower = -4, upper = -1, trafo = function(x) 10^x)
  )
  return(par.set)
}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

getNnetSpace = function(...) {
  par.set = makeParamSet(
    makeIntegerParam("size",  lower = 1, upper = 11, trafo = function(x) 2^x ),
    makeIntegerParam("maxit", lower = 1, upper = 3, trafo = function(x) 10^x),
    makeNumericParam("decay", lower =-4, upper = 0, trafo = function(x)10^x)
  )
  return(par.set)
}
 
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

getNaiveBayesSpace = function(...) {
  par.set =  makeParamSet()
  return(par.set)
}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

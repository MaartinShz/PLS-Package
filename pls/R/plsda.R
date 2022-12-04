plsda <-
function(ncomp=NULL){

  if(!is.numeric(ncomp) & !is.null(ncomp)){
    stop("Number of composant must be a numeric")

  }

  #PLS Instance Creation
  instance = list("ncomp"=ncomp)
  class(instance) = "PLSDA"

  return(instance)
}

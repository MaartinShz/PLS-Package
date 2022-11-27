#' PLSDA Class
#'
#' Class of the object PLSDA, this class is used to create an object Plsda, to use a Partial least squares regression method.
#'
#'
#' @usage
#' obj = plsda()
#'
#' @param
#'
#' @return
#' obj plsda object
#'
#'
#' @examples
#' obj = plsda()
#'
#' print(obj)
#' summary(obj)
#'
plsda = function(ncomp=2, normalize = F, multi_class = 'auto'){
  #vérification des hyperparamètres
  #if(){}

  #création de l'instance
  instance = list("ncomp"=ncomp)
  class(instance) = "PLSDA"

  return(instance)



}

#surcharge de la fonction print
print.plsda = function(objet){
  cat("type : ", class(objet), "\n")

}

#surcharge de la fonction summary
summary.plsda = function(objet){
  cat("type : ", class(objet), "\n")

}


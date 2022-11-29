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
plsda = function(formula=NULL, data=NULL, ncomp=NULL, var.select = F){
  #vérification des hyperparamètres
  #if(){}

  #création de l'instance
  instance = list("ncomp"=ncomp)
  class(instance) = "PLSDA"

  return(instance)



}
#print() fournit au moins une fonction de classement permettant d’attribuer les classes aux individus
#surcharge de la fonction print
print.plsda = function(objet){
  cat("type : ", class(objet), "\n")

}

#surcharge de la fonction summary
summary.plsda = function(objet){
  cat("type : ", class(objet), "\n")

}




#' Titre
#'
#' Description
#'
#' @usage
#' utilisation
#'
#' @param
#' argument 1
#' @return
#' Value return
#'
#'
#' @examples
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


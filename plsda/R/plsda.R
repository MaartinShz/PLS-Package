plsda = function(ncomp, normalize = F, multi_class = 'auto'){
  #vérification des hyperparamètres
  #if(){}

  #création de l'instance
  instance = list()
  class(instance) = "PLSDA"



}

#surcharge de la fonction print
print.PLS = function(objet){
  cat("type : ", class(objet), "\n")
}

#surcharge de la fonction summary
summary.PLS = function(objet){
  cat("type : ", class(objet), "\n")
}

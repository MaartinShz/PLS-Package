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

plsda_fit<-function(ObjectPLSDA, var.cible, data, ncomp=NULL, var.select = F, centre=T){

  if (class(ObjectPLSDA)!="PLSDA") {
    stop("Object's class is not PLSDA")
  }

  if (!is.data.frame(data)){ #check if data is a dataframe
    stop("data must be a dataframe")
  }


  if(is.null(ncomp) || !is.numeric(ncomp)){
    #rang de la matrice
    a = min(nrow(data), ncol(data)) # si ncomp is null
    ncomp = a
  }
  ###########################

  # selection de X et Y
  x= data[,-ncol(data)]
  Y= var.cible

  if(centre){
    # centre-reduire les explicatives
    x = scale(x)
  }


  # recodage de la variable cible
  y = get_dummies(Y)
  y = scale(y)


  ###########################  ###########################

  #matrice des poids des composantes de X
  Xweights = data.frame(matrix(rep(0), nrow = ncol(x), ncol=ncomp))
  rownames(Xweights) = colnames(x)

  #matrice des composantes de X # loadings # var latentes
  Xloadings = data.frame(matrix(rep(0), nrow = ncol(x), ncol=ncomp))
  rownames(Xloadings) = colnames(x)

  #matrice des scores de X
  Xscores = data.frame(matrix(rep(0), nrow = nrow(x), ncol=ncomp))

  #matrice des scores de Y
  Yscores = data.frame(matrix(rep(0), nrow = nrow(x), ncol=ncomp))

  #matrice des composantes de Y # loadings # var latentes
  Yloadings = data.frame(matrix(rep(0), nrow = ncol(y), ncol = ncomp))
  rownames(Yloadings) = colnames(y)

  ###########################  ###########################

  for(k in 1:ncomp){
    u <- as.matrix(y[,1])

    w = (t(x) %*% u) / (sum(u^2)) #t(u) %*% u #dim(4 1)   #matrice des poids des composantes de X
    w = w / sqrt(sum(w^2)) # normalization de w

    w_new=0

    while(abs(mean(w)-mean(w_new)) > 1e-10){

      w_new=w

      t = x %*% w / (sum(w^2)) #t(x) #matrice des scores de X
      q = (t(y) %*% t) / (sum(t^2))  #matrice des composantes de Y # loadings
      u = (y %*% q) / (sum(q^2)) #t(y) #matrice des scores de Y
      w = (t(x) %*% u) / (sum(u^2)) #t(u) %*% u #dim(4 1)   #matrice des poids des composantes de X
      w = w / sqrt(sum(w^2)) # normalization de w
    }

    P = (t(x) %*% as.matrix(t)) / (sum(t^2)) #matrice des composantes de X # loadings
    x = x - t %*% t(P)
    y = y - (t %*% t(q))

    #stockage des colonnes

    Xweights[, k] <- w
    Xscores[, k] <- t
    Yscores[, k] <- u
    Xloadings[, k] <- P
    Yloadings[, k] <- q


  }

  x_rotation = as.matrix(Xweights) %*%  solve(t(Xloadings)%*%as.matrix(Xweights))
  coeff = x_rotation%*%t(Yloadings)
  ecart = sapply(data.frame(y),sd)
  coeff = coeff*ecart

  intercept = colMeans(y)

  obj = list("x"=x,
            "y"=y,
            "y_loadings"=Yloadings,
            "y_scores"=Yscores,
            "x_weights"=Xweights,
            "x_loadings"=Xloadings,
            "x_scores"=Xscores,
            "ncomp"=ncomp,
            "coefficients"= coeff,
            "intercept"=intercept)
  class(obj) = "PLSDA"

 return(obj)

}

data = iris
obj = plsda()
print(plsda_fit(obj,data$Species, data, ncomp=2))

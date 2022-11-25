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


  #rang de la matrice
  a = min(nrow(data), ncol(data)) # si ncomp is null

  if(is.null(ncomp)){
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

  w=0.5

  for(k in 1:ncomp){
    u <- as.matrix(y[,1])

    while(abs(1-sum(w^2)) > 1e-10){

      w = (t(x) %*% u) / (sum(u^2)) #t(u) %*% u #dim(4 1)   #matrice des poids des composantes de X
      w = w / sqrt(sum(w^2)) # normalization de w

      #browser()

      t = x %*% w / (sum(w^2)) #t(x) #matrice des scores de X
      q = (t(y) %*% t) / (sum(t^2))  #matrice des composantes de Y # loadings

      u = (y %*% q) / (sum(q^2)) #t(y) #matrice des scores de Y
    }

    P = (t(x) %*% t) / (sum(t^2)) #matrice des composantes de X # loadings
    x = x - t %*% t(P)
    y = y - t %*% as.matrix(t(q))

    print(w)
    print(t)


      #stockage des colonnes

  Xweights[, k] <- w #
  Xscores[, k] <- t #
  Yscores[, k] <- u
  Xloadings[, k] <- P
  Yloadings[, k] <- q


  }





 #x_rotation = w%*%solve(t(P)%*%w)
 #coef = x_rotation%*%t(q)
 #ecart = sapply(y,FUN= sd)

 #coef = coef*ecart
 #intercept = colMeans(y)


 obj = list("x"=x,
            "y"=y,
            "y_loadings"=Yloadings,
            "y_scores"=Yscores,
            "x_loadings"=Xloadings,
            "x_weights"=Xweights,
            "x_scores"=Xscores,
            "ncomp"=ncomp)#,
            #"coeff"= coeff,
            #"intercept"=intercept)


  return(2)

}

data = iris
obj = plsda()
print(plsda_fit(obj,data$Species, data, ncomp=2))

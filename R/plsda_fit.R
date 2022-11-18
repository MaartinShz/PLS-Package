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


plsda_fit<-function(var.cible,data,ncomp=NULL, var.select = F, nfold = 10){

  #rang de la matrice
  a = min(nrow(data), ncol(data)) # si ncomp is null

  if(is.null(ncomp)){
    ncomp = a
  }

  # selection de X et Y
  x= data[,-5] #to do
  Y= var.cible

  # centre-reduire les explicatives
  x= scale(x)

  # recodage de la variable cible
  y <- get_dummies(Y)


  #matrice des poids des composantes de X
  w <- data.frame(matrix(rep(0), nrow = ncol(x), ncol=ncomp))
  rownames(w) <- colnames(x)

  #matrice des composantes de X # loadings # var latentes
  P <- data.frame(matrix(rep(0), nrow = ncol(x), ncol=ncomp))
  rownames(P) <- colnames(x)

  #matrice des scores de X
  t <- data.frame(matrix(rep(0), nrow = nrow(x), ncol=ncomp))

  #matrice des scores de Y
  u <- data.frame(matrix(rep(0), nrow = nrow(x), ncol=ncomp))

  #matrice des composantes de Y # loadings # var latentes
  q <- data.frame(matrix(rep(0), nrow = ncol(y), ncol = ncomp))
  rownames(q) <- colnames(y)

  for(k in 1:ncomp){
    u <- as.matrix(y[,1])
    w.old = 1
    while(abs(sum(w.old^2)-sum(w^2)) > 1e-10){
      #browser()

      print(class(t(u)))
      print(class(u))
      print(t(u))
      print(u)

      w = (t(x) %*% u) / (sum(u^2)) ###sum(u^2)
      w = w / sqrt(as.numeric(t(w)) %*% (as.numeric(w)))
      t = t(x) %*% w / (t(w) %*% w)
      q = (t(y) %*% t) / (t(t) %*% t)
      u = t(y) %*% q / (t(q) %*% q)
    }

    P = (t(x) %*% t) / (t(as.matrix(t)) %*% as.matrix(t))

    x = x - t %*% t(P)

    y = y - t %*% as.matrix(t(q))
  }
  return(w)
}
data = iris
plsda_fit(data$Species, data)



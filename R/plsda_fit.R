#' plsda_fit
#'
#' Method to use The Partial least squares regression
#' It initialize the method and train the model with the pls regression
#' to make a prediction on a dataset
#'
#' @usage
#' plsda_fit(obj,data$Species, data, ncomp=2)
#'
#' @param
#' ObjectPLSDA PLDA Object
#' formula vector of the target data of the train dataset
#' data dataframe of the train dataset
#' ncomp integer number of composant
#' var.select boolean made a variable selection or not
#' centre boolean if the data need to be normalize
#'
#' @return
#' obj plsda object
#'
#' @examples
#'obj = plsda()
#'plsda_fit(obj,iris$Species, iris, ncomp=2)

plsda_fit<-function(ObjectPLSDA, formula, data, ncomp=NULL, var.select = F, centre=T){

  if (class(ObjectPLSDA)!="PLSDA") {
    stop("Object's class is not PLSDA")
  }

  if (!is.data.frame(data)){ #check if data is a dataframe
    stop("data must be a dataframe")
  }


  if(is.null(ncomp) || !is.numeric(ncomp) || ncomp>min(nrow(data), ncol(data))){
    # if ncomp is null or in a wrong format we take the Range of the matrix
    ncomp = min(nrow(data), ncol(data))
  }
  ###########################

  # selection of X the predictive data  and  Y the target dataz
  x= data[,-ncol(data)]
  Y= formula
  # recode in dummy values the target data
  y = get_dummies(Y)

  if(centre){
    # data normalization
    x = scale(x)
    y = scale(y)
  }







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

    temp=0

    while(abs(mean(w)-mean(temp)) > 1e-10){

      temp=w
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
            "data"=data,
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
obj = plsda_fit(obj,data$Species, data, ncomp=2)
print(obj)

print(row.names(obj$x_loadings))



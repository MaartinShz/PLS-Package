plsda_fit <-
function(object, formula, data, ncomp=NULL, var.select = F, center=T, threshold = 0.8){

  if (class(object)!="PLSDA") {
    stop("Object's class is not PLSDA")
  }

  if (!is.data.frame(data)){ #check if data is a dataframe
    stop("data must be a dataframe")
  }


  if(is.null(ncomp) || !is.numeric(ncomp) || ncomp>min(nrow(data), ncol(data))){
    # if ncomp is null or in a wrong format we initialize it at 2
    ncomp = 2
  }


  if (var.select == T){
    obj = plsda_fit(object = object, formula = formula, data= data, ncomp=ncomp, var.select = F, center=center)
    newX = plsda_vip(obj,threshold = threshold)$newX
    X = data[,newX]
  }else{
    X = model.matrix(formula,data=data)[,-1]
  }
  ###########################


  # selection of X the predictive data  and  Y the target dataz
  #X = model.matrix(formula,data=data)[,-1] #pour enlever intercept
  Y = model.response(model.frame(formula,data=data))
  # recode in dummy values the target data
  y = get_dummies(Y)

  if(center){
    # data normalization
    x = scale(X)
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
    iteration = 0

    while(abs(mean(w)-mean(temp)) > 1e-10){
      iteration = iteration + 1
      temp=w
      t = x %*% w / (sum(w^2)) #t(x) #matrice des scores de X
      q = (t(y) %*% t) / (sum(t^2))  #matrice des composantes de Y # loadings
      u = (y %*% q) / (sum(q^2)) #t(y) #matrice des scores de Y
      w = (t(x) %*% u) / (sum(u^2)) #t(u) %*% u #dim(4 1)   #matrice des poids des composantes de X
      w = w / sqrt(sum(w^2)) # normalization de w

      if (iteration>500) {
        stop("PLS regression cannot converge")
      }

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


  testXrot <- tryCatch({
    solve(t(Xloadings)%*%as.matrix(Xweights))
  },
  error = function(err) {
    stop("reduce number of composant, ncomp")
  })


  x_rotation = as.matrix(Xweights) %*%  testXrot
  coeff = x_rotation%*%t(Yloadings)
  ecart = sapply(data.frame(y),sd)
  coeff = coeff*ecart

  intercept = colMeans(y)

  obj = list("x"=x,
             "ytarget"=Y,
            "y"=y,
            "data"=data,
            "y_loadings"=Yloadings,
            "y_scores"=Yscores,
            "x_weights"=Xweights,
            "x_loadings"=Xloadings,
            "x_scores"=Xscores,
            "corrX"=cor(x),
            "eigen"=eigen(cor(x)),
            "ncomp"=ncomp,
            "coefficients"= coeff,
            "intercept"=intercept)
  class(obj) = "PLSDA"

 return(obj)

}

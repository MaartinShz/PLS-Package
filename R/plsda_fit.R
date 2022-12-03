#' plsda_fit
#'
#' @description
#' Method to use The Partial least squares regression
#' It initialize the method and train the model with the pls regression
#' to make a prediction on a dataset
#' This function use the NIPALS algorithm for make a prediction on binary or multinominal target
#'
#' @usage
#' plsda_fit(obj,data$Species, data, ncomp=2)
#'
#' @param
#' object PLDA Object
#' formula an object of class formula use to select exolicative data and taget data of the dataset
#' data dataframe of the train dataset
#' ncomp integer number of composant
#' var.select boolean for use the vip function
#' centre boolean if the data need to be normalize
#'
#' @return
#' obj plsda object
#' \code{X} the original dataset containing the predictors.
#'
#' @examples
#'obj = plsda()
#'plsda_fit(obj,Species~., iris, ncomp=2)

plsda_fit<-function(object, formula, data, ncomp=NULL, var.select = F, centre=T){ # Fit function for a pls object

  if (class(object)!="PLSDA") {
    stop("Object's class is not PLSDA")
  }

  if (!is.data.frame(data) & !is.matrix(data) & !class(data)=="model.matrix.default"){ #check data format
    stop("data must be a dataframe")
  }


  if(is.null(ncomp) || !is.numeric(ncomp) || ncomp>min(nrow(data), ncol(data))){

    # if ncomp is null or in a wrong format we take the Range of the matrix
    ncomp = min(nrow(data), ncol(data))
  }

  # selection of X the predictive data  and  Y the target dataz
  X = model.matrix(formula,data=data)[,-1] #pour enlever intercept
  Y = model.response(model.frame(formula,data=data))

  # recode in dummy values the target data
  y = get_dummies(Y)

  if(centre){
    # data normalization
    x = scale(X)
    y = scale(y)
  }


  ##############################################################################

  #matrix composants X weights
  Xweights = data.frame(matrix(rep(0), nrow = ncol(x), ncol=ncomp))
  rownames(Xweights) = colnames(x)

  #matrix of X loadings # latents variables
  Xloadings = data.frame(matrix(rep(0), nrow = ncol(x), ncol=ncomp))
  rownames(Xloadings) = colnames(x)

  #matrix X scores
  Xscores = data.frame(matrix(rep(0), nrow = nrow(x), ncol=ncomp))

  #matrix Y scores
  Yscores = data.frame(matrix(rep(0), nrow = nrow(x), ncol=ncomp))

  #matrix of y loadings # latants varaibles
  Yloadings = data.frame(matrix(rep(0), nrow = ncol(y), ncol = ncomp))
  rownames(Yloadings) = colnames(y)

  ##############################################################################
  for(k in 1:ncomp){
    u <- as.matrix(y[,1])

    w = (t(x) %*% u) / (sum(u^2)) #t(u) %*% u #matrix composants X weights
    w = w / sqrt(sum(w^2)) # normalization of w

    temp=0
    iteration = 0

    while(abs(mean(w)-mean(temp)) > 1e-10){ # stop if results converge
      iteration = iteration + 1
      temp=w
      t = x %*% w / (sum(w^2)) #matrix X scores #
      q = (t(y) %*% t) / (sum(t^2)) #matrix Y loadings
      u = (y %*% q) / (sum(q^2)) #t(y) #matrix Y scores#
      w = (t(x) %*% u) / (sum(u^2)) # = / (t(u) %*% u) # matrix composants X weights
      w = w / sqrt(sum(w^2)) #normalization of w

      if (iteration>500) {
        stop("PLS regression cannot converge")
      }

    }

    P = (t(x) %*% as.matrix(t)) / (sum(t^2)) #matrix X loadings
    x = x - t %*% t(P)
    y = y - (t %*% t(q))

    #datas stock in dataframes

    Xweights[, k] <- w
    Xscores[, k] <- t
    Yscores[, k] <- u
    Xloadings[, k] <- P
    Yloadings[, k] <- q

  }


  testXrot <- tryCatch({ # if the number of composant is too high calcul can't be solved
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

#data = iris
#obj = plsda()
#obj = plsda_fit(obj,Species~., iris,ncomp=2)
#plot.varCorr(obj)

#print(obj)
#print(plsda_fit(obj, Species ~ Sepal.Length + Petal.Length, data = iris, ncomp = 2))


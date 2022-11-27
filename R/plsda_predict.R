#' plsda_predict
#'
#' Method to use The Partial least squares regression Prediction
#' It make a prediction on test data
#'
#' @usage
#' plsda_predict(obj,xtest)
#'
#' @param
#' object PLDA Object
#' Xtest dataframe of the test dataset with no target variable
#' type "posterior" or "class" return format of the method
#'
#' @return
#' type= posterior #probabilité d’appartenance aux classes)
#' type= class #classe prédite
#'
#'
#' @examples
#'#obj = plsda()
#'obj = plsda_fit(obj,iris$Species,iris,ncomp=2)
#'xtest= iris[,-ncol(iris)]
#'plsda_predict(obj,xtest)
#'
#'
plsda_predict<-function(object, Xtest, type="posterior"){
  if (class(object)!="PLSDA") {
    stop("Object's class is not PLSDA")
  }

  if (type != "posterior" & type != "class"){
    stop("incorrect type")
  }
  if (!is.data.frame(Xtest)){ #check if data is a dataframe
    stop("data must be a dataframe")
  }

  x = scale(Xtest)

  y_pred = x%*% as.matrix(object$coefficients)# + object$intercept

  temp = apply(y_pred,1,exp)
  Ysoftmax = t(temp/colSums(temp))

  if (type=="posterior"){
    return(Ysoftmax)
  }
  else{
    pred = apply(Ysoftmax,1,which.max)
    return(as.factor(levels(object$y)[pred]))
  }


}






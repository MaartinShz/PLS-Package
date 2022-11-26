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


obj = plsda()
obj = plsda_fit(obj,iris$Species,iris,ncomp=2)
xtest= iris[,-ncol(iris)]
plsda_predict(obj,xtest)





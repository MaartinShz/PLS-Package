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

  x = scale(Xtest)

  y_pred = t(x)%*%objects$coeff+objects$intercept

  temp = apply(ypred,1,exp)
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
plsda_fit(obj,iris$Species,iris)




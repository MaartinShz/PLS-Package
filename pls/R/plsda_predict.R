plsda_predict <-
function(obj, newdata, type="posterior"){
  if (class(obj)!="PLSDA") { # check if the object is a pls object
    stop("Object's class is not PLSDA")
  }
  if (type != "posterior" & type != "class" & !class(data)=="model.matrix.default"){
    stop("incorrect type")
  }
  if (!is.data.frame(newdata)){ #check if data is a dataframe
    stop("data must be a dataframe")
  }
  if (ncol(newdata) != ncol(obj$x)){ #check if data match with explication train
    stop("data test don't match with data train")
  }

  x = scale(newdata)

  y_pred = x%*% as.matrix(obj$coefficients)

  temp = apply(y_pred,1,exp)
  Ysoftmax = t(temp/colSums(temp))

  if (type=="posterior"){# return the probability for each class
    return(Ysoftmax)
  }
  else{
    pred = apply(Ysoftmax,1,which.max)
    return(colnames(obj$y)[pred])# return the target prediction for each observation
  }
}

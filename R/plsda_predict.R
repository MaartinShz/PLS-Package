#' plsda_predict
#'
#' Method to use The Partial least squares regression Prediction
#' It make a prediction on test data
#'
#' @usage
#' plsda_predict(obj,newdata)
#'
#' @param
#' obj PLDA object
#' newdata dataframe of the test dataset with no target variable
#' type "posterior" or "class" return format of the method
#'
#' @return
#' type= posterior to have probability of class membership by observation
#' type= class to have the class predicted by observation
#'
#'
#' @examples
#'obj = plsda()
#'obj = plsda_fit(obj,iris$Species,iris,ncomp=2)
#'newdata= iris[,-ncol(iris)]
#'plsda_predict(obj,newdata)
#'
#'
#'

plsda_predict<-function(obj, newdata, type="posterior"){
  if (class(obj)!="PLSDA") {
    stop("Object's class is not PLSDA")
  }
  if (type != "posterior" & type != "class"){
    stop("incorrect type")
  }
  if (!is.data.frame(newdata)){ #check if data is a dataframe
    stop("data must be a dataframe")
  }
  if (ncol(newdata) != ncol(obj$x)){ #check if data is a dataframe
    stop("data test don't match with data train")
  }

  x = scale(newdata)

  y_pred = x%*% as.matrix(obj$coefficients)# + obj$intercept

  temp = apply(y_pred,1,exp)
  Ysoftmax = t(temp/colSums(temp))

  if (type=="posterior"){
    return(Ysoftmax)
  }
  else{
    pred = apply(Ysoftmax,1,which.max)
    #print(Ysoftmax)
    #print(colnames(obj$y))
    #print(pred)
    #print(colnames(obj$y)[pred])
    return(colnames(obj$y)[pred])
  }
}

#obj = plsda()
#obj = plsda_fit(obj,Species~.,iris,ncomp=2)
#newdata= iris[,-ncol(iris)]
#plsda_predict(obj,newdata,type = "class")



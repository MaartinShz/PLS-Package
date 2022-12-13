#' PLSDA Class
#'
#' @description
#' Class of the object PLSDA, this class is used to create an object Plsda, to use a Partial least squares regression method.
#'
#'
#' @usage
#' obj = plsda()
#'
#' @param
#' ncomp number of composant
#'
#' @return
#' obj plsda object
#'
#' @examples
#' obj = plsda()
#'
#' objpls = plsda(ncomp=2)
#'
#'
#' print(obj)
#' summary(obj)
#'
#' @export
#'

plsda = function(ncomp=NULL){

  if(!is.numeric(ncomp) & !is.null(ncomp)){
    stop("Number of composant must be a numeric")
  }

  #PLS Instance Creation
  instance = list("ncomp"=ncomp)
  class(instance) = "PLSDA"

  return(instance)
}

#' print function for PLSDA Class
#'
#' @description
#' Overload of print function
#'
#' @usage
#' obj = plsda()
#'
#' @param
#' obj an pls object
#'
#' @return
#' observe value of an pls object
#'
#' @examples
#' obj = plsda()
#' print(obj)

#' @export
#'



#Overload of print function
print.plsda = function(object){
  if (class(object)!="PLSDA") {
    stop("Object's class is not PLSDA")
  }
  if(is.null(object$intercept)){
    cat("type : ", class(object), "\n")
  }else {
    print("x : ", object$x, "\n")
    print("y : ", object$y, "\n")
    print("data : ", object$data, "\n")
    print("ncomp : ", object$ncomp, "\n")
    print("y_loading : ", object$y_loading, "\n")
    print("y-scores : ", object$y_scores, "\n")
    print("x_weights : ", object$x_weights, "\n")
    print("x_loadings : ", object$x_loadings, "\n")
    print("x_scores : ", object$x_scores, "\n")
    print("eigen : ", object$eigen, "\n")
    print("coefficients : ", object$coefficients, "\n")
    print("intercept : ", object$intercept, "\n")
  }
}

#' summary for PLSDA Class
#'
#' @description
#' Overload of summary function
#'
#'
#' @usage
#' summary(obj)
#'
#' @param
#' obj an pls object
#'
#' @return
#' observe value of explicative varaibles in an object pls
#'
#' @examples
#' obj = plsda()
#' summary(obj)
#'
#' @export
#'


#Overload of summary function
summary.plsda = function(object){
  if (class(object)!="PLSDA") {
    stop("Object's class is not PLSDA")
  }
  if(is.null(object$intercept)){
    cat("type : ", class(object), "\n")
  }else {
    print("data : ", object$data, "\n")
    print("x_weights : ", object$x_weights, "\n")
    print("x_scores : ", object$x_scores, "\n")
    print("ncomp : ", object$ncomp, "\n")
    print("corrX : ", object$corrX, "\n")

  }


}




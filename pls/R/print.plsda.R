print.plsda <-
function(object){
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

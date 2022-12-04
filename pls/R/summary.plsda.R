summary.plsda <-
function(object){
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

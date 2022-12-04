#' variableMap.plsda()
#'
#' @name
#' variableMap.plsda
#'
#' @description
#' variableMap.plsda : map of individuals on 2 composants
#'
#' @usage
#' variableMap.plsda(obj)
#'
#' @param
#' obj  plsda object return by fit function
#' @return
#' plot plot to show individus projection in a new plan with 2 composants
#'
#' @examples
#' obj = plsda()
#' obj =plsda_fit(obj,Species~., iris, ncomp=2)

#' variableMap.plsda(obj,obj$x_scores$X1,obj$x_scores$X2)
#'
#' @export
#'

variableMap.plsda <- function(object, comp1, comp2) {

  if (class(object)!="PLSDA") {
    stop("Object's class is not PLSDA")
  }

  plot(comp1,comp2,xlab="Comp.1",ylab="Comp.2", col =obj$ytarget , bty ="n")
  text(comp1,comp2,labels=obj$ytarget,cex=0.60)
  abline(h=0,v=0)

}


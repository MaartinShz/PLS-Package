#' plot.scree()
#'
#' @name
#' plot.scree
#'
#' @description
#' plot.scree : plots the variances against the number of the principal component.
#'
#' @usage
#' plot.scree(obj)
#'
#' @param
#' obj  plsda object return by fit function
#' @return
#' plot plot to show eigen values of each composant
#'
#' @examples
#' obj = plsda()
#' obj =plsda_fit(obj,Species~., iris, ncomp=2)
#'
#' plot.scree(obj)
#'
#' @export
#'


plot.scree <- function(object){ # scree plot used to determine the number of factors to retain of a pls object


  if (class(object)!="PLSDA") {
    stop("Object's class is not PLSDA")
  }
  if (is.null(object$eigen) || is.null(object$eigen$values)){
    stop("Object PLSDA is not complete")
  }
  scree <- plot(object$eigen$values,
                type="o",
                col = "red",
                lwd = 3,
                pch = 4,
                ylab="Eigen values",
                xlab="Number of Components",
                main =paste(class(object)," Scree plot "))
}

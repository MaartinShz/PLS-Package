#' plot
#'
#' @name
#' plot
#'
#' @description
#' plot.plsda : plots the variances against the number of the principal component.
#' plot.varCorr : show the correlation matrix in a pretty plot
#' variableMap.plsda : map of individuals on 2 composants
#'
#' @usage
#' plot.scree(obj)
#' plot.varCorr(obj)
#' variableMap.plsda(obj,obj$x_scores$X1,obj$x_scores$X2)
#'
#' @param
#' obj  plsda object return by fit function
#' @return
#' plot plot to show information about data
#'
#' @examples
#' obj = plsda()
#' obj =plsda_fit(obj,Species~., iris, ncomp=2)
#'
#' plot.scree(obj)
#' plot.varCorr(obj)
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


plot.varCorr <- function(object){ # plot to show Correlation matrix of explication data
  if (class(object)!="PLSDA") {
    stop("Object's class is not PLSDA")
  }

  reshapeCorr = data.frame(matrix(rep(0), nrow = length(obj$corrX), ncol=3, )) # transform the correlation matrix in a dataframe exploitable
  i=0
  for (k in 1:ncol(obj$corrX))
  {
    for ( l in 1:nrow(obj$corrX))
    {
      i=i+1
      reshapeCorr[i,3]=obj$corrX[l,k]
      reshapeCorr[i,1]=rownames(obj$corrX)[l]
      reshapeCorr[i,2]=colnames(obj$corrX)[k]
    }
  }

  ggplot(data = reshapeCorr, aes(x=X1, y=X2, fill=X3)) +
    geom_tile()# print the plot

}

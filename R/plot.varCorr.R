#' plot.varCorr()
#'
#' @name
#' plot.varCorr
#'
#' @description
#' plot.varCorr : show the correlation matrix in a pretty plot
#'
#' @usage
#' plot.varCorr(obj)
#'
#' @param
#' obj  plsda object return by fit function
#' @return
#' plot to show Correlation matrix
#'
#' @examples
#' obj = plsda()
#' obj =plsda_fit(obj,Species~., iris, ncomp=2)
#'
#' plot.varCorr(obj)
#'
#' @export
#'

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

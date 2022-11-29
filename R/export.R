#' export.plsda
#'
#' function to export your prediction in a csv
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

export.plsda <- function(object, ypred){

  if (class(object)!="PLSDA") {
    stop("Object's class is not PLSDA")
  }

  if (!is.data.frame(ypred)){ #check if data is a dataframe
    stop("data must be a dataframe")
  }
  path = paste(getwd(),"/PredByPLS.csv",sep = "")
  write.csv(iris,path, row.names = TRUE)# ? csv2 = TRUE
  print(paste("Redistered here : ",path,sep=" "))
}

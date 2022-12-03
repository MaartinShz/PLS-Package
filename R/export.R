#' export.plsda
#'
#' @description
#' function to export your prediction in a csv file
#'
#' @usage
#' export.plsda(ypred)
#'
#'
#' @param
#' obj plsda object
#'
#' @return
#' Value return
#' ypred prediction made by the plsda_predict function
#'
#' @examples
#'obj = plsda()
#'obj = plsda_fit(obj,target~.,data,ncomp=2)
#'ypred = plsda_predict(obj, xtest,type = "posterior")
#'export.plsda(ypred)
#'
export.plsda <- function(ypred, path=NULL){ # function to export a dataframe to a csv file

  if (!is.data.frame(ypred) & !is.matrix(ypred)){ #check if data is a dataframe or a matrix
    stop("data must be a dataframe or a matrix")
  }
  if (is.null(path)){ # if path is null we take the current directory to export file
    path = paste(getwd(),"/PredByPLS.csv",sep = "")
  }

  write.csv(iris,path, row.names = TRUE) # export the file in csv
  print(paste("Redistered here : ",path,sep=" "))
}

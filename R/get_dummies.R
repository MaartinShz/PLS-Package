#' get_dummies
#'
#' @description
#' This function allows you to convert categorical variables into numerical variables.
#' The different modalities are recorded in new columns that encode the presence of this category with binary values
#'
#' @usage
#' get_dummies(y)
#'
#' @param
#' y a vector, factor that will be transformed, often used for your target variable
#' @return
#' dummies a matrix with all dummy values of the param in entry
#'
#' @examples
#' ydummies = get_dummies(iris$Species)
#'
#' @export
#'

get_dummies<-function(y){

  y = as.factor(as.vector(y))
  modalites = levels(y)
  dummies = sapply(modalites,function(case){ifelse(case==y,1,0)})

  return(as.matrix(dummies))
}

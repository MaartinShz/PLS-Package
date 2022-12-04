#' checkinstall.shiny.plsda
#'
#' @description
#' functions to check if all packages are installed
#' checkinstall.shiny.plsda function to check package that the shiny app pls needs
#'
#' @usage
#' checkinstall.shiny.plsda()
#'
#' @examples
#' checkinstall.shiny.plsda()
#'
#' @export
#'
checkinstall.shiny.plsda <- function() {

  packages <- c("shiny","readxl", "dplyr", "plotly")
  install.packages(setdiff(packages, rownames(installed.packages())))
  library(shiny)
  library(readxl)
  library(dplyr)
  library(plotly)


}

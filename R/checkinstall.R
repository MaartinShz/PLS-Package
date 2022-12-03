#' checkinstall
#'
#' @description
#' functions to check if all packages are installed
#' checkinstall.plsda function to check package that the library pls needs
#' checkinstall.shiny.plsda function to check package that the shiny app pls needs
#'
#' @usage
#' checkinstall.plsda()
#'
#'
#' @return
#' obj plsda object
#'
#'
#' @examples
#' checkinstall.plsda()
#' checkinstall.shiny.plsda()
#'
#' @export
#'

checkinstall.plsda <- function() {

  packages <- c("ggplot2")
  install.packages(setdiff(packages, rownames(installed.packages())))
  library("ggplot2")

}

checkinstall.shiny.plsda <- function() {

  packages <- c("shiny","readxl", "dplyr")
  install.packages(setdiff(packages, rownames(installed.packages())))

}



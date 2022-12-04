#' checkinstall.plsda
#'
#' @description
#' functions to check if all packages are installed
#' checkinstall.plsda function to check package that the library pls needs
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
#'
#' @export
#'

checkinstall.plsda <- function() {

  packages <- c("ggplot2")
  install.packages(setdiff(packages, rownames(installed.packages())))
  library("ggplot2")

}





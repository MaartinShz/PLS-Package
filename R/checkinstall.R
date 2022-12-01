checkinstall.plsda <- function() {

  packages <- c("ggplot2")
  install.packages(setdiff(packages, rownames(installed.packages())))

}

checkinstall.shiny.plsda <- function() {

  packages <- c("shiny","readxl")
  install.packages(setdiff(packages, rownames(installed.packages())))

}

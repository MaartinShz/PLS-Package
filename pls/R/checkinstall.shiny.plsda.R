checkinstall.shiny.plsda <-
function() {

  packages <- c("shiny","readxl", "dplyr")
  install.packages(setdiff(packages, rownames(installed.packages())))

}

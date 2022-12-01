checkinstall.plsda <- function() {

  packages <- c("ggplot2")
  install.packages(setdiff(packages, rownames(installed.packages())))

}

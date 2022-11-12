#' Titre
#'
#' Description
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
#' y = get_dummies(iris$Species)

plot.plsda <- function(x, ...) {


  quality <- x$Quality
  barplot(quality,
          beside=TRUE,
          main="Model quality by Component",
          xlab="Component",
          ylab="Quality",
          col=c("red","blue"),
          space=c(0.05,0.2),
          legend=rownames(quality))


  VIP <- x$VIP
  for (h in 1:ncol(VIP)) {
    barplot(VIP[,h],
            names.arg=rownames(VIP),
            main=c(paste("Variable Importance Plot for component",h),"Confidence interval at 0.95%"),
            xlab="Variables",
            ylab="VIP",
            col="blue")
    abline(a=0,b=0,h=0.8,v=0,lty=5)
    abline(a=0,b=0,h=1,v=0,lty=5)

  }
}

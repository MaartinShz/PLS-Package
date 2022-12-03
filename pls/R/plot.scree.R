plot.scree <-
function(object){ # scree plot used to determine the number of factors to retain of a pls object

  if (class(object)!="PLSDA") {
    stop("Object's class is not PLSDA")
  }
  if (is.null(object$eigen) || is.null(object$eigen$values)){
    stop("Object PLSDA is not complete")
  }
  scree <- plot(object$eigen$values,
                type="o",
                col = "red",
                lwd = 3,
                pch = 4,
                ylab="Eigen values",
                xlab="Number of Components",
                main =paste(class(object)," Scree plot "))
}

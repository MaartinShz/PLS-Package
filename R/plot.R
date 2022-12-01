#' Plot
#'
#' plot.plsda : plots the variances against the number of the principal component.
#'
#' @usage
#' plot.scree(obj)
#'
#' @param
#' obj  plsda object
#' @return
#' plot a scree plot
#'
#'
#' @examples
#'plot.scree(obj)
#'plot.varCorr(obj)
#'


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


variableMap.plsda <- function(x, ...) {

}

plot.scree <- function(object){

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

plot.varCorr <- function(object){
  if (class(object)!="PLSDA") {
    stop("Object's class is not PLSDA")
  }

  reshapeCorr = data.frame(matrix(rep(0), nrow = length(obj$corrX), ncol=3, ))
  i=0
  for (k in 1:ncol(obj$corrX))
  {
    for ( l in 1:nrow(obj$corrX))
    {
      i=i+1
      reshapeCorr[i,3]=obj$corrX[l,k]
      reshapeCorr[i,1]=rownames(obj$corrX)[l]
      reshapeCorr[i,2]=colnames(obj$corrX)[k]
    }
  }

  ggplot(data = reshapeCorr, aes(x=X1, y=X2, fill=X3)) +
    geom_tile()

}


plot_mapVariable <- function(object){

  if (class(object)!="PLSDA") {
    stop("Object's class is not PLSDA")
  }

  ggplot(obj$x_loadings, aes(row.names(obj$x_loadings), obj$x_loadings$X1)) +
    geom_boxplot() + coord_flip()
}

#ggplot(obj$x_loadings) +
#  geom_hex(aes(x = obj$x_loadings$X1, y = obj$x_loadings$X2), bins = 20)

#Carte des individus dans « les » espaces factoriels
#• Courbes mettant en relation le nombre de composants à sélectionner et un critère
#quelconque d’évaluation de la qualité de la modélisation (éventuellement calculé avec une procédure de rééchantillonnage)

#' Variable Importance in Projection
#'
#' @param object
#' A PLSDA class model.
#' @param threshold
#' threshold of variable's importance. 0.8 by default.
#' @return
#' VIP : Most importants variables in the model.
#' \cr
#' newX : New variables
#' \cr
#' Newdataset : New dataset constructed with the selected variables
#'
#' @examples
#' plsda_vip=(object = objPLSDA)
#' plsda_vip=(object = objPLSDA,threshold=0.7)
#'
#' @export
#'
plsda_vip<-function(Object,formula,threshold=0.8){

  # Taking information from the object PLSDA
  xs=Object$x_scores
  xw=Object$x_weights
  X=Object$x
  y=Object$y
  ircoeff=Object$y_loadings
  ncomp=Object$ncomp
  r=nrow(xw)

  #explained Y variance
  ssy=diag(t(xs)%*%as.matrix(xs)%*%t(ircoeff)%*%as.matrix(ircoeff))
  ssy_tot_exp=sum(ssy)

  weight=(xw/sqrt(colSums(xw^2)))^2
  vip = sqrt(r*(ssy*weight)/ssy_tot_exp)

  # Taking the most important variable
  imp_v=rownames(vip)[which(vip[,ncomp]>threshold)]


  # We take 2 most importants variables if there is only 0 or 1 variable that are superior of the threshold
  if (length(imp_v)<2){
    vip_sorted = vip[order(-vip[,ncomp]),]
    imp_v=rownames(vip_sorted)[1:2]
  }


  # New X with important variables
  newX = colnames(X[,imp_v])

  # New dataset with important variables
  newdataset=data.frame(X[,imp_v],y)

  return(list("newX"=newX, "vip"=vip, "newdataset"=newdataset))
}




















#Object = obj
#test=plsda_vip(obj)
#obj$x
#test$newX
#test$vip
#test$newdataset

#ncomp = 2


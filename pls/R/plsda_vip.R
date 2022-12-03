plsda_vip <-
function(Object,formula,threshold=0.8){

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
  variable_important=rownames(vip)[which(vip[,ncomp]>threshold)]


  # We take 2 most importants variables if there is only 0 or 1 variable that are superior of the threshold
  if (length(variable_important)<2){
    vip_sorted = vip[order(-vip[,ncomp]),]
    variable_important=rownames(vip_sorted)[1:2]
  }


  # New X with important variables
  newX = colnames(X[,variable_important])

  # New dataset with important variables
  newdataset=data.frame(X[,variable_important],y)

  return(list("newX"=newX, "vip"=vip, "newdataset"=newdataset))
}

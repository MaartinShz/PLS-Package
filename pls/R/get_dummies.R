get_dummies <-
function(y){

  y = as.factor(as.vector(y))
  modalites = levels(y)
  dummies = sapply(modalites,function(case){ifelse(case==y,1,0)})

  return(as.matrix(dummies))
}

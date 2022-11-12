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


scale<-function (x, reduce=T){

    Mat<-as.matrix(x)
    if(typeof(Mat)!="double"){
      stop("error in matrix")
    }
    means<-apply(Mat,2,mean)

    if(ncol(Mat)>1){newMat<-t(apply(Mat,1,function(x){ return(x-means)}))
    }else{newMat <- Mat-means
    }
    if(reduce){vars<-apply(Mat,2,var)
      newMat <- t(apply(newMat,1,function(x){x/sqrt(vars)}))
      return(list("New"=as.matrix(newMat), "means"=means, "vars"=vars))
    }else{
      return(list("New"=as.matrix(newMat),"means"=means))
    }


}


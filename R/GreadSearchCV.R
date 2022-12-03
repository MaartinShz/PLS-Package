#' GridSearchCV
#'
#' @param
#'
#' @param
#'
#' @return
#'
#'
#'
#'
#' @examples
#'
#'
#' @export
#'
GridSearchCV = function(ObjectPLSDA, formula, data, cv = 5, method = 'rsplit'){

    if (class(ObjectPLSDA)!="PLSDA") {
      stop("Object's class is not PLSDA")
    }


    n = nrow(data)
    shuffled_data = data[sample(1:n),]
    fold = list()


    if(method == 'rsplit'){
      for(i in 1:cv){

        #Création dataset d'apprentissage et test aléatoire
        m = matrix(FALSE, nrow = 1, ncol = 150)
        m[,1:(n*0.3)]=TRUE
        ind = sample(m)
        fold[[i]] = ind
      }
    }

    if(method == "kFold"){
      Size = n/cv
      for(i in 1:cv){
        ind = rep(T,n)
        lowb = i * Size - Size + 1
        highb = i * Size
        ind[lowb:highb] = F
        fold[[i]] = ind
      }
    }

    realfscore = c()
    models = list()
    for(k in cv){
      #
      X = model.matrix(formula,data=data)[,-1]
      Y = model.response(model.frame(formula, data = data))
      Y = as.factor(as.vector(Y))

      #Récupération des folds
      ind = fold[[k]]
      train = shuffled_data[!ind,]
      test = shuffled_data[ind,]

      Xtest = data.frame(test[,colnames(X)])
      Ytest = test[,colnames(Y)]

      #Apprentissage du train et predict sur le test
      plsTrain = plsda_fit(ObjectPLSDA, formula, train)
      predTest = plsda_predict(plsTrain, Xtest)

      cm = table(Ytest, predTest)

      totfs = c()
      for(i in 1:nrow(cm)){
        precision = cm[i,i]/sum(cm[,i])
        recall = cm[i,i]/sum(cm[i,])
        fscore = (2*precision*recall)/(precision+recall)
        totfs = append(totfs,fscore)
      }

      Yweights = table(Ytest)/length(Ytest)
      realfscore=sum(totfs*Yweights)
      realfscorevector = append(realfscorevector, realfscore)
      models[[k]] = plsTrain
    }
    model = models[[which.max(realfscorevector)]]
    fscore = realfscorevector[which.max(realfscorevector)]

    return(list("model" = model, "fscore" = fscore))
}


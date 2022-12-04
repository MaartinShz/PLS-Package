#' GridSearchCV
#'
#' @param objectPLSDA
#' A PLSDA class model.
#' @param formula
#' vector of the target data of the train dataset
#' @param data
#' dataframe of the train dataset
#' @param cv
#' Number of datasets creation for cross validation
#' @param method
#' random split or taking cv pieces of the datasets
#'
#' @return
#' model : Best model from the cross-validation
#'
#' \cr
#' fscore : F-score of the model
#'
#' @examples
#' GridSearchCV(obj,Species~.,Iris)
#' GridSearchCV(obj,Species~.,Iris, cv= 10)
#' GridSearchCV(obj,Species~.,Iris, method = 'kfold')
#'
#' @export
#'
GridSearchCV = function(ObjectPLSDA=obj, formula, data, cv = 5, method = 'rsplit'){

    if (class(ObjectPLSDA)!="PLSDA") {
      stop("Object's class is not PLSDA")
    }

    # initialization
    n = nrow(data)
    shuffled_data = data[sample(1:n),]
    fold = list()

    #We create cv new datasets of 30% True and 70% False
    if(method == 'rsplit'){
      for(i in 1:cv){
        m = matrix(FALSE, nrow = 1, ncol = 150)
        m[,1:(n*0.3)]=TRUE
        ind = sample(m)
        fold[[i]] = ind
      }
    }

    #we use kfold method to create cv new datasets
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

    #initialization
    realfscore = c()
    realfscorevector = c()
    models = list()
    for(k in 1:cv){

      # selection of X the predictive data  and  Y the target data
      X = model.matrix(Species~.,data=data)[,-1]
      Y = model.response(model.frame(Species~., data = data))
      Y = as.factor(as.vector(Y))
      Ycol = setdiff(colnames(data),colnames(X))

      #Folds recuperation
      ind = fold[[k]]
      train = shuffled_data[!ind,]
      test = shuffled_data[ind,]

      Xtest = data.frame(test[,colnames(X)])
      Ytest = test[,Ycol]
      #learning from the train and predict in the test
      plsTrain = plsda_fit(ObjectPLSDA, Species~., train)
      predTest = plsda_predict(plsTrain, Xtest,type = "class")

      #confusion matrix
      cm = table(Ytest, predTest)

      #Calculate indicators
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

    #We take the best model and his f-score
    model = models[[which.max(realfscorevector)]]
    fscore = realfscorevector[which.max(realfscorevector)]
    return(list("model" = model, "fscore" = fscore ))
}


#ah = GridSearchCV(obj,Species~.,iris)
#ah$model
#ah$fscore


cross_validation = function(formula, data, ncomp, cv = 5, method = 'rsplit'){

    n = nrow(data)
    shuffled_data = data[sample(1:n),]
    fold = list()


    if(method == 'rsplit'){
      for(i in 1:cv){

        #Création dataset d'apprentissage et test aléatoire
        shuffled_data = data[sample(1:nrow(data)),]
        train = head(shuffled_data,n)
        test = tail(shuffled_data,nrow(data)-n)
      }
    }

    if(merthod == "kFold"){
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
      Xnames = attributes(terms(formula, data=train))$term.labels
      Yname = toString(formula[[2]])


      #Récupération des folds
      ind = fold[k]
      train = shuffled_data[ind,]
      test = shuffled_data[!ind,]

      Xtest = data.frame(test[,Xnames])
      Ytest = test[,Yname]


      #Apprentissage du train et predict sur le test
      plsTrain = plsda_fit(formula, train)
      predTest = plsda_predict(plsTrain, test)

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

data = iris

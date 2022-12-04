split_sample <-
function(data, train_perc = 0.7){

  #check input
  if (train_perc < 0 | train_perc > 1){
    stop("L'échantillon de test est sous forme de pourcentage, veuillez entrer un nombre entre 0 et 1")
  }

  # mix dataset
  n = round(nrow(data)*train_perc)
  shuffled_data = data[sample(1:nrow(data)),]

  #creation of 2 sub dataset one for train or one for test
  train = head(shuffled_data,n)
  test = tail(shuffled_data,nrow(data)-n)

  #return in one list the train dataset and the test dataset
  return(list('train' = train, 'test' = test))
}

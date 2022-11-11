#' Test
#'
#' C'est une description

split_sample = function(data, train_perc = 0.7){
  
  #Contrôle de saisie
  if (train_perc < 0 | train_perc > 1){
    stop("L'Ã©chantillon de test est sous forme de pourcentage, veuillez entrer un nombre entre 0 et 1")
  }
  
  #Mélange du jeu de données
  n = round(nrow(data)*train_perc)
  shuffled_data = data[sample(1:nrow(data)),]
  
  #Création de 2 sous-dataframe de test et d'apprentissage
  X = head(shuffled_data,n)
  Y = tail(shuffled_data,nrow(data)-n)
  
  #On retourne une liste qui contient les données d'apprentissage ainsi que les données test
  return(list('train' = X, 'test' = Y))
}
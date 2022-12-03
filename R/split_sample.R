#' split_sample
#'
#' @description
#' functions to split a dataset in 2 sub-dataframe.
#' one dataset of learning
#' one dataset for testing
#'
#'
#' @usage
#' split_sample(data=iris, train_perc=70)
#' split_sample(data=iris, train_perc=(100-30))
#'
#' @param
#' data dataframe of data you will split
#'
#' @return
#' obj plsda object
#' train_perc value between 0 and 1 to which gives the percentage of the size of the learning dataset
#'
#' @examples
#' split_sample(data=iris, train_perc=0.7)
#' split_sample(data=iris, train_perc=(1-0.3))
#'

split_sample = function(data, train_perc = 0.7){

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

  #return in one list the train dsataset and the test dataset
  return(list('train' = train, 'test' = test))
}

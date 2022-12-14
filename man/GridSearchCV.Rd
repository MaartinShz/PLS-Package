% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/GridSearchCV.R
\name{GridSearchCV}
\alias{GridSearchCV}
\title{GridSearchCV}
\usage{
GridSearchCV(ObjectPLSDA, formula, data, cv = 5, method = "rsplit")
}
\arguments{
\item{formula}{vector of the target data of the train dataset}

\item{data}{dataframe of the train dataset}

\item{cv}{Number of datasets creation for cross validation}

\item{method}{random split or taking cv pieces of the datasets}

\item{objectPLSDA}{A PLSDA class model.}
}
\value{
model : Best model from the cross-validation

\cr
fscore : F-score of the model
}
\description{
First of all, this function will make a cross validation of the dataset and will calculate the F1-score.
The best model of this will be return with his fscore.
}
\examples{
GridSearchCV(obj,Species~.,Iris)
GridSearchCV(obj,Species~.,Iris, cv= 10)
GridSearchCV(obj,Species~.,Iris, method = 'kfold')

}

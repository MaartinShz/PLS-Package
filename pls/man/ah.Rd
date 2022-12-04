\name{ah}
\alias{ah}
\docType{data}
\title{
%%   ~~ data name/kind ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of the dataset. ~~
}
\usage{data("ah")}
\format{
  The format is:
List of 2
 $ model :List of 14
  ..$ x           : num [1:105, 1:4] 0.47006 0.1524 0.00831 0.21159 0.07245 ...
  .. ..- attr(*, "scaled:center")= Named num [1:4] 5.85 3.05 3.77 1.2
  .. .. ..- attr(*, "names")= chr [1:4] "Sepal.Length" "Sepal.Width" "Petal.Length" "Petal.Width"
  .. ..- attr(*, "scaled:scale")= Named num [1:4] 0.826 0.451 1.768 0.757
  .. .. ..- attr(*, "names")= chr [1:4] "Sepal.Length" "Sepal.Width" "Petal.Length" "Petal.Width"
  .. ..- attr(*, "dimnames")=List of 2
  .. .. ..$ : chr [1:105] "108" "49" "24" "2" ...
  .. .. ..$ : chr [1:4] "Sepal.Length" "Sepal.Width" "Petal.Length" "Petal.Width"
  ..$ ytarget     : Factor w/ 3 levels "setosa","versicolor",..: 3 1 1 1 1 3 3 3 2 1 ...
  .. ..- attr(*, "names")= chr [1:105] "108" "49" "24" "2" ...
  ..$ y           : num [1:105, 1:3] 0.4285 0.0129 0.4157 0.4369 -0.341 ...
  .. ..- attr(*, "scaled:center")= Named num [1:3] 0.333 0.333 0.333
  .. .. ..- attr(*, "names")= chr [1:3] "setosa" "versicolor" "virginica"
  .. ..- attr(*, "scaled:scale")= Named num [1:3] 0.474 0.474 0.474
  .. .. ..- attr(*, "names")= chr [1:3] "setosa" "versicolor" "virginica"
  .. ..- attr(*, "dimnames")=List of 2
  .. .. ..$ : NULL
  .. .. ..$ : chr [1:3] "setosa" "versicolor" "virginica"
  ..$ data        :'data.frame':	105 obs. of  5 variables:
  .. ..$ Sepal.Length: num [1:105] 7.3 5.3 5.1 4.9 5.5 4.9 6.7 6.3 5.6 4.6 ...
  .. ..$ Sepal.Width : num [1:105] 2.9 3.7 3.3 3 4.2 2.5 3.3 3.3 3 3.6 ...
  .. ..$ Petal.Length: num [1:105] 6.3 1.5 1.7 1.4 1.4 4.5 5.7 6 4.5 1 ...
  .. ..$ Petal.Width : num [1:105] 1.8 0.2 0.5 0.2 0.2 1.7 2.1 2.5 1.5 0.2 ...
  .. ..$ Species     : Factor w/ 3 levels "setosa","versicolor",..: 3 1 1 1 1 3 3 3 2 1 ...
  ..$ y_loadings  :'data.frame':	3 obs. of  2 variables:
  .. ..$ X1: num [1:3, 1] 0.545 -0.135 -0.41
  .. .. ..- attr(*, "dimnames")=List of 2
  .. .. .. ..$ : chr [1:3] "setosa" "versicolor" "virginica"
  .. .. .. ..$ : NULL
  .. ..$ X2: num [1:3, 1] 0.173 -0.397 0.225
  .. .. ..- attr(*, "dimnames")=List of 2
  .. .. .. ..$ : chr [1:3] "setosa" "versicolor" "virginica"
  .. .. .. ..$ : NULL
  ..$ y_scores    :'data.frame':	105 obs. of  2 variables:
  .. ..$ X1: num [1:105, 1] -1.79 2.38 2.38 2.38 2.38 ...
  .. ..$ X2: num [1:105, 1] 2.508 0.991 1.105 1.056 0.92 ...
  ..$ x_weights   :'data.frame':	4 obs. of  2 variables:
  .. ..$ X1: num [1:4, 1] -0.457 0.342 -0.584 -0.577
  .. .. ..- attr(*, "dimnames")=List of 2
  .. .. .. ..$ : chr [1:4] "Sepal.Length" "Sepal.Width" "Petal.Length" "Petal.Width"
  .. .. .. ..$ : NULL
  .. ..$ X2: num [1:4, 1] 0.2917 0.9193 0.0557 0.2582
  .. .. ..- attr(*, "dimnames")=List of 2
  .. .. .. ..$ : chr [1:4] "Sepal.Length" "Sepal.Width" "Petal.Length" "Petal.Width"
  .. .. .. ..$ : NULL
  ..$ x_loadings  :'data.frame':	4 obs. of  2 variables:
  .. ..$ X1: num [1:4, 1] -0.502 0.316 -0.579 -0.563
  .. .. ..- attr(*, "dimnames")=List of 2
  .. .. .. ..$ : chr [1:4] "Sepal.Length" "Sepal.Width" "Petal.Length" "Petal.Width"
  .. .. .. ..$ : NULL
  .. ..$ X2: num [1:4, 1] 0.4317 0.9113 0.0731 0.1248
  .. .. ..- attr(*, "dimnames")=List of 2
  .. .. .. ..$ : chr [1:4] "Sepal.Length" "Sepal.Width" "Petal.Length" "Petal.Width"
  .. .. .. ..$ : NULL
  ..$ x_scores    :'data.frame':	105 obs. of  2 variables:
  .. ..$ X1: num [1:105, 1] -2.21 2.31 1.82 2.03 2.61 ...
  .. .. ..- attr(*, "dimnames")=List of 2
  .. .. .. ..$ : chr [1:105] "108" "49" "24" "2" ...
  .. .. .. ..$ : NULL
  .. ..$ X2: num [1:105, 1] 0.4166 0.796 0.0024 -0.7843 1.8926 ...
  .. .. ..- attr(*, "dimnames")=List of 2
  .. .. .. ..$ : chr [1:105] "108" "49" "24" "2" ...
  .. .. .. ..$ : NULL
  ..$ corrX       : num [1:4, 1:4] 1 -0.863 -0.44 -0.911 -0.863 ...
  .. ..- attr(*, "dimnames")=List of 2
  .. .. ..$ : chr [1:4] "Sepal.Length" "Sepal.Width" "Petal.Length" "Petal.Width"
  .. .. ..$ : chr [1:4] "Sepal.Length" "Sepal.Width" "Petal.Length" "Petal.Width"
  ..$ eigen       :List of 2
  .. ..$ values : num [1:4] 2.89 1.11 2.42e-16 -2.26e-16
  .. ..$ vectors: num [1:4, 1:4] 0.567 -0.568 -0.389 -0.453 -0.251 ...
  .. ..- attr(*, "class")= chr "eigen"
  ..$ ncomp       : num 2
  ..$ coefficients: num [1:4, 1:3] -0.066 0.3131 -0.213 -0.0894 -0.0433 ...
  .. ..- attr(*, "dimnames")=List of 2
  .. .. ..$ : chr [1:4] "Sepal.Length" "Sepal.Width" "Petal.Length" "Petal.Width"
  .. .. ..$ : chr [1:3] "setosa" "versicolor" "virginica"
  ..$ intercept   : Named num [1:3] 8.79e-17 -1.14e-17 1.54e-16
  .. ..- attr(*, "names")= chr [1:3] "setosa" "versicolor" "virginica"
  ..- attr(*, "class")= chr "PLSDA"
 $ fscore: num 0.91
}
\details{
%%  ~~ If necessary, more details than the __description__ above ~~
}
\source{
%%  ~~ reference to a publication or URL from which the data were obtained ~~
}
\references{
%%  ~~ possibly secondary sources and usages ~~
}
\examples{
data(ah)
## maybe str(ah) ; plot(ah) ...
}
\keyword{datasets}

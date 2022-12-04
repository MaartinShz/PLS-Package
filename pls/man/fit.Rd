\name{fit}
\alias{fit}
\docType{data}
\title{
%%   ~~ data name/kind ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of the dataset. ~~
}
\usage{data("fit")}
\format{
  The format is:
List of 14
 $ x           : num [1:105, 1:4] -0.82859 -0.09934 -0.00281 0.02074 -0.4862 ...
  ..- attr(*, "scaled:center")= Named num [1:4] 5.78 3.04 3.67 1.16
  .. ..- attr(*, "names")= chr [1:4] "Sepal.Length" "Sepal.Width" "Petal.Length" "Petal.Width"
  ..- attr(*, "scaled:scale")= Named num [1:4] 0.776 0.448 1.68 0.721
  .. ..- attr(*, "names")= chr [1:4] "Sepal.Length" "Sepal.Width" "Petal.Length" "Petal.Width"
  ..- attr(*, "dimnames")=List of 2
  .. ..$ : chr [1:105] "101" "57" "92" "41" ...
  .. ..$ : chr [1:4] "Sepal.Length" "Sepal.Width" "Petal.Length" "Petal.Width"
 $ ytarget     : Factor w/ 3 levels "setosa","versicolor",..: 3 2 2 1 3 1 2 2 3 2 ...
  ..- attr(*, "names")= chr [1:105] "101" "57" "92" "41" ...
 $ y           : num [1:105, 1:3] 0.206 -0.382 -0.309 0.066 0.112 ...
  ..- attr(*, "scaled:center")= Named num [1:3] 0.333 0.4 0.267
  .. ..- attr(*, "names")= chr [1:3] "setosa" "versicolor" "virginica"
  ..- attr(*, "scaled:scale")= Named num [1:3] 0.474 0.492 0.444
  .. ..- attr(*, "names")= chr [1:3] "setosa" "versicolor" "virginica"
  ..- attr(*, "dimnames")=List of 2
  .. ..$ : NULL
  .. ..$ : chr [1:3] "setosa" "versicolor" "virginica"
 $ data        :'data.frame':	105 obs. of  5 variables:
  ..$ Sepal.Length: num [1:105] 6.3 6.3 6.1 5 5.8 5.4 6.4 6.1 6.2 6.7 ...
  ..$ Sepal.Width : num [1:105] 3.3 3.3 3 3.5 2.7 3.4 3.2 2.8 2.8 3.1 ...
  ..$ Petal.Length: num [1:105] 6 4.7 4.6 1.3 5.1 1.7 4.5 4 4.8 4.4 ...
  ..$ Petal.Width : num [1:105] 2.5 1.6 1.4 0.3 1.9 0.2 1.5 1.3 1.8 1.4 ...
  ..$ Species     : Factor w/ 3 levels "setosa","versicolor",..: 3 2 2 1 3 1 2 2 3 2 ...
 $ y_loadings  :'data.frame':	3 obs. of  2 variables:
  ..$ X1: num [1:3, 1] 0.55 -0.19 -0.376
  .. ..- attr(*, "dimnames")=List of 2
  .. .. ..$ : chr [1:3] "setosa" "versicolor" "virginica"
  .. .. ..$ : NULL
  ..$ X2: num [1:3, 1] 0.165 -0.365 0.228
  .. ..- attr(*, "dimnames")=List of 2
  .. .. ..$ : chr [1:3] "setosa" "versicolor" "virginica"
  .. .. ..$ : NULL
 $ y_scores    :'data.frame':	105 obs. of  2 variables:
  ..$ X1: num [1:105, 1] -1.778 -0.817 -0.817 2.403 -1.778 ...
  ..$ X2: num [1:105, 1] 3.32 -2.99 -3.02 1.04 3.09 ...
 $ x_weights   :'data.frame':	4 obs. of  2 variables:
  ..$ X1: num [1:4, 1] -0.474 0.326 -0.585 -0.571
  .. ..- attr(*, "dimnames")=List of 2
  .. .. ..$ : chr [1:4] "Sepal.Length" "Sepal.Width" "Petal.Length" "Petal.Width"
  .. .. ..$ : NULL
  ..$ X2: num [1:4, 1] 0.258 0.92 0.018 0.293
  .. ..- attr(*, "dimnames")=List of 2
  .. .. ..$ : chr [1:4] "Sepal.Length" "Sepal.Width" "Petal.Length" "Petal.Width"
  .. .. ..$ : NULL
 $ x_loadings  :'data.frame':	4 obs. of  2 variables:
  ..$ X1: num [1:4, 1] -0.514 0.285 -0.58 -0.567
  .. ..- attr(*, "dimnames")=List of 2
  .. .. ..$ : chr [1:4] "Sepal.Length" "Sepal.Width" "Petal.Length" "Petal.Width"
  .. .. ..$ : NULL
  ..$ X2: num [1:4, 1] 0.4003 0.9314 0.0674 0.1307
  .. ..- attr(*, "dimnames")=List of 2
  .. .. ..$ : chr [1:4] "Sepal.Length" "Sepal.Width" "Petal.Length" "Petal.Width"
  .. .. ..$ : NULL
 $ x_scores    :'data.frame':	105 obs. of  2 variables:
  ..$ X1: num [1:105, 1] -2.008 -0.842 -0.745 2.312 -1.351 ...
  .. ..- attr(*, "dimnames")=List of 2
  .. .. ..$ : chr [1:105] "101" "57" "92" "41" ...
  .. .. ..$ : NULL
  ..$ X2: num [1:105, 1] 1.1832 0.8575 0.0965 0.4184 -0.4393 ...
  .. ..- attr(*, "dimnames")=List of 2
  .. .. ..$ : chr [1:105] "101" "57" "92" "41" ...
  .. .. ..$ : NULL
 $ corrX       : num [1:4, 1:4] 1 -0.531 -0.446 -0.886 -0.531 ...
  ..- attr(*, "dimnames")=List of 2
  .. ..$ : chr [1:4] "Sepal.Length" "Sepal.Width" "Petal.Length" "Petal.Width"
  .. ..$ : chr [1:4] "Sepal.Length" "Sepal.Width" "Petal.Length" "Petal.Width"
 $ eigen       :List of 2
  ..$ values : num [1:4] 2.51 1.49 0.00 -4.44e-16
  ..$ vectors: num [1:4, 1:4] 0.55 -0.554 -0.523 -0.343 -0.403 ...
  ..- attr(*, "class")= chr "eigen"
 $ ncomp       : num 2
 $ coefficients: num [1:4, 1:3] -0.06915 0.2946 -0.23831 -0.08422 0.00351 ...
  ..- attr(*, "dimnames")=List of 2
  .. ..$ : chr [1:4] "Sepal.Length" "Sepal.Width" "Petal.Length" "Petal.Width"
  .. ..$ : chr [1:3] "setosa" "versicolor" "virginica"
 $ intercept   : Named num [1:3] 1.53e-16 -2.04e-16 1.80e-16
  ..- attr(*, "names")= chr [1:3] "setosa" "versicolor" "virginica"
 - attr(*, "class")= chr "PLSDA"
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
data(fit)
## maybe str(fit) ; plot(fit) ...
}
\keyword{datasets}

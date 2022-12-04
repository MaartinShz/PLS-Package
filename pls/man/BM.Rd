\name{BM}
\alias{BM}
\docType{data}
\title{
%%   ~~ data name/kind ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of the dataset. ~~
}
\usage{data("BM")}
\format{
  The format is:
List of 2
 $ model :List of 14
  ..$ x           : num [1:105, 1:4] -0.0188 0.0513 0.5475 0.0179 0.5355 ...
  .. ..- attr(*, "scaled:center")= Named num [1:4] 5.82 3.04 3.74 1.19
  .. .. ..- attr(*, "names")= chr [1:4] "Sepal.Length" "Sepal.Width" "Petal.Length" "Petal.Width"
  .. ..- attr(*, "scaled:scale")= Named num [1:4] 0.827 0.438 1.747 0.751
  .. .. ..- attr(*, "names")= chr [1:4] "Sepal.Length" "Sepal.Width" "Petal.Length" "Petal.Width"
  .. ..- attr(*, "dimnames")=List of 2
  .. .. ..$ : chr [1:105] "92" "41" "119" "147" ...
  .. .. ..$ : chr [1:4] "Sepal.Length" "Sepal.Width" "Petal.Length" "Petal.Width"
  ..$ ytarget     : Factor w/ 3 levels "setosa","versicolor",..: 2 1 3 3 2 2 1 1 2 2 ...
  .. ..- attr(*, "names")= chr [1:105] "92" "41" "119" "147" ...
  ..$ y           : num [1:105, 1:3] -0.3719 0.086 1.0895 0.3085 -0.0499 ...
  .. ..- attr(*, "scaled:center")= Named num [1:3] 0.333 0.343 0.324
  .. .. ..- attr(*, "names")= chr [1:3] "setosa" "versicolor" "virginica"
  .. ..- attr(*, "scaled:scale")= Named num [1:3] 0.474 0.477 0.47
  .. .. ..- attr(*, "names")= chr [1:3] "setosa" "versicolor" "virginica"
  .. ..- attr(*, "dimnames")=List of 2
  .. .. ..$ : NULL
  .. .. ..$ : chr [1:3] "setosa" "versicolor" "virginica"
  ..$ data        :'data.frame':	105 obs. of  5 variables:
  .. ..$ Sepal.Length: num [1:105] 6.1 5 7.7 6.3 6 6.7 5.1 4.5 6.1 5.7 ...
  .. ..$ Sepal.Width : num [1:105] 3 3.5 2.6 2.5 2.2 3.1 3.8 2.3 2.9 2.8 ...
  .. ..$ Petal.Length: num [1:105] 4.6 1.3 6.9 5 4 4.4 1.5 1.3 4.7 4.1 ...
  .. ..$ Petal.Width : num [1:105] 1.4 0.3 2.3 1.9 1 1.4 0.3 0.3 1.4 1.3 ...
  .. ..$ Species     : Factor w/ 3 levels "setosa","versicolor",..: 2 1 3 3 2 2 1 1 2 2 ...
  ..$ y_loadings  :'data.frame':	3 obs. of  2 variables:
  .. ..$ X1: num [1:3, 1] 0.541 -0.131 -0.412
  .. .. ..- attr(*, "dimnames")=List of 2
  .. .. .. ..$ : chr [1:3] "setosa" "versicolor" "virginica"
  .. .. .. ..$ : NULL
  .. ..$ X2: num [1:3, 1] 0.172 -0.431 0.263
  .. .. ..- attr(*, "dimnames")=List of 2
  .. .. .. ..$ : chr [1:3] "setosa" "versicolor" "virginica"
  .. .. .. ..$ : NULL
  ..$ y_scores    :'data.frame':	105 obs. of  2 variables:
  .. ..$ X1: num [1:105, 1] -0.58 2.38 -1.83 -1.83 -0.58 ...
  .. ..$ X2: num [1:105, 1] -3.057 0.968 2.474 2.228 -3.057 ...
  ..$ x_weights   :'data.frame':	4 obs. of  2 variables:
  .. ..$ X1: num [1:4, 1] -0.487 0.307 -0.582 -0.574
  .. .. ..- attr(*, "dimnames")=List of 2
  .. .. .. ..$ : chr [1:4] "Sepal.Length" "Sepal.Width" "Petal.Length" "Petal.Width"
  .. .. .. ..$ : NULL
  .. ..$ X2: num [1:4, 1] 0.261 0.934 0.038 0.24
  .. .. ..- attr(*, "dimnames")=List of 2
  .. .. .. ..$ : chr [1:4] "Sepal.Length" "Sepal.Width" "Petal.Length" "Petal.Width"
  .. .. .. ..$ : NULL
  ..$ x_loadings  :'data.frame':	4 obs. of  2 variables:
  .. ..$ X1: num [1:4, 1] -0.522 0.286 -0.577 -0.561
  .. .. ..- attr(*, "dimnames")=List of 2
  .. .. .. ..$ : chr [1:4] "Sepal.Length" "Sepal.Width" "Petal.Length" "Petal.Width"
  .. .. .. ..$ : NULL
  .. ..$ X2: num [1:4, 1] 0.358 0.934 0.066 0.129
  .. .. ..- attr(*, "dimnames")=List of 2
  .. .. .. ..$ : chr [1:4] "Sepal.Length" "Sepal.Width" "Petal.Length" "Petal.Width"
  .. .. .. ..$ : NULL
  ..$ x_scores    :'data.frame':	105 obs. of  2 variables:
  .. ..$ X1: num [1:105, 1] -0.636 2.303 -3.313 -1.62 -0.632 ...
  .. .. ..- attr(*, "dimnames")=List of 2
  .. .. .. ..$ : chr [1:105] "92" "41" "119" "147" ...
  .. .. .. ..$ : NULL
  .. ..$ X2: num [1:105, 1] 0.06895 0.43996 -0.00969 -0.79145 -1.81044 ...
  .. .. ..- attr(*, "dimnames")=List of 2
  .. .. .. ..$ : chr [1:105] "92" "41" "119" "147" ...
  .. .. .. ..$ : NULL
  ..$ corrX       : num [1:4, 1:4] 1 -0.746 -0.372 -0.899 -0.746 ...
  .. ..- attr(*, "dimnames")=List of 2
  .. .. ..$ : chr [1:4] "Sepal.Length" "Sepal.Width" "Petal.Length" "Petal.Width"
  .. .. ..$ : chr [1:4] "Sepal.Length" "Sepal.Width" "Petal.Length" "Petal.Width"
  ..$ eigen       :List of 2
  .. ..$ values : num [1:4] 2.67 1.33 4.44e-16 1.11e-16
  .. ..$ vectors: num [1:4, 1:4] 0.571 -0.571 -0.415 -0.418 -0.309 ...
  .. ..- attr(*, "class")= chr "eigen"
  ..$ ncomp       : num 2
  ..$ coefficients: num [1:4, 1:3] -0.0738 0.2916 -0.2061 -0.091 -0.0384 ...
  .. ..- attr(*, "dimnames")=List of 2
  .. .. ..$ : chr [1:4] "Sepal.Length" "Sepal.Width" "Petal.Length" "Petal.Width"
  .. .. ..$ : chr [1:3] "setosa" "versicolor" "virginica"
  ..$ intercept   : Named num [1:3] 1.10e-16 -1.71e-16 4.10e-17
  .. ..- attr(*, "names")= chr [1:3] "setosa" "versicolor" "virginica"
  ..- attr(*, "class")= chr "PLSDA"
 $ fscore: num 0.817
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
data(BM)
## maybe str(BM) ; plot(BM) ...
}
\keyword{datasets}

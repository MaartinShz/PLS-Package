\name{newdata}
\alias{newdata}
\docType{data}
\title{
%%   ~~ data name/kind ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of the dataset. ~~
}
\usage{data("newdata")}
\format{
  The format is:
List of 2
 $ train:'data.frame':	105 obs. of  5 variables:
  ..$ Sepal.Length: num [1:105] 6.3 6.3 6.1 5 5.8 5.4 6.4 6.1 6.2 6.7 ...
  ..$ Sepal.Width : num [1:105] 3.3 3.3 3 3.5 2.7 3.4 3.2 2.8 2.8 3.1 ...
  ..$ Petal.Length: num [1:105] 6 4.7 4.6 1.3 5.1 1.7 4.5 4 4.8 4.4 ...
  ..$ Petal.Width : num [1:105] 2.5 1.6 1.4 0.3 1.9 0.2 1.5 1.3 1.8 1.4 ...
  ..$ Species     : Factor w/ 3 levels "setosa","versicolor",..: 3 2 2 1 3 1 2 2 3 2 ...
 $ test :'data.frame':	45 obs. of  5 variables:
  ..$ Sepal.Length: num [1:45] 4.4 6.1 6 7.7 6.5 6.2 6.5 6.4 6.3 6.7 ...
  ..$ Sepal.Width : num [1:45] 3 3 3 2.6 3 3.4 3 3.1 2.8 3.3 ...
  ..$ Petal.Length: num [1:45] 1.3 4.9 4.8 6.9 5.8 5.4 5.5 5.5 5.1 5.7 ...
  ..$ Petal.Width : num [1:45] 0.2 1.8 1.8 2.3 2.2 2.3 1.8 1.8 1.5 2.1 ...
  ..$ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 3 3 3 3 3 3 3 3 3 ...
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
data(newdata)
## maybe str(newdata) ; plot(newdata) ...
}
\keyword{datasets}

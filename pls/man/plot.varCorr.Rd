\name{plot.varCorr}
\alias{plot.varCorr}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
plot.varCorr(object)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{
%%     ~~Describe \code{object} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (object) 
{
    if (class(object) != "PLSDA") {
        stop("Object's class is not PLSDA")
    }
    reshapeCorr = data.frame(matrix(rep(0), nrow = length(obj$corrX), 
        ncol = 3, ))
    i = 0
    for (k in 1:ncol(obj$corrX)) {
        for (l in 1:nrow(obj$corrX)) {
            i = i + 1
            reshapeCorr[i, 3] = obj$corrX[l, k]
            reshapeCorr[i, 1] = rownames(obj$corrX)[l]
            reshapeCorr[i, 2] = colnames(obj$corrX)[k]
        }
    }
    ggplot(data = reshapeCorr, aes(x = X1, y = X2, fill = X3)) + 
        geom_tile()
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory (show via RShowDoc("KEYWORDS")):
% \keyword{ ~kwd1 }
% \keyword{ ~kwd2 }
% Use only one keyword per line.
% For non-standard keywords, use \concept instead of \keyword:
% \concept{ ~cpt1 }
% \concept{ ~cpt2 }
% Use only one concept per line.

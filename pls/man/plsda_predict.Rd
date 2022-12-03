\name{plsda_predict}
\alias{plsda_predict}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
plsda_predict(obj, newdata, type = "posterior")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{obj}{
%%     ~~Describe \code{obj} here~~
}
  \item{newdata}{
%%     ~~Describe \code{newdata} here~~
}
  \item{type}{
%%     ~~Describe \code{type} here~~
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
function (obj, newdata, type = "posterior") 
{
    if (class(obj) != "PLSDA") {
        stop("Object's class is not PLSDA")
    }
    if (type != "posterior" & type != "class" & !class(data) == 
        "model.matrix.default") {
        stop("incorrect type")
    }
    if (!is.data.frame(newdata)) {
        stop("data must be a dataframe")
    }
    if (ncol(newdata) != ncol(obj$x)) {
        stop("data test don't match with data train")
    }
    x = scale(newdata)
    y_pred = x \%*\% as.matrix(obj$coefficients)
    temp = apply(y_pred, 1, exp)
    Ysoftmax = t(temp/colSums(temp))
    if (type == "posterior") {
        return(Ysoftmax)
    }
    else {
        pred = apply(Ysoftmax, 1, which.max)
        return(colnames(obj$y)[pred])
    }
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

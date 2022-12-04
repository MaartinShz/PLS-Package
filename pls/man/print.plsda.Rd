\name{print.plsda}
\alias{print.plsda}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
print.plsda(object)
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
    if (is.null(object$intercept)) {
        cat("type : ", class(object), "\n")
    }
    else {
        print("x : ", object$x, "\n")
        print("y : ", object$y, "\n")
        print("data : ", object$data, "\n")
        print("ncomp : ", object$ncomp, "\n")
        print("y_loading : ", object$y_loading, "\n")
        print("y-scores : ", object$y_scores, "\n")
        print("x_weights : ", object$x_weights, "\n")
        print("x_loadings : ", object$x_loadings, "\n")
        print("x_scores : ", object$x_scores, "\n")
        print("eigen : ", object$eigen, "\n")
        print("coefficients : ", object$coefficients, "\n")
        print("intercept : ", object$intercept, "\n")
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

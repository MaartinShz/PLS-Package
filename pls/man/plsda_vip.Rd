\name{plsda_vip}
\alias{plsda_vip}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
plsda_vip(Object, formula, threshold = 0.8)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{Object}{
%%     ~~Describe \code{Object} here~~
}
  \item{formula}{
%%     ~~Describe \code{formula} here~~
}
  \item{threshold}{
%%     ~~Describe \code{threshold} here~~
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
function (Object, formula, threshold = 0.8) 
{
    xs = Object$x_scores
    xw = Object$x_weights
    X = Object$x
    y = Object$y
    ircoeff = Object$y_loadings
    ncomp = Object$ncomp
    r = nrow(xw)
    ssy = diag(t(xs) \%*\% as.matrix(xs) \%*\% t(ircoeff) \%*\% as.matrix(ircoeff))
    ssy_tot_exp = sum(ssy)
    weight = (xw/sqrt(colSums(xw^2)))^2
    vip = sqrt(r * (ssy * weight)/ssy_tot_exp)
    variable_important = rownames(vip)[which(vip[, ncomp] > threshold)]
    if (length(variable_important) < 2) {
        vip_sorted = vip[order(-vip[, ncomp]), ]
        variable_important = rownames(vip_sorted)[1:2]
    }
    newX = colnames(X[, variable_important])
    newdataset = data.frame(X[, variable_important], y)
    return(list(newX = newX, vip = vip, newdataset = newdataset))
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

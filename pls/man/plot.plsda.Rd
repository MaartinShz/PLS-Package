\name{plot.plsda}
\alias{plot.plsda}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
plot.plsda(x, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
%%     ~~Describe \code{x} here~~
}
  \item{\dots}{
%%     ~~Describe \code{\dots} here~~
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
function (x, ...) 
{
    quality <- x$Quality
    barplot(quality, beside = TRUE, main = "Model quality by Component", 
        xlab = "Component", ylab = "Quality", col = c("red", 
            "blue"), space = c(0.05, 0.2), legend = rownames(quality))
    VIP <- x$VIP
    for (h in 1:ncol(VIP)) {
        barplot(VIP[, h], names.arg = rownames(VIP), main = c(paste("Variable Importance Plot for component", 
            h), "Confidence interval at 0.95\%"), xlab = "Variables", 
            ylab = "VIP", col = "blue")
        abline(a = 0, b = 0, h = 0.8, v = 0, lty = 5)
        abline(a = 0, b = 0, h = 1, v = 0, lty = 5)
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

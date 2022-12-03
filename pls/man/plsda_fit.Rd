\name{plsda_fit}
\alias{plsda_fit}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
plsda_fit(object, formula, data, ncomp = NULL, var.select = F, centre = T)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{
%%     ~~Describe \code{object} here~~
}
  \item{formula}{
%%     ~~Describe \code{formula} here~~
}
  \item{data}{
%%     ~~Describe \code{data} here~~
}
  \item{ncomp}{
%%     ~~Describe \code{ncomp} here~~
}
  \item{var.select}{
%%     ~~Describe \code{var.select} here~~
}
  \item{centre}{
%%     ~~Describe \code{centre} here~~
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
function (object, formula, data, ncomp = NULL, var.select = F, 
    centre = T) 
{
    if (class(object) != "PLSDA") {
        stop("Object's class is not PLSDA")
    }
    if (!is.data.frame(data) & !is.matrix(data) & !class(data) == 
        "model.matrix.default") {
        stop("data must be a dataframe")
    }
    if (is.null(ncomp) || !is.numeric(ncomp) || ncomp > min(nrow(data), 
        ncol(data))) {
        ncomp = min(nrow(data), ncol(data))
    }
    X = model.matrix(formula, data = data)[, -1]
    Y = model.response(model.frame(formula, data = data))
    y = get_dummies(Y)
    if (centre) {
        x = scale(X)
        y = scale(y)
    }
    print(class(x))
    print(ncol(x))
    print(ncomp)
    Xweights = data.frame(matrix(rep(0), nrow = ncol(x), ncol = ncomp))
    rownames(Xweights) = colnames(x)
    Xloadings = data.frame(matrix(rep(0), nrow = ncol(x), ncol = ncomp))
    rownames(Xloadings) = colnames(x)
    Xscores = data.frame(matrix(rep(0), nrow = nrow(x), ncol = ncomp))
    Yscores = data.frame(matrix(rep(0), nrow = nrow(x), ncol = ncomp))
    Yloadings = data.frame(matrix(rep(0), nrow = ncol(y), ncol = ncomp))
    rownames(Yloadings) = colnames(y)
    for (k in 1:ncomp) {
        u <- as.matrix(y[, 1])
        w = (t(x) \%*\% u)/(sum(u^2))
        w = w/sqrt(sum(w^2))
        temp = 0
        iteration = 0
        while (abs(mean(w) - mean(temp)) > 1e-10) {
            iteration = iteration + 1
            temp = w
            t = x \%*\% w/(sum(w^2))
            q = (t(y) \%*\% t)/(sum(t^2))
            u = (y \%*\% q)/(sum(q^2))
            w = (t(x) \%*\% u)/(sum(u^2))
            w = w/sqrt(sum(w^2))
            if (iteration > 500) {
                stop("PLS regression cannot converge")
            }
        }
        P = (t(x) \%*\% as.matrix(t))/(sum(t^2))
        x = x - t \%*\% t(P)
        y = y - (t \%*\% t(q))
        Xweights[, k] <- w
        Xscores[, k] <- t
        Yscores[, k] <- u
        Xloadings[, k] <- P
        Yloadings[, k] <- q
    }
    testXrot <- tryCatch({
        solve(t(Xloadings) \%*\% as.matrix(Xweights))
    }, error = function(err) {
        stop("reduce number of composant, ncomp")
    })
    x_rotation = as.matrix(Xweights) \%*\% testXrot
    coeff = x_rotation \%*\% t(Yloadings)
    ecart = sapply(data.frame(y), sd)
    coeff = coeff * ecart
    intercept = colMeans(y)
    obj = list(x = x, y = y, data = data, y_loadings = Yloadings, 
        y_scores = Yscores, x_weights = Xweights, x_loadings = Xloadings, 
        x_scores = Xscores, corrX = cor(x), eigen = eigen(cor(x)), 
        ncomp = ncomp, coefficients = coeff, intercept = intercept)
    class(obj) = "PLSDA"
    return(obj)
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

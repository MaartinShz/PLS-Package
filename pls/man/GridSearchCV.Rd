\name{GridSearchCV}
\alias{GridSearchCV}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
GridSearchCV(ObjectPLSDA, formula, data, cv = 5, method = "rsplit")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{ObjectPLSDA}{
%%     ~~Describe \code{ObjectPLSDA} here~~
}
  \item{formula}{
%%     ~~Describe \code{formula} here~~
}
  \item{data}{
%%     ~~Describe \code{data} here~~
}
  \item{cv}{
%%     ~~Describe \code{cv} here~~
}
  \item{method}{
%%     ~~Describe \code{method} here~~
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
function (ObjectPLSDA, formula, data, cv = 5, method = "rsplit") 
{
    if (class(ObjectPLSDA) != "PLSDA") {
        stop("Object's class is not PLSDA")
    }
    if (method != "rsplit" && method != "kfold") {
        stop("the method need to be a rsplit or a kfold")
    }
    n = nrow(data)
    shuffled_data = data[sample(1:n), ]
    fold = list()
    if (method == "rsplit") {
        for (i in 1:cv) {
            m = matrix(FALSE, nrow = 1, ncol = 150)
            m[, 1:(n * 0.3)] = TRUE
            ind = sample(m)
            fold[[i]] = ind
        }
    }
    if (method == "kFold") {
        Size = n/cv
        for (i in 1:cv) {
            ind = rep(T, n)
            lowb = i * Size - Size + 1
            highb = i * Size
            ind[lowb:highb] = F
            fold[[i]] = ind
        }
    }
    realfscore = c()
    realfscorevector = c()
    models = list()
    for (k in 1:cv) {
        X = model.matrix(formula, data = data)[, -1]
        Y = model.response(model.frame(formula, data = data))
        Y = as.factor(as.vector(Y))
        Ycol = setdiff(colnames(data), colnames(X))
        ind = fold[[k]]
        train = shuffled_data[!ind, ]
        test = shuffled_data[ind, ]
        Xtest = data.frame(test[, colnames(X)])
        Ytest = test[, Ycol]
        plsTrain = plsda_fit(ObjectPLSDA, formula, train)
        predTest = plsda_predict(plsTrain, Xtest, type = "class")
        cm = table(Ytest, predTest)
        totfs = c()
        for (i in 1:nrow(cm)) {
            precision = cm[i, i]/sum(cm[, i])
            recall = cm[i, i]/sum(cm[i, ])
            fscore = (2 * precision * recall)/(precision + recall)
            totfs = append(totfs, fscore)
        }
        Yweights = table(Ytest)/length(Ytest)
        realfscore = sum(totfs * Yweights)
        realfscorevector = append(realfscorevector, realfscore)
        models[[k]] = plsTrain
    }
    model = models[[which.max(realfscorevector)]]
    fscore = realfscorevector[which.max(realfscorevector)]
    return(list(model = model, fscore = fscore))
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

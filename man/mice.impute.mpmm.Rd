% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mice.impute.mpmm.R
\name{mice.impute.mpmm}
\alias{mice.impute.mpmm}
\alias{mpmm}
\title{Imputation by multivariate predictive mean matching}
\usage{
mice.impute.mpmm(data, format = "imputes", ...)
}
\arguments{
\item{data}{matrix with exactly two missing data patterns}

\item{format}{A character vector specifying the type of object that should
be returned. The default is \code{format = "imputes"}.}

\item{...}{Other named arguments.}
}
\value{
A matrix with imputed data, which has \code{ncol(y)} columns and
\code{sum(wy)} rows.
}
\description{
Imputes multivariate incomplete data among which there are specific relations,
for instance, polynomials, interactions, range restrictions and sum scores.
}
\details{
This function implements the predictive mean matching and applies canonical
regression analysis to select donors fora set of missing variables. In general,
canonical regressionanalysis looks for a linear combination of covariates that
predicts a linear combination of outcomes (a set of missing variables)
optimally in a least-square sense (Israels, 1987). The predicted
value of the linear combination of the set of missing variables
would be applied to perform predictive mean matching.
}
\note{
The function requires variables in the block have the same missingness pattern.
If there are more than one missingness pattern, the function will return
a warning.
}
\examples{
require(lattice)

# Create Data
B1 <- .5
B2 <- .5
X <- rnorm(1000)
XX <- X^2
e <- rnorm(1000, 0, 1)
Y <- B1 * X + B2 * XX + e
dat <- data.frame(x = X, xx = XX, y = Y)

# Impose 25 percent MCAR Missingness
dat[0 == rbinom(1000, 1, 1 - .25), 1:2] <- NA

# Prepare data for imputation
blk <- list(c("x", "xx"), "y")
meth <- c("mpmm", "")

# Impute data
imp <- mice(dat, blocks = blk, method = meth, print = FALSE)

# Pool results
pool(with(imp, lm(y ~ x + xx)))

# Plot results
stripplot(imp)
plot(dat$x, dat$xx, col = mdc(1), xlab = "x", ylab = "xx")
cmp <- complete(imp)
points(cmp$x[is.na(dat$x)], cmp$xx[is.na(dat$x)], col = mdc(2))
}
\seealso{
\code{\link{mice.impute.pmm}}
Van Buuren, S. (2018).
\href{https://stefvanbuuren.name/fimd/sec-knowledge.html#sec:quadratic}{\emph{Flexible Imputation of Missing Data. Second Edition.}}
Chapman & Hall/CRC. Boca Raton, FL.

Other univariate imputation functions: 
\code{\link{mice.impute.cart}()},
\code{\link{mice.impute.lasso.logreg}()},
\code{\link{mice.impute.lasso.norm}()},
\code{\link{mice.impute.lasso.select.logreg}()},
\code{\link{mice.impute.lasso.select.norm}()},
\code{\link{mice.impute.lda}()},
\code{\link{mice.impute.logreg.boot}()},
\code{\link{mice.impute.logreg}()},
\code{\link{mice.impute.mean}()},
\code{\link{mice.impute.midastouch}()},
\code{\link{mice.impute.mnar.logreg}()},
\code{\link{mice.impute.norm.boot}()},
\code{\link{mice.impute.norm.nob}()},
\code{\link{mice.impute.norm.predict}()},
\code{\link{mice.impute.norm}()},
\code{\link{mice.impute.pmm}()},
\code{\link{mice.impute.polr}()},
\code{\link{mice.impute.polyreg}()},
\code{\link{mice.impute.quadratic}()},
\code{\link{mice.impute.rf}()},
\code{\link{mice.impute.ri}()}
}
\author{
Mingyang Cai and Gerko Vink
}
\concept{univariate imputation functions}
\keyword{datagen}

% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/conf_mat.R
\name{summary.conf_mat}
\alias{summary.conf_mat}
\title{Summary Statistics for Confusion Matrices}
\usage{
\method{summary}{conf_mat}(object, prevalence = NULL, beta = 1,
  wide = FALSE, ...)
}
\arguments{
\item{object}{An object of class \code{\link[=conf_mat]{conf_mat()}}.}

\item{prevalence}{A number in \code{(0, 1)} for the prevalence (i.e.
prior) of the event. If left to the default, the data are used
to derive this value.}

\item{beta}{A numeric value used to weight precision and
recall for \code{\link[=f_meas]{f_meas()}}.}

\item{wide}{A single logical value: should there be one row and
columns for each statistic (\code{wide = TRUE}) or a column for the
statistic name (\code{name}) and the estimate (\code{value}).}

\item{...}{Not currently used.}
}
\value{
A tibble. Note that if the argument \code{prevalence} was
used, the value reported in the tibble reflects the argument
value and not the observed rate of events.
}
\description{
Various statistical summaries of confusion matrices are
produced and returned in a easily used format. These potentially
include those shown in the help pages for \code{\link[=sens]{sens()}}, \code{\link[=recall]{recall()}},
and \code{\link[=accuracy]{accuracy()}}.
}
\details{
There is no common convention on which factor level should
automatically be considered the "event" or "positive" results.
In \code{yardstick}, the default is to use the \emph{first} level. To
change this, a global option called \code{yardstick.event_first} is
set to \code{TRUE} when the package is loaded. This can be changed
to \code{FALSE} if the last level of the factor is considered the
level of interest.
}
\examples{
data("two_class_example")

cmat <- conf_mat(two_class_example, truth = "truth", estimate = "predicted")
summary(cmat, wide = TRUE)
summary(cmat, wide = TRUE, prevalence = 0.70)

library(dplyr)
data("hpc_cv")

# Compute statistics per resample then summarize
hpc_cv \%>\%
  group_by(Resample) \%>\%
  do(summary(conf_mat(., truth = "obs", estimate = "pred"))) \%>\%
  group_by(name) \%>\%
  summarize(mean = mean(value, na.rm = TRUE),
            sd = sd(value, na.rm = TRUE))

}

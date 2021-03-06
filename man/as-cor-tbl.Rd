% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/as-cor-tbl.R
\name{as_cor_tbl}
\alias{as_cor_tbl}
\alias{as_cor_tbl.matrix}
\alias{as_cor_tbl.data.frame}
\alias{as_cor_tbl.rcorr}
\alias{as_cor_tbl.corr.test}
\alias{as_cor_tbl.cor_tbl_fct}
\alias{as_cor_tbl.mantel_tbl}
\alias{as_cor_tbl.default}
\title{Coerce to a cor_tbl object.}
\usage{
as_cor_tbl(corr, ...)

\method{as_cor_tbl}{matrix}(corr, type = c("full", "upper", "lower"),
  show.diag = TRUE, p = NULL, low = NULL, upp = NULL,
  row.names = NULL, col.names = NULL, cluster.type = c("none", "all",
  "row", "col"), keep.name = FALSE, ...)

\method{as_cor_tbl}{data.frame}(corr, p = NULL, low = NULL,
  upp = NULL, cluster.type = c("none", "all", "row", "col"),
  keep.name = FALSE, ...)

\method{as_cor_tbl}{rcorr}(corr, fill.diag.p = 0, ...)

\method{as_cor_tbl}{corr.test}(corr, ...)

\method{as_cor_tbl}{cor_tbl_fct}(corr, ...)

\method{as_cor_tbl}{mantel_tbl}(corr, byrow = TRUE, ...)

\method{as_cor_tbl}{default}(corr, ...)
}
\arguments{
\item{corr}{Any \code{R} object.}

\item{...}{Extra params, see Details.}

\item{type}{A string, "full" (default), "upper" or "lower", display full
matrix, lower triangular or upper triangular matrix.}

\item{show.diag}{A logical value indicating whether keep the diagonal.}

\item{p}{Matrix of p value.}

\item{low}{Matrix of the lower bound of confidence interval.}

\item{upp}{Matrix of the upper bound of confidence interval.}

\item{cluster.type}{A string, the ordering type of the correlation matrix.
    \itemize{
  \item{\code{"none"} for original order (default).}
  \item{\code{"all"} for reordering rows and columns at the same time.}
  \item{\code{"row"} for reordering rows, just supports the symmetry correlation matrix.}
  \item{\code{"col"} for reordering columns, just supports the symmetry correlation matrix.}
}}

\item{keep.name}{A logical value indicating whether keep the x/y column name.}
}
\value{
A cor_tbl object.
}
\description{
Functions to coerce a object to cor_tbl if possible.
}
\details{
The method of coerce a \code{matrix} object to a cor_tbl object is the
    fundamental function. In the earth, other methods is call the \code{as_cor_tbl.matrix}
    coerce to cor_tbl except \code{as_cor_tbl.mantel_tbl}.
    For \code{as_cor_tbl.matrix}, \code{...} params pass to \code{\link[ggcor]{matrix_order}},
    and for \code{as_cor_tbl.data.frame}, \code{...} params pass to \code{as_cor_tbl.matrix}.
}
\examples{
corr <- cor(mtcars)
as_cor_tbl(corr)
}
\author{
Houyun Huang

Lei Zhou

Jian Chen

Taiyun Wei
}

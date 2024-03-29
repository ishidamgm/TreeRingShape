% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/TreeRingsInterpolation.R
\name{TreeRingsInterpolation}
\alias{TreeRingsInterpolation}
\title{Interpolates tree ring between representative (manual input) tree rings with tree ring points}
\usage{
TreeRingsInterpolation(TR)
}
\arguments{
\item{TR}{object  of classTreeRingShape (without tree ring interpolated)}
}
\value{
TR  object  of classTreeRingShape (with tree ring interpolated)
}
\description{
Interpolates tree ring between representative (manual input) tree rings with tree ring points
}
\examples{
slotNames(TR)
help("classTreeRingShape-class",package="TreeRingShape")
TR. <- TreeRingsInterpolation(TR)

}

# plot.R ####


#' Plot a graphics of tree rings
#'
#' @param L  a list of tree rings polygon coordinates (X,Y)
#' @param rn vector of ring number of list (L), default 1:length(L)
#' @param col color of plot
#' @param ... other parameters to be passed through to plotting functions
#' @export
#' @return No return value, only draw tree ring plot.
#'
#' @examples
#'
#' Lplot(TR@L,main=TR@L_filename)
#' Lplot(TR@L,rn=1:20,col='blue',main=TR@L_filename)
Lplot <- function(L, rn = 1:length(L), col = "red", ...) {
  plot(L[[1]], type = "l", ...)
  for (i in rn) lines(L[[i]], col = col)
}

#' Draw a graphics of tree rings by 1 ring (3*3 in a screen)
#'
#' @param L  a list of tree rings polygon coordinates (X,Y)
#' @param i.ring integer vector, tree ring number for drawing
#' @param nrow  par(mfrow=c(nrow,ncol))
#' @param ncol  par(mfrow=c(nrow,ncol))
#' @param ask  logical; if TRUE, the user is asked before each plot
#' @param ... other parameters to be passed through to plotting functions.
#'
#' @export
#' @return No return value, only draw tree ring plot.
#' @examples
#' Lplot2(TR@L,i.ring=1:9, nrow=1,ncol=1,type='b')
#' Lplot2(TR@L,type='b')
Lplot2 <- function(L, i.ring = 1:length(L), nrow = 3, ncol = 3, ask = "FALSE", ...) {
  oldpar <- par(no.readonly = TRUE)
  on.exit(par(oldpar))
  par(mfrow = c(nrow, ncol))
  for (i in i.ring) plot(L[[i]], main = paste(i, ":", names(L)[i], "yr"), ...)
}

#' Check center angle of points to input order
#'
#' @param L list of tree rings
#' @param i.ring integer vector, tree ring number for drawing
#' @param nrow  par(mfrow=c(nrow,ncol))
#' @param ncol  par(mfrow=c(nrow,ncol))
#'
#' @export
#' @return No return value, only draw tree ring plot.
#' @examples
#' slotNames(TR)
#' Lplot(TR@L)
#' str(TR@L)
#' Lrad.plot(TR@L,11:19)
#'
Lrad.plot <- function(L, i.ring = 1:4,nrow=2,ncol=2) {
  oldpar <- par(no.readonly = TRUE);   on.exit(par(oldpar))
  par(mfrow = c(nrow, ncol))
  for (i in i.ring) {
    x <- L[[i]][, 1]
    y <- L[[i]][, 2]
    rad <- atan2(y, x)
    plot(rad, main = paste(i, ":", names(L)[i], "year"), ylim = c(-pi - 0.1, pi + 0.1))
    abline(h = c(-pi, 0, pi), col = "red")
  }
}

#' Draw a plot of tree rings
#' This function draws Tree rings of a disk from x, y list(x,y) with name of year.
#' @param L   list(x,y) of Tree ring coordinates with name of year
#' @param year name of  column of Tree ring year (0(cambium),1,2,....,n(pith))
#' @param ... other parameters to be passed through to plotting functions
#'
#' @export
#' @return No return value, only draw tree ring plot.
#' @examples
#' names(TR@L)
#' plot_TreeRing(TR@L)
#' plot_TreeRing(TR@L,year=10,type='l',col='blue')
#
plot_TreeRing <- function(L , year = 0, ...) {   #= TR@L
  xy <- L[[which(names(L) == year)]]
  plot(xy, main = year, ...)
}



#' Plot tree rings from data fame
#' This function draws Tree rings of a disk from data frame(x,y,year).
#' @param df  name of a data frame
#' @param year_label name of  column of Tree ring year (0(cambium),1,2,....,n(pith))
#'
#' @export
#' @return No return value, only draw tree ring plot.
#' @seealso \code{\link{Llist2dataframe}}  for the data frame
#'
#' @examples
#'
#' TR@L_ <- Llist2dataframe(TR@L)     # data frame of tree rings
#' names(TR@L_)
#' plot_TreeRings_df(TR@L_)
#'
plot_TreeRings_df <- function(df , year_label = "yr") {
  plot(df[df[, year_label] == 0, c("x", "y")], type = "l")
  for (i in unique(df[, year_label])) lines(df[df[, year_label] == i, c("x", "y")])
}

#' plot_TreeRing_df
#' Draw a Tree ring of a disk from data frame(x,y,year)
#' @param df    name of a data frame
#' @param year  integer vector of years to draw tree rings
#' @param year_label name of  column of Tree ring year (0(cambium),1,2,....,n(pith))
#'
#' @export
#' @return No return value, only draw tree ring plot.
#' @examples
#' TR@L_ <- Llist2dataframe(TR@L)     # data frame of tree rings
#' plot_TreeRing_df(TR@L_, year =1)
#'
plot_TreeRing_df <- function(df , year = 0, year_label = "yr") {
  plot(df[df[, year_label] == year, c("x", "y")], type = "l")
}

#' Plot and return data frame of  year_disk area and year_Tree ring area
#'
#' @param L2  list of tree rings
#' @param yr_end outermost year of tree ring
#'
#' @return list of Year_DiskArea and Year_TreeRingArea
#' @export
#'
#'@seealso \code{\link{TreeRingsInterpolation}}
#'


plot_year_RingArea <- function(L2, yr_end = 2018) {
  a <- rev(sapply(L2, area))
  yr_a <- (yr_end - length(a) + 1):yr_end
  Year_DiskArea <- data.frame(Year = yr_a, Disk_Area = a)
  plot(Year_DiskArea)

  # windows()
  Year_TreeRingArea <- data.frame(Year = yr_a[-1], Tree_Ring_Area = diff(a))
  plot(Year_TreeRingArea, type = "b")

  abline(v = seq(round(min(yr_a)/10) * 10, max(yr_a), 10), col = "gray")

  return(list(Year_DiskArea = Year_DiskArea, Year_TreeRingArea = Year_TreeRingArea))

}


#' Calculate tree ring index from chronosequence data (year,growth)
#'
#' @param ya   data frame of chronosequence data (year,growth)
#'
#' @param spar  smoothing parameter of spline curve
#'
#' @return list spline ; fitting parameter of Spline curve  ,
#' idx ; data.frame(year,TreeRingIndex)
#'
#' @references Cook, E., & Peters, K. (1981). The smoothing spline,
#' a new approach to standardising forest interior tree-ring.Trre-ring Bulletin,
#' 41, 45–53.
#'
#' @export
#'
#'@seealso \code{\link{TreeRingsInterpolation}}
#'


TreeRingIndex <- function(ya, spar = 0.8) {
  sm <- stats::smooth.spline(ya, spar = spar)
  idx <- ya[, 2]/predict(sm, ya[, 1])$y
  return(list(spline = sm, idx = data.frame(year = ya[, 1], TreeRingIndex = idx)))
}

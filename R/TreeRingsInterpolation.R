# TreeRingsInterpolation.R ####

#' Read TreeRingsPoints shape file, check and save parameters
#'
#' @param TR is tree ring  class (classTreeRingShape )
#'
#' #@return list of  (P,P00,YR_P,n_id,YR_P,n_YR)
#' @export
#'
#' @examples
#' \dontrun{
#' P_filename<-'points277_h600'\t\t#####shape file name (without extention 'abc.shp' -> 'abc')
#' TreeRingsPoints(TR)
#' #' }


TreeRingsPoints <- function(TR) {
  d <- ReadShapefile_TreeRingPoints(TR@P_filename, id.tag = TR@P_id.tag, ring.tag = TR@P_ring.tag)
  id <- d$id
  yr <- d$yr
  # original point of a tree dist, ordinarily a pith,otherwise center of radial measurement points
  i <- which(d$id == 0)
  (P00 <- c(d$x[i], d$y[i]))  ###  original point : P00
  d$x <- d$x - P00[1]
  d$y <- d$y - P00[2]  ###  original point  -> 0,0  from  P00

  i <- order(d$id, d$yr)  #  sorting data
  (d <- d[i, ])  # reason : the shape file data saved without sorting in Qgis
  r <- sqrt((d$x^2 + d$y^2))  #  distance from a pith (center of tree rings)
  l <- sqrt(diff(d$x)^2 + diff(d$y)^2)  # distance between points
  rad <- atan2(d$y, d$x)
  deg <- rad/degree
  P <- data.frame(d, rad, deg, r)  # data frame of radial measurement points
  # \tdelete center point (id=0)
  P <- subset(P, id != 0)
  P <- na.omit(P)
  head(P)
  YR_P <- unique(P$yr)  ##### P$yr
  n_YR <- length(YR_P)  ##### total number of tree rings (including outermost cambium layer)
  n_id <- length(unique(P$id))  ##### number of radial measurement points

  tail(d)  #  check data #
  str(d)
  table(yr)
  plot(d$yr)
  plot(d$id)
  plot(sort(d$yr))
  plot(r)
  plot(deg, r, xlab = "center angle", ylab = "distance from center point")
  plot(d$id[-1], l, xlab = "id", ylab = "distances among points")

  TR@P <- P
  TR@P00 <- P00
  TR@n_id <- n_id
  TR@YR_P <- YR_P
  TR@n_YR <- n_YR

  return(TR)

  # save(P,P00,YR_P,n_id,YR_P,n_YR,file=paste0(P_filename,'.RData'))
  # return(list(P=P,P00=P00,YR_P=YR_P,n_id=n_id,YR_P=YR_P,n_YR=n_YR))

}


#' Read representative tree ring lines from shape files
#'
#' @param  TR is tree ring  class (classTreeRingShape )
#'
#' @return TR (TreeRing class TR@L<-L ; TR@L_<-L_ ; TR@YR_L <-YR_L ; TR@ln <- ln)
#' @export
#'
#' @examples
#'  \dontrun{
#'  setwd('../Abies_277_h400')
#'  TreeRingsLines(TR)
#'  }
#'
TreeRingsLines <- function(TR) {
  L <- TR@L
  P00 <- TR@P00
  P <- TR@P
  L_ring_colname <- TR@L_ring.tag
  d <- shapefiles::read.shapefile(TR@L_filename)  ### read tree ring line from shape file
  #d <- sf::st_read(TR@L_filename)  ### read tree ring line from shape file
  ring <- as.numeric(as.vector(d$dbf$dbf[, L_ring_colname]))


  # sorting tree ring lines with `ring` (year from outermost) 'jjj' is the order #
  jjj <- order(ring)
  (ln <- length(d$shp$shp))
  L <- c()
  for (i in 1:ln) L <- c(L, list(as.matrix(d$shp$shp[[jjj[i]]]$points)))  # Lの追加

  (YR_L <- c(as.numeric(as.vector(d$dbf$dbf[, L_ring_colname])))[jjj])

  names(L) <- YR_L  # add names of tree ring line #

  # conversion of coordinate center point to (0,0)
  for (i in 1:ln) L[[i]] <- t(t(L[[i]]) - P00)

  # plot representative tree rings and measurement points
  plot(L[[1]], type = "l", col = "red")
  lapply(L, lines)
  points(P$x, P$y, pch = ".", col = "red")
  abline(h = 0, v = 0, col = "blue")

  # Llist2dataframe #
  L_ <- Llist2dataframe(L)

  # relationships between center angle and distance from center point
  x <- L[[1]][, 1]
  y <- L[[1]][, 2]
  plot(atan2(y, x)/degree, sqrt(x^2 + y^2), type = "n", ylim = c(0, max(P$r, na.rm = TRUE)), xlab = "Center angle (degree)", ylab = "distance from the center point")
  for (ii in 1:length(L)) {
    x <- L[[ii]][, 1]
    y <- L[[ii]][, 2]
    points(atan2(y, x)/degree, sqrt(x^2 + y^2), pch = ".")
  }


  # measurement points
  points(P$deg, P$r, col = "red", pch = ".")

  # save(L,L_,file=paste0(L_filename,'.RData'))
  TR@L <- L
  TR@L_ <- L_
  TR@YR_L <- YR_L
  TR@ln <- ln
  return(TR)

}


#' Interpolates tree ring between representative (manual input) tree rings with tree ring points
#'
#' @param TR   object  of classTreeRingShape (without tree ring interpolated)
#'
#' @return TR  object  of classTreeRingShape (with tree ring interpolated)
#' @export
#'
#' @examples
#' slotNames(TR)
#' help("classTreeRingShape-class",package="TreeRingShape")
#' TR. <- TreeRingsInterpolation(TR)
#'
TreeRingsInterpolation <- function(TR) {

  TR@P -> P
  TR@P00 -> P00
  TR@n_id -> n_id
  TR@YR_P -> YR_P
  TR@n_YR -> n_YR
  TR@L -> L
  TR@L_ -> L_
  TR@YR_L -> YR_L
  TR@ln -> ln

  ## YRn<-10:11 #### number of representative tree ring lines <<<<< for check fitting of Spline curve, needs more than 2
  ## lines
  YRn <- 1:length(YR_L)  ## for all data execution

  # check of reference number of radial measurement points (year+1，because outermost(ordinarily cambium layer) tree ring
  # lines start from 0)

  i12 <- match(YR_L[YRn], YR_P)

  # new tree rings interpalated
  YR2 <- YR_L[YRn[1]]:YR_L[rev(YRn)[1]]


  # >>> start of calculation for tree ring interpolation ####

  L2 <- c()  # list of tree rings to be interpolated

  for (iii in 2:length(YRn)) {
    ## If you want to check individual tree ring lines, input such as iii<-3
    yr12 <- YR_L[iii - 1]:YR_L[iii]  ## range of calculation
    i12_ <- i12[iii - 1]:i12[iii]  ##  reference number, caution!!  the numbers are year +1
    if (length(i12_) == 2) {
      ## this loop don't work to consecutive tree rings
      L2 <- c(L2, list(L[[iii - 1]]))
      next
    }

    yr_pn <- c()
    for (i in 1:length(i12_)) {
      yr_pn <- c(yr_pn, list(which(P$yr == yr12[i])))
    }
    names(yr_pn) <- yr12

    ## plot of tree rings and nearest input points
    L_out <- L[[YRn[iii - 1]]]
    L_in <- L[[YRn[iii]]]
    np <- nstP(L_out, L_in)
    plot(L[[1]], type = "l", col = "red")
    lapply(L, lines)
    segments(L_out[, 1], L_out[, 2], L_in[np, 1], L_in[np, 2], col = "blue")


    ## plot
    rdst. <- c()
    for (i in 2:(length(yr12) - 1)) {
      rdst. <- c(rdst., list(rdst_MerginePlus(L, P, yr12[i])))
    }


    plot(0, type = "n", ylim = c(0, 1), xlim = c(-180, 180), main = paste(yr12[1], rev(yr12)[1], sep = "-"), xlab = "-180 to 180 degree",
         ylab = "ratio of distance between tree rings")

    for (i in 1:length(rdst.)) points(rdst.[[i]], col = i)

    spl <- c()  #### fit Spline curve
    for (ii in 1:length(rdst.)) {
      (spline <- smooth.spline(rdst.[[ii]], spar = 2e-04))
      xxx <- seq(-200, 200, 1)
      lines(predict(spline, xxx), col = "red")
      spl <- c(spl, list(spline))  #  store spline curve function in 'spl'
    }
    names(spl) <- yr12[2:(length(yr12) - 1)]


    ## interpolation of tree rings ####
    L2 <- c(L2, list(L_out))
    for (jj in 1:length(spl)) {
      spline <- spl[[jj]]
      # plot(predict(spline,-180:180))
      dL <- L_out - L_in[np, ]  # difference of L_out and L_in
      L.ave <- (L_out + L_in[np, ])/2  # average of 2 coordinates
      deg_spl <- atan2(L.ave[, 2], L.ave[, 1])/degree  # center angle
      ratio_ <- predict(spline, deg_spl)$y
      L_cal <- L_in[np, ] + dL * ratio_
      lines(L_cal, col = "red")
      L2 <- c(L2, list(L_cal))
    }

  }
  L2 <- c(L2, list(L[[length(YRn)]]))  #\tAdd innermost annual ring last
  # <<< end of calculation for tree ring interpolation ####

  names(L2) <- YR2  ##\tname each annual ring

  plot(L[[1]], type = "l", col = "red")
  lapply(L2, lines, col = "blue")
  points(P$x, P$y, pch = ".", col = "red")

  TR@L2 <- L2

  return(TR)





}

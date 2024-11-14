# TreeRingsInterpolation.R ####

#' Read TreeRingsPoints shape file, check and save parameters
#'
#' @param TR a tree ring  class (classTreeRingShape )
#'
#' @return a list of  (P,P00,YR_P,n_id,YR_P,n_YR)
#' @export
#'
#' @examples
#'  #  didectory of tree ring shapefiles
#'  .dir <- system.file("shp",package = "TreeRingShape")
#'
#' # path of  P_filename
#' .file <- "Abies_277_h400_TreeRing_Points.shp"
#'  TR_@P_filename <- paste(.dir,.file,sep="/")
#'
#'   TreeRingsPoints(TR_)@P
#'



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

}


#' Read representative tree ring lines from shape files
#'
#' @param  TR a tree ring  class (classTreeRingShape )
#'
#' @return TR (TreeRing class TR@L<-L ; TR@L_<-L_ ; TR@YR_L <-YR_L ; TR@ln <- ln)
#' @export
#'
#' @examples
#'  #  didectory of tree ring shapefiles
#'  .dir <- system.file("shp",package = "TreeRingShape")
#'
#' # path of  P_filename
#' .file <- "Abies_277_h400_TreeRing_Points.shp"
#'  TR_@P_filename <- paste(.dir,.file,sep="/")
#'
#'   TreeRingsPoints(TR_)@P
#'
#' # path of L_file name
#' .file <- "Abies_277_h400_TreeRing_Representative.shp"
#' L_filename <- paste(.dir,.file,sep="/")
#'  TreeRingsPoints(TR_)@L
#'  Lplot(TR@L)
#'
TreeRingsLines <- function(TR) {
  P <- TR@P
  L <- ReadShapefile_TreeRings(TR@L_filename,ring.tag = "ring")
  ln <- length(L)
  YR_L <- as.numeric(names(L))
  # conversion of coordinate center point to (0,0)
  for (i in 1:ln) L[[i]] <- t(t(L[[i]]) - TR@P00)

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
#' # tree ring interpolation (add TR@L2 to classTreeRingShape )
#' TR@L2   ### empty
#' TR <- TreeRingsInterpolation(TR)
#' TR@L2  ###  entered
#' ya <- plot_year_RingArea(TR@L2, 2018)$Year_TreeRingArea
#' # Figure of relationships year and tree ring area
#' plot(ya,type='b')
#' tri. <- TreeRingIndex(ya)
#' lines(tri.$spline,col='red',lw=2)
#' # Figure of relationships year and tree ring index
#' plot(tri.$idx,type='b')
#' abline(h=1,col='red')
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

  # new tree rings interpolated
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


#' Construct a object (TR) of classTreeRingShape
#'
#'
#'
#' @param P_filename   file name of shape file (P) for tree ring points  (without extention)
#' @param L_filename   file name of shape file (L) for tree ring lines  (without extention)
#' @param L2_filename  file name of shape file (L2) for tree ring lines interpolated (without extention)
#' @param P_id.tag     column name of id in shape file (P), default is 'id'
#' @param P_ring.tag   column name of ring no.(ordinaly year,outermost=0) in shape file (L), default is 'ring'
#' @param L_ring.tag   column name of ring no.(ordinaly year,outermost=0) in shape file (L), default is 'ring'
#' @return generated new object from classTreeRingShape
#' @export
#'
#'
#' @examples
#'
#'
#' test_TreeRingShape <- function(){
#' oldwd <- getwd()
#' on.exit(setwd(oldwd))
#' setwd(system.file("shp",package = "TreeRingShape"))
#'
#' TR.<-TreeRingShape(
#' P_filename='Abies_277_h400_TreeRing_Points.shp',
#' L_filename='Abies_277_h400_TreeRing_Representative.shp',
#' L2_filename='Abies_277_h400_TreeRing.shp',
#' P_id.tag='id',P_ring.tag='ring',
#' L_ring.tag='ring')
#'
#'  slotNames(TR.)
#'  str(TR.)
#'  Lplot(TR.@L2)
#'  return(TR.)
#' }
#'
#'  TR. <- test_TreeRingShape()
#'  DiskInfo(TR.)
#'

TreeRingShape <- function(P_filename, L_filename, L2_filename, P_id.tag = "id", P_ring.tag = "ring", L_ring.tag = "ring") {

  # generate new TR object from classTreeRingShape

  TR <- new("classTreeRingShape")  # treering_cls #str(TR)

  # tree ring points
  TR@P_filename <- P_filename  #'points277_h400'
  TR@P_id.tag <- "id"
  TR@P_ring.tag <- "ring"
  TR <- TreeRingsPoints(TR)

  # representative tree ring lines
  TR@L_filename <- L_filename  # 'line277_h400'
  TR@L_ring.tag <- L_ring.tag
  TR <- TreeRingsLines(TR)

  # representative + interpolated tree ring lines
  TR@L2_filename <- L2_filename  #
  TR <- TreeRingsInterpolation(TR)

  return(TR)

}

#'  Return information for tree disk analysed from  TreeRingShape class
#'
#' @param TR. class of TreeRingShape
#' @param dpi Resolution of tree disk image
#'
#' @return data frame of information for tree disk analysed
#' @export
#'
#'@seealso \code{\link{TreeRingShape}}
#'
DiskInfo <- function(TR.,dpi=1200){
  #dpi <- 1200      # resolution of tree disk image
  mm <-25.4/dpi
  Width_mm <- round((max(TR.@L_$x)-min(TR.@L_$x))*mm)   # diameter of tree disk (x)
  Height_mm <- round((max(TR.@L_$y)-min(TR.@L_$y))*mm )  # diameter of tree disk (y)
  Circumference_mm <- round( circumference(TR.@L[[1]]*mm))
  L2_n <- TR.@n_YR   # 186
  L2_points_n <- sum(sapply(TR.@L2,nrow)) # 17810 : Total number of tree ring lines inputed
  L2_total_length_mm <- round(sum(sapply(TR.@L2,circumference))*mm)
  L_n  <- TR.@ln     #  38
  L_points_n <- nrow(TR.@L_) # 17810 : Total number of tree ring lines inputed
  L_total_length_mm <- round(sum(sapply(TR.@L,circumference))*mm)
  Mean_distance_between_L_points_um <- round(L_total_length_mm/L_points_n*1000)
  P_points_total_n <- nrow(TR.@P)  # 3773
  P_points_radial_n <- 8*L2_n  # 3773
  P_points_partial_n <- P_points_total_n-P_points_radial_n   # 3773
  Total_points_input_manually <- L_points_n + P_points_total_n
  L_L2_length_pct <-round(100*L_total_length_mm / L2_total_length_mm )
  L_L2_points_pct <-round(100*L_points_n / L2_points_n )

  df<-data.frame(Width_mm,
                 Height_mm,
                 Circumference_mm,
                 L2_n,
                 L2_points_n,
                 L2_total_length_mm,
                 L_n,
                 L_points_n,
                 L_total_length_mm,
                 Mean_distance_between_L_points_um,
                 P_points_total_n,
                 P_points_radial_n,
                 P_points_partial_n,
                 Total_points_input_manually,
                 L_L2_length_pct,
                 L_L2_points_pct)

  df <- t(data.frame(df))
  colnames(df)[1]<-TR.@L2_filename
  return(df)

}

# ShapeFile.R ####

#'  Write a shapefile of interpolated tree rings
#'
#' @param L2 is as list of Tree ring polygons (X, Y)
#' @param filename is a shape file(path) name written to disk.
#'
#' @return data of Shapefile
#' @export
#'
#' @examples
#'
#' \dontrun{#'
#' WriteShapefile_TreeRings (TR@L2, tempfile("TreeRingShape_test",fileext = ".shp"))
#' dir(tempdir())
#' }

WriteShapefile_TreeRings <- function(L2 , filename = "test.shp") {
  id. <- c()
  shp. <- c()
  yn. <- length(L2)
  yr. <- names(L2)
  for (ii in 1:yn.) {
    id. <- c(id., rep((ii - 1), nrow(L2[[ii]])))
  }
  L2.Table <- data.frame(Id = 0:(yn. - 1), ring = yr.)
  # sf:: ######
  L2.sf<-sf::st_sfc(sapply(L2,sf::st_linestring))
  L2.sf<-sf::st_sf(L2.sf,L2.Table)
  sf::st_write(L2.sf,filename)
  #return(L2.sf)
}


#'  Read a shape file of Tree Ring Points ( P : radial input and correction points)
#'
#' @param filename is a file name of Tree ring points (shape file )
#' The extension (.shp) is unnecessary.
#'
#' @param   id.tag  string, column name of id (attribute table)
#' @param ring.tag  string, column name of ring years  (0 is cambium layer)
#'
#' @return a data frame of TreeRingPoints (radial input and correction points)
#' @export
#'
#' @examples
#'\dontrun{
#'
#' # sample data of 'Abies_277_h400' can be download from
#' #https://www.sanchikanri.com/treering/Abies_277_h400.zip
#'
#' file.path <- '../Abies_277_h400/Abies_277_h400_TreeRing_Points.shp'
#' ReadShapefile_TreeRingPoints(file.path,id.tag='id',ring.tag='ring')
#'
#' }

#'
ReadShapefile_TreeRingPoints <- function(filename = "Abies_277_h400_TreeRing_Points.shp", id.tag = "id", ring.tag = "ring") {
  d <- sf::read_sf(filename)
  xy <- sf::st_coordinates(d)
  if (ncol(xy) == 3) {
    i <- (unique(xy[, 3]))
  } else {
    i <- 1:nrow(xy)
  }
  d. <- data.frame(d)[i, c(id.tag, ring.tag)]
  d <- data.frame(x = xy[, 1], y = xy[, 2], id = d.[, 1], yr = d.[, 2])
  d <- d[order(d$id, d$yr), ]
  return(d)
}


#' Return x,y coordinates of a tree ring center point (P00) from shape file of tree ring points
#'
#' @param filename  a shape file name of Tree ring points
#'
#' @param   id.tag  string, column name of id (attribute table)
#' @param ring.tag string, column name of ring years  (0 is cambium layer)
#'
#' @return numeric : x,y coordinates of a tree ring center point (P00)
#' @export
#'
#' @examples
#' # This example NOT be run examples
#' \dontrun{
#' # read a original point P00 ####
#' filename <- '../Abies_277_h400/Abies_277_h400_TreeRing_Points.shp'
#' ReadShapefile_P00(filename)
#'}
ReadShapefile_P00 <- function(filename = "Abies_277_h400_TreeRing_Points.shp", id.tag = "id", ring.tag = "ring") {
  d <- ReadShapefile_TreeRingPoints(filename, id.tag, ring.tag)
  i <- which(d$id == 0)
  (P00 <- c(d$x[i], d$y[i]))  ### original point P00
  return(P00)
}



#' Read Shapefile_TreeRings
#'
#' @param filename is a file name(path) of shape file written to disk.
#'
#' @param ring.tag string, column name of ring years  (0 is cambium layer)
#'
#' @return a list of tree ring lines
#' @export
#'
#' @examples
#'\dontrun{
#' filename <- '../Abies_277_h400/Abies_277_h400_TreeRing_Representative.shp'
#' Lplot(ReadShapefile_TreeRings(filename))
#'}
#'
ReadShapefile_TreeRings <- function(filename = "Abies_277_h400_TreeRing_Representative.shp", ring.tag = "ring") {
  d <- sf::read_sf(filename)
  ring <- data.frame(d)[,ring.tag]

  # sorting of tree ring lines
  jjj <- order(ring)
  ln <- nrow(d)
  L <- c()
  xy <- sf::st_coordinates(d)
  for (i in 1:ln) {
    L <- c(L, list(xy[xy[,3]==jjj[i],c(1,2)]) ) #### from data frame to list
  }

  YR_L <- ring[jjj]

  names(L) <- YR_L  # add names of tree rings
  return(L)
}
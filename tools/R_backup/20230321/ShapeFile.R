# ShapeFile.R ####

#'  Write a shapefile of interpolated tree rings
#'
#' @param L2 is as list of Tree ring polygons (X, Y)
#' @param filename is a file name of shape file written to disk.
#' The extension (.shp) is unnecessary.
#'
#' @return data of Shapefile
#' @export
#'
#' @examples
#'
#' \dontrun{
#' file.path <- '../Abies_277_h400_test'
#' tempdir()
#'
#' WriteShapefile_TreeRings (TR@L, tempfile("TreeRingShape_test"))
#'
#' }

WriteShapefile_TreeRings <- function(L2 , filename = "test") {
  id. <- c()
  shp. <- c()
  yn. <- length(L2)
  yr. <- names(L2)
  for (ii in 1:yn.) {
    shp. <- rbind(shp., L2[[ii]])
    id. <- c(id., rep((ii - 1), nrow(L2[[ii]])))
  }
  dd <- data.frame(Id = id., X = shp.[, 1], Y = shp.[, 2])
  ddTable <- data.frame(Id = 0:(yn. - 1), ring = yr.)  ###=c('1','2','3','4','5')
  ddShapefile <- shapefiles::convert.to.shapefile(dd, ddTable, "Id", 3)
  shapefiles::write.shapefile(ddShapefile, filename, arcgis = T)
  return(ddShapefile)
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
#' file.path <- '../Abies_277_h400/Abies_277_h400_TreeRing_Points'
#' ReadShapefile_TreeRingPoints(file.path,id.tag='id',ring.tag='ring')
#'
#' }

#'
ReadShapefile_TreeRingPoints <- function(filename = "points277_h600", id.tag = "id", ring.tag = "ring") {
  d <- sf::st_read(paste0(filename, ".shp"))  # 2022/12/18  str(d)
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
#' @param filename  a file name of Tree ring points (shape file )
#' The extension (.shp) is unnecessary.
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
#' file.path <- '../Abies_277_h400/Abies_277_h400_TreeRing_Points'
#' ReadShapefile_P00(file.path)
#'}
ReadShapefile_P00 <- function(filename = "points277_h600", id.tag = "id", ring.tag = "ring") {
  d <- ReadShapefile_TreeRingPoints(filename, id.tag, ring.tag)
  i <- which(d$id == 0)
  (P00 <- c(d$x[i], d$y[i]))  ### original point P00
  return(P00)
}



#' Read Shapefile_TreeRings
#'
#' @param filename is a file name of shape file written to disk.
#' The extension (.shp) is unnecessary.
#' @param ring.tag string, column name of ring years  (0 is cambium layer)
#'
#' @return a data frame of TreeRingPoints (radial input and correction points)
#' @export
#'
#' @examples
#'\dontrun{
#' file.path <- '../Abies_277_h400/Abies_277_h400_TreeRing_Representative'
#' Lplot(ReadShapefile_TreeRings(file.path))
#'}
#'
ReadShapefile_TreeRings <- function(filename = "Abies_277_h400_TreeRing_Representative", ring.tag = "ring") {
  d <- shapefiles::read.shapefile(filename)
  ring <- as.numeric(as.vector(d$dbf$dbf[, ring.tag]))

  # sorting of tree ring lines
  jjj <- order(ring)
  (ln <- length(d$shp$shp))
  L <- c()
  for (i in 1:ln) L <- c(L, list(as.matrix(d$shp$shp[[jjj[i]]]$points)))  #### add L

  (YR_L <- c(as.numeric(as.vector(d$dbf$dbf[, ring.tag])))[jjj])

  names(L) <- YR_L  # add names of tree rings
  return(L)
}

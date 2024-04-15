# setClass.R ####

#' class of TreeRingShape
#'
#' @slot P_filename character. file name of shape file (P) for tree ring points
#' @slot P_id.tag character.   column name of id in shape file (P), default is 'id'
#' @slot P_ring.tag character. column name of ring no.(ordinaly year,outermost=0) in shape file (P), default is 'ring'
#' @slot P data.frame.         radial tree ring points (x,y,id,yr,r,deg)
#' @slot P00 numeric.          x,y coordinates c(px00,py00) of tree ring center point, ordinarily a pith in a disk, a point of id==0 in P
#' @slot n_id numeric.         number of radial measurement points, length(unique(P$id))-1  (omit a original point id=0)
#' @slot YR_P numeric.         total number of tree rings, unique(P$ring)
#' @slot L_filename character. file name of shape file (L) for tree ring lines
#' @slot L_ring.tag character. column name of ring no.(ordinaly year,outermost=0) in shape file (L), default is 'ring'
#' @slot L list.               x,y coordinates of representative tree rings
#' @slot L_ data.frame.        x,y coordinates of representative tree rings
#' @slot YR_L numeric.         cumulative tree rings number(year) from 0 (cambium layer) of L =dbf$ring, names(L)
#' @slot ln numeric.           total number of  representative tree rings,  length(L)
#' @slot L2_filename           character. file name of shape file (L2) for tree ring lines interpolated
#' @slot L2 list.              x,y coordinates of representative + interpolated tree rings
#' @slot n_YR numeric.        total number of representative + interpolated tree rings  = unique(P$yr), length(L2)
#'
#' @export
#'
#' @examples
#'  TR. <- new('classTreeRingShape')
#'  TR.
#'  slotNames(TR.)
#'  str(TR.)
methods::setClass("classTreeRingShape",
         slots = c(P_filename = "character",
                   P_id.tag = "character",
                   P_ring.tag = "character",
                   P = "data.frame",

                   P00 = "numeric",
                   n_id = "numeric",
                   YR_P = "numeric",
                   L_filename = "character",
                   L_ring.tag = "character",
                   L = "list",
                   L_ = "data.frame",

                   YR_L = "numeric",
                   ln = "numeric",
                   L2_filename = "character",
                   L2 = "list",
                   n_YR = "numeric")
         )

# TR ####
#' A sample object of class TreeRingShape
#'
#' The data set contains tree ring shape data for Abies_277_h400 sampled from Tateyama, central Japan.
#' Its disk image and shape files can be download from  https://www.sanchikanri.com/treering/Abies_277_h400.zip
#' It's intended to demonstrate the structure and use of `TreeRingShape` class objects within the package.
#'
#' @name TR
#' @export
#' @examples
#' # Access basic information about the TreeRingShape object
#' slotNames(TR)
#' str(TR)
#' # Plot the tree ring shape data
#' Lplot(TR@L)
"TR"

# TR_ ####
#' A sample object of class TreeRingShape, shapefile paths and column names only.
#'
#' The full data set contains tree ring shape data for Abies_277_h400 sampled from Tateyama, central Japan.
#' Its disk image and shape files can be download from  https://www.sanchikanri.com/treering/Abies_277_h400.zip
#' @name TR_
#' @export
#' @examples
#' # Access basic information about the TreeRingShape object
#' TR_<-new_classTreeRingShape(
#' P_filename='Abies_277_h400_TreeRing_Points.shp',
#' L_filename='Abies_277_h400_TreeRing_Representative.shp',
#' L2_filename='Abies_277_h400_TreeRing.shp',
#' P_id.tag='id',
#' P_ring.tag='ring',
#' L_ring.tag='ring')
#' slotNames(TR_)
#' str(TR_)
"TR_"

#' Initial setting of  a new classTreeRingShape (TR)
#' @param P_filename   file name of shape file (P) for tree ring points
#' @param L_filename   file name of shape file (L) for tree ring lines
#' @param L2_filename  file name of shape file (L2) for tree ring lines interpolated
#' @param P_id.tag     column name of id in shape file (P), default is 'id'
#' @param P_ring.tag   column name of ring no.(ordinaly year,outermost=0) in shape file (L), default is 'ring'
#' @param L_ring.tag   column name of ring no.(ordinaly year,outermost=0) in shape file (L), default is 'ring'
#' @return generated new object from classTreeRingShape
#' @export
#'
#' @examples
#' TR_<-new_classTreeRingShape(
#' P_filename='Abies_277_h400_TreeRing_Points.shp',
#' L_filename='Abies_277_h400_TreeRing_Representative.shp',
#' L2_filename='Abies_277_h400_TreeRing.shp',
#' P_id.tag='id',
#' P_ring.tag='ring',
#' L_ring.tag='ring')
#'
#'  TR_
#'  slotNames(TR_)
#'  str(TR_)
#'
#'
#'
new_classTreeRingShape <- function(P_filename, L_filename, L2_filename,
                                               P_id.tag = "id", P_ring.tag = "ring", L_ring.tag = "ring") {

  # generate new TR object from classTreeRingShape

  TR <- new("classTreeRingShape")  # treering_cls #str(TR)

  # tree ring points
  TR@P_filename <- P_filename  #'ex : points277_h400'
  TR@P_id.tag <- "id"
  TR@P_ring.tag <- "ring"
  #TR <- TreeRingsPoints(TR)

  # representative tree ring lines
  TR@L_filename <- L_filename  # 'ex : line277_h400'
  TR@L_ring.tag <- L_ring.tag
  #TR <- TreeRingsLines(TR)

  # representative + interpolated tree ring lines
  TR@L2_filename <- L2_filename  #
  #TR <- TreeRingsInterpolation(TR)

  return(TR)

}



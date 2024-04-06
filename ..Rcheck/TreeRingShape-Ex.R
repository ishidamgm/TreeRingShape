pkgname <- "TreeRingShape"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
base::assign(".ExTimings", "TreeRingShape-Ex.timings", pos = 'CheckExEnv')
base::cat("name\tuser\tsystem\telapsed\n", file=base::get(".ExTimings", pos = 'CheckExEnv'))
base::assign(".format_ptime",
function(x) {
  if(!is.na(x[4L])) x[1L] <- x[1L] + x[4L]
  if(!is.na(x[5L])) x[2L] <- x[2L] + x[5L]
  options(OutDec = '.')
  format(x[1L:3L], digits = 7L)
},
pos = 'CheckExEnv')

### * </HEADER>
library('TreeRingShape')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("Ldeg360")
### * Ldeg360

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: Ldeg360
### Title: Return a vector of center angle 0 to 360(degree) for x y
###   coordinate vector
### Aliases: Ldeg360

### ** Examples

 xy <-TR@L[[1]]
 plot(Ldeg360(xy[,1],xy[2]))




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("Ldeg360", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("Llist2dataframe")
### * Llist2dataframe

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: Llist2dataframe
### Title: Convert from a list of tree rings polygons (L) to data frame to
###   a data frame with no.,year,x,y,r(radius),radian(center angle),degree.
###   The data frame is sorted by degree(0 to 360).
### Aliases: Llist2dataframe

### ** Examples

L_ <- Llist2dataframe(TR@L)
head(L_) ; tail(L_)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("Llist2dataframe", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("Lmove")
### * Lmove

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: Lmove
### Title: Move the tree rings coordinates based on P00 (x,y movement
###   coordinates).
### Aliases: Lmove

### ** Examples

Lplot(TR@L)
sapply(Lmove(TR@L,c(3000,-3000)),lines,col="blue")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("Lmove", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("Lplot")
### * Lplot

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: Lplot
### Title: Plot a graphics of tree rings
### Aliases: Lplot

### ** Examples


Lplot(TR@L,main=TR@L_filename)
Lplot(TR@L,rn=1:20,col='blue',main=TR@L_filename)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("Lplot", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("Lplot2")
### * Lplot2

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: Lplot2
### Title: Draw a graphics of tree rings by 1 ring (3*3 in a screen)
### Aliases: Lplot2

### ** Examples

Lplot2(TR@L,i.ring=1:9, nrow=1,ncol=1,type='b')
Lplot2(TR@L,type='b')



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("Lplot2", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("Lrad.plot")
### * Lrad.plot

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: Lrad.plot
### Title: Check center angle of points to input order
### Aliases: Lrad.plot

### ** Examples

slotNames(TR)
Lplot(TR@L)
str(TR@L)
Lrad.plot(TR@L,11:19)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("Lrad.plot", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("Lrn")
### * Lrn

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: Lrn
### Title: Return a ring number of tree ring polygons list (L) from year
### Aliases: Lrn

### ** Examples

Lrn(TR@L,8)  # 8 is the formation year (from outermost) of the tree ring




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("Lrn", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("Lsort")
### * Lsort

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: Lsort
### Title: Sort x,y coordinates of a tree ring line with center angle of
###   each point
### Aliases: Lsort

### ** Examples

i<-seq(0,2*pi,0.1)
l.<-data.frame(x=sin(i),y=cos(i))
l.[10,]<-l.[20,]
plot(l.,type="b")
plot(Lsort(l.),type="b")




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("Lsort", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("Lsort_all")
### * Lsort_all

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: Lsort_all
### Title: Sort x,y coordinates of tree ring lines with center angle of
###   each point apply Lsort to list of tree ring lines
### Aliases: Lsort_all

### ** Examples

str(Lsort_all(TR@L))




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("Lsort_all", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("ReadShapefile_P00")
### * ReadShapefile_P00

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: ReadShapefile_P00
### Title: Return x,y coordinates of a tree ring center point (P00) from
###   shape file of tree ring points
### Aliases: ReadShapefile_P00

### ** Examples

# This example NOT be run examples
## Not run: 
##D # read a original point P00 ####
##D filename <- '../Abies_277_h400/Abies_277_h400_TreeRing_Points.shp'
##D ReadShapefile_P00(filename)
## End(Not run)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("ReadShapefile_P00", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("ReadShapefile_TreeRingPoints")
### * ReadShapefile_TreeRingPoints

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: ReadShapefile_TreeRingPoints
### Title: Read a shape file of Tree Ring Points ( P : radial input and
###   correction points)
### Aliases: ReadShapefile_TreeRingPoints

### ** Examples

## Not run: 
##D 
##D # sample data of 'Abies_277_h400' can be download from
##D #https://www.sanchikanri.com/treering/Abies_277_h400.zip
##D 
##D file.path <- '../Abies_277_h400/Abies_277_h400_TreeRing_Points.shp'
##D ReadShapefile_TreeRingPoints(file.path,id.tag='id',ring.tag='ring')
##D 
## End(Not run)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("ReadShapefile_TreeRingPoints", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("ReadShapefile_TreeRings")
### * ReadShapefile_TreeRings

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: ReadShapefile_TreeRings
### Title: Read Shapefile_TreeRings
### Aliases: ReadShapefile_TreeRings

### ** Examples

## Not run: 
##D filename <- '../Abies_277_h400/Abies_277_h400_TreeRing_Representative.shp'
##D Lplot(ReadShapefile_TreeRings(filename))
## End(Not run)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("ReadShapefile_TreeRings", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("TR")
### * TR

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: TR
### Title: A sample object of class TreeRingShape
### Aliases: TR
### Keywords: datasets

### ** Examples

# Access basic information about the TreeRingShape object
slotNames(TR)
str(TR)
# Plot the tree ring shape data
Lplot(TR@L)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("TR", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("TreeRingIndex")
### * TreeRingIndex

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: TreeRingIndex
### Title: Calculate tree ring index from chronosequence data (year,growth)
### Aliases: TreeRingIndex

### ** Examples

## Not run: 
##D ya <- plot_year_RingArea(TR@L2, 2018)$Year_TreeRingArea
##D plot(ya,type='b')
##D tri. <- TreeRingIndex(ya)
##D lines(tri.$spline,col='red',lw=2)
##D plot(tri.$idx,type='b')
##D abline(h=1,col='red')
## End(Not run)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("TreeRingIndex", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("TreeRingShape")
### * TreeRingShape

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: TreeRingShape
### Title: Construct a object (TR) of classTreeRingShape
### Aliases: TreeRingShape

### ** Examples


## Not run: 
##D 
##D # sample data enable to download from
##D # https://www.sanchikanri.com/treering/Abies_277_h400.zip
##D setwd('../Abies_277_h400') #set working directory with shape files
##D TR.<-TreeRingShape(
##D P_filename='Abies_277_h400_TreeRing_Points.shp',
##D L_filename='Abies_277_h400_TreeRing_Representative.shp',
##D L2_filename='Abies_277_h400_TreeRing.shp',
##D P_id.tag='id',P_ring.tag='ring',
##D L_ring.tag='ring')
##D 
##D  TR.
##D  slotNames(TR.)
##D  str(TR.)
##D  Lplot(TR.@L2)
##D 
## End(Not run)





base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("TreeRingShape", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("TreeRingsInterpolation")
### * TreeRingsInterpolation

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: TreeRingsInterpolation
### Title: Interpolates tree ring between representative (manual input)
###   tree rings with tree ring points
### Aliases: TreeRingsInterpolation

### ** Examples

slotNames(TR)
TR <- TreeRingsInterpolation(TR)
ya <- plot_year_RingArea(TR@L2, 2018)$Year_TreeRingArea
plot(ya,type='b')
tri. <- TreeRingIndex(ya)
lines(tri.$spline,col='red',lw=2)
plot(tri.$idx,type='b')
abline(h=1,col='red')




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("TreeRingsInterpolation", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("TreeRingsLines")
### * TreeRingsLines

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: TreeRingsLines
### Title: Read representative tree ring lines from shape files
### Aliases: TreeRingsLines

### ** Examples

 ## Not run: 
##D  setwd('../Abies_277_h400') #set working directory with shape files
##D  TR <- TreeRingsLines(TR)
##D  
## End(Not run)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("TreeRingsLines", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("TreeRingsPoints")
### * TreeRingsPoints

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: TreeRingsPoints
### Title: Read TreeRingsPoints shape file, check and save parameters
### Aliases: TreeRingsPoints

### ** Examples

## Not run: 
##D  setwd('../Abies_277_h400') #set working directory with shape files
##D  TreeRingsPoints(TR)
##D #' 
## End(Not run)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("TreeRingsPoints", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("WriteShapefile_TreeRings")
### * WriteShapefile_TreeRings

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: WriteShapefile_TreeRings
### Title: Write a shapefile of interpolated tree rings
### Aliases: WriteShapefile_TreeRings

### ** Examples


## Not run: 
##D #'
##D WriteShapefile_TreeRings (TR@L2, tempfile("TreeRingShape_test",fileext = ".shp"))
##D dir(tempdir())
## End(Not run)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("WriteShapefile_TreeRings", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("area")
### * area

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: area
### Title: Return a area from polygon xy coordinates
### Aliases: area

### ** Examples

xy<-data.frame(x=c(0,1,2,1),y=c(1,2,1,0))
plot(xy,type="b") ; polygon(xy)
area(xy)






base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("area", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("circumference")
### * circumference

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: circumference
### Title: Return circumference length of polygon line
### Aliases: circumference

### ** Examples

l. <- data.frame(x=c(0,0,1,1),y=c(0,1,1,0))
plot(l.,type="b") ; polygon(l.)
circumference(l.)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("circumference", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("classTreeRingShape-class")
### * classTreeRingShape-class

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: classTreeRingShape-class
### Title: class of TreeRingShape
### Aliases: classTreeRingShape-class

### ** Examples

 TR. <- new('classTreeRingShape')
 TR.
 slotNames(TR.)
 str(TR.)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("classTreeRingShape-class", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("dst")
### * dst

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: dst
### Title: Return a vector of distances from original a point (0,0) from a
###   matrix or data frame of xy coordinates
### Aliases: dst

### ** Examples

plot(TR@L[[1]])
plot(dst(TR@L[[1]]))



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("dst", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("dstpp")
### * dstpp

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: dstpp
### Title: Return vector for distance between adjacent two points
### Aliases: dstpp

### ** Examples

l.<-TR@L[[1]]
plot(l.)
x<-l.[,1] ;y<-l.[,2]
dstpp(x,y)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("dstpp", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("new_classTreeRingShape")
### * new_classTreeRingShape

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: new_classTreeRingShape
### Title: Initial setting of a new classTreeRingShape (TR)
### Aliases: new_classTreeRingShape

### ** Examples

## Not run: 
##D (wd. <- getwd())
##D setwd('../Abies_277_h400')
##D dir()
##D TR.<-new_classTreeRingShape(
##D P_filename='Abies_277_h400_TreeRing_Points.shp',
##D L_filename='Abies_277_h400_TreeRing_Representative.shp',
##D L2_filename='Abies_277_h400_TreeRing.shp',
##D P_id.tag='id',
##D P_ring.tag='ring',
##D L_ring.tag='ring')
##D 
##D  TR.
##D  slotNames(TR.)
##D  str(TR.)
##D 
## End(Not run)





base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("new_classTreeRingShape", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("nstP")
### * nstP

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: nstP
### Title: Return a vector of row numbers of points that have nearest
###   center angle
### Aliases: nstP

### ** Examples

L_out<-TR@L[[1]];L_in<-TR@L[[30]]
np<-nstP(L_out,L_in)
plot(L_out,col="red"); points(L_in)
segments(L_out[,1],L_out[,2],L_in[np,1],L_in[np,2],col="blue")




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("nstP", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("plot_TreeRing")
### * plot_TreeRing

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: plot_TreeRing
### Title: Draw a plot of tree rings This function draws Tree rings of a
###   disk from x, y list(x,y) with name of year.
### Aliases: plot_TreeRing

### ** Examples

names(TR@L)
plot_TreeRing(TR@L)
plot_TreeRing(TR@L,year=10,type='l',col='blue')



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("plot_TreeRing", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("plot_TreeRing_df")
### * plot_TreeRing_df

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: plot_TreeRing_df
### Title: plot_TreeRing_df Draw a Tree ring of a disk from data
###   frame(x,y,year)
### Aliases: plot_TreeRing_df

### ** Examples

TR@L_ <- Llist2dataframe(TR@L)     # data frame of tree rings
plot_TreeRing_df(TR@L_, year =1)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("plot_TreeRing_df", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("plot_TreeRings_df")
### * plot_TreeRings_df

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: plot_TreeRings_df
### Title: Plot tree rings from data fame This function draws Tree rings of
###   a disk from data frame(x,y,year).
### Aliases: plot_TreeRings_df

### ** Examples


TR@L_ <- Llist2dataframe(TR@L)     # data frame of tree rings
names(TR@L_)
plot_TreeRings_df(TR@L_)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("plot_TreeRings_df", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("plot_year_RingArea")
### * plot_year_RingArea

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: plot_year_RingArea
### Title: Plot and return data frame of year_disk area and year_Tree ring
###   area
### Aliases: plot_year_RingArea

### ** Examples

## Not run: 
##D plot_year_RingArea(TR@L2,2018)
## End(Not run)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("plot_year_RingArea", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("rdst")
### * rdst

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: rdst
### Title: Return relative distance between two representative tree rings
### Aliases: rdst

### ** Examples


rdst.<-rdst(TR@L,TR@P,73)
plot(rdst.)
spline<-smooth.spline(rdst.$rad,rdst.$rdst, spar =0.0002)
lines(predict(spline,seq(-pi,pi,0.01)),col="red")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("rdst", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("rdst_MerginePlus")
### * rdst_MerginePlus

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: rdst_MerginePlus
### Title: Return relative distance between two representative tree rings
### Aliases: rdst_MerginePlus

### ** Examples

year.<-73
rdst.<-rdst_MerginePlus(TR@L,TR@P,year.)
plot(rdst.,xlim=c(-200,200),main=year.)
spline<-smooth.spline(rdst.$deg,rdst.$rdst, spar =0.0002)
lines(predict(spline,seq(-202,220,1)),col="red")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("rdst_MerginePlus", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("seq_deg")
### * seq_deg

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: seq_deg
### Title: Return a vector of sequence of angles between start and end
###   angle 0 to pi -pi to 0
### Aliases: seq_deg

### ** Examples

seq_deg(170,-170,.5)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("seq_deg", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')

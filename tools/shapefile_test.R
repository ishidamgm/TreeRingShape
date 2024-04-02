# tools/shapefile_test.R ####
#
library(TreeRingShape)
library(shapefiles)
library(sf)

help(package="TreeRingShape")

slotNames(TR)
TR@P_filename

f <- '../Abies_277_h400/Abies_277_h400_TreeRing_Points'
f <- '../Abies_277_h400/Abies_277_h400_TreeRing_Points.shp'

d<-read_sf(f)
#d<-st_read(f)
st_coordinates(d)
data.frame(d)
st_write(d,"test.shp")
d.st<-d

filename<-file.path
ReadShapefile_TreeRingPoints(file.path,id.tag="id",ring.tag="ring")


f.<-tempfile(fileext = ".shp")
dir(tempdir())

#' file.path <- '../Abies_277_h400/Abies_277_h400_TreeRing_Representative'
#' Lplot(ReadShapefile_TreeRings(file.path))

d<-st_read(paste0(file.path, ".shp"))
str(d)
plot(sf::st_coordinates(d),type="l")
XY <- sf::st_coordinates(d)

str(XY)
tail(XY)


# from data frame to shape files
pt1 = st_point(c(0,1))
pt2 = st_point(c(1,1))
st_sfc(pt1, pt2)
d = data.frame(a = 1:2)
d$geom = st_sfc(pt1, pt2)
df = st_as_sf(d)
d
st_sfc(st_linestring(XY))
d2=data.frame(d)
d2$geom = st_sfc(st_linestring(XY))
plot(d)
d2 <- data.frame(d)
d2$geom <- st_sfc(st_multilinestring(L2))
plot(d2)

ddTable$geom <- st_sfc(st_multilinestring(L2))
plot(ddTable)
plot()
z<-st_sfc(st_multilinestring(L2))
plot(z)
data.frame(z)

st_sfc(L2)
st_linestring(L2[[1]])
ddTable$geom<-st_sfc(sapply(L2,st_linestring))
plot(ddTable)
st_coordinates(ddTable)
st_sfc(ddTable)
#################
z<-st_sfc(sapply(L2,st_linestring))
z<-st_sf(z,ddTable)
st_write(z,"z.shp")
########

plot(z)
plot(data.frame(ddTable,z))
st_join(z,ddTable)

# pdf() ####
wd<-getwd()
setwd(tempdir())
pdf("test2.pdf")
plot(1:10)
plot((1:10)^2)
dev.off()
dir()

# cttation ####
citation("sf")


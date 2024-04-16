# calculation.R ####

#' Constant for conversion from degree to radian ####
#' @name degree
#'
degree<-pi/180  # degree :

#' Return circumference length of polygon line
#'
#' @param l. data frame of line coordinates (x,y)
#'
#' @return a numeric of circumference length of polygon line
#' @export
#'
#' @examples
#' l. <- data.frame(x=c(0,0,1,1),y=c(0,1,1,0))
#' plot(l.,type="b") ; polygon(l.)
#' circumference(l.)
circumference <- function(l.){
  l.2<-rbind(l.[-1,],l.[1,])
  len<-sum(rowSums((l.-l.2)^2))
  return(len)
}

#' Return a  area from polygon xy coordinates
#'
#' @param xy a atrix or data frame of xy coordinates
#'
#' @return a vector of polygon area
#'
#'
#' @examples
#' xy<-data.frame(x=c(0,1,2,1),y=c(1,2,1,0))
#' plot(xy,type="b") ; polygon(xy)
#' area(xy)
#'
#'
#'
area <- function(xy){
  x <- xy[,1];y <- xy[,2]
  x2 <- c(x[2:length(x)], x[1])
  y2 <- c(y[2:length(y)], y[1])

  abs(sum((x2-x)*(y+y2)/2))
}


#' Return vector for distance between adjacent two points
#'
#' @param x vector of x coordinates
#' @param y vector of y coordinates
#'
#' @return  vector for distance between adjacent two points
#' @export
#'
#' @examples
#' l.<-TR@L[[1]]
#' plot(l.)
#' x<-l.[,1] ;y<-l.[,2]
#' dstpp(x,y)
dstpp<-function(x,y){
  x2<-c(rev(x)[1],x[-length(x)])
  y2<-c(rev(y)[1],y[-length(y)])
  dxy<-sqrt((x-x2)^2+(y-y2)^2)
  return(dxy)
}


#' Return a vector of distances from original a point (0,0)
#' from a matrix or data frame of xy coordinates
#'
#' @param xy a matrix or data frame of xy coordinates
#'
#' @return a vector of distances from original a point
#' @export
#'
#' @examples
#' plot(TR@L[[1]])
#' plot(dst(TR@L[[1]]))
dst <- function(xy){#xy<-L[[19]]
  x<-xy[,1] ; y <-xy[,2]
  sqrt(diff(x)^2+diff(y)^2)
}

#' Return a vector of row numbers of  points that have nearest  center angle
#'
#'
#' @param z1 a data frame or a matrix of  xy coordinates of a tree ring  (usualy inner ring)
#' @param z2  a data frame or a matrix of  xy coordinates of a tree ring  (usualy outer ring)
#'
#' @return a vector of row numbers of z2, the length is nrow(z1)
#' @export
#'
#' @examples
#' L_out<-TR@L[[1]];L_in<-TR@L[[30]]
#' np<-nstP(L_out,L_in)
#' plot(L_out,col="red"); points(L_in)
#' segments(L_out[,1],L_out[,2],L_in[np,1],L_in[np,2],col="blue")
#'
nstP<-function(z1,z2){
  a1<-atan2(z1[,2],z1[,1]) ; a2<-atan2(z2[,2],z2[,1])
  np<-c()
  for (i in 1:nrow(z1)){
    np<-c(np,which.min((cos(a1[i])-cos(a2))^2+(sin(a1[i])-sin(a2))^2))
  }
  return(np)
}




#' Return a vector of sequence of angles between start and end angle
#'  0 to pi -pi to 0
#'
#' @param deg1 start angle
#' @param deg2 end angle
#' @param deg.by  step of sequence
#'
#' @return vector of sequence of angles between start and end angle
#' @export
#'
#' @examples
#' seq_deg(170,-170,.5)
#'
seq_deg <- function(deg1,deg2,deg.by=1){
  if((deg1<=0 & deg2<=0) | (deg1>=0 & deg2>=0))return(seq(deg1,deg2,deg.by))
  if(deg1>=0 & deg2<=0) return(c(seq(deg1,180,deg.by),seq(-180,deg2,deg.by)))
  if(deg1<=0 & deg2>=0) return(c(seq(deg1,0,deg.by),seq(0,deg2,deg.by)))
}



#' Return relative distance between two representative tree rings
#'
#' @param L list of x,y coordinates of representative tree rings (TR@L)
#' @param P data.frame (x,y,id,yr,r,deg) of radial tree ring points (TR@P)
#' @param yr year
#'
#' @return   a data frame with relative distance and center angle
#' @export
#'
#' @examples
#'
#' rdst.<-rdst(TR@L,TR@P,73)
#' plot(rdst.)
#' spline<-smooth.spline(rdst.$rad,rdst.$rdst, spar =0.0002)
#' lines(predict(spline,seq(-pi,pi,0.01)),col="red")
rdst <-function(L,P,yr){
  i<-which(P$yr==yr)
  x<-P$x[i] ; y<-P$y[i]

  yr.<-as.numeric(names(L))
  i<-tail(which(yr.<yr),1)
  yr1<-yr.[i];yr2<-yr.[i+1]
  L1<-L[[i]] ; L2<-L[[i+1]]
  ##  plot(L2,type="l",col="red");lines(L1,col="blue"); lines(x,y,type="b")
  r <-sqrt( x^2+ y^2)
  rad <- atan2(y,x)
  r1<-sqrt(L1[,1]^2+L1[,2]^2)
  r2<-sqrt(L2[,1]^2+L2[,2]^2)

  r_in <-  r1[nstP(cbind(x,y),L1)]
  r_out <- r2[nstP(cbind(x,y),L2)]
  rdst. <- (r_out-r) / (r_out-r_in)
  rdst.[rdst.==Inf] <-0
  i<-order(rad)
  return(data.frame(rad,rdst=rdst.)[i,])
}



#' Return relative distance between two representative tree rings
#'
#' @param L is a list of tree rings(x,y coordinates).
#' @param P data.frame (x,y,id,yr,r,deg) of radial tree ring points (TR@P)
#' @param yr  integer of year
#'
#' @return  a data frame with relative distance and center angle(degree)
#' with mergine (-90 - 0 - 360 - 90)
#' @export
#'
#' @examples
#' year.<-73
#' rdst.<-rdst_MerginePlus(TR@L,TR@P,year.)
#' plot(rdst.,xlim=c(-200,200),main=year.)
#' spline<-smooth.spline(rdst.$deg,rdst.$rdst, spar =0.0002)
#' lines(predict(spline,seq(-202,220,1)),col="red")

rdst_MerginePlus <- function(L,P,yr){ #,pi/2
  ddeg<-180
  df <- rdst(L,P,yr) #nrow(df)
  deg.<- df$rad/degree
  rdst.<- df$rdst
  # front
  i<--ddeg <deg. & deg. < 0
  deg.pre<-deg.[i]+360 ; rdst.pre<-rdst.[i]
  # back
  i<- 0 <deg. & deg. < ddeg
  deg.pos<-deg.[ i ]-360 ;rdst.pos<-rdst.[ i ]
  deg.<- c(deg.pre,deg.,deg.pos)
  rdst.<- c(rdst.pre,rdst.,rdst.pos)
  return(data.frame(deg=deg., rdst=rdst.))

}





#' Move the tree rings coordinates based on P00 (x,y movement coordinates).
#'
#' @param L  a list of tree rings(x,y coordinates).
#' @param P00 x, y coordinates of a center point (usually a pith).
#'
#' @return moved L to center point 0,0
#' @export
#'
#' @examples
#' Lplot(TR@L)
#' sapply(Lmove(TR@L,c(3000,-3000)),lines,col="blue")
Lmove <- function(L,P00=P00){
  # default : move to the original center point coordinates  from center point (0,0)
  for (i in 1:length(L))L[[i]]<-t(t(L[[i]])+P00)
  return(L)
}

#' Convert from a list of tree rings polygons (L) to data frame
#' to a data frame with no.,year,x,y,r(radius),radian(center angle),degree.
#' The data frame is sorted by degree(0 to 360).
#'
#' @param L list of tree ring lines
#'
#' @return data frame
#' @export
#'
#'@examples
#' L_ <- Llist2dataframe(TR@L)
#' head(L_) ; tail(L_)
Llist2dataframe <-function(L){
  L_<-c()
  for (i in 1:length(L)){
    x<-L[[i]][,1];y<- L[[i]][,2]
    Lr   <- sqrt(x^2+y^2)
    Lrad <- atan2(y,x)
    #Ldeg <- (Lrad/degree+360)%%360
    Ldeg <- Lrad/degree
    L.df <- data.frame(i,yr=names(L)[i],x,y,r=Lr,rad=Lrad,deg=Ldeg)
    L.df <- L.df[order(L.df$deg),]  # sort with center angle, can't use in the case of recovery growth, such as after barking
    L_<-rbind(L_,L.df)
  }
  return(L_)
}



#' Return a ring number of tree ring polygons list (L) from year
#'
#' @param L tree ring polygons list (L)
#' @param yr years (or rings)
#'
#' @return a ring number of tree ring polygons list (L)
#' @export
#'
#' @examples
#' Lrn(TR@L,168)  # 168 is the formation year (from outermost) of the tree ring
#'
Lrn <- function(L,yr){
  return(which(names(L)==yr))
}


#' Sort  x,y coordinates of a tree ring line with center angle of each point
#'
#' @param l.  x,y coordinates matrix (ncol=2) or data.frame of an tree ring.
#'
#' @return    ordered with center angle of each point
#' @export
#'
#' @examples
#' i<-seq(0,2*pi,0.1)
#' l.<-data.frame(x=sin(i),y=cos(i))
#' l.[10,]<-l.[20,]
#' plot(l.,type="b")
#' plot(Lsort(l.),type="b")
#'
Lsort <- function(l.){#
  x<-l.[,1] ; y<- l.[,2]
  #Ldeg <- (atan2(y,x)/degree+360)%%360
  Ldeg <- atan2(y,x)/degree
  return(l.[order(Ldeg),])

}

#' Sort  x,y coordinates of tree ring lines with center angle of each point
#' apply Lsort to list of tree ring lines
#'
#' @param L  a list of tree ring lines (x,y)
#'
#' @return   a list of tree ring lines (x,y) ordered with center angle of each point
#' @export
#'
#' @examples
#' str(Lsort_all(TR@L))
#'
Lsort_all <- function(L){
  L000 <- c()
  for(i in 1:length(L)){
    L000 <- c(L000,list(Lsort(L[[i]])))
  }
  names(L000) <- names(L)
  return(L000)
}


#' Return a vector of center angle 0 to 360(degree) for x y coordinate vector
#'
#' @param x  a vector of x coordinates
#' @param y  a vector of y coordinates
#'
#' @return a vector of center angle 0 to 360(degree) for x y coordinate vector
#' @examples
#'  xy <-TR@L[[1]]
#'  plot(Ldeg360(xy[,1],xy[2]))
#'
Ldeg360 <- function(x,y){
  return((atan2(y,x)/degree+360)%%360)
}



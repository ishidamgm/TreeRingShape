# make_TR_.R

TR_<-new_classTreeRingShape(
  P_filename='Abies_277_h400_TreeRing_Points.shp',
  L_filename='Abies_277_h400_TreeRing_Representative.shp',
  L2_filename='Abies_277_h400_TreeRing.shp',
  P_id.tag='id',
  P_ring.tag='ring',
  L_ring.tag='ring')

TR_
slotNames(TR_)
str(TR_)

# save(TR_,file="./data/TR_.RData")
load("./data/TR_.RData")
TR_

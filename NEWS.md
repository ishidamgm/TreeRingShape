# TreeRingShape 3.0.3
* Added  \\value to following function
 TreeRingsPoints.Rd,  WriteShapefile_TreeRings.Rd: \value 
     
# TreeRingShape 3.0.2
* Added Authors@R field in  DESCRIPTION file.
* Wrote package names in single quotes , as GIS soft ('Qgis'<https://www.qgis.org/en/site/>)
* Added  \\value to following function
       Lplot.Rd, Lplot2.Rd, Lrad.plot.Rd, plot_TreeRing_df.Rd, plot_TreeRing.Rd,
  plot_TreeRings_df.Rd, TreeRingsPoints.Rd, WriteShapefile_TreeRings.Rd
    \\value  ⇒　** #' @return No return value, only draw tree ring plot. **
* Added  sample Shapefiles in inst/shp
* All  dontrun{} were deleted, and capable of execute with  sample Shapefiles in inst/shp
* A donttest{} was used in WriteShapefile_TreeRings ()
* Reset user's options()　  
  “oldpar <- par(no.readonly = TRUE);   on.exit(par(oldpar)) “ were included  in Lplot2() and Lrad.plot()
* Reset user's working directory 
     “oldwd <- getwd() ; on.exit(setwd(oldwd)) “ was used in a Example function of  TreeRingShape(). 

# TreeRingShape 3.0.1
* correct from 'seq.deg()' to 'seq_deg()' as s4 generic 

# TreeRingShape 3.0.0
* Initial comitment. 
* It was supposed to be 0.1.0, but I made a mistake and ended up with 3.0.0. Please note that this is in the early stages of development.

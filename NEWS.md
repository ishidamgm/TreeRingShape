# TreeRingShape 3.0.5 
* DESCRIPTION Update:
 Added tibble and waldo to the Suggests field to address any indirect dependencies.
* Error Handling in ReadShapefile_P00:
 Modified ReadShapefile_P00 to include a check that confirms the presence of a center point with id == 0 in the data, as this is required for the function to work correctly. If id == 0 is not found, an informative error message is now returned.

# TreeRingShape 3.0.4 
* URL: "https://cran.r-project.org/web/packages/TreeRingShape/index.html" added in DESCRIPTION.
* Corrected code of circumference() 
* Added DiskInfo() 

# TreeRingShape 3.0.3 (published on CRAN 2024/04/23)
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
* Initial commitment. 
* It was supposed to be 0.1.0, but I made a mistake and ended up with 3.0.0. Please note that this is in the early stages of development.

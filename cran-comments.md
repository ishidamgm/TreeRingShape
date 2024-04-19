## Test environments

* R version 4.3.3 (2024-02-29)
 Platform: x86_64-pc-linux-gnu (64-bit)
 Running under: Ubuntu 22.04.4 LTS
* R version 4.3.3 (2024-02-29)
 Platform: x86_64-apple-darwin20 (64-bit)
 Running under: macOS Ventura 13.3.1

* R version 4.3.3 (2024-02-29)
 Platform: x86_64-w64-mingw32/x64 (64-bit)
 Running under: Windows 11 x64 (build 22631)

* R version 4.3.3 (2024-02-29)
 Platform: x86_64-w64-mingw32/x64 (64-bit)
 Running under: Windows 11 x64 (build 22631)
 
* R Under development (unstable) (2024-04-16 r86435 ucrt)
Platform: x86_64-w64-mingw32/x64
Running under: Windows 11 x64 (build 22631)


## R CMD check --as-cran results
0 errors | 0 warnings | 1 note

## devtools::check() 
0 errors ✔ | 0 warnings ✔ | 0 notes ✔

## New submission
* checking CRAN incoming feasibility ... [2s/13s] NOTE
Maintainer: ‘Megumi ISHIDA <ishidam@sanchikanri.com>’

## Reverse dependencies

There are no reverse dependencies.

## Notes

### Resubmition 3.0.3 
* Added  \\value to following function    
       *TreeRingsPoints.Rd:  
       　　-> \\value   a list of (P,P00,YR_P,n_id,YR_P,n_YR)    
       * WriteShapefile_TreeRings.Rd:  
       　　-> \\value   No return value, called for side effects.

  
 
 
### Resubmition 3.0.2
* Status: 2 NOTEs
* 1.
 Author field differs from that derived from Authors@R
 Author:    ‘Megumi ISHIDA’
 Authors@R: ‘Megumi Ishida [aut, cre, cph]’
* ->  corrected from "Authors@R: ‘Megumi Ishida "  to  "Authors@R: ‘Megumi  ISHIDA"    in  DESCRIPTION

* 2.
 Found the following (possibly) invalid URLs:
   URL: https://www.qgis.org (moved to https://www.qgis.org/en/site/)
 From: DESCRIPTION
 NEWS.md
* -> corrected from " https://www.qgis.org"  to  "https://www.qgis.org/en/site/"  in 　DESCRIPTION　and NEWS.md

### Submition

* Added Authors@R field in  DESCRIPTION file.
* Wrote package names in single quotes , as GIS soft ('Qgis'<https://www.qgis.org>)
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



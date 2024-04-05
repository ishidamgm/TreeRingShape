# devtools.R
.libPaths()
library(devtools)
library(testthat)
library(TreeRingShape)

# uninstall & install ####
detach("package:TreeRingShape", unload = TRUE)
.libPaths()
dir(.libPaths()[1],"TreeRingShape")
devtools::uninstall(".")
dir(.libPaths()[1],"TreeRingShape")
devtools::install_github("ishidamgm/TreeRingShape")
library(TreeRingShape)
help(package = "TreeRingShape")
browseVignettes("TreeRingShape")


# check ####
devtools::check()

#　devtools::document　####
devtools::document()
devtools::build_manual()   ## pdf manual ####

# build and install package with vignettes !!! ####
devtools::build(binary = TRUE,vignettes = TRUE,manual = TRUE)
devtools::install(build_vignettes = TRUE)
library(TreeRingShape)
help(package = "TreeRingShape")
browseVignettes("TreeRingShape")

# CRAN ####
## 22  Releasing to CRAN https://r-pkgs.org/release.html ####
devtools::build()
devtools::check()       #  errors ✔ | 0 warnings ✔ | 0 notes ✔
devtools::revdep()      #character(0)

# ??? devtools::build_win()
# usethis::use_cran_comments()
# sessionInfo()

# usethis::use_release_issue()
## Selection: 1
## ✔ Opening URL 'https://github.com/ishidamgm/TreeRingShape/issues/1'
#

# install_github  ####
# install_github("ishidamgm/TreeRingShape")


#devtools::install()
devtools::install(build_vignettes = TRUE)
library(TreeRingShape)
help(package = "TreeRingShape")
browseVignettes("TreeRingShape")

#devtools::build_vignettes("TreeRingShape")
#usethis::use_vignette("TreeRingShape")
#devtools::use-vignette("TreeRingFShape")
#devtools::build_rmd("vignettes/TreeRingShape.Rmd")

  # down sizing TR ####
  ## memory size ####
  print(object.size(TR), units="Mb")
  print(object.size(TR@L), units="Mb")
  print(object.size(TR@L2), units="Mb")
  print(object.size(TR@L_), units="Mb")

  ## output small TR ####
  if(0){
    TR.<-TR
    TR.@L_ <-data.frame(0)
    TR.@L2 <-list(0)
    print(object.size(TR.), units="Mb")
    TR<-TR.
    save(TR,file="TR.RData")
    save(TR,file="data/TR_compress.RData",compress=TRUE,compression_level = 9)
    # not effective >>> save(TR, file="./data/TR_compressed.RData", compress="xz", compression_level=9)
  }




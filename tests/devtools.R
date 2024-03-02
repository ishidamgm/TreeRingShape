# devtools.R
# R CMD Rd2pdf TreeRingShape


devtools::document()

#devtools::build_vignettes("TreeRingShape")

usethis::use_vignette("TreeRingShape")

devtools::install(build_vignettes = TRUE)  # !!!! ####

vignette("TreeRingShape", package="TreeRingShape")

vignette()

setwd("./vignettes")
setwd("..")
help(package = "TreeRingShape")
vignette(package = "TreeRingShape")

  .libPaths()

  devtools::check()
  #devtools::check_doc()

  devtools::document()


  ?tools::resaveRdaFiles
  save(TR, file="./data/TR_compressed.RData", compress="xz", compression_level=9)

 #   devtools::use-vignette("TreeRingFShape")
  devtools::build_rmd("vignettes/TreeRingShape.Rmd")

  dir("./R")
  f. <- "./R/setClass.R"
  formatR::tidy_source(f.)

  formatR::tidy_source()   #clipboard

  #use_testthat

  usethis::use_testthat()
  library(testthat)
  library(TreeRingShape)
  test_check("TreeRingShape")
  rlang::last_trace()
  rlang::last_trace(drop = FALSE)

  vignette("TreeRingFShape")


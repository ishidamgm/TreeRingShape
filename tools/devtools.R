# devtools.R
# R CMD Rd2pdf TreeRingShape

library(devtools)
library(testthat)
library(TreeRingShape)


help(package = "TreeRingShape")
.libPaths()

# memory size ####
print(object.size(TR), units="Mb")
print(object.size(TR@L), units="Mb")
print(object.size(TR@L2), units="Mb")
print(object.size(TR@L_), units="Mb")

TR.<-TR
TR.@L_ <-data.frame(0)
TR.@L2 <-list(0)
print(object.size(TR.), units="Mb")
TR<-TR.
save(TR,file="TR.RData")
save(TR,file="data/TR_compress.RData",compress=TRUE,compression_level = 9)

#　devtools::document　####
#
devtools::document()

# vignette ####
# ヘルプにビニエットのリンクをつける ####   !!!
#  ビルドの後ビルドするとまたなくなる
devtools::install(build_vignettes = TRUE)

#devtools::build_vignettes("TreeRingShape")

usethis::use_vignette("TreeRingShape")

vignette("TreeRingShape", package="TreeRingShape")

vignette()

setwd("./vignettes")
setwd("..")

vignette(package = "TreeRingShape")


  vignette("TreeRingFShape")
# check ####
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

  #use_testthat ####
  library(testthat)
  usethis::use_testthat()


  test_check("TreeRingShape")
  rlang::last_trace()
  rlang::last_trace(drop = FALSE)

  # data-raw　####
  ### ** Examples

  x <- data.frame(x = 1:10, y = "x", stringsAsFactors = TRUE)
  # A data frame is an S3 object with class data.frame
  expect_s3_class(x, "data.frame")
  expect_s4_class(x, "data.frame")
  show_failure(expect_s4_class(x, "data.frame"))

  expect_s3_class(TR@L_, "data.frame")




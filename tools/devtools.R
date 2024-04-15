# devtools.R
.libPaths()
library(devtools)
library(testthat)
library(TreeRingShape)

help(package = "TreeRingShape")

# uninstall & install ####
detach("package:TreeRingShape", unload = TRUE)
.libPaths()
dir(.libPaths()[1],"TreeRingShape")
devtools::uninstall(".")
dir(.libPaths()[1],"TreeRingShape")
devtools::install_github("ishidamgm/TreeRingShape",vignettes = TRUE)
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
#devtools::install_github("ishidamgm/TreeRingShape", build_vignettes = TRUE,force=T)
devtools::install(build_vignettes = TRUE)
devtools::install(build_vignettes = TRUE)
library(TreeRingShape)
help(package = "TreeRingShape")
browseVignettes("TreeRingShape")
# 3.0.1
# S3 Generic/Method Consistency NOTE: Points out mismatches for apparent methods
# not registered with S3 generic methods (seq and seq.deg). This is a reminder to
# register these methods properly to avoid potential issues and comply with
# the R packaging guidelines.

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
## urlchecker::url_check() #### >>> ✔ All URLs are correct!
## devtools::check(remote = TRUE, manual = TRUE) ####
# Maintainer: ‘Megumi ISHIDA <ishidam@sanchikanri.com>’
# New submission
# 0 errors ✔ | 0 warnings ✔ | 1 note ✖
## devtools::check_win_devel() ####
# Submit to CRAN: ####
## usethis::use_version('major') ####
# Selection: 1
# ✔ Adding files
# ✔ Making a commit with message 'Increment version number to 3.0.0'

## devtools::submit_cran() ####
# ── Submitting ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
# ℹ Path /tmp/RtmpmGXJBy/TreeRingShape_3.0.0.tar.gz
# ℹ File size: 3.4 Mb
#
# Ready to submit TreeRingShape (3.0.0) to CRAN?
#
#   1: Not yet
# 2: Of course
# 3: Nope
# Selection: 2
# ℹ Uploading package & comments
# ℹ Confirming submission
# ✔ Package submission successful
# ℹ Check your email for confirmation link.
# ! Don't forget to tag this release once accepted by CRAN
# ✔ Adding '^CRAN-SUBMISSION$' to '.Rbuildignore'
# ✔ Setting active project to '/home/i/8T/Dropbox/00D/00/ring/TreeRingShape'

# qpdf ####
#sudo apt-get update
#sudo apt-get install qpdf

## R CMD check --as-cran . ####
devtools::build_vignettes()
#TreeRingShape_3.0.1_R_x86_64-pc-linux-gnu.tar.gz
## resubmit　3.0.1　####
# TreeRingShape 3.0.1
#　* correct from 'seq.deg()' to 'seq_deg()' as s4 generic
## R CMD check --as-cran . ####
## sudo R CMD check --as-cran . ####
#　devtools::submit_cran()

# Authors@R: c(
#   person("Megumi", "ISHIDA", email = "ishidam@sanchikanri.com",
#          role = c("aut", "cph", "cre"),
#          comment = c(ORCID = "0000-0003-0978-5388")))
#devtools::install()
devtools::install(build_vignettes = TRUE)
library(TreeRingShape)
help(package = "TreeRingShape")
browseVignettes("TreeRingShape")

#devtools::build_vignettes("TreeRingShape")
#
#devtools::build_rmd("vignettes/TreeRingShape.Rmd")

# vinette ####
#usethis::use_vignette("TreeRingShape")

devtools::build_vignettes()

  # down sizing TR ####
  ## memory size ####
  print(object.size(TR), units="Mb")
  print(object.size(TR@L), units="Mb")
  print(object.size(TR@L2), units="Mb")
  print(object.size(TR@L_), units="Mb")

  ## output small TR ####
  if(0){
    TR_<-TR
    TR_@L_ <-data.frame(0)
    TR_@L2 <-list(0)
    print(object.size(TR_), units="Mb")
    TR<-TR_
    save(TR,file="TR.RData")
    save(TR,file="data/TR_compress.RData",compress=TRUE,compression_level = 9)
    # not effective >>> save(TR, file="./data/TR_compressed.RData", compress="xz", compression_level=9)
  }

# dir ####
  (f<-dir(".",pattern="*競合",recursive = T,all.files=T))
#file.remove(f)

#* checking package vignettes in ‘inst/doc’ ... WARNING
#  Directory 'inst/doc' does not exist.

#
  getwd()
  dir(,recursive = T,full.names = T)
  #git　delete rm -r .Rcheck ####
  # git rm -r ..Rcheck
  # git commit -m "Remove ..Rcheck directory"
  # git push origin main
  ####



  # file.copy ####
  dir("../Abies_277_h400")

  #
  system.file(".",pakage="TreeRingShape")

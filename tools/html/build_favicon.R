# build_favicon.R
# https://pkgdown.r-lib.org/articles/pkgdown.html

library(pkgdown)
usethis::use_pkgdown()
pkgdown::build_site()
usethis::use_pkgdown_github_pages()
dir()
pkgdown::build_favicons("docs/favicon.png")


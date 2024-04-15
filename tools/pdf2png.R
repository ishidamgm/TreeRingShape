# pdf2png.R

library(pdftools)


#' pdf2png
#'
#' @param pdf_file
#'
#' @return
#' @export
#'
#' @examples
#'
#' dir()
#' pdf2png("test2.pdf")
#' dir()
#'
pdf2png<-function(pdf_file,dpi=150){
  info <- pdf_info(pdf_file)
  for (i in 1:info$pages){
    bitmap <- pdf_render_page(pdf_file,dpi=dpi)
    png::writePNG(bitmap, paste0(substr(10000+i,2,999),".png"))
  }
}
pdf2png("test2.pdf")


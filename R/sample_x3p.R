#' Sample from an x3p object
#' 
#' @param x3p x3p object
#' @param m integer value - every mth value is included in the sample 
#' @param mY integer value - every mth value is included in the sample in x direction and every mYth value is included in y direction 
#' @param offset integer value between 0 and m-1 to specify offset of the sample
#' @param offsetY integer value between 0 and mY-1 to specify different offsets for x and y direction
#' @return down-sampled x3p object
#' @export
#' @examples
#' logo <- read_x3p(system.file("csafe-logo.x3p", package="x3ptools"))
#' dim(logo$surface.matrix)
#' # down-sample to one-fourth of the image:
#' logo4 <- sample_x3p(logo, m=4)
#' dim(logo4$surface.matrix)
#' \dontrun{
#' image_x3p(logo)
#' image_x3p(logo4)
#' }
sample_x3p <- function(x3p, m=2, mY=m, offset = 0, offsetY = offset) {
  stopifnot("x3p" %in% class(x3p))
  sizes <- dim(x3p$surface.matrix)
  seqx <- seq.int(from = 1+offset, to = sizes[1], by=m)
  seqy <- seq.int(from = 1+offsetY, to = sizes[2], by=mY)
  
  
  x3p$surface.matrix <- x3p$surface.matrix[seqx, seqy]
  if (!is.null(x3p$mask)) 
    x3p$mask <- x3p$mask[seqy, seqx]
  
  x3p$header.info$sizeX <- length(seqx)
  x3p$header.info$sizeY <- length(seqy)
  
  x3p$header.info$incrementX <- m*x3p$header.info$incrementX
  x3p$header.info$incrementY <- m*x3p$header.info$incrementY
  
  x3p$matrix.info$MatrixDimension$SizeX[[1]] <- x3p$header.info$sizeX
  x3p$matrix.info$MatrixDimension$SizeY[[1]] <- x3p$header.info$sizeY
  
  
  x3p
}
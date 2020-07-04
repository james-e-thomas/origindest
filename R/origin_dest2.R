origin_dest2 <- function(x, y) {
  colnames(x) <- paste0("origin_", colnames(x))
  colnames(y) <- paste0("dest_", colnames(y))
  rownames(x) <- c()
  rownames(y) <- c()
  y <- dplyr::mutate(y,
                     row_number = rownames(y),
                     row_number = as.numeric(row_number)
  )
  y2 <- as.data.frame(rep(1:nrow(x), nrow(y)))
  colnames(y2) <- "row_number2"
  y <- tidyr::uncount(y, nrow(x))
  y <- cbind.data.frame(y, y2)
  rm(y2)
  y <- dplyr::arrange(y, row_number2, row_number)
  x <- tidyr::uncount(x, nrow(y)/nrow(x))
  x <- cbind.data.frame(x, y)
  rm(y)
  rownames(x) <- c()
  x <- dplyr::select(x, !starts_with("row_number"))
}

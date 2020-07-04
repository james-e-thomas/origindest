origin_dest1 <- function(x) {
  colnames(x) <- paste0("origin_", colnames(x))
  x2 <- x
  colnames(x2) <- paste0("dest", colnames(x))
  colnames(x2) <- gsub("origin", "", colnames(x2))
  x <- cbind.data.frame(x, x2)
  rm(x2)
  rownames(x) <- c()
  x <- dplyr::mutate(x,
                     row_number = rownames(x),
                     row_number = as.numeric(row_number)
              )
  x <- tidyr::uncount(x, nrow(x))
  rownames(x) <- c()
  x2 <- as.data.frame(rep(1:sqrt(nrow(x)), sqrt(nrow(x))))
  colnames(x2) <- "row_number2"
  x <- cbind.data.frame(x, x2)
  rm(x2)
  x2 <- dplyr::select(x, !starts_with("origin_"))
  x <- dplyr::select(x, starts_with("origin_"))
  x2 <- dplyr::arrange(x2, row_number2, row_number)
  x <- cbind.data.frame(x, x2)
  rm(x2)
  x <- dplyr::filter(x, row_number != row_number2)
  x <- dplyr::select(x, !starts_with("row_number"))
}

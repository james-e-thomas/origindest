append_dest_origin <- function(x) {
  x2 <- dplyr::select(x, starts_with("dest_"), starts_with("origin_"))
  colnames(x2) <- gsub("dest_", "origindest_", colnames(x2))
  colnames(x2) <- gsub("origin_", "dest_", colnames(x2))
  colnames(x2) <- gsub("origindest_", "origin_", colnames(x2))
  x <- rbind.data.frame(x, x2)
  rm(x2)
  x
}

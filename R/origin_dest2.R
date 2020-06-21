function(x, y) {
  colnames(x) <- paste0("origin_", colnames(x))
  colnames(y) <- paste0("dest_", colnames(y))
  x <- uncount(x, nrow(y))
  y <- uncount(y, nrow(x)/nrow(y))
  y <- mutate(y, row_number = rownames(y))
  rownames(x) <- c()
  rownames(y) <- c()
  y <- mutate(y,
              row_number = gsub("^([0-9]+)$", "\\1\\.0", row_number),
              row_number2 = gsub("([0-9]+)(\\.)([0-9]+)", "\\1", row_number),
              row_number = gsub("([0-9]+)(\\.)([0-9]+)", "\\3", row_number),
              row_number = as.numeric(row_number),
              row_number2 = as.numeric(row_number2)
  )
  y <- arrange(y, row_number, row_number2)
  x <- cbind.data.frame(x, y)
  rm(y)
  x <- select(x, !starts_with("row_number"))
}

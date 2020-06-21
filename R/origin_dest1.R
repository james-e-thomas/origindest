function(x) {
  colnames(x) <- paste0("origin_", colnames(x))
  x2 <- x
  colnames(x2) <- paste0("dest", colnames(x))
  colnames(x2) <- gsub("origin", "", colnames(x2))
  x <- cbind.data.frame(x, x2)
  rm(x2)
  x <- uncount(x, nrow(x))
  x <- mutate(x, row_number = rownames(x))
  rownames(x) <- c()
  x <- mutate(x,
    row_number = gsub("^([0-9]+)$", "\\1\\.0", row_number),
    row_number2 = gsub("([0-9]+)(\\.)([0-9]+)", "\\1", row_number),
    row_number = gsub("([0-9]+)(\\.)([0-9]+)", "\\3", row_number),
    row_number = as.numeric(row_number),
    row_number2 = as.numeric(row_number2)
  )
  x2 <- select(x, !starts_with("origin_"))
  x <- select(x, starts_with("origin_"))
  x2 <- arrange(x2, row_number, row_number2)
  x <- cbind.data.frame(x, x2)
  rm(x2)
  x <- filter(x, row_number + 1 != row_number2)
  x <- select(x, !starts_with("row_number"))
}

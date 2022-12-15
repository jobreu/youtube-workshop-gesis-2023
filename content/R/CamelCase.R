# CamelCase function

## convert emoji names to CamelCase (if you want to learn (more) about CamelCase: https://en.wikipedia.org/wiki/Camel_case)
simpleCap <- function(x) {

  # Splitting the string
  splitted <- strsplit(x, " ")[[1]]

  # Pasting it back together with capital letters
  paste(toupper(substring(splitted, 1,1)), substring(splitted, 2),sep = "", collapse = " ")

}
# Function for replacing emojis in the comments

ReplaceEmoji <- function(x) {

  # install packages

  if ("remotes" %in% installed.packages() != TRUE) {
    install.packages("remotes")
  }
  if ("qdapRegex" %in% installed.packages() != TRUE) {
    install.packages("qdapRegex")
  }
  if ("emo" %in% installed.packages() != TRUE) {
    remotes::install_github("hadley/emo")
  }

  # load packages
  library(qdapRegex)
  library(emo)

  # source helper functions
  source("CamelCase.R")

  # import emoji list
  EmojiList <- jis

  CamelCaseEmojis <- lapply(jis$name, simpleCap)
  CollapsedEmojis <- lapply(CamelCaseEmojis, function(x){gsub(" ", "", x, fixed = TRUE)})
  EmojiList[,4]$name <- unlist(CollapsedEmojis)

  # order the list by the length of the string to avoid partial matching of shorter strings
  EmojiList <- EmojiList[rev(order(nchar(jis$emoji))),]

  # assign x to a new variable so we can save the progress in the for-loop (see below)
  New <- x

  # note: rm_default throws a warning on each iteration that we can ignore
  oldw <- getOption("warn")
  options(warn = -1)

  # cycle through the list and replace everything
  # we have to add clean = FALSE and trim = FALSE to avoid deleting whitespaces that are part of the pattern

  for (i in 1:dim(EmojiList)[1]){

    New <- rm_default(New, pattern = EmojiList[i,3],replacement = paste0("EMOJI_", EmojiList[i,4]$name, " "), fixed = TRUE, clean = FALSE, trim = FALSE)

  }

  # turn warning messages back on
  options(warn = oldw)

  # output result
  return(New)

}
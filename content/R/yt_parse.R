## YouTube parsing Script

# Note: This function will only work if the helper functions are in the same directory
# (CamelCase.R;ExtractEmoji.R;ReplaceEmoji.R)

yt_parse <- function(data){

  #### Setup

  # installing packages
  if ("remotes" %in% installed.packages() != TRUE) {
    install.packages("remotes")
  }
  if ("anytime" %in% installed.packages() != TRUE) {
    install.packages("anytime")
  }
  if ("qdapRegex" %in% installed.packages() != TRUE) {
    install.packages("qdapRegex")
  }
  if ("emo" %in% installed.packages() != TRUE) {
    remotes::install_github("hadley/emo")
  }

  # loading packages
  library(anytime)
  library(qdapRegex)
  library(emo)

  # sourcing helper functions
  source("CamelCase.R")
  source("ExtractEmoji.R")
  source("ReplaceEmoji.R")

  #### Data Preparation

  # accounting for dataframes without "parentId" column (those scraped with get_comments() instead of get_all_comments())

  if (is.null(data$parentId)) {

    parentId <- rep(NA,dim(data)[1])
    data <- cbind.data.frame(data,parentId)

  }

  # only keeping the relevant columns
  data <- data[,c("authorDisplayName","textOriginal","likeCount","publishedAt","updatedAt","parentId","id")]

  # convert dataframe columns to proper types
  data$authorDisplayName <- as.character(data$authorDisplayName)
  data$textOriginal <- as.character(data$textOriginal)
  data$likeCount <- as.numeric(data$likeCount)
  data$parentId <- as.character(data$parentId)
  data$id <- as.character(data$id)
  data$publishedAt <- anytime(data$publishedAt, asUTC = TRUE)
  data$updatedAt <- anytime(data$updatedAt, asUTC = TRUE)

  #### Emojis

  # Create a text column in which emojis are replaced by their textual descriptions
  # (This is handled by the helper function ReplaceEmoji)
  TextEmoRep <- ReplaceEmoji(data$textOriginal)

  # Create a text column in which emojis are deleted
  TextEmoDel <- ji_replace_all(data$textOriginal,"")

  # Create a column with only the textual descriptions of emojis for each comment
  Emoji <- sapply(TextEmoRep,ExtractEmoji)

  #### URLs

  # Extract URLs from comments
  Links <- rm_url(data$textOriginal, extract = TRUE)
  Links <- I(Links)

  #### Combine everything into one dataframe
  df <- cbind.data.frame(data$authorDisplayName,data$textOriginal,TextEmoRep,TextEmoDel,Emoji,data$likeCount,Links,data$publishedAt,data$updatedAt,data$parentId,data$id, stringsAsFactors = FALSE)
  names(df) <- c("Author","Text","TextEmojiReplaced","TextEmojiDeleted","Emoji","LikeCount","URL","Published","Updated","ParentId","CommentID")
  row.names(df) <- NULL

  #### return results
  return(df)

}
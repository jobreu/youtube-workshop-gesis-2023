# function for extracting Emoji from text

ExtractEmoji <- function(x){

  SpacerInsert <- gsub(" ","[{[SpAC0R]}]", x)
  ExtractEmoji <- rm_between(SpacerInsert,"EMOJI_","[{[SpAC0R]}]", fixed = TRUE, extract = TRUE, clean = FALSE, trim = FALSE, include.markers = TRUE)
  UnlistEmoji <- unlist(ExtractEmoji)
  DeleteSpacer <- sapply(UnlistEmoji,function(x){gsub("[{[SpAC0R]}]"," ",x,fixed = TRUE)})
  names(DeleteSpacer) <- NULL

  Emoji <-paste0(DeleteSpacer,collapse = "")
  return(Emoji)

}
# Notes:
# This function requires that the following packages are installed: 
#   - dplyr, stringr (both part of the tidyverse)
#   - hadley/emo & dill/emoGG from GitHub
# The function has two arguments: 
# x = the data frame with the frequencies
# n = the number of mappings to create
# The data frame containing the frequencies should be created using the `textstat_frequency()` function from the `quanteda.textstats` package
# The emoji names in the `feature` column of the frequency df should have the format "emoji_facewithtearsofjoy"
# Please note that this code has not been tested systematically. 
# Depending on which emojis are the most frequent for the video you look at, this function might not work because
# a) one of the emojis is not included in the emoji lookup table (which uses the `jis` data frame from the `emo` package or 
# b) the content in the `runes` column does not match the format/code that the `emoji` argument in the `geom_emoji` function from the `emoGG` package expects.

create_emoji_mappings <- function(x, n) {
  
  emoji_lookup <- emo::jis %>% 
    dplyr::select(runes, name) %>% 
    dplyr::mutate(runes = stringr::str_to_lower(runes),
           name = stringr::str_to_lower(name)) %>% 
    dplyr::mutate(name = stringr::str_replace_all(name, " ", "")) %>% 
    dplyr::mutate(name = paste0("emoji_", name))
  
  library(emoGG)
  
  for(i in 1:n){
    name <- paste0("mapping", i)
    assign(name,
           do.call(geom_emoji,list(data = x[i,],
                                   emoji = gsub("^0{2}","", strsplit(tolower(emoji_lookup$runes[emoji_lookup$name == as.character(x[i,]$feature)])," ")[[1]][1]))), envir = .GlobalEnv)
  }
}

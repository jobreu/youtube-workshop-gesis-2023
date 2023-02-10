# for transcripts generated with this tool for Chrome:
# https://github.com/kazuki-sf/YouTube_Summary_with_ChatGPT
# The extension can be used to copy the video transcript.
# This should then be stored in one .txt file per video.

# We need to set an option and load the stringr library before we use the function

options(encoding = "utf-8")
library(stringr)

# YT scripts parsing function

# This function reads in all .txt files from a given directory and creates a dataframe containing the following:
# timestamps, text lines, video name, video URL, video ID

read_scripts <- function(directory) {
  
  # Get a list of all .txt files in the directory
  files <- list.files(path = directory, pattern = "\\.txt$", full.names = TRUE)
  
  # Initialize an empty list to store the contents of the .txt files
  scripts <- list()
  
  # Initialize an empty vector to store the video URL from each .txt file
  url <- c()
  
  # Initialize an empty vector to store the video title from each .txt file
  title <- c()
  
  # Loop over the files and read each one, skipping the first 4 lines
  for (i in 1:length(files)) {
    file <- files[i]
    con <- file(file, "r")
    for (j in 1:4) {
      readLines(con, n = 1)
    }
    text <- readLines(con)
    close(con)
    
    # Add the contents of the file to the list 'scripts'
    scripts[[i]] <- text
    
    # Read the second line and add it to the 'url' vector
    con <- file(file, "r")
    readLines(con, n = 1)
    line2 <- readLines(con, n = 1)
    close(con)
    url <- c(url, rep(line2, length(text)))
    
    # Read the first line and add it to the 'title' vector
    con <- file(file, "r")
    line1 <- readLines(con, n = 1)
    close(con)
    title <- c(title, rep(line1, length(text)))
  }
  
  # Transform the 'scripts' list into a dataframe with one column named 'line'
  scripts_df <- do.call(rbind, lapply(scripts, data.frame, stringsAsFactors = FALSE))
  colnames(scripts_df) <- "line"
  
  # Add the 'url' & 'title' vectors to the 'scripts' dataframe
  scripts_df$url <- url
  scripts_df$title <- title
  
  # Extract the video ID from video URL
  scripts_df$videoID <- gsub(".*v=", "", scripts_df$url)
  
  # Separate the timestamp and the remaining text in the 'line' variable
  scripts_df$text <- gsub("\\(.*?\\)\\s+", "", scripts_df$line)
  scripts_df$timestamp <- regmatches(scripts_df$line, regexpr("\\(\\d{2}:\\d{2}\\)", scripts_df$line))
  scripts_df$timestamp <- sapply(scripts_df$timestamp, function(x) x[1])
  
  # Remove excess whitespaces from the text
  scripts_df$text <- stringr::str_squish(scripts_df$text)
  
  # Deselect the line column
  scripts_df <- subset(scripts_df, select = -c(line))
  
  # Change the column order
  scripts_df <- scripts_df[, c(5, 4, 2, 1, 3)]
  
  return(scripts_df)
  
}
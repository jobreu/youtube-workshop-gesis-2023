# DISCLAIMER: Due to a change in the YouTube API, the get_captions function from the tuber package only works for videos created with the account that the app used for API access was created with
# If you want to collect subtitles for videos that you did not create yourself, you should use the youtubecaption package (see below)

#### Setup ####

# Before doing anything else, please run the script "Authentication.R" first

# Install & load packages
if (!require(youtubecaption)) install.packages("youtubecaption") # Easier option for getting captions; needs Anaconda
if (!require(remotes)) install.packages("remotes") # for installation from GitHub
if (!require(tuber)) remotes::install_github("soodoku/tuber") # YouTube data
if (!require(subtools)) remotes::install_github("fkeck/subtools") # Subtitle processing
if (!require(stm)) install.packages("stm") # Functions for structural topic models (used here for text processing)
if (!require(tm)) install.packages("tm") # package required for stm

library(youtubecaption)
library(tuber)
library(subtools)
library(stm)
library(tm)

## Upon running this line, there will be a prompt in the console asking you to save the access token in a file
## Select "No" by entering 2 in the console and hitting enter.
## Afterwards, a browser window should open, prompting you to log in with your Google account
## After logging in, you can close the browser and return to R
yt_oauth(appID,appSecret, token = "")

#### Extracting Subtitles ####
# Get video info including the subtitles id
Caption_list1 <- list_caption_tracks(video_id = "nI_OfkQOG6Q") # Video with 1 set of subtitles
Caption_list2 <- list_caption_tracks(video_id = "C0AY3AN5kI4") # video with 1 automatically created set of subtitles (ASR)
Caption_list3 <- list_caption_tracks(video_id = "3TNkWTRNNYE") # video with 2 sets of substitles -> 400 error
Caption_list4 <- list_caption_tracks(video_id = "j93NnRLyym0") # ASR exists, but cannot be selected
Caption_list5 <- list_caption_tracks(video_id = "YgWgHRjv_Ps") # ARS exists, but no subs displayed
Caption_list6 <- list_caption_tracks(video_id = "OuO135_5Rxk") # ARS exists, but no subs displayed

# Example with Video 3
# Extract the IDs
ID_ASR <- Caption_list3[1,"id"] # automatically created subtitle
ID_DE <- Caption_list3[2,"id"] # German subtitle

# Retrieve the subtitles (format=raw)
Text_ASR <- rawToChar(get_captions(id = ID_ASR, format = "sbv")) # automatically created subtitle
Text_DE <- rawToChar(get_captions(id = ID_DE, format = "sbv")) # German subtitle (translated per default)
Text_GER <- rawToChar(get_captions(id = ID_DE, format = "sbv", lang = "de")) # German subtitle (in German)

# Known Issues
# 1. Videos can have more than one subtitle for the same language
# 2. If the video has disabled third-party contributions for the subtitles, the query will result in a 403 error
#  https://stackoverflow.com/questions/30653865/downloading-captions-always-returns-a-403

# Write readable subtitles to file because subtools cannot read from variables
write(Text_ASR, file = "Captions_ASR.sbv", sep="\n") 
write(Text_DE, file = "Captions_DE.sbv", sep="\n")
write(Text_GER, file = "Captions_GER.sbv", sep="\n")

# Read the subtitles file and convert it into a subtools object
Subs_ASR <- read_subtitles("Captions_ASR.sbv", format = "subviewer") 
Subs_DE <- read_subtitles("Captions_DE.sbv", format = "subviewer")
Subs_GER <- read_subtitles("Captions_GER.sbv", format = "subviewer")

# Retrieve text data from the subtools object
Subtext_ASR <- get_raw_text(Subs_ASR)
Subtext_DE <- get_raw_text(Subs_DE)
Subtext_GER <- get_raw_text(Subs_GER)

# Display results
Subtext_ASR
Subtext_DE
Subtext_GER

#### Processing Subtitles (note: could also be done with quanteda) ####
processed_tuber <- textProcessor(Subtext_GER,
                                 metadata = NULL,
                                 lowercase = TRUE,
                                 removestopwords = TRUE,
                                 removenumbers = TRUE, 
                                 removepunctuation = TRUE,
                                 stem = TRUE, 
                                 wordLengths = c(3, Inf), 
                                 sparselevel = 1, 
                                 language = "en", 
                                 verbose = TRUE,
                                 onlycharacter = FALSE, 
                                 striphtml = FALSE, 
                                 customstopwords = NULL) # cleaning up and converting to stm format

ut_tuber <- prepDocuments(processed_tuber$documents,
                          processed_tuber$vocab,
                          processed_tuber$meta,
                          lower.thresh = 0,
                          upper.thresh = Inf,
                          subsample = NULL,
                          verbose = TRUE) # Preparing processed texts; if there is more than one document, adjust lower.thresh

# Display results
out_tuber[["vocab"]]

# Simpler solution with the youtubecaption package (NB: this requires an Anaconda installation)
# Store full URL in a variable

url <- "https://www.youtube.com/watch?v=3TNkWTRNNYE"

# Get captions for that video and assign it to an object
caption <- get_caption(url)
# You will receive an error message because the default is English captions "en", but this video has none

# Try German captions
caption <- get_caption(url, language = "de")

# Show resulting dataframe
caption
# You will see that these are the manual German captions. 
# There is no way of selecting the automatically created German captions because they are also labeled as "de".
# Save the captions as an Excel file and open it right away:
get_caption(url = url,
            language = "de",
            savexl = TRUE,
            openxl = TRUE)

# Process caption texts
processed_caption <- textProcessor(caption,
                                   metadata = NULL,
                                   lowercase = TRUE,
                                   removestopwords = TRUE,
                                   removenumbers = TRUE,
                                   removepunctuation = TRUE,
                                   stem = TRUE, 
                                   wordLengths = c(3, Inf), 
                                   sparselevel = 1, 
                                   language = "en",
                                   verbose = TRUE,
                                   onlycharacter = FALSE,
                                   striphtml = FALSE,
                                   customstopwords = NULL) # Cleaning up and converting to stm format

out_caption <- prepDocuments(processed_caption$documents,
                             processed_caption$vocab,
                             processed_caption$meta,
                             lower.thresh = 0,
                             upper.thresh = Inf,
                             subsample = NULL,
                             verbose = TRUE) # Preparing processed texts; if there is more than one document, adjust lower.thresh
out_caption[["vocab"]]

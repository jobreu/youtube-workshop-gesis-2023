# check if packages are installed and install them if that is not the case
packages <- c("remotes",
              "tuber",
              "keyring",
              "tidyverse",
              "anytime",
              "qdapRegex",
              "vosonSML",
              "lexicon",
              "syuzhet",
              "ggcorrplot",
              "sentimentr",
              "quanteda",
              "quanteda.textstats",
              "wordcloud")

install.packages(setdiff(packages,
                         rownames(installed.packages())))

# some packages need to be installed from GitHub
library(remotes)

install_github("hadley/emo")
install_github("dill/emoGG")
install_github("jooyoungseo/youtubecaption")
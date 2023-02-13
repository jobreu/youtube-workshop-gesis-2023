# Workshop "Automatic Sampling and Analysis of YouTube Comments", GESIS 2023
Materials for the 2023 *GESIS Training* workshop "Automatic Sampling and Analysis of YouTube Comments"

[Johannes Breuer](https://www.johannesbreuer.com/) ([johannes.breuer@gesis.org](mailto:johannes.breuer@gesis.org), [\@MattEagle09](https://twitter.com/MattEagle09)); [Annika Deubel](https://www.cais-research.de/team/annika-deubel/) ([annika.deubel@cais-research.de](mailto:annika.deubel@cais-research.de), [\@anndeub](https://twitter.com/anndeub)); [M. Rohangis Mohseni](https://www.researchgate.net/profile/M-Mohseni) ([Rohangis.Mohseni@tu-ilmenau.de](mailto:Rohangis.Mohseni@tu-ilmenau.de), [\@romohseni](https://twitter.com/romohseni))

[![](https://licensebuttons.net/l/by/3.0/80x15.png)](https://creativecommons.org/licenses/by/4.0/) 
Please link to the [workshop GitHub repository](https://github.com/jobreu/youtube-workshop-gesis-2023)

---

## Workshop description

*YouTube* is the largest and most popular video platform on the internet. The producers and users of *YouTube* content generate huge amounts of data. These data are also of interest to researchers (in the social sciences as well as other disciplines) for studying different aspects of online media use and communication. Accessing and working with these data, however, can be challenging. In this workshop, we will first discuss the potential of *YouTube* data for research in the social sciences, and then introduce participants to different tools and methods for sampling and analyzing data from *YouTube*. We will then demonstrate and compare several tools for collecting *YouTube* data. Our focus for the main part of the workshop will be on using the `R` to collect data via the [YouTube API](https://developers.google.com/youtube), process, and analyze it. Regarding the type of data, we will focus on user comments but also will also (briefly) look into other *YouTube* data, such as video statistics and subtitles. For the comments, we will show how to clean/process them in `R`, how to deal with emojis, and how to do some basic forms of automated text analysis (e.g., word frequencies, sentiment analysis). While we believe that *YouTube* data has great potential for research in the social sciences (and other disciplines), we will also discuss the unique challenges and limitations of using this data.

## Target group

The workshop is aimed at people who are interested in using *YouTube* data for their research. 

## Learning objectives

Participants will learn how they can use *YouTube* data for their research. They will get to know tools and methods for collecting *YouTube* data. By the end of the workshop, participants should be able to...
- automatically collect *YouTube* data
- process/clean it
- do some basic (exploratory) analyses of user comments

## Prerequisites

Participants should at least have some basic knowledge of `R` and, ideally, also the [`tidyverse`](https://www.tidyverse.org/). Basic `R` knowledge can, for example, be acquired through the *swirl* course "R Programming" (see https://swirlstats.com/) or the [*RStudio* Primer "Programming basics"](https://rstudio.cloud/learn/primers/1.2), both of which are available for free. There also are many brief online introductions to the `tidyverse`, such as this [blog post by Dominic Royé](https://dominicroye.github.io/en/2020/a-very-short-introduction-to-tidyverse/) or this [workshop by Olivier Gimenez](https://oliviergimenez.github.io/intro_tidyverse/#1).

For the exercises as well as for "coding along" with the slides, access to the *YouTube* API is required. Information on this can be found in the slides on the [*YouTube* API Setup](https://jobreu.github.io/youtube-workshop-gesis-2023/slides/A0_YouTubeAPISetup.html).

## Timetable & content

### Day 1

| Time | Topic | Slides | Exercises | Solutions |
| ---: | :---- | :----: | :-------: | :-------: |
| 09:00 - 10:00 | Introduction | [HTML](https://jobreu.github.io/youtube-workshop-gesis-2023/slides/A1_Intro.html), [PDF](https://raw.githubusercontent.com/jobreu/youtube-workshop-gesis-2023/main/slides/A1_Intro.pdf) | - | - |
| 10:00 - 11:00 | The YouTube API | [HTML](https://jobreu.github.io/youtube-workshop-gesis-2023/slides/A2_The_YouTube_API.html), [PDF](https://raw.githubusercontent.com/jobreu/youtube-workshop-gesis-2023/main/slides/A2_The_YouTube_API.pdf) | [HTML](https://jobreu.github.io/youtube-workshop-gesis-2023/exercises/Exercise_A2_The_YouTube_API.html) | [HTML](https://jobreu.github.io/youtube-workshop-gesis-2023/solutions/Exercise_A2_The_YouTube_API.html) |
| 11:00 - 11:15 | *Coffee Break* | - | - | - |
| 11:15 - 12:15 | Tools for collecting YouTube data | [HTML](https://jobreu.github.io/youtube-workshop-gesis-2023/slides/A3_Tools_for_collecting_YouTube_data.html), [PDF](https://raw.githubusercontent.com/jobreu/youtube-workshop-gesis-2023/main/slides/A3_Tools_for_collecting_YouTube_data.pdf) | - | - |
| 12:15 - 13:15 | *Lunch Break* | - | - | - |
| 13:15 - 14:45 | Collecting YouTube data with R | [HTML](https://jobreu.github.io/youtube-workshop-gesis-2023/slides/A4_Collecting_YouTube_data_with_R.html), [PDF](https://raw.githubusercontent.com/jobreu/youtube-workshop-gesis-2023/main/slides/A4_Collecting_YouTube_data_with_R.pdf) | [HTML](https://jobreu.github.io/youtube-workshop-gesis-2023/exercises/Exercise_A4_Collecting_YouTube_data_with_R.html) | [HTML](https://jobreu.github.io/youtube-workshop-gesis-2023/solutions/Exercise_A4_Collecting_YouTube_data_with_R.html) |
| 14:45 - 15:00 | *Coffee Break* | - | - | - |
| 15:00 - 16:30 | Processing and cleaning user comments | [HTML](https://jobreu.github.io/youtube-workshop-gesis-2023/slides/A5_Processing_and_Cleaning_User_Comments.html), [PDF](https://raw.githubusercontent.com/jobreu/youtube-workshop-gesis-2023/main/slides/A5_Processing_and_Cleaning_User_Comments.pdf) | [HTML](https://jobreu.github.io/youtube-workshop-gesis-2023/exercises/Exercise_A5_Processing_and_cleaning_user_comments.html) | [HTML](https://jobreu.github.io/youtube-workshop-gesis-2023/solutions/Exercise_A5_Processing_and_cleaning_user_comments.html) |

### Day 2

| Time | Topic | Slides | Exercises | Solutions |
| ---: | :---- | :----: | :-------: | :-------: |
| 09:00 - 10:15 | Basic text analysis of user comments | [HTML](https://jobreu.github.io/youtube-workshop-gesis-2023/slides/B1_Basic_text_analysis_of_user_comments.html), [PDF](https://raw.githubusercontent.com/jobreu/youtube-workshop-gesis-2023/main/slides/B1_Basic_text_analysis_of_user_comments.pdf) | [HTML](https://jobreu.github.io/youtube-workshop-gesis-2023/exercises/Exercise_B1_Basic_text_analysis_of_user_comments.html) | [HTML](https://jobreu.github.io/youtube-workshop-gesis-2023/solutions/Exercise_B1_Basic_text_analysis_of_user_comments.html) |
| 10:15 - 10:30 | *Coffee Break* | - | - | - |
| 11:15 - 12:15 | Sentiment analysis of user comments | [HTML](https://jobreu.github.io/youtube-workshop-gesis-2023/slides/B2_Sentiment_Analysis_of_User_Comments.html), [PDF](https://raw.githubusercontent.com/jobreu/youtube-workshop-gesis-2023/main/slides/B2_Sentiment_Analysis_of_User_Comments.pdf) | [HTML](https://jobreu.github.io/youtube-workshop-gesis-2023/exercises/Exercise_B2_Sentiment_analysis_of_user_comments.html) | [HTML](https://jobreu.github.io/youtube-workshop-gesis-2023/solutions/Exercise_B2_Sentiment_analysis_of_user_comments.html) |
| 12:00 - 13:00 | *Lunch Break* | - | - | - |
| 13:00 - 14:00 | Excursus: Retrieving video subtitles | [HTML](https://jobreu.github.io/youtube-workshop-gesis-2023/slides/B3_Retrieving_Video_Subtitles.html), [PDF](https://raw.githubusercontent.com/jobreu/youtube-workshop-gesis-2023/main/slides/B3_Retrieving_Video_Subtitles.pdf) | - | - |
| 14:00 - 14:15 | *Coffee Break* | - | - | - |
| 15:00 - 16:30 | Recap, outlook, practice | [HTML](https://jobreu.github.io/youtube-workshop-gesis-2023/slides/B4_Recap_Outlook_Practice.html), [PDF](https://raw.githubusercontent.com/jobreu/youtube-workshop-gesis-2023/main/slides/B4_Recap_Outlook_Practice.pdf) | - | - |

## Acknowledgements

Parts of the content have been developed by [Julian Kohne](https://www.juliankohne.com/) for a previous version of this workshop. The materials (slides, exercises, etc.) have been using the `R` packages [`xaringan`](https://github.com/yihui/xaringan), [`unilur`](https://koncina.github.io/unilur/), and [`woRkshoptools`](https://github.com/StefanJuenger/woRkshoptools).
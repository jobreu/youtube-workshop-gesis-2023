# taken & adapted from the development version of tuber on Feb 22nd, 2022 (https://github.com/soodoku/tuber)
# see this commit: https://github.com/soodoku/tuber/commit/42a8131098856c8aeb0fcbad70ed5f0e33b9652b

conditional_unnest_wider <- function(data_input, var) {
  if (var %in% names(data_input)) {
    tidyr::unnest_wider(data_input, var, names_sep = "_")
  } else {
    data_input
  }
}


video_details_to_df <- function(res) {
  intermediate <- res %>%
    tibble::enframe() %>%
    tidyr::pivot_wider() %>%
    tidyr::unnest(cols = c(kind, etag)) %>%
    # reflect level of nesting in column name
    dplyr::rename(response_kind = kind, response_etag = etag) %>%
    tidyr::unnest(items) %>%
    tidyr::unnest_wider(col = items) %>%
    # reflect level of nesting in column name for those that may not be unique
    dplyr::rename(items_kind = kind, items_etag = etag) %>%
    tidyr::unnest_wider(snippet)
  
  intermediate_2 <- intermediate %>%
    # fields that may not be available:
    # live streaming details
    conditional_unnest_wider(var = "liveStreamingDetails") %>%
    # region restriction (rental videos)
    conditional_unnest_wider(var = "regionRestriction") %>%
    conditional_unnest_wider(var = "regionRestriction_allowed") %>%
    # statistics
    conditional_unnest_wider(var = "statistics") %>%
    # status
    conditional_unnest_wider(var = "status") %>%
    # player
    conditional_unnest_wider(var = "player") %>%
    # contentDetails
    conditional_unnest_wider(var = "contentDetails") %>%
    conditional_unnest_wider(var = "topicDetails") %>%
    conditional_unnest_wider(var = "localized") %>%
    conditional_unnest_wider(var = "pageInfo") %>%
    # thumbnails
    conditional_unnest_wider(var = "thumbnails") %>%
    conditional_unnest_wider(var = "thumbnails_default") %>%
    conditional_unnest_wider(var = "thumbnails_standard") %>%
    conditional_unnest_wider(var = "thumbnails_medium") %>%
    conditional_unnest_wider(var = "thumbnails_high") %>%
    conditional_unnest_wider(var = "thumbnails_maxres")
  
  
  intermediate_2
}
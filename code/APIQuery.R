###############################################################################
#
# RStackExchange / John Horton
# oDesk Contract #13552832
#
# Authors:
# Alexander Gedranovich
# John Horton 
# Created: 2014-11-03
#
# Code style follows 'Google R Style Guide'
# https://google-styleguide.googlecode.com/svn/trunk/Rguide.xml
###############################################################################

APIQuery <- function(path, site = "stackoverflow", .order = "desc", 
                     .sort = "activity", .page = 1, .pagesize = 100,
                     .fromdate = NULL, .todate = NULL) {
  # General low-level function to query StackExchange API
  # 
  # Args:
  #   path:
  #   .order:
  #   .sort:
  #   ...
  # 
  # Returns:
  #   JSON...
  
  stopifnot(!missing(path))
  stopifnot(.order %in% c("desc", "asc"))
  stopifnot(.sort %in% c("activity", "votes", "creation", "hot",
                         "week", "month"))
  
  # Basic query parameters
  query <- list(
    key = "AG4IMJa4g9zxDYSJF8gckg((",
    site = site,
    order = .order,
    sort = .sort,
    page = .page,
    pagesize = .pagesize)
  
  # Tries to get dates
  .fromdate <- as.epoch(.fromdate)
  .todate <- as.epoch(.todate)
  
  # Extends query
  if (!is.null(.fromdate)) {
    query$fromdate <- .fromdate
  }
  
  if (!is.null(.todate)) {
    query$fromdate <- .todate
  }
  
  # Send request
  response <- 
    GET("http://api.stackexchange.com/2.2", 
        accept_json(),
        path = path,
        query = query
    )
  stop_for_status(response)
  
  # Returns results
  answer <- content(response, as = "parsed", type = "application/json")
  answer
}


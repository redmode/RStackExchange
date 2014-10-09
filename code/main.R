###############################################################################
#
# RStackExchange / John Horton
# oDesk Contract #13552832
#
# Prototyping code
#
# Authors:
# Alexander Gedranovich
# John Horton 
# Created: 2014-10-08
#
# Code style follows 'Google R Style Guide'
# https://google-styleguide.googlecode.com/svn/trunk/Rguide.xml
###############################################################################

rm(list = ls(all = TRUE))
gc(reset = TRUE)
set.seed(12345)

library(stringr)
library(dplyr)

OnlineQuery <- function(query.id, params = NULL, site = "stackoverflow") {
  # Returns CSV data file for given query ID
  # Uses StackExchange Data Explorer
  # 
  # Args:
  #   query.id: ID for query at http://data.stackexchange.com
  #   params: named character vector or list with query parameters
  #   site: name of one of the StackExchange site
  
  stopifnot(!missing(query.id))
  
  se.url <- sprintf("http://data.stackexchange.com/%s/csv/%d", 
                    site, query.id)
  
  if (!is.null(params)) {
    params <- sprintf("?%s", str_c(names(params), "=", unlist(params),
                                    collapse = "&"))
    params <- str_replace(params, ",", "%2C")
    params <- str_replace(params, " ", "%20")
    se.url <- str_c(se.url, params)
  }
  
  df <- tryCatch(read.table(se.url, header = T, sep = ",") %>% tbl_df(), 
                 error = function(e) {
                   warning(e)
                   return(NULL)
                 })
  df
}


# Tests for Online ------------------------------------------------------------

# Non-parametric
df <- OnlineQuery(952)
df

# One parameter
df <- OnlineQuery(785, params = list(UserId = "1796914"))
df

df <- OnlineQuery(785, params = c(UserId = "1796914"))
df

df <- OnlineQuery(8116, params = list(UserId = "1796914"))
df

# Created for this test (last 100 closed questions)
df <- OnlineQuery(303686)
df

# Wrong query
df <- OnlineQuery(-1)
df


# Tests for SQL ---------------------------------------------------------------

# sql <- "SELECT TOP 10 Id, DisplayName, Reputation 
#         FROM Users
#         ORDER BY Reputation DESC"
# url <- "http://data.stackexchange.com/stackoverflow/new/query/save/1"
# 
# 
# 
# library(httr)
# 
# 
# api <- sprintf("%s?sql='%s'", url, sql)
# 
# 
# # Makes request
# response <- POST(url, 
# #                  accept_json(),
# #                  add_headers(.indicoio$header),
#                  body = list(sql = sql)
# )
# stop_for_status(response)
# 
# # Returns results
# answer <- content(response, as = "parsed", type = "application/json")
# if (length(answer) < 2) {
#   stop("Invalid result from API!")
# }
# answer
# 
# library(RCurl)
# postForm(url, sql = sql)


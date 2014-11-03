###############################################################################
#
# RStackExchange / John Horton
# oDesk Contract #13552832
#
# Authors:
# Alexander Gedranovich
# John Horton 
# Created: 2014-11-02
#
# Code style follows 'Google R Style Guide'
# https://google-styleguide.googlecode.com/svn/trunk/Rguide.xml
###############################################################################

OnlineQuery <- function(query.id, params = NULL, site = "stackoverflow", ...) {
  # Returns CSV data file for given query ID
  # Uses StackExchange Data Explorer
  # 
  # Args:
  #   query.id: ID for query at http://data.stackexchange.com
  #   params: named character vector or list with query parameters
  #   site: name of one of the StackExchange site
  #   ...: additional arguments to 'read.table'
  #
  # Returns:
  #   data.frame with query results (as read from CSV file)
  
  stopifnot(!missing(query.id))
  stopifnot(str_trim(site) != "")
  
  se.url <- sprintf("http://data.stackexchange.com/%s/csv/%d", 
                    site, query.id)
  
  if (!is.null(params)) {
    params <- sprintf("?%s", str_c(names(params), "=", unlist(params),
                                    collapse = "&"))
    params <- str_replace(params, ",", "%2C")
    params <- str_replace(params, " ", "%20")
    se.url <- str_c(se.url, params)
  }
  
  df <- tryCatch(read.table(se.url, header = T, sep = ",", ...) %>% tbl_df(), 
                 error = function(e) {
                   warning(e)
                   return(NULL)
                 })
  df
}


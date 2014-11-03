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

as.epoch <- function(s) {
  # Helper function to convert string to epoch time
  # 
  # Args:
  #   s: ...
  
  if (is.null(s) || is.na(s)) {
    return(NULL)
  }
  
  formats <- c("%Y-%m-%d", "%Y-%m-%d %H:%M:%S")
  
  epoch <- sapply(formats, function(f) {
    as.integer(as.POSIXct(strptime(s, f)))
  }, simplify = TRUE, USE.NAMES = FALSE)
  
  if (!any(!is.na(epoch))) {
    stop(sprintf("Can't convert '%s' to epoch time!", s))
  }
  
  epoch[which(!is.na(epoch))[1]]
}
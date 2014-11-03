###############################################################################
#
# RStackExchange / John Horton
# oDesk Contract #13552832
#
# Main code
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
library(httr)

source("code/utils.R")
source("code/OnlineQuery.R")
source("code/APIQuery.R")

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


# Test API---------------------------------------------------------------------

APIQuery(path = "questions")

APIQuery(path = "answers", .fromdate = "2014-11-01")



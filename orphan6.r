require(XML); require(RCurl); require(RJSONIO); require(plyr)
require(devtools)
require(testthat)
install_github("ritis", "ropensci")
require(ritis)

require(roxygen2)
roxygenize("/Users/ScottMac/github/vijaybarve/rgbif")
roxygenize("/Users/ScottMac/github/schamberlain/rwikispeedia")
roxygenize("/Users/ScottMac/github/ropensci/rbhl")
check("/Users/ScottMac/github/rOpenSciGSoCTest")
run_examples("/Users/ScottMac/github/rOpenSci/rplos")

install.packages("devtools")
require(devtools)
install_github("dryad", "rOpenSci")
require(citeulike)
totimp


roxygenize("/Users/ScottMac/github/SChamberlain/govdat")
check("/Users/ScottMac/github/SChamberlain/govdat")
install_github("govdat", "SChamberlain")
require(govdat)
help(govdat)
sll_cw_dates(phrase='I would have voted', start_date='2001-01-20',
   end_date='2009-01-20', granularity='year', party='D', percentages=TRUE,
   printdf=TRUE)


require(devtools)
install_github("dryad", "ropensci")
require(dryad)


roxygenize("/Users/ScottMac/github/rOpenSci/taxize_")
require(devtools)
install_github("taxize_", "ropensci")
require(taxize)
require(roxygen2)
roxygenize("/Users/ScottMac/github/SChamberlain/rwikispeedia")

require(devtools)
install_github("rdryad","ropensci","master")
require(rdryad)

require(plyr)

install_github("test_that","hadley","master")
require(testthat)

roxygenize("/Users/ScottMac/github/rOpenSci/rgbif")
setwd("/Users/ScottMac/github/rOpenSci/rplos")
build("/Users/ScottMac/github/rOpenSci/rplos")
build("/Users/ScottMac/github/rOpenSci/rplos", binary=T)
build_win("/Users/ScottMac/github/rOpenSci/rplos")
# install("/Users/ScottMac/github/rOpenSci/rplos_0.0-1.tar.gz")
check("/Users/ScottMac/github/rOpenSci/rgbif")
# run_examples("/Users/ScottMac/github/rOpenSci/rplos")
# run_examples("/Users/ScottMac/github/rOpenSci/rplos", start="plot_throughtime.Rd")
release("/Users/ScottMac/github/rOpenSci/rgbif", check = TRUE)

?almplosallviews
# ?almplosallviewsdf
?almplotallviews
?almpub
?almpubmedcentid
?almpubmedid
?almtitle
?almtotcites
?almupdated
?articlelength
# ?browsepaper
?crossref
?formatarticleurl
?plosabstract
?plosauthor
?plosfigtabcaps
?plossubject
?plostitle
?plosviews
?plosword
?plot_throughtime
?searchplos

setwd("private/var/folders/c6/d88zcms97dg5y_jvf3263f8r0000gn/T/Rtmp5kD5ZN/rplos.Rcheck")
setwd("/Users/ScottMac/github/SChamberlain/schamberlain.github.com/_posts")
newdir <- "/Users/ScottMac/github/SChamberlain/schamberlain.github.com/_posts/new"
require(plyr); require(stringr)

files <- dir()
# a <- readLines("2011-03-13-species-abundance-distributions-and-basketball.html")
fileslist <- llply(files, readLines)
# grep("layout: ", a)
laply(fileslist, grep, pattern="time: ")

# x <- fileslist[[30]]
replaceem <- function(x) {
  x[3] <- "layout: post"
  x[6] <- "categories: "
  x[5] <- str_replace(x[5], "time", "date")
  x
}
# replaceem(fileslist[[40]])

fileslistnew <- llply(fileslist, replaceem)
# writeLines(c(a,a), "~/new.html")
writeem <- function(x) {
  writeLines(x, con=paste(newdir, '/', , '.markdown', sep=''))
}
# l_ply(filestlistnew, writeem)


files2 <- str_replace(files, ".html", ".markdown")

for(i in 1:length(files2)) {
    writeLines(fileslistnew[[i]], con=paste(newdir, '/', files2[i], sep=''))
}
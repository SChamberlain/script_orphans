require(stringr)
files <- dir("/Users/ScottMac/github/SChamberlain/toedit2/")
filespaths <- paste(
	"/Users/ScottMac/github/SChamberlain/schamberlain.github.com/_posts/", 
	files, sep="")
# newpaths <- paste(
# 	"/Users/ScottMac/github/SChamberlain/schamberlain.github.com/_posts/use/", 
# 	files, sep="")
filespaths[[1]]
require(plyr)
# x <- filespaths[[3]]
reformat <- function(x, write) {
	y <- paste(
		"/Users/ScottMac/github/SChamberlain/schamberlain.github.com/_posts/toedit/", 
		x, sep="")
	temp <- readLines(y)
	yaml <- temp[grep("---", temp)[[1]]:grep("---", temp)[[2]]]
	yaml2 <- yaml[-c(grep("name:", yaml), grep("author:", yaml))]
	yaml2[grep("categories:", yaml2)] <- "tags: "
	if(identical(grep("- [A-Za-z]+", yaml2), integer(0))==TRUE){yaml2<-yaml2} else
		{
			yaml2 <- yaml2[-grep("- [A-Za-z]+", yaml2)]
			tags <- paste(str_trim(str_replace(yaml[grep("- [A-Za-z]+", yaml)], "-", ""), "both"), collapse=" ")
			yaml2[grep("tags:", yaml2)] <- paste("tags: ", tags, sep="")
		}
	newpost <- temp[-c(grep("---", temp)[[1]]:grep("---", temp)[[2]])]
	author <- paste("Written by ~ ", 
		str_trim(str_split(temp[grep("author: ", temp)], ":")[[1]][[2]], "both"),
		sep="")
	out <- c(yaml2, "", author, newpost)
	if(write==TRUE){
		writeLines(out, paste(
		"/Users/ScottMac/github/SChamberlain/schamberlain.github.com/_posts/use/", 
		x, sep=""))
	} else
		{out}
}
l_ply(files, reformat, write=TRUE)
reformat(files[[3]], write=TRUE)



x <- files[[3]]
notilda <- function(x, write) {
	y <- paste(
		"/Users/ScottMac/github/SChamberlain/toedit2/", 
		x, sep="")
	temp <- readLines(y)
	out <- str_replace(temp, "~", "")
	if(write==TRUE){
		writeLines(out, paste(
			"/Users/ScottMac/github/SChamberlain/toedit2/notilda/", 
			x, sep=""))
	} else
		{out}
}
l_ply(files, notilda, write=TRUE)
notilda(files[[87]], write=FALSE)
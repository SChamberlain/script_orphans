# Phylopic in R
# library(ape); library(png); library(httr); library(RCurl)
# library(ggplot2); library(png); library(gridExtra)

# output <- content(GET("http://phylopic.org/api/a/name/search?text=Homo sapiens&options=names"))
# lapply(output$result, function(y) sapply(y, function(x) x[[1]][[1]]))

#' Text search for uuids
#' 
#' These aren't necessarily ones with images though. See example
#' @import 
#' @param text 
#' @param options 
#' @examples
#' search_text(text = "Homo sapiens", options = "names")
search_text <- function(text, options){
  url <- "http://phylopic.org/api/a/name/search"
  args <- compact(list(text = text, options = options))
  output <- content(GET(url, query=args), as="text")
  stuff <- RJSONIO::fromJSON(output)$result
  uuids <- as.character(do.call(c, sapply(stuff, function(x) x[[1]], simplify=TRUE)))
  return( uuids )  
}

#' Search for images for the taxa
#' 
#' @import httr plyr
#' @param uuid The UUID of the taxonomic name.
#' @param subtaxa If set to "true", includes subtaxa in the search.
#' @param supertaxa If not set to "false", includes supertaxa in the search.
#' @param options Space-separated list of options for the result value.
#' @param cleanoutput If TRUE, remove elements with no data.
#' @examples 
#' someuuids <- search_text(text = "Homo sapiens", options = "names")
#' search_images(uuid=someuuids[[12]], options=c("pngFiles", "credit", "canonicalName"))
#' 
#' # all of them
#' search_images(uuid=someuuids, options=c("pngFiles", "credit", "canonicalName"))
search_images <- function(uuid, subtaxa = NULL, options = NULL, cleanoutput = TRUE){
  
  url <- "http://phylopic.org/api/a/name/"
  
  foo <- function(inputuuid){  
    url2 <- paste0(url, inputuuid, "/images")
    
    args <- compact(list(subtaxa=subtaxa, options=options))
    output <- content(GET(url2, query=args))
    
    other <- as.character(sapply(output$result$other, function(x) x[[1]]))
    if(length(other)==0) other <- NULL
    supertaxa <- as.character(sapply(output$result$supertaxa, function(x) x[[1]]))
    if(length(supertaxa)==0) supertaxa <- NULL
    subtaxa <- as.character(sapply(output$result$subtaxa, function(x) x[[1]]))
    if(length(subtaxa)==0) subtaxa <- NULL
    
    compact(list(other=other, supertaxa=supertaxa, subtaxa=subtaxa))
  }
  temp <- llply(uuid, foo)
  names(temp) <- uuid
  if(cleanoutput)
    temp[!sapply(temp, function(x) length(x))==0]
  else
    return( temp )
}

#' Get image
#' 
#' @import RCurl png
#' @param uuids One to many uuids, possibly from the function search_images
#' @seealso \code{link\{search_images}}
#' toget <- c("27356f15-3cf8-47e8-ab41-71c6260b2724", "bd88f674-6976-4cb2-a46e-e6a12a8ba463", "e547cd01-7dd1-495b-8239-52cf9971a609")
#' get_image(uuids = toget, size = "512")
get_image <- function(uuids, size){
  out <- lapply(uuids, function(x) readPNG(getURLContent(paste0("http://phylopic.org/assets/images/submissions/", x, ".", size, ".png"))))
  return( out )
}

# "http://phylopic.org/api/a/name/1ee65cf3-53db-4a52-9960-a9f7093d845d/images?subtaxa=true&options=pngFiles+credit+licenseURL+svgFile+canonicalName+html"

#' Make phylogeny with Phylopic images
#'
#' @import ggplot2 ggphylo gridExtra ape
#' @param pngobj Object from get_image function
#' @examples 
#' toget <- c("27356f15-3cf8-47e8-ab41-71c6260b2724", "bd88f674-6976-4cb2-a46e-e6a12a8ba463", "e547cd01-7dd1-495b-8239-52cf9971a609")
#' myobjs <- get_image(uuids = toget, size = "512") 
#' make_phylo(pngobj=myobjs)
make_phylo <- function(pngobj){
  imgtoplot <- lapply(pngobj, function(y) matrix(rgb(y[,,1], y[,,2], y[,,3], y[,,4] * 0.2), nrow = dim(y)[1]))
  tree <- rcoal(n=length(pngobj))
  ggphylo(tree, label.size = 0, node.size = 0) +
    theme_phylo_blank2() +
    annotation_custom(xmin=0.35, xmax=0.42, ymin=2.8, ymax=3.1, rasterGrob(imgtoplot[[1]])) +
    annotation_custom(xmin=0.35, xmax=0.42, ymin=1.8, ymax=2.1, rasterGrob(imgtoplot[[2]])) +
    annotation_custom(xmin=0.35, xmax=0.42, ymin=0.9, ymax=1.3, rasterGrob(imgtoplot[[3]]))
  
  ggannlist <- list()
  for(i in seq_along(imgtoplot)){
    ggannlist[[i]] <- annotation_custom(xmin=0.35, xmax=0.42, ymin=i-0.2, ymax=i+0.2, rasterGrob(imgtoplot[[i]]))
  }
#   lapply(imgtoplot, function(x) annotation_custom(xmin=0.35, xmax=0.42, ymin=2.8, ymax=3.1, rasterGrob(x)))
}
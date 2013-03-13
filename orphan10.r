#' Get CiteUlike usernames or groups that cite the DOI.
#' @import XML RCurl plyr
#' @param keywords Search terms.
#' @return Character vector of usernames or group names.
#' @export
#' @examples \dontrun{
#' search(doi = '10.1371/journal.pmed.0020124')
#' }
search <-
  
function(keywords, 
         url = 'http://www.citeulike.org/search/all?q=')
{
  url <- paste(url, keywords, sep='')
  out <- xpathApply(xmlParse(getURL(url)), "//post")
  list_ <- lapply(out, xmlAttrs)
  laply(list_, function(x) x[[1]])
}
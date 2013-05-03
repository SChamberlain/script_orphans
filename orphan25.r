Rscript -e 'library(RCurl); library(doMC); library(plyr); registerDoMC(cores=4); llply(list(\'http://data.gbif.org/ws/rest/occurrence/count?scientificname=Helianthus+annuus\', \'http://data.gbif.org/ws/rest/occurrence/count?scientificname=Helianthus\'), getURL, .parallel=TRUE)'

getURL("http://data.gbif.org/ws/rest/occurrence/count?scientificname=Helianthus+annuus")
GET("http://data.gbif.org/ws/rest/occurrence/count?scientificname=Helianthus+annuus")

'http://data.gbif.org/ws/rest/occurrence/count?scientificname=Helianthus+annuus,http://data.gbif.org/ws/rest/occurrence/count?scientificname=Helianthus'

http://localhost:9292/api/v1/system/gbif_count_url?url=http://data.gbif.org/ws/rest/occurrence/count?scientificname=Helianthus
http://localhost:9292/api/v1/system/gbif_many_urls?urls=http://data.gbif.org/ws/rest/occurrence/count?scientificname=Helianthus,http://data.gbif.org/ws/rest/occurrence/count?scientificname=Helianthus




getURL("http://data.gbif.org/ws/rest/occurrence/count?scientificname=Helianthus+annuus")

library(RCurl); library(httr)


urls <- list("http://data.gbif.org/ws/rest/occurrence/list?scientificname=Helianthus annuus",
             "http://data.gbif.org/ws/rest/occurrence/list?scientificname=Poa annua",
             "http://data.gbif.org/ws/rest/occurrence/list?scientificname=Quercus robur",
             "http://data.gbif.org/ws/rest/occurrence/list?scientificname=Puma concolor")

"http://localhost:9292/api/v1/system/gbif_args?baseurl=http://data.gbif.org/ws/rest/occurrence/list&sciname=Helianthus+annuus,Poa+annua,Quercus+robur,Puma+concolor"
out <- GET("http://localhost:9292/api/v1/system/gbif?baseurl=http://data.gbif.org/ws/rest/occurrence/list&sciname=Helianthus+annuus,Poa+annua&concur=2")
content(out)

urls <- list("http://alm.plos.org/api/v3/articles?ids=10.1371/journal.pone.0000012&api_key=WQcDSXml2VSWx3P&info=detail", 
             "http://alm.plos.org/api/v3/articles?ids=10.1371/journal.pone.0000013&api_key=WQcDSXml2VSWx3P&info=detail", 
             "http://alm.plos.org/api/v3/articles?ids=10.1371/journal.pone.0000143&api_key=WQcDSXml2VSWx3P&info=detail",
             "http://alm.plos.org/api/v3/articles?ids=10.1371/journal.pone.0000144&api_key=WQcDSXml2VSWx3P&info=detail",
             "http://alm.plos.org/api/v3/articles?ids=10.1371/journal.pone.0000313&api_key=WQcDSXml2VSWx3P&info=detail")
#              "http://alm.plos.org/api/v3/articles?ids=10.1371/journal.pone.0000400&api_key=WQcDSXml2VSWx3P&info=detail"
#              "http://alm.plos.org/api/v3/articles?ids=10.1371/journal.pone.0000402&api_key=WQcDSXml2VSWx3P&info=detail",
#              "http://alm.plos.org/api/v3/articles?ids=10.1371/journal.pone.0000403&api_key=WQcDSXml2VSWx3P&info=detail",
#              "http://alm.plos.org/api/v3/articles?ids=10.1371/journal.pone.0000404&api_key=WQcDSXml2VSWx3P&info=detail",
#              "http://alm.plos.org/api/v3/articles?ids=10.1371/journal.pone.0000405&api_key=WQcDSXml2VSWx3P&info=detail",
#              "http://alm.plos.org/api/v3/articles?ids=10.1371/journal.pone.0000406&api_key=WQcDSXml2VSWx3P&info=detail",
#              "http://alm.plos.org/api/v3/articles?ids=10.1371/journal.pone.0000407&api_key=WQcDSXml2VSWx3P&info=detail")

# system.time( llply(urls , GET) )
# system.time( llply(urls , getURL) )
# system.time( GET(paste("http://localhost:9292/api/v1/system/gbif_many_urls?urls=",urls,collapse=",",sep="")) )


system.time( slow <- content(GET(paste("http://secure-wave-2640.herokuapp.com/api/v1/system/many_urls?urls=",paste(urls,collapse=",",sep=""),sep=""))) )

system.time( fast <- content(GET(paste("http://secure-wave-2640.herokuapp.com/api/v1/system/par_urls?urls=",paste(urls,collapse=",",sep=""),sep=""))) )

system.time( reg <- llply(urls, function(x) content(GET(x))) )
registerDoMC(4)
system.time( regpar <- llply(urls, function(x) content(GET(x)), .parallel=TRUE) )
system.time( mine <- GET("http://localhost:9292/api/v1/system/gbif?baseurl=http://data.gbif.org/ws/rest/occurrence/list&sciname=Helianthus+annuus,Poa+annua,Quercus+robur,Puma+concolor&concur=4") )
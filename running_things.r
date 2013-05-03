library(httr)

out <- content(GET('http://en.wikipedia.org/w/api.php?action=query&prop=revisions&titles=Eupatorus_gracilicornis&rvprop=content&format=json'))
fromJSON(
  out$query$pages$`39163674`$revisions[[1]]$`*`
         )

fromJSON("{{Taxobox\n| name = Eupatorus gracilicornis\n| image = Eupatorus gracilicornis Vol.jpg\n| image_width = 240px\n| image_caption = \n| regnum = [[Animal]]ia\n| phylum = [[Arthropod]]a\n| classis = [[Insect]]a\n| ordo = [[Coleoptera]]\n| subordo = [[Polyphaga]]\n| infraordo = Scarabaeiformia<!-- monotypic, don't link -->\n| superfamilia = [[Scarabaeoidea]]\n| familia = [[Scarabaeidae]]\n| subfamilia = [[Dynastinae]]\n| genus = ''[[Eupatorus]]''\n| species = '''''Eupatorus gracilicornis'''''\n| binomial = ''''''Eupatorus gracilicornis'''''\n| binomial_authority = Arrow, 1908<ref>Arrow, G.J. 1908: A contribution to the classification of the coleopterous family Dynastidae. Transactions of the Entomological Society of London, 2: 321-358.</ref>\n}}")


library(roxygen2); library(testthat)
sofa <- "/Users/scottmac2/github/sac/sofa"
roxygenise(sofa)

sofa <- "/Users/scottmac2/github/sac/sofa"
install(sofa)
library(sofa)
# sofa_ping()
results <- elasticsearch(dbname="rplos_db", q="scienceseeker")
summary(results)
summary(results)$base_url
rawdata(results)


library(roxygen2); library(testthat)
rgbif <- "/Users/scottmac2/github/ropensci/rgbif"
roxygenise(rgbif)

rgbif <- "/Users/scottmac2/github/ropensci/rgbif"
install(rgbif)
library(rgbif)
out <- occurrencelist(scientificname = 'Puma concolor', coordinatestatus = TRUE, maxresults = 100)
out
minimal(out)
map(out)
map(out, geom=geom_jitter, jitter=0.2)

out <- densitylist(originisocountrycode = "CA")
head(out)
minimal(out)

# Taxize manuscript
setwd("/Users/scottmac2/github/ropensci/taxize_/inst/doc/")
knit("taxize_withcode.Rnw")
knit("taxize_withcode_appA.Rnw")
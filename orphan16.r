setwd("/Mac/FieldSeasons/ANALYSES/seln_analyses")
diffs <- read.csv("seldiffs_foranova2.csv")
grads <- read.csv("selgrads_w5traits_est2.csv")
head(diffs); str(diffs)
head(grads); str(grads)

ssvec <- gsub("C", "Source 1", diffs$seed_source)
ssvec <- gsub("B", "Source 2", ssvec)
diffs$seed_source <- as.factor(ssvec)
ssvec <- gsub("C", "Source 1", grads$seed_source)
ssvec <- gsub("B", "Source 2", ssvec)
grads$seed_source <- as.factor(ssvec)
diffs$plot <- paste(diffs$year, diffs$site, diffs$seed_source, diffs$near_far, sep='')
grads$plot <- paste(grads$year, grads$site, grads$seed_source, grads$near_far, sep='')


doit <- function(x) {
  if(!is.na(x)){
    if(x < 0.06) { 1 } else
    { 0 }
  } else
  { NA }
}


diffsmelt_est <- melt(diffs, id.vars=1:4, measure.vars=5:13)
diffsmelt_p <- melt(diffs, id.vars=1:4, measure.vars=14:22)
gradsmelt_est <- melt(grads, id.vars=1:4, measure.vars=5:13)
gradsmelt_p <- melt(grads, id.vars=1:4, measure.vars=14:22)
diffsmelt_ <- cbind(diffsmelt_est, diffsmelt_p[,-c(1:5)])
gradsmelt_ <- cbind(gradsmelt_est, gradsmelt_p[,-c(1:5)])
names(diffsmelt_)[6:7] <- c("est","p")
names(gradsmelt_)[6:7] <- c("est","p")
diffsmelt_$pfill <- laply(diffsmelt_$p, doit)
gradsmelt_$pfill <- laply(gradsmelt_$p, doit)

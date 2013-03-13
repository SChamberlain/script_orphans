#######################################################
###########Community-Network Structure Simulation######
#######################################################
library(bipartite)

# Set of mean and sd combinations of log-normal distribution
mu<-c(0.5,2.9,5.3)
sig<-c(0.75,1.6,2.45)

make.matrices<-function(a,b,nmats){
	plants<-round(rlnorm(n=30, meanlog=mu[a], sdlog=sig[b]))
	animals<-round(rlnorm(n=10, meanlog=mu[a], sdlog=sig[b]))
	plants<-plants*(600/sum(plants))
	animals<-animals*(600/sum(animals))
	r2dtable(nmats,animals,plants)
}

# Make matrices
matrices <- make.matrices(1,1,100)

# Calculate some network metrics-e.g., for one combination of mu and sigma
linkspersp <- numeric(100)
h2 <- numeric(100)
inteven <- numeric(100)

for(i in 1:length(matrices)){
	m<-matrix(unlist(matrices[i]),ncol=30,byrow=F)
	metrics<-t(networklevel(m,index=c("links per species","H2","interaction evenness")))
	linkspersp[i]<-metrics[1]
	h2[i]<-metrics[2]
	inteven[i]<-metrics[3]
}

linkspersp
h2
inteven
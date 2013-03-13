library(bipartite)

# Set of mean and sd combinations of log-normal distribution
# In my case, these values were those empirically estimated 
# from many bipartite networks from the Interaction Web Database
mu <- c(0.5,2.9,5.3)
sig <- c(0.75,1.6,2.45)

# Function to make a set of matrices based on some combination of mu and sigma values
make.matrices <- function(a,b,nmats){
	plants <- round(rlnorm(n=30, meanlog=mu[a], sdlog=sig[b]))
	animals <- round(rlnorm(n=10, meanlog=mu[a], sdlog=sig[b]))
	plants <- plants[600/sum(plants)]
	animals <- animals(600/sum(animals))
	r2dtable(nmats,animals,plants)
}

# Output matrices
matrices11 <- make.matrices(1,1,100)

# Etc. for the remaining combinations of mu and sigma
#matrices12 <- make.matrices(1,2,100)
#matrices13 <- make.matrices(1,3,100)
#matrices21 <- make.matrices(2,1,100)
# etc.....

# Calculate some network metrics-e.g., for one combination of mu and sigma
linkspersp11 <- numeric(100)
inteven11 <- numeric(100)
h211 <- numeric(100)

for(i in 1:length(matrices11)){
	m <- matrix(unlist(matrices11[i]),ncol=30,byrow=F)
	metrics <- t(networklevel(m,index=c("links per species","H2","interaction evenness")))
	linkspersp11[i] <- metrics[1]
	inteven11[i] <- metrics[2]
	h211[i] <- metrics[3]
}

linkspersp11
h211
inteven11
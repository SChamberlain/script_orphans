# packages
install.packages(c("ape","phytools"))
library(ape); library(phytools)

# Make phylogenetic trees
tree_predator <- rcoal(10)
tree_prey <- rcoal(10)

# Simulate traits on each tree
# set.seed(101)
trait_predator <- fastBM(tree_predator, a = 10, bounds=c(0,100))
trait_prey <- fastBM(tree_prey, a = 10, bounds=c(0,100))

# Create network of predator and prey
## This is the part I can't do yet. I want to create bipartite networks, where 
## predator and prey interact based on certain crriteria. For example, predator
## species A and prey species B only interact if their body size ratio is
## greater than X.
bmatrix <- 
	outer(trait_predator, trait_prey,
								 function(x,y) as.numeric(x > y))

# library(Matrix)
# image(Matrix(bmatrix),xlab="Prey",ylab="Predator",sub="")

df <- data.frame(bmatrix)
df$rows <- row.names(df)
melted <- melt(bmatrix)
ggplot(melted, aes(Var1, Var2)) + 
	geom_tile(aes(fill = value), colour = "white", binwidth=3) + 
	scale_fill_gradient(low = "lightgrey", high = "black", breaks=seq(0,45,5))
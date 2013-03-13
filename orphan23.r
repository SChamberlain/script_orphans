library(ape); library(reshape)
data <- read.dna(file="~/twelve_gene_ml.phy", format="sequential")

have <- sapply(1:65, function(x) 
	length(as.list(data)[[x]][-grep("-", as.list(data)[[x]])]),
			 USE.NAMES=FALSE
)
names(have) <- attributes(data)$dimnames[[1]]
sort_df(ldply(have), vars=".id")




library(taxize)
# species <- "Enophrys bison"
# out <- get_genes_avail(species, seqrange="1:3000", getrelated=F)
# out_coi <- get_seqs(species, gene=c("coi", "co1"), seqrange="1:2000", getrelated=F, writetodf=F)

genenames <- list(c("coi","co1"),"rag1","Glyt","myh6","plagl2","Ptr","SH3PX3",
									"sreb2","tbr1","zic1","cytb","NADH5|ND5","12S ribosomal|12S large subunit",
									c("16S ribosomal","16S large subunit"),c("28S ribosomal","28s large subunit"))
species <- "Lampetra fluviatilis" # to replace Petromyzon
out2 <- llply(genenames, function(x) get_seqs(species, gene=x, seqrange="1:2000", getrelated=F, writetodf=F), .inform=T, .progress="text")
out2


# Create phylogenies from running on westgrid
library(plyr); library(ape)
path <- "/Users/scottmac2/Downloads/raxmlHPC/out/genetreez/"
folders <- dir(path)

foo <- function(x){
	in_ <- read.table(paste0(path, x, "/RAxML_bestTree.v_genetrees"))
	tree <- read.tree(text=as.character(in_[1,]))
	pdf(paste0(path, x, ".pdf"))
	plot(tree, no.margin=TRUE, cex=0.6)
	dev.off()
}
l_ply(folders, foo)
library(gdata); library(plyr)

# dat <- read.xls("/Users/scottmac2/Dropbox/ElleCANPOLIN/Networks_traits_data/pollinatorlist_master.xlsx", "species")
dat <- read.xls("/Users/scottmac2/Dropbox/ElleCANPOLIN/Networks_traits_data/CanadianFloraMatingSystems_edited.xlsx", "plant_list")
str(dat)

countnonna <- function(x){
	x <- na.omit(x)
	length(as.character(x)[!as.character(x)==""])
}

# beesonly <- colwise(countnonna)(dat[dat$bees==1,c("sciname","sociality", "parasitic", "cleptoparasite_specialization", "nest_location", "nest_detail", "nest_type", "cpforager", "host_plant_specialization","any_size_data")])
# nobees <- colwise(countnonna)(dat[dat$bees==0,c("sciname","sociality", "parasitic", "cleptoparasite_specialization", "nest_location", "nest_detail", "nest_type", "cpforager", "host_plant_specialization","any_size_data")])

traitstoget <- c("scientific_name","pollination_mechanism","life_form","symmetry",
								 "colour_category","multicoloured","flowersize_range_mm","breeding",
								 "inflor_size","self_incompat","parity","inflor_type","usda_duration",
								 "usda_flower_color","flower_size_n","inflorescence_size_o")
all <- colwise(countnonna)(dat[, traitstoget ])

# datout <- rbind(beesonly, nobees, all)
# write.csv(cbind(rows=c("bees","nobees","all"), datout), "asdf.csv")
write.csv(all, "summary_plants.csv")



getem <- as.character(read.csv("getget.csv")[,1])
library(taxize)
out <- llply(getem, function(x) classification(get_uid(x)))
names(out) <- getem
out[["Catostomus"]]


library(ape)
plot(
	read.tree(file="/Users/scottmac2/Dropbox/Vamosi_Heard/topology_tree/phylocom-4.2/mac2/phyloout.txt"),
	cex=0.7, no.margin=TRUE	
)

plot(
	read.tree(file="/Users/scottmac2/Dropbox/Vamosi_Heard/topology_tree/phylocom-4.2/mac2/phylo"),
	cex=0.6, no.margin=TRUE	
)
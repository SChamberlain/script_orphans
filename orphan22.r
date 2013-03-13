seedpred20102011_ <- seedpred20102011[,5:7]
seedpred20102011_ <- seedpred20102011_[-14,]
seedpreddist <- vegdist(seedpred20102011_, method = "bray")
mds11 <- metaMDS(seedpreddist, distance="bray", k=2, trymax = 9999)

adonis(seedpreddist ~ year * near_far * site, seedpred20102011[-14,], perm=9999, method='bray')

mod <- betadisper(seedpreddist, seedpred20102011[-14,]$near_far)
perm <- permutest(mod, pairwise=TRUE, control=permControl(nperm=9999))
perm
# modsite <- betadisper(seedpreddist, droplevels(dfseedpred9$site))
# perm <- permutest(modsite, pairwise=TRUE, control=permControl(nperm=9999))
# perm

dimension<-matrix(NA, nrow=6, ncol=2)  # makes an empty matrix of NAs size [6,2]
colnames(dimension)<-c("#of Axis", "Stress") # adds some names to make it pretty
# the beginning of a loop statement this is going to loop 6 times with i increasing by 1 each loop.
for (i in 1:6){  
	tmp<-metaMDS(seedpreddist, k=i, autotransform=T)
	dimension[i,1]<-i
	dimension[i,2]<-tmp$stress}
dimension #prints the filled table

# plot
mdsdf11 <- cbind(data.frame(mds11$points), nearfar=seedpred20102011[-14,"near_far"],
								 site=seedpred20102011[-14,"site"])
mdsdf11$site_ <- laply(mdsdf11$site, function(x) as.numeric(str_split(x, " ")[[1]][[2]]))
b_seedpred <- ggplot(mdsdf11, aes(MDS1, MDS2, shape=nearfar)) +
	geom_point(size=5) +
	scale_shape_manual(name="",values=c(16,1)) +
	scale_y_continuous(limits=c(-0.5,0.5)) +
	scale_x_continuous(limits=c(-0.5,0.5)) +
	#   geom_text(position = position_jitter(w=0.02, h=0.02)) +
	theme_bw(base_size=22) +
	labs(x = "\nAxis 1", y = "Axis 2\n") +
	opts(panel.grid.major = theme_blank(),panel.grid.minor=theme_blank(),
			 legend.position=c(0.15,0.15),
			 legend.key = theme_blank(),
			 panel.border = theme_rect(size = 2)) +
	labs(x = "", y = "")


#########
# SIMPER
# SIMPER analyses, for contribution of individual species to diffs btw treatments
getperc <- function(x) {
	x$sp <- row.names(x)
	x$perspperccontr <- round(x[,1] / sum(x[,1]), 2) 
	x
}

trtinfo_ <- seedpred20102011[-14,1:4]
sim_prox <- with(trtinfo_, simper(seedpred20102011[-14,5:7], near_far))
simprox_ <- summary(sim_prox)[[1]]
simprox_$perspperccontr <- round(simprox_[,1] / sum(simprox_[,1]), 2)
simprox_$what <- rep("seedpreds_2010_2011_prox", nrow(simprox_))
simprox_
sim_site <- with(trtinfo_, simper(seedpred20102011[-14,5:7], site))
sim_site_ <- summary(sim_site)
sim_site_ <- ldply(sim_site_, getperc)
sim_site_$what <- rep("seedpreds_2010_2011_site", nrow(sim_site_))
sim_site_
simsite_percontr <- dcast(sim_site_, sp ~ .id, value.var="perspperccontr")
simsite_cumsum <- dcast(sim_site_, sp ~ .id, value.var="cumsum")
simsite_cast <- rbind(simsite_percontr, simsite_cumsum)

# write.csv(sim10site_, "simper_2010sitevsite_.csv")
write.csv(simsite_cast, "simsite_cast_seedpred2011.csv")
write.csv(simprox_, "simprox_seedpred2011.csv")
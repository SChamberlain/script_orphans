getperc <- function(x) {
  x$sp <- row.names(x)
  x$perspperccontr <- round(x[,1] / sum(x[,1]), 2) 
  x
}

allantag <- merge(spdat_10[,c(1:5,14,16,17,21,23:24)], foldat[,c(5,12,13)], by.x="plant_no", by.y="plant")
str(allantag)

# dfseedpred9 <- ddply(allantag, .(site, seed_source, near_far), summarise, 
#   I_prop_ = mean(I_prop, na.rm=T),
#   G_prop_ = mean(G_prop, na.rm=T),
#   MP_prop_ = mean(MP_prop, na.rm=T),
#   chewtot = mean(chewscore, na.rm=T),
#   leafburntot = mean(leafhopperburnscore, na.rm=T))
# str(dfseedpred9)

dfseedpred9 <- ddply(allantag, .(site, seed_source, near_far), summarise, 
  I_tot_ = mean(I_tot, na.rm=T),
  G_tot_ = mean(G_tot, na.rm=T),
  MP_tot_ = mean(MP_tot, na.rm=T),
  chewtot = mean(chewscore, na.rm=T),
  leafburntot = mean(leafhopperburnscore, na.rm=T))
str(dfseedpred9)

dfseedpred9_ <- dfseedpred9[,4:8]
# dfseedpred9_ <- decostand(dfseedpred9_, "normalize")
seedpreddist <- vegdist(dfseedpred9_, method = "bray")
mds10 <- metaMDS(seedpreddist, distance="bray", k=2, trymax = 9999)

adonis(seedpreddist ~ near_far * site, dfseedpred9, perm=9999, method='bray')

mod <- betadisper(seedpreddist, dfseedpred9$near_far)
perm <- permutest(mod, pairwise=TRUE, control=permControl(nperm=9999))
perm

dimension<-matrix(NA, nrow=6, ncol=2)  # makes an empty matrix of NAs size [6,2]
colnames(dimension)<-c("#of Axis", "Stress") # adds some names to make it pretty
# the beginning of a loop statement this is going to loop 6 times with i increasing by 1 each loop.
for (i in 1:6){  
  tmp<-metaMDS(seedpreddist, k=i, autotransform=T)
  dimension[i,1]<-i
  dimension[i,2]<-tmp$stress}
dimension #prints the filled table

mdsdf10 <- cbind(data.frame(mds10$points), nearfar=dfseedpred9$near_far,
                 site=dfseedpred9$site)
mdsdf10$site_ <- laply(mdsdf10$site, function(x) as.numeric(str_split(x, " ")[[1]][[2]]))
a_seedpred <- ggplot(mdsdf10, aes(MDS1, MDS2, label = site_, shape=nearfar)) +
  geom_point(size=4) +
  scale_shape_manual(name="",values=c(16,1)) +
  scale_y_continuous(limits=c(-0.2,0.2), breaks=c(-0.2,-0.1,0,0.1,0.2)) +
  geom_text(position = position_jitter(w=0.02, h=0.02)) +
  theme_bw(base_size=22) +
  labs(x = "\nAxis 1", y = "Axis 2\n") +
  opts(panel.grid.major = theme_blank(),panel.grid.minor=theme_blank(),
       legend.position="none",
       panel.border = theme_rect(size = 2)) +
  labs(x = "", y = "")




# SIMPER 2010 
trtinfo_10 <- dfseedpred9[,1:3]
sim10_prox <- with(trtinfo_10, simper(dfseedpred9_, near_far))
sim10prox_ <- summary(sim10_prox)[[1]]
sim10prox_$perspperccontr <- round(sim10prox_[,1] / sum(sim10prox_[,1]), 2)
sim10prox_$what <- rep("near_v_far_2010", nrow(sim10prox_))
sim10prox_
write.csv(sim10prox_, "/Mac/FieldSeasons/ANALYSES/seedpreds/simper_antagonists_2010_tot.csv")

sim10_site <- with(trtinfo_10, simper(dfseedpred9_, site))
sim10_site_ <- summary(sim10_site)
sim10_site_ <- llply(sim10_site_, getperc)
sim10_site_$what <- rep("2010", nrow(sim10_site_))
sim10_site_
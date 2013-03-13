# correlation of phylogenetic signal vs. mean phylognetic distance
setwd("/Users/ScottMac/Dropbox/PhylogenyMA_ms/Data & Trees/_All/Output/Output_11Apr/summarytables")
dat <- read.csv("treemetrics.csv")
datnoout <- dat[dat$numsp < 150,]
str(dat); head(dat)
require(ggplot2)

# cor.test(dat$mpd_, dat$K)
cor.test(dat$numsp, dat$mpd_)
cor.test(datnoout$numsp, datnoout$mpd_)
cor.test(dat$numsp, dat$mpd_, method="spearman")
cor.test(datnoout$numsp, datnoout$mpd_, method="spearman")
# qplot(K, mpd_, data=dat, geom="point")
qplot(numsp, mpd_, data=dat, geom=c("point","smooth"), method="lm")
qplot(numsp, mpd_, data=datnoout, geom=c("point","smooth"), method="lm")

it <- read.csv("/Users/ScottMac/Dropbox/PhylogenyMA_ms/paperabbrevs_matchlist_breadth.csv")
datnew <- merge(dat, it, by.x="study_names", by.y="longcode")


# 
str(datnew)
datnew$breadth <- factor(datnew$breadth, levels=c("birds","arthropods","plants","animals","multiple"))
ggplot(datnew, aes(breadth, K)) +
  geom_boxplot() +
  theme_bw(base_size=20) +
  scale_y_continuous(limits=c(0,1)) +
  labs(x="\nTaxonomic breadth", y="Phylogenetic signal (K)\n")
ggsave("signal_breadth.jpeg")

fit <- lm(K ~ breadth, data=datnew)
require(car)
Anova(fit, type=3)
TukeyHSD(aov(K ~ breadth, data=datnew))
shapiro.test(residuals(fit))
hist(residuals(fit))




# 
require(ape)
tree <- rcoal(10)

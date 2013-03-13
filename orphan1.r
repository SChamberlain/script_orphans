install.packages(c("plyr","ggplot2","reshape2","stringr","devtools"))
require(ggplot2)

####  Pollen grains
setwd("/Volumes/KATPC/Scott_Nov2011_onPCatLab/Images/Pollen_grains/BeakleyBeallNear_Jul16_2011/pilotset")
dat <- read.csv("pollen_grain_pilotstudy.csv")
dat <- dat[dat$notes == 1,]

ggplot(dat, aes(y=manual, x=software)) +
  theme_bw(base_size = 16) +
  geom_point(size = 4) +
  scale_y_continuous(limits = c(0, 300)) +
  scale_x_continuous(limits = c(0, 300)) +
  stat_abline(intercept = 0, slope = 1, linetype = 2) +
  stat_smooth(method="glm", formula = y ~ x + x^2) +
  labs(y = "Manual count\n", x = "\nComputer count")


glmfit <- lm(manual ~ software, data = dat)
summary(glmfit)




####  leaf discs
setwd("/Volumes/KATPC/Scott_Nov2011_onPCatLab/Images/Leaf_discs")
leafdat <- read.csv("leaf_disc_pilotstudy.csv")

ggplot(leafdat, aes(y=gland_count_manual, x=gland_count_software)) +
  theme_bw(base_size = 16) +
  geom_point(size = 4) +
  scale_y_continuous(limits = c(0, 300)) +
  scale_x_continuous(limits = c(0, 300)) +
  stat_abline(intercept = 0, slope = 1, linetype = 2) +
  stat_smooth(method="glm", formula = y ~ x + x^2) +
  labs(y = "Manual count\n", x = "\nComputer count")


glmfit <- lm(gland_count_manual ~ gland_count_software, data = leafdat)
summary(glmfit)




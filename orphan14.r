require(data.table)
setwd("/Users/ScottMac/Dropbox/Helianthus_Scott")
indflowdat <- read.csv("alldata_tomatchtoinfo2.csv")
head(indflowdat); str(indflowdat)

# average for each plant
dt <- data.table(indflowdat)
dd <- data.frame(dt[, 
    list(mean=mean(length, na.rm=T), n=length(length)), 
    by=c("year","site","seed_source","near_far","plant","trait")]) 
str(dd_) 
dd_ <- dcast(dd, year + site + seed_source + near_far + plant ~ trait, value.var="mean")
names(dd_)[6:14] <- c("pet_l","pet_w","ta_l","t_l","th_w","bu_l","bu_w","u_l","u_w")

  # create new variables
dd_$ae_l <- dd_$ta_l - dd_$t_l
dd_$pet_size <- dd_$pet_l * dd_$pet_w
dd_$bu_size <- dd_$bu_l * dd_$bu_w
dd_$u_size <- dd_$u_l * dd_$u_w
dd_ <- dd_[,-c(6:8,11:15)] # remove columns
str(dd_)


########
dat10 <- dat[dat$year %in% 2010, ]
dat11 <- dat[dat$year %in% 2011, ]
inflowdata_axes_10 <- dd_[dd_$year %in% 2010, ]
inflowdata_axes_11 <- dd_[dd_$year %in% 2011, ]
alldat10 <- merge(dat10, inflowdata_axes_10[,-c(1:4)], by.x="plant_no", by.y="plant", all.x=T)
alldat11 <- merge(dat11, inflowdata_axes_11[,-c(1:4)], by.x="plant_no", by.y="plant", all.x=T)
alldat1011 <- rbind(alldat10, alldat11)
alldat1011$plot <- as.factor(paste(alldat1011$year, "_", alldat1011$site, "_",
                                   alldat1011$seed_source, "_", alldat1011$near_far, sep=''))
str(alldat1011)

# add proportional seed damage
alldat1011$M_prop <- alldat1011$M_tot/alldat1011$U_tot
alldat1011$I_prop <- alldat1011$I_tot/alldat1011$U_tot
alldat1011$P_prop <- alldat1011$P_tot/alldat1011$U_tot
alldat1011$G_prop <- alldat1011$G_tot/alldat1011$U_tot
alldat1011$MP_prop <- alldat1011$MP_tot/alldat1011$U_tot

# remove hand-pollination plants
alldat11_ <- alldat1011[alldat1011$year %in% 2011,]
pldat <- read.csv("/Mac/FieldSeasons/ANALYSES/pollen_limitation/pollen_limitation_study.csv")
alldat11_ <- alldat11_[!alldat11_$plant_no %in% pldat$plant_no,]
alldat1011 <- rbind(alldat1011[alldat1011$year %in% 2010,], alldat11_)
str(alldat1011)

# calculate seln differentials and relativize traits, etc.
selnprepfunc <- function(x, fitnessvar, traitvars) {
  # Calculate relative fitness
  datall <- cbind(x, relfitness = x[,fitnessvar]/mean(x[,fitnessvar], na.rm=T))
  #   names(datall)[22] <- "relfitness"
  # Standardize traits to mean 0, sd 1
  cbind(datall[,-traitvars], rescaler(datall[,traitvars],"sd"))
}
out <- llply(split(alldat1011, alldat1011$plot), 
             function(y) selnprepfunc(y, 18, c(6:9,11,20:24)))

# calculate seln differentials and output table
# getseldiffs <- function(x) {
#   # Selection differentials and correlations among traits, 
#   # cov for differentials and cor.prob for trait correlations and P-values
#   seldiffs <- cov(na.omit(x[, c(21:28)])) # covariances (=seln differentials)
#   selcorrs <- cor.prob(na.omit(x[, c(21:28)])) # corr coeff, P-values
#   seldiffs_selcorrs <- data.frame(seldiffs, selcorrs) # puts together
#   seldiffs_selcorrs[1,c(2:6,8:12)]
# }  

# calculate seln differentials and output table
getseldiffs <- function(x) {
  outlist <- list()
  for(i in 1:length(names(x[,22:31]))) {
    temp <- x[,22:31]
    t <- try(cor.test(x$relfitness, temp[,i]), silent=T)
    r <- t[[4]][[1]]
    p <- t[[3]]
    n <- t[[2]][[1]]
    outlist[[i]] <- c(r, p, n)
  }
  outdf <- ldply(outlist)
  names(outdf) <- c("r","P_val","N_plants")
  outdf$trait <- names(x[,22:31])
  outdf
}
# getseldiffs(out[[1]])
out <- out[-5]
tt <- ldply(out, getseldiffs, .inform=T)
tt <- cbind(ldply(str_split(tt$.id, "_")), tt[,-1]) # split plot info
names(tt)[1:4] <- c("year","site","seed_source","near_far")
tempp <- melt(tt, id.vars=c(1:4,8), measure.vars=5:7)
writeout <- dcast(tempp, year+site+seed_source+near_far ~ trait+variable) # put traits in sep columns
setwd("/Mac/FieldSeasons/ANALYSES/seln_analyses")
write.csv(writeout, "all_seldiffs_selcorrs_5traits_new.csv", row.names=F)









vv <- list(ten_Beakley_Beall_Far=BeakleyBeallFar10_, ten_Beakley_Beall_Near=BeakleyBeallNear10_,
           ten_Beakley_MF_Near=BeakleyMFNear10_, ten_Bradshaw_Beall_Near=BradshawBeallNear10_,
           ten_Dodd_Beall_Far=DoddBeallFar10_,
           ten_Dodd_Beall_Near=DoddBeallNear10_, ten_Dodd_MF_Far=DoddMFFar10_,
           ten_Dodd_MF_Near=DoddMFNear10_, ten_Marek_Beall_Far=MarekBeallFar10_,
           ten_Marek_Beall_Near=MarekBeallNear10_)
selgrads <- ldply(vv, )
write.csv(selgrads, "selgrads_withPC1and2axes.csv")

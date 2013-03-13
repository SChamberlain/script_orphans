# PCA for individual flower traits
require(reshape2)
str(alldfds_info)
indflow_4pca <- dcast(alldfds_info, site + seed_source + near_far + plant ~ trait, 
      value.var=3, fun.aggregate=mean)
str(indflow_4pca)

prcomp(~1+2+3+4+5+6+7+8+9, scale=TRUE)

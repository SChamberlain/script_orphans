
################## Plot results
# install_github('ggphylo', 'gjuggler')
library(ggplot2); library(ggphylo); library(reshape2)

df_rand_melt <- melt(df_rand)
ggplot(df_rand_melt, aes(type, value, fill=variable)) +
	theme_bw(base_size=18) +
	geom_boxplot() +
	facet_wrap(~ variable, scales="free") +
	theme(legend.position = 'none')


# ratio 1 
df_traits1_ratio_melt <- melt(df_traits1_ratio)
ggplot(df_traits1_ratio_melt, aes(type, value, fill=variable)) +
	theme_bw(base_size=18) +
	geom_boxplot() +
	facet_wrap(~ variable, scales="free") +
	theme(legend.position = 'none')

# ratio 2
df_traits2_ratio_melt <- melt(df_traits2_ratio)
ggplot(df_traits2_ratio_melt, aes(type, value, fill=variable)) +
	theme_bw(base_size=18) +
	geom_boxplot() +
	facet_wrap(~ variable, scales="free") +
	theme(legend.position = 'none')

# complementarity 1
df_traits1_comp_melt <- melt(df_traits1_comp)
ggplot(df_traits1_comp_melt, aes(type, value, fill=variable)) +
	theme_bw(base_size=18) +
	geom_boxplot() +
	facet_wrap(~ variable, scales="free") +
	theme(legend.position = 'none')

# complementarity 2
df_traits2_comp_melt <- melt(df_traits2_comp)
ggplot(df_traits2_comp_melt, aes(type, value, fill=variable)) +
	theme_bw(base_size=18) +
	geom_boxplot() +
	facet_wrap(~ variable, scales="free") +
	theme(legend.position = 'none')

# barrier 1
df_traits1_barrier_melt <- melt(df_traits1_barr)
ggplot(df_traits1_barrier_melt, aes(type, value, fill=variable)) +
	theme_bw(base_size=18) +
	geom_boxplot() +
	facet_wrap(~ variable, scales="free") +
	theme(legend.position = 'none')

# barrier 2
df_traits2_barrier_melt <- melt(df_traits2_barr)
ggplot(df_traits2_barrier_melt, aes(type, value, fill=variable)) +
	theme_bw(base_size=18) +
	geom_boxplot() +
	facet_wrap(~ variable, scales="free") +
	theme(legend.position = 'none')



netmets = c("connectance", "links per species", 
						"nestedness", "web asymmetry", "cluster coefficient")
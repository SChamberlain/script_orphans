require(plyr); require(stringr); require(ggplot2); require(lubridate); require(twitteR)

datout_1 <- searchTwitter("I work for the internet", n = 1500, since='2011-11-11', until='2011-12-12')
datout_2 <- searchTwitter("I work for the internet", n = 1500, since='2011-11-13', until='2011-12-14')
datoutdf <- ldply(c(datout_1, datout_2), function(x) x$toDataFrame(), .progress="text")

actual <- grep("I work for the internet", datoutdf[,1], ignore.case=T)
datoutdf2 <- datoutdf[actual,]

datoutdf2$newtime <- round_date(datoutdf2[,4], "hour")
datoutdf2_ <- ddply(datoutdf2, .(newtime), summarise, 
                   numtweets = length(newtime))

ggplot(droplevels(datoutdf2_), aes(newtime, numtweets)) +
  theme_bw(base_size=18) +
  geom_line(color="red") +
#   scale_x_date(format = "%d") +
  labs(x='\nTime', y='Number of tweets\n') +
  opts(title="Tweets containing 'I work for the internet'")
setwd("/Mac/R_stuff/Blog_etc/IWorkForTheInternet")
# ggsave("iworkfortheinternet.png")

df <- data.frame( 
  date = seq(Sys.Date(), len=100, by="1 day")[sample(100, 50)], 
 price = runif(50) 
) 
df <- df[order(df$date), ] 
dt <- qplot(date, price, data=df, geom="line") + opts(aspect.ratio = 1/4) 
dt + scale_x_date(labels = date_format("%m/%d"))
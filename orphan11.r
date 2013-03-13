set.seed(3)

dat <- data.frame(var1 = as.factor(rep(c("a","b"), each = 8)),
                  var2 = as.factor(rep(c("c","d"), 8)),
                  response = round(rnorm(16, 10, 4), 0))

mod <- lm(response ~ var1 * var2, data = dat)
summary(mod)
interaction.plot(dat$var2, dat$var1, dat$response)

# the intercept in the first line of summary(mod) tests var1a_var2c == 0
# in the second line of summary(mod) you test var1a_var2c - var1b_var2c == 0,
# which is the effect of var1 within var2c
# in the third line you test var1a_var2c - var1a_var2d == 0,
# which is the effect of var2 within var1a
# in the fourth line you test the interaction, which is:
# (var1a_var2c - var1a_var2d) - (var1b_var2c - var1b_var2d) == 0

# relevel var2, then the intercept is var1a_var2d
# and the second line tests var1a_var2d - var1b_var2d == 0,
# which is the effect of var1 within var2d
dat1 <- dat
dat1$var2 <- relevel(dat$var2, ref = "d")
mod1 <- lm(response ~ var1 * var2, data = dat1)
summary(mod1)

# test this with one call with package {contrast}:
require(contrast)
var2_in_var1 <- contrast(mod,
                         list(var2 = levels(dat$var2), var1 = "b"),
                         list(var2 = levels(dat$var2), var1 = "a"))
print(var2_in_var1, X = TRUE)


library(nlme)
Orthodont2 <- Orthodont
Orthodont2$newAge <- Orthodont$age - 11
fm1Orth.lme2 <- lme(distance ~ Sex*newAge, data = Orthodont2, random = ~ newAge | Subject)
summary(fm1Orth.lme2)

mm <- contrast(fm1Orth.lme2,
         a = list(Sex = levels(Orthodont2$Sex), newAge = 8 - 11),
         b = list(Sex = levels(Orthodont2$Sex), newAge = 10 - 11))
print(mm, X = TRUE)








dat <- read.csv(file="Anova.csv", header=TRUE, sep=",")
fit <- lm(dat$Copylog ~ dat$Infection + dat$Day)
summary(fit)
fit.aov <- aov(lm(dat$Copylog ~ dat$Infection + as.factor(dat$Day)))
summary(fit.aov)
TukeyHSD(fit.aov)

resp.var <- dat$Copylog
pred.var <- paste(dat$Infection, dat$Day, sep="")  # one-way + continue 
fit.aov <- aov(lm(resp.var ~ pred.var))
summary(fit.aov)
TukeyHSD(fit.aov)

# R base
plot(dat$Copylog~dat$Day)
vec.cols <- cols[dat$Infection]
jitter <- runif(n=nrow(dat), min = -.3, max =.3)

plot(y = dat$Copylog, 
     x = dat$Day + jitter, 
     col=vec.cols, pch = 16, 
     ylab="Copylog",
     xlab="day")

points(x=rep(0, 4), y=seq(from=330, by=15, length.out = 4), pch=16, col= cols)

text(x=rep(0, 4), y=seq(from=330, by=15, length.out = 4), pch=16, col= cols, 
     labels=c("LsoA", "LsoB"),
     pos = 4, cex = .6)

fit <- lm(dat$Copylog ~ dat$Day)

abline(fit, col= "red", lwd=2)


ggplot(data = dat, aes(x = Day, y = Copylog)) +
  geom_point(aes(colour = Infection)) +
  geom_smooth(aes(colour = Infection))

ggraptR(dat)



# y = β0 + β1x1 + β2X2

data("ChickWeight")
plot(ChickWeight$weight~ChickWeight$Time)
fit <- lm(ChickWeight$weight ~ ChickWeight$Diet + ChickWeight$Time + ChickWeight$Chick)
summary(fit)
install.packages("viridis")
library(viridis)
Uqique(ChickWeight$Diet)
cols <- viridis(4)
cols <- rainbow(4)

vec.cols <- cols[ChickWeight$Diet]

jitter <- runif(n=nrow(ChickWeight), min = -.3, max =.3)

plot(y =ChickWeight$weight, 
     x = ChickWeight$Time + jitter, 
     col=vec.cols, pch = 16, 
     ylim=c(0, max(ChickWeight$weight)),
     cex=.6,
     ylab="Weight (g)",
     xlab="day")
                                                                           
points(x=rep(0, 4), y=seq(from=330, by=15, length.out = 4), pch=16, col= cols)

text(x=rep(0, 4), y=seq(from=330, by=15, length.out = 4), pch=16, col= cols, 
     labels=c("Diet1", "Diet2","Diet3","Diet4"),
     pos = 4, cex = .6)

fit <- lm(ChickWeight$weight ~ ChickWeight$Time)

abline(fit, col= "red", lwd=2)

ggraptR(ChickWeight)

tree.height <- rnorm(300, mean=30, sd=5)
hist(tree.height)
treatment <- rep(c("A", "B", "C"), each = 100)
x <- data.frame(tree.height[1:100], tree.height[101:200], tree.height[201:300])

newx <- data.frame(tree.height, treatment)
ggraptR(newx)


boxplot(x)

install.packages("beeswarm")
library(beeswarm)
beeswarm(x, cex=.5, method = "swarm")

ggplot(newx, aes(y=tree.height, x=as.factor(treatment))) + 
  geom_jitter(width=.04, size=.5, alpha=.5) +
  geom_boxplot(stat="boxplot", position="dodge", alpha=0.5, outlier.shape = NA) + 
  theme_classic() +
  theme(text=element_text(family="sans", face="plain", color="#000000", size=15, hjust=0.5, vjust=0.5)) + 
  xlab("as.factor(treatment)") + 
  ylab("tree.height") 


ggplot(newx, aes(y=tree.height, x=as.factor(treatment))) + 
  geom_violin(stat="ydensity", position="dodge", alpha=0.5, trim=TRUE, scale="area") +
  theme_classic() +
  theme(text=element_text(family="sans", face="plain", color="#000000", size=15, hjust=0.5, vjust=0.5)) + 
  xlab("as.factor(treatment)") + 
  ylab("tree.height") 







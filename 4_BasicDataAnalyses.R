###------------Brief Analysis Intro---------------------------------------------
#
# By Danielle Walkup (with lots of help from Google) 
# OSOS 2018 Workshop, August 2018
#
# This script goes with the intro pdf and will take you through a few  
# basic data analyses
# 
###------------Working directory and Packages-----------------------------------
#
# Set up our packages to install and load:
#install.packages(c("car","PerformanceAnalytics"))
library(car)
library(PerformanceAnalytics)
#
# Set up our working directory:
getwd()
#setwd("C:/Users/Danielle/Desktop/OSOS_IntroR")  #change the directory as needed
#
###------------Get our data frame-----------------------------------------------
#
# Lets load our cleaned data set:
dir("outputs/data")  #I can never remember the file names 
#
liz.file <- "outputs/data/LizardData_Clean.csv"
liz.df <- read.csv(liz.file, strip.white = T)
#
head(liz.df)  #I always double check my loaded files!
str(liz.df)  #let's reload these with numeric
liz.df <- read.csv(liz.file, colClasses = c("character","factor","factor","factor"
                                            , "numeric", "numeric", "numeric"
                                            , "numeric")
                   , strip.white = T)
str(liz.df)  #looks good
#
###------------Some Basic Data analysis tools-----------------------------------
#
#the t-test:
?t.test
t.test(liz.df$SVL ~ liz.df$Sex)  #error because we have some too many levels
#
# let's double check our factor:
levels(liz.df$Sex)#
# let's try to remove them this way:
liz.df.tt <- liz.df[!is.na(liz.df$Sex), ]
sum(is.na(liz.df.tt$Sex))  #we should have no NA's
t.test(liz.df.tt$SVL ~ liz.df.tt$Sex)  #doesn't work again because of the factor levels
levels(liz.df.tt$Sex)  #so we still have the blank level showing, remember just
#because we subset out a factor doesn't mean it disappears
#
#let's try a workaround
liz.df.tt$Sex <- as.character(liz.df.tt$Sex)
table(liz.df.tt$Sex)  #Let's check what we have - blanks not NA's here
# so let's remove the blanks:
liz.df.tt <- liz.df.tt[liz.df.tt$Sex != "", ]  
table(liz.df.tt$Sex)  #finally!!!
#
# and now we can turn it back to a factor to use it later
liz.df.tt$Sex <- as.factor(liz.df.tt$Sex)
levels(liz.df.tt$Sex)  #and we are down to two factors, lets try the ttest
#
t.test(liz.df.tt$SVL ~ liz.df.tt$Sex)  #it worked! Sadly this is likely confounded by species!
#
# let's try an anova:
# One-Way ANOVA:
liz.aov <- aov(liz.df.tt$SVL ~ liz.df.tt$ID)
summary(liz.aov)
plot(residuals(liz.aov))
TukeyHSD(liz.aov)  #check the pairwise differences
#
# Two-way ANOVA:
liz.2aov <- aov(SVL ~ ID + Sex + ID:Sex, data = liz.df.tt)
liz.2aov2 <- aov(SVL ~ ID*Sex, data = liz.df.tt)
summary(liz.2aov)
TukeyHSD(liz.2aov)
#
# But are the assumptions met? We'll look at the one-way ANOVA
liz.res <- residuals(liz.aov)
shapiro.test(liz.res)  #haha, nope
leveneTest(SVL ~ ID, data = liz.df.tt)  #thats ok
hist(liz.df.tt$SVL)
plot(liz.aov)  #can see the residuals
#
# What if we transformed the data? We can add a column to the data frame
liz.df.tt$logSVL <- log10(liz.df.tt$SVL)
shapiro.test(liz.df.tt$logSVL)  #better, but still not normal
# 
# we could also just run the test but not save the data
shapiro.test(log10(liz.df.tt$SVL))
hist(log10(liz.df.tt$SVL))
#
# Still not normal, what about non-parametric tests to relax the normality assumption
# Kruskal-Wallace test (non-parametric ANOVA)
?kruskal.test
kruskal.test(SVL ~ ID, data = liz.df.tt)
# Wilcox Rank Sum test (non-parametric t-test)
?wilcox.test
wilcox.test(SVL ~ Sex, data = liz.df.tt)
#
# Linear models basics:
liz.lm <- lm(Mass ~ SVL + ID + Sex + ID:Sex, data = liz.df.tt)
summary(liz.lm)
plot(liz.lm)
#
# But as we know, correlated variables can affect the accuracy
# So lets check the correlation between SVL, Tail, and Mass
liz.df.cor <- liz.df.tt[,c(5,6,8)]
liz.df.cc <- liz.df.cor[complete.cases(liz.df.cor),]
#
# we can use the default 
cor(liz.df.cc)
#
# I also like this function in the PerformanceAnalytics Package
chart.Correlation(liz.df.cc)
dev.off()  #i've found after this chart.Correlation, you want to clear the plot 
           #area, otherwise future plot margins are funky
#
# And this is where I leave you! Remember there are numerous packages available
# to help with analyses you want to do. Google is your friend!
# glm model with proportion data
Day29 <- read.table('glm.txt', header = T)
attach(Day29)
glm29 <- glm(cbind(Noninfected, Infected) ~ Haplotype, family=binomial)
summary(glm29)

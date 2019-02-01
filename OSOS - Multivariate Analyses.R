
### Multivariate analyses ###

install.packages("ade4")
library(ade4)


data(iris)
colnames(iris)
str(iris)

#### Univariate ####


# DENSITY

Plot_SW<-ggplot(data=iris, aes(x=Sepal.Width,fill=Species,color=Species)) +
	geom_density() +
	scale_fill_manual(values=alpha(c("coral","cornflowerblue","darkorchid"),0.5)) +
	scale_color_manual(values=c("coral","cornflowerblue","darkorchid")) +
	guides(fill="none",color="none")

Plot_SL<-ggplot(data=iris, aes(x=Sepal.Length,fill=Species,color=Species)) +
	geom_density() +
	scale_fill_manual(values=alpha(c("coral","cornflowerblue","darkorchid"),0.5)) +
	scale_color_manual(values=c("coral","cornflowerblue","darkorchid")) +
	guides(fill ="none",color="none")

Plot_PW<-ggplot(data=iris, aes(x=Petal.Width,fill=Species,color=Species)) +
	geom_density() +
	scale_fill_manual(values=alpha(c("coral","cornflowerblue","darkorchid"),0.5)) +
	scale_color_manual(values=c("coral","cornflowerblue","darkorchid")) +
	guides(fill ="none",color="none")

Plot_PL<-ggplot(data=iris, aes(x=Petal.Length,fill=Species,color=Species)) +
	geom_density() +
	scale_fill_manual(values=alpha(c("coral","cornflowerblue","darkorchid"),0.5)) +
	scale_color_manual(values=c("coral","cornflowerblue","darkorchid")) +
	guides(fill ="none",color="none")

grid.arrange(Plot_SW,Plot_SL,Plot_PW,Plot_PL,nrow=2,ncol=2)


# VIOLIN PLOT

Plot_SW<-ggplot(data=iris, aes(y=Sepal.Width,x=Species,fill=Species,color=Species)) +
	geom_violin() +
	scale_fill_manual(values=alpha(c("coral","cornflowerblue","darkorchid"),0.5)) +
	scale_color_manual(values=c("coral","cornflowerblue","darkorchid")) +
	guides(fill="none",color="none")

Plot_SL<-ggplot(data=iris, aes(y=Sepal.Length,x=Species,fill=Species,color=Species)) +
	geom_violin() +
	scale_fill_manual(values=alpha(c("coral","cornflowerblue","darkorchid"),0.5)) +
	scale_color_manual(values=c("coral","cornflowerblue","darkorchid")) +
	guides(fill ="none",color="none")

Plot_PW<-ggplot(data=iris, aes(y=Petal.Width,x=Species,fill=Species,color=Species)) +
	geom_violin() +
	scale_fill_manual(values=alpha(c("coral","cornflowerblue","darkorchid"),0.5)) +
	scale_color_manual(values=c("coral","cornflowerblue","darkorchid")) +
	guides(fill ="none",color="none")

Plot_PL<-ggplot(data=iris, aes(y=Petal.Length,x=Species,fill=Species,color=Species)) +
	geom_violin() +
	scale_fill_manual(values=alpha(c("coral","cornflowerblue","darkorchid"),0.5)) +
	scale_color_manual(values=c("coral","cornflowerblue","darkorchid")) +
	guides(fill ="none",color="none")

grid.arrange(Plot_SW,Plot_SL,Plot_PW,Plot_PL,nrow=2,ncol=2)
	
# ANOVAS and Tukeys... and bonferroni corrections... 	


#### Bivariate ####

# geom_point
Plot_Sepal<-ggplot(data=iris, aes(y=Sepal.Length,x= Sepal.Width,color=Species)) +
	geom_point(size=7) +
	scale_color_manual(values=alpha(c("coral","cornflowerblue","darkorchid"),0.5)) +
	guides(fill="none",color="none")

Plot_Petal<-ggplot(data=iris, aes(y=Petal.Length,x= Petal.Width,color=Species)) +
	geom_point(size=7) +
	scale_color_manual(values=alpha(c("coral","cornflowerblue","darkorchid"),0.5)) +
	guides(fill="none",color="none")

quartz(width=7,height=4)
grid.arrange(Plot_Sepal, Plot_Petal,nrow=1,ncol=2)

# geom_density2d
Plot_Sepal<-ggplot(data=iris, aes(y=Sepal.Length,x= Sepal.Width,color=Species,fill=Species)) +
	geom_density2d(h=1) +
	scale_color_manual(values=c("coral","cornflowerblue","darkorchid")) +
	guides(fill="none",color="none") +
	ggtitle(label="Sepal") +
	theme_light() + theme(plot.title=element_text(hjust=0.5))

Plot_Petal<-ggplot(data=iris, aes(y=Petal.Length,x= Petal.Width,color=Species,fill=Species)) +
	geom_density2d(h=1) +
	scale_color_manual(values=c("coral","cornflowerblue","darkorchid")) +
	guides(fill="none",color="none")+
	labs(title="Petal") +
	theme_light() + theme(plot.title=element_text(hjust=0.5))

quartz(width=7,height=4)
grid.arrange(Plot_Sepal, Plot_Petal,nrow=1,ncol=2)

### MANOVAs ... 

quartz(width=7,height=7)
pairs(iris,col=alpha(c("coral","cornflowerblue","darkorchid"),0.5)[iris$Species],pch=16)

install.packages("GGally")
library('GGally')
ggpairs(iris,aes(color=Species,alpha=0.5))


data(mtcars)
str(mtcars)
ggpairs(mtcars,pch=16)



# With even more variables,
# we need to build a new representation that summarizes the data in fewer dimensions


     ###                             ###
     ###     ####    ###    ###      ### 
     ###     #   #  #   #  #   #     ###
     ###     ####   #      #####     ###
     ###     #      #   #  #   #     ###
     ###     #       ###   #   #     ###
	 ###                             ###

# UNSUPERVISED
# Reduction of the dimensionality -> Creation of uncorrelated variables

str(iris)

data_iris<-iris[,c("Sepal.Length","Sepal.Width","Petal.Length","Petal.Width")] # Only keep the variables of interest

#### PCA ####

dudi.pca(data_iris) # DUality DIagram . Principal Component Analysis

pca1<-dudi.pca(data_iris, # dataset
		 scannf=FALSE, # barplot of the eigenvalues - SCAN Number of Factors
		 nf=2, # Number of Factors kept for the graph
		 center=TRUE, # Centering - tranforms the data so each variable has a mean of 0
		 scale=TRUE) # Scaling - tranforms the data so each variable has a variance of 1 - same weight in the pca

str(pca1)

### Eigen values
pca1$eig
Explained_Var<-round(pca1$eig/sum(pca1$eig)*100,1) # Controlled/Measured loss of information

### Representation of each variable on the Principal Components
pca1$co # Values

s.corcircle(pca1$co) # Correlation circle

plot(pca1$li, # plot of the indiviuals in the new system
     col=alpha(c("coral","cornflowerblue","darkorchid"),0.5  )[iris[,"Species"]],
     pch=16,
     cex=2)

# Figures together
quartz(height=6,width=11)
par(mfrow=c(1,2))
s.corcircle(pca1$co) # Correlation circle
plot(pca1$li,col=alpha(c("coral","cornflowerblue","darkorchid"),0.5)[iris[,"Species"]],pch=16,cex=2)

# The pca separtes the species even though the species information was not included in the analysis ---> unsupervised

# Same data
s.class(pca1$li, # position of the individuals in the new system
		fac=iris$Species, # grouping
		col=alpha(c("coral","cornflowerblue","darkorchid"),0.7))






     ###                            ###
     ###     #      ###    ###      ### 
     ###     #      #  #  #   #     ###
     ###     #      #  #  #####     ###
     ###     #      #  #  #   #     ###
     ###     #####  ###   #   #     ###
	 ###                            ###


# SUPERVISED

lda1<-discrimin(dudi.pca(data_iris,scannf=F,nf=4), # a pca object
				fac=iris$Species, # grouping factor
				scannf=FALSE, # screeplot
				nf=2) # number of components

### Figure
quartz(height=6,width=11)
par(mfrow=c(1,2))
s.corcircle(lda1$va) # Correlation circle
s.class(lda1$li,fac=iris$Species,col=alpha(c("coral","cornflowerblue","darkorchid"),0.7))

str(lda1)

data(lascaux)
?lascaux

lascaux$morpho #just select the data

data_lascaux <- droplevels(na.omit(data.frame(Rivers=lascaux$riv,Morpho=lascaux$morpho)))    #delete something

pca1<-dudi.pca(data_lascaux[,-1],scannf = F,nf=2)

head(data_lascaux)

dudi.pca(data_lascaux,scannf = F,nf=2)

str(pca1)

s.corcircle(pca1$co)

plot(pca1$li)

quartz()
par(mfrow=c(2,1))
s.corcircle(pca1$co)
s.class(pca1$li,fac=data_lascaux$Rivers)


lda1 <- discrimin(pca1,scannf = F,nf=2,fac=data_lascaux$Rivers)

quartz()
par(mfrow=c(2,1))
s.corcircle(lda1$va)
s.class(lda1$li,fac=data_lascaux$Rivers)








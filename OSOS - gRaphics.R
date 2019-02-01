
### gRaphics ###

rm(list=ls()) # Clears the list of objects in memory

# In this session we will learn how to use R to plot graphics using {base} and {ggplot2}

# Base is already installed in R
# For the package ggplot2:
install.packages("ggplot2") # Downloads and installs ggplot2
library("ggplot2") # Loads ggplot2

install.packages("gridExtra")
library("gridExtra")

# For both packages we will work with the "iris" dataset from {base}


# Loading, examining and preparing the dataset
# --------------------------------------------

data(iris) # loads the iris dataset

iris # the whole dataset
head(iris) # 10 first rows
colnames(iris) # names of the columns
str(iris) # STRucture of the dataset

# Lines with observations (often individuals)
# Columns with "num" (measures) and column with "Factor" (grouping)

# Manipulation of factors
iris$Specices<-as.factor(iris$Specices) # Modifies a column to factor
levels(iris$Species) # Shows the levels of the factor - plotting order

#iris$Species <- factor(x=iris$Species,levels=levels(iris$Species)[c(2,1,3)]) # Changes the order of the levels
#levels(iris$Species)


# Stealing ideas for good looking graphics
# ----------------------------------------

demo(graphics)
# or go to google images / r-graph-gallery.com
# check the requirements for graphics in the journal you are submitting your paper to

# Plotting
# --------


		###                                ###
		###     ###    ##    ###  ####     ###
		###     #  #  #  #  #     #        ###
		###     ###   ####   ##   ###      ###
		###     #  #  #  #     #  #        ###
		###     ###   #  #  ###   ####     ###
		###                                ###


###                                            ###
###  I. MAKING A PLOT WITH BASE STEP BY STEP   ###
###                                            ###

# Building a plot with {base} looks like drawing on a with page
# You will always have the same sequence of command lines:

### 1- OPEN A WINDOW FOR THE GRAPH ######################################################################################################

quartz(height=6,width=6) # function(argument1=value,argument2=value)
# x11(height=4,width=6) # quartz for mac, x11 for windows/linux

### 2- SET THE GENERAL PARAMETERS FOR THE GRAPH #########################################################################################

par() # We will come back to this one later

### 3- CREATE A PLOT - plot(x= ,y=) #####################################################################################################

plot(x= iris$Sepal.Width, y= iris$Sepal.Length) # default scatterplot
plot(Sepal.Length ~ Sepal.Width, data=iris) # better alternative way to write the data - no need to repeat the name of the dataset (iris) 

# After, this is what will happen in real life:
# You will look at your graph and progressively add arguments to the function 
plot(Sepal.Length~Sepal.Width,data=iris,xlim=c(2,5),ylim=c(4,8)) # xlim: limits min and max on x-axis, ylim: limits min and max on y-axis
plot(Sepal.Length~Sepal.Width,data=iris,xlim=c(2,5),ylim=c(4,8),pch=16) # pch: Plotting CHaracter= type of point to use
plot(Sepal.Length~Sepal.Width,data=iris,xlim=c(2,5),ylim=c(4,8),pch=16,col="blue") # col: color for the data - 1 value gives the same color to all points
plot(Sepal.Length~Sepal.Width,data=iris,xlim=c(2,5),ylim=c(4,8),pch=16,col=c("coral","cornflowerblue","darkorchid")[Species]) # 1 color value for each level of the variable betwen brackets
plot(Sepal.Length~Sepal.Width,data=iris,xlim=c(2,5),ylim=c(4,8),pch=16,col=c("coral","cornflowerblue","darkorchid")[Species],cex=2) # cex: Character EXpansion (size of the points)
plot(Sepal.Length~Sepal.Width,data=iris,xlim=c(2,5),ylim=c(4,8),pch=16,col=c("coral","cornflowerblue","darkorchid")[Species],cex=Petal.Length)
plot(Sepal.Length~Sepal.Width,data=iris,xlim=c(2,5),ylim=c(4,8),pch=16,col=alpha(c("coral","cornflowerblue","darkorchid")[Species],0.5),cex=Petal.Length,bty="n",las=1, xlab="Sepal width (cm)",ylab="Sepal length (cm)",main="Iris") # bty= Box TYpe, las: orientation of the tick labels, xlab: X-axis LABel, main: title

# But on your script you only keep one line
plot(Sepal.Length~Sepal.Width,data=iris,xlim=c(2,5),ylim=c(4,8),pch=16,col=alpha(c("coral","cornflowerblue","darkorchid")[Species],0.5),cex=Petal.Length,bty="n",las=1, xlab="Sepal width (cm)",ylab="Sepal length (cm)",main="Iris",cex.main=3,font.main=4)

### 4- MODIFY/REPLACE PARTS OF THE GRAPH #################################################################################################

# There is a limited number of parameters that you can change from the plot() function
# If you need to really tune the whole graph you will need to use a new fucntion for each part of the graph you want to tune

# Example with the axes - function axis()
# ---------------------------------------

# First delete the axes in your plot

plot(Sepal.Length~Sepal.Width,data=iris,
	 xlim=c(2,5),ylim=c(4,8),
	 pch=16,
	 col=alpha(c("coral","cornflowerblue","darkorchid")[Species],0.5),
	 cex=Petal.Length,
	 bty="n",
	 las=1, 
	 xlab="Sepal width (cm)",ylab="Sepal length (cm)",
	 main="Iris",cex.main=3,font.main=4,
	 axes=FALSE) # Deletes the axes

# Then write the axis function with your arguments
axis(side=1,col="grey30",lwd=3,font=2,las=1,at=c(2:5),cex.axis=2) # side: 1=bottom, 2=left, 3=top, 4=right # lwd: Line WiDth # font: 1=normal, 2=bold, 3=italic, 4= bold and italic # las: orientation of the tick labels # at: position of the ticks # cex.axis: Character EXpansion of the labels on the AXIS
axis(side=2,col="grey30",lwd=3,font=2,las=1,at=c(4:8),cex.axis=2)

# PROBLEM ---> the tick labels on the x-axis are too close from the ticks


# SOLUTION 1: DIY
quartz(height=6,width=6)
plot(Sepal.Length~Sepal.Width,data=iris,
	 xlim=c(2,5),ylim=c(4,8),
	 pch=16,
	 col=alpha(c("coral","cornflowerblue","darkorchid")[Species],0.5),
	 cex=Petal.Length,
	 bty="n",
	 las=1, 
	 xlab="Sepal width (cm)",ylab="Sepal length (cm)",
	 main="Iris",cex.main=3,font.main=4,
	 axes=FALSE) # Deletes the axes
axis(side=1,col="grey30",lwd=3,font=2,las=1,at=c(2:5),cex.axis=2,labels=c("","","","")) # "Delete" the labels
mtext(side=1,at=2:5,line=1.7,text=2:5,cex=2,font=2,col="grey30") # Add the labels manually with mtext (Margin TEXT) # line: how far from the axis # text: text to be written  
axis(side=2,col="grey30",lwd=3,font=2,las=1,at=c(4:8),cex.axis=2,col.axis="grey30")

# SOLUTION 2: ASK THE INTERNET
quartz(height=6,width=6)
par(ylbias=-0.3) # <-------------------------- use of the general parameters function
plot(Sepal.Length~Sepal.Width,data=iris,
	 xlim=c(2,5),ylim=c(4,8),
	 pch=16,
	 col=alpha(c("coral","cornflowerblue","darkorchid")[Species],0.5),
	 cex=Petal.Length,
	 bty="n",
	 las=1, 
	 xlab="Sepal width (cm)",ylab="Sepal length (cm)",
	 main="Iris",cex.main=3,font.main=4,
	 axes=FALSE) # Deletes the axes
axis(side=1,col="grey30",lwd=3,font=2,las=1,at=c(2:5),cex.axis=2) # side: 1=bottom, 2=left, 3=top, 4=right # lwd: Line WiDth # font: 1=normal, 2=bold, 3=italic, 4= bold and italic # las: orientation of the tick labels # at: position of the ticks # cex.axis: Character EXpansion of the labels on the AXIS
axis(side=2,col="grey30",lwd=3,font=2,las=1,at=c(4:8),cex.axis=2)


# Now you need bigger axes labels...
quartz(height=6,width=6)
par(ylbias=-0.3)
plot(Sepal.Length~Sepal.Width,data=iris,
	 xlim=c(2,5),ylim=c(4,8),
	 pch=16,
	 col=alpha(c("coral","cornflowerblue","darkorchid")[Species],0.5),
	 cex=Petal.Length,
	 bty="n",
	 las=1, 
	 xlab="Sepal width (cm)",ylab="Sepal length (cm)",
	 main="Iris",cex.main=3,font.main=4,
	 axes=FALSE,
	 cex.lab=2, font.lab=2,col.lab="grey30") # Character EXpansion, font, color of the LABels

axis(side=1,col="grey30",lwd=3,font=2,las=1,at=c(2:5),cex.axis=2,col.axis="grey30")
axis(side=2,col="grey30",lwd=3,font=2,las=1,at=c(4:8),cex.axis=2,col.axis="grey30")


### 4- ADD NEW OBJECTS #####################################################################################################################

legend() # Adds a legend
text() # Adds text
mtext() # Adds text in the margin
segments() # Adds segments
abline() # Adds straight line
line() # Adds line
curve() # Adds curve
arrows() # Adds arrows
points() # Adds points
rect() # Adds points
symbols() # Adds symbols
grid() # Adds grid
rug() # Adds rug
#... and many other
# check ?legend, ?text, ?mtext, ... for details



# Example with legend()
quartz(height=6,width=6)
par(ylbias=-0.3)
plot(Sepal.Length~Sepal.Width,data=iris,
	 xlim=c(2,5),ylim=c(4,8),
	 pch=16,
	 col=alpha(c("coral","cornflowerblue","darkorchid")[Species],0.5),
	 cex=Petal.Length,
	 bty="n",
	 las=1, 
	 xlab="Sepal width (cm)",ylab="Sepal length (cm)",
	 main="Iris",cex.main=3,font.main=4,
	 axes=FALSE,
	 cex.lab=2, font.lab=2,col.lab="grey30")
axis(side=1,col="grey30",lwd=3,font=2,las=1,at=c(2:5),cex.axis=2,col.axis="grey30")
axis(side=2,col="grey30",lwd=3,font=2,las=1,at=c(4:8),cex.axis=2,col.axis="grey30")

legend(4.2,8,pch=rep(16,3),col=alpha(c("coral","cornflowerblue","darkorchid"),0.5),legend=levels(iris$Species))

# Example with text()
quartz(height=6,width=6)
par(ylbias=-0.3)
plot(Sepal.Length~Sepal.Width,data=iris,
	 xlim=c(2,5),ylim=c(4,8),
	 pch=16,
	 col=alpha(c("coral","cornflowerblue","darkorchid")[Species],0.5),
	 cex=Petal.Length,
	 bty="n",
	 las=1, 
	 xlab="Sepal width (cm)",ylab="Sepal length (cm)",
	 main="Iris",cex.main=3,font.main=4,
	 axes=FALSE,
	 cex.lab=2, font.lab=2,col.lab="grey30")
axis(side=1,col="grey30",lwd=3,font=2,las=1,at=c(2:5),cex.axis=2,col.axis="grey30")
axis(side=2,col="grey30",lwd=3,font=2,las=1,at=c(4:8),cex.axis=2,col.axis="grey30")

text(c(4,3.6,4),y=c(4.6,6.3,7.4),labels=levels(iris$Species),col=alpha(c("coral","cornflowerblue","darkorchid"),0.5),cex=2,font=4,pos=4)


### 5- ADD NEW OBJECTS - STATISTICS #####################################################################################################################

for (loop_species in 1:nlevels(iris$Species))
{
	sub_data<-subset(iris,Species==levels(iris$Species)[loop_species])
	linear_model<-lm(Sepal.Length~Sepal.Width,data=sub_data)
	# abline(linear_model)
	segments(min(sub_data$Sepal.Width),
			 min(sub_data$Sepal.Width)*linear_model$coeff[2]+linear_model$coeff[1],
			 max(sub_data$Sepal.Width),
			 max(sub_data$Sepal.Width)*linear_model$coeff[2]+linear_model$coeff[1],
			 col=c("darkred","navyblue","darkorchid4")[loop_species],lwd=3)
}

# You have to do the stats you want to plot
# or find a package with a function that will do it
# ggplot2 is doing it for you


### 6- CHANGE THE LAYOUT #####################################################################################################################


# With - par(mfrow=)

quartz(height=4,width=11)
par(ylbias=-0.3,
    mfrow=c(1,3), # Multiple Figures ROW:  c(row,columns)
    mar=c(6,5,4,2)) # MARgins
	
for (loop_species in 1:nlevels(iris$Species))
{
	Sub_sp<-levels(iris$Species)[loop_species]
	sub_data<-subset(iris,Species==levels(iris$Species)[loop_species])
	
	plot(Sepal.Length~Sepal.Width,data=droplevels(subset(iris,Species!=Sub_sp)),
	     xlim=c(1.8,5),ylim=c(4,8),
	     pch=16,
	     col=alpha(c("lightgrey","lightgrey")[Species],0.5),
	     cex=Petal.Length,
	     bty="n",
	     las=1, 
	     xlab="Sepal width (cm)",ylab="Sepal length (cm)",
	     main=c("Iris setosa","Iris versicolor","Iris virginica")[loop_species],
	     col.main=alpha(c("coral","cornflowerblue","darkorchid")[loop_species],0.5),
	     cex.main=3,
	     font.main=4,
	     axes=FALSE,
	     cex.lab=2, 
	     font.lab=2,
	     col.lab="grey30")
	points(Sepal.Length~Sepal.Width,data=subset(iris,Species==Sub_sp),
	       col=alpha(c("coral","cornflowerblue","darkorchid")[loop_species],0.5),
	       pch=16,
	       cex=Petal.Length)
	axis(side=1,col="grey30",lwd=3,font=2,las=1,at=c(2:5),cex.axis=2,col.axis="grey30")
	axis(side=2,col="grey30",lwd=3,font=2,las=1,at=c(4:8),cex.axis=2,col.axis="grey30")

	linear_model<-lm(Sepal.Length~Sepal.Width,data=sub_data)
	segments(min(sub_data$Sepal.Width), # x1
	         min(sub_data$Sepal.Width)*linear_model$coeff[2]+linear_model$coeff[1], # y1
	         max(sub_data$Sepal.Width), # x2
	         max(sub_data$Sepal.Width)*linear_model$coeff[2]+linear_model$coeff[1], # y2
	         col=c("red","blue","magenta")[loop_species],lwd=3)
}

# With - layout(mat=)

#   1 3 3
#   2 3 3 

quartz(height=7,width=11)
layout(mat=matrix(c(1,3,3,2,3,3),nrow=2,ncol=3,byrow=T))
par(ylbias=-0.3,mar=c(6,5,4,2)) # MARgins

for (loop_species in 1:nlevels(iris$Species))
{
	Sub_sp<-levels(iris$Species)[loop_species]
	sub_data<-subset(iris,Species==levels(iris$Species)[loop_species])
	
	plot(Sepal.Length~Sepal.Width,data=droplevels(subset(iris,Species!=Sub_sp)),
	     xlim=c(1.8,5),ylim=c(4,8),
	     pch=16,
	     col=alpha(c("lightgrey","lightgrey")[Species],0.5),
	     cex=Petal.Length,
	     bty="n",
	     las=1, 
	     xlab="Sepal width (cm)",ylab="Sepal length (cm)",
	     main=c("Iris setosa","Iris versicolor","Iris virginica")[loop_species],
	     col.main=alpha(c("coral","cornflowerblue","darkorchid")[loop_species],0.5),
	     cex.main=3,
	     font.main=4,
	     axes=FALSE,
	     cex.lab=2, 
	     font.lab=2,
	     col.lab="grey30")
	points(Sepal.Length~Sepal.Width,data=subset(iris,Species==Sub_sp),
	       col=alpha(c("coral","cornflowerblue","darkorchid")[loop_species],0.5),
	       pch=16,
	       cex=Petal.Length)
	axis(side=1,col="grey30",lwd=3,font=2,las=1,at=c(2:5),cex.axis=2,col.axis="grey30")
	axis(side=2,col="grey30",lwd=3,font=2,las=1,at=c(4:8),cex.axis=2,col.axis="grey30")

	linear_model<-lm(Sepal.Length~Sepal.Width,data=sub_data)
	segments(min(sub_data$Sepal.Width), # x1
	         min(sub_data$Sepal.Width)*linear_model$coeff[2]+linear_model$coeff[1], # y1
	         max(sub_data$Sepal.Width), # x2
	         max(sub_data$Sepal.Width)*linear_model$coeff[2]+linear_model$coeff[1], # y2
	         col=c("red","blue","magenta")[loop_species],lwd=3)
}




###                             ###
###  II. OTHER TYPES OF PLOTS   ###
###                             ###

### 1- STRIPCHART ################################################################################

stripchart(Sepal.Length ~ Species, data=iris) # default stipchart

stripchart(Sepal.Length ~ Species, data=iris,
		   pch=18, # type of point, try this line: plot(0:25,rep(1,26),ylim=c(0,2),pch=0:25,col="black",bg="red") ; grid()
           col=alpha(c("coral","cornflowerblue","darkorchid"),0.5), # color of the outline of the point           
           cex=3) # size of the points

stripchart(Sepal.Length ~ Species, data=iris,
		   pch=18, # type of point, try this line: plot(0:25,rep(1,26),ylim=c(0,2),pch=0:25,col="black",bg="red") ; grid()
           col=alpha(c("coral","cornflowerblue","darkorchid"),0.5), # color of the outline of the point           
           cex=3, # size of the points
           vertical=TRUE) # orientation

stripchart(Sepal.Length ~ Species, data=iris,
		   pch=18, # type of point, try this line: plot(0:25,rep(1,26),ylim=c(0,2),pch=0:25,col="black",bg="red") ; grid()
           col=alpha(c("coral","cornflowerblue","darkorchid"),0.5), # color of the outline of the point           
           cex=3, # size of the points
           vertical=TRUE, # orientation
           method="jitter") # jitters the points... (set.seed(468))


### 2- BOXPLOT ################################################################################

# We have seen the function plot() that created a scatter plot with 2 numerical variables
# plot() will also make a boxplot if you enter a numerical variable in y and a factor variable in x

plot(Sepal.Length ~ Species, data=iris)

# However it is better to use the proper function boxplot() to get acces to a larger set of parameters - pars

boxplot(Sepal.Length ~ Species, data=iris,
        las=1,
        boxwex=0.5,
        notch=TRUE,
        col=alpha(c("coral","cornflowerblue","darkorchid"),0.5),
        border="grey40",
        ylab="Sepal.Length")
        
        
### 1 & 2- Combining plots with add=TRUE ####################################################

boxplot(Sepal.Length ~ Species, data=iris, las=1, 
		boxwex=0.5, # Width of the boxplots
		notch=TRUE) # CI median 95%
		
stripchart(Sepal.Length ~ Species, data=iris,
		   pch=18, # type of point, try this line: plot(0:25,rep(1,26),ylim=c(0,2),pch=0:25,col="black",bg="red") ; grid()
           col=alpha(c("coral","cornflowerblue","darkorchid"),0.5), # color of the outline of the point           
           cex=3, # size of the points
           vertical=TRUE, # orientation
		   method="jitter", # jitters the points... (set.seed(468))
		   add=TRUE) # adds the plot to an existing plot


### 3- BARPLOT ##############################################################################

# Different type of data!!!
data_barplot<-as.matrix(aggregate(cbind(Petal.Length,Petal.Width,Sepal.Length,Sepal.Width) ~ Species , data=iris , FUN=mean)[,2:5])
rownames(data_barplot)<-levels(iris$Species)

# plot the barplot
barplot(data_barplot)

barplot(data_barplot,
		beside=T, # puts the bars side by side instead of on top of each other - you can write T instead of TRUE (and F instead of FALSE)
		legend=T, # adds a legend
		col=c("coral","cornflowerblue","darkorchid"), # the colors filling the bars
		border="transparent", # the color of the border of the bars
		las=1, # orientation of the ticks labels
		ylab="size (cm)", # Y-axis LABel
		names=c("Petal length","Petal width","Sepal length","Sepal width")) # X-axis labels for the groups of bars (single bar if beside=FALSE)


### 4- PIE CHART ##############################################################################

# Different type of data!!!
data_pie<-table(iris$Species)

# plot the pie
pie(data_pie)

### 5- HISTOGRAM ##############################################################################

hist(iris$Petal.Length)

hist(subset(iris,Species=="setosa")$Petal.Length,
	 col="lightgrey",
	 freq=F)

### 6- PLOT ############################################

data_hist<-hist(subset(iris,Species=="setosa")$Petal.Length,col="lightgrey", freq=F)

plot(data_hist$mids,data_hist$density)

plot(data_hist$mids,data_hist$density,
	 type="b",
	 lty="dotted",
	 pch=21,
	 cex=2,
	 col="red",
	 bg="blue",
	 lwd=3)
	 

hist(subset(iris,Species=="setosa")$Petal.Length,col="lightgrey", freq=F)
points(data_hist$mids,data_hist$density,
	   type="b",
	   lty="dotted",
	   pch=21,
	   cex=2,
	   col="red",
	   bg="blue",
	   lwd=3)







		###                                                 ###
		###    ###    ###   ###   #      ##   #####   ##    ###
		###   #      #      #  #  #     #  #    #    #  #   ###
		###   #  ##  #  ##  ###   #     #  #    #      #    ###
		###   #   #  #   #  #     #     #  #    #     #     ###
		###    ###    ###   #     ####   ##     #    ####   ###
		###                                                 ###



# Based on the grammar of graphics


###                                               ###
###  I. MAKING A PLOT WITH GGPLOT2 STEP BY STEP   ###
###                                               ###


### ggplot ########################################################################################################

ggplot(data=iris, # the data set
	   aes(x= Sepal.Width, y=Sepal.Length))  # AESthetics, in ggplot() you define the dimensions of your graph (x: what is on the x-axis, y: what is on y-axis)


### geom #########################################################################################################

ggplot(data=iris, aes(x= Sepal.Width, y=Sepal.Length)) + 
	geom_point() # Adds a layer with points

# There are many types of geom() that can be added as layers on top of each other
# Just as an example ############################################################
ggplot(data=iris, aes(x= Sepal.Width, y=Sepal.Length)) + 
	geom_point(color="red") + # put another + at the end of the line
	geom_line(color="blue") # Adds a layer that plots a line between data points

ggplot(data=iris, aes(x= Sepal.Width, y=Sepal.Length)) + 
	geom_line(color="blue") + # for the line under the points, put the line first
	geom_point(color="red") # put another + at the end of the line

ggplot(data=iris, aes(x= Sepal.Width, y=Sepal.Length)) + 
	geom_path(color="blue") + # Draws the path between points
	geom_point(color="red")
#################################################################################

# But now we just want points with one color for each species

ggplot(data=iris, aes(x= Sepal.Width, y=Sepal.Length)) + 
	geom_point()
# in {base} we would have written: points(y~x, col=c("coral","cornflowerblue","darkorchid")[iris$Species])

# In ggplot the Species is coded as a 3rd dimension more obviously than in base
# We actually have y ~ x ~ color  <--->  sepal.length ~ sepal.width ~ species

# it is therefore put alongside x and y in ggplot(aes())
ggplot(data=iris, aes(x=Sepal.Width, y=Sepal.Length, color=Species)) +
	geom_point()

# We can add more dimensions to the graph (color= ,size=, shape= )
ggplot(data=iris, aes(x=Sepal.Width, y=Sepal.Length, color=Species, size=Petal.Length)) +
	geom_point()

# But we want these colors -> c("coral","cornflowerblue","darkorchid")

# Automatic transformation of the data by ggplot:
# Species ---> colors     
# setosa versicolor virginica  ---> red green blue


### scale ########################################################################################################

# color scale:
ggplot(data=iris, aes(x= Sepal.Width, y=Sepal.Length, color=Species, size= Petal.Length)) +
	geom_point() +
	scale_color_manual(values=alpha(c("coral","cornflowerblue","darkorchid"),0.5)) # 
 
	# scale_color_manual: scale _ aesthetic _ type of scale

# size scale:
ggplot(data=iris, aes(x= Sepal.Width, y=Sepal.Length, color=Species, size= Petal.Length)) +
	geom_point() +
	scale_color_manual(values=alpha(c("coral","cornflowerblue","darkorchid"),0.5)) +
	scale_size_continuous(range=c(1,10)) # note that it doesn't change the legend - real values / visual values

# x or z scales: scale_y_log10   scale_x_sqrt




### ADJUSTMENTS OF THE NON-DATA COMPONENTS OF THE PLOT #########################################################

A <- ggplot(data=iris, aes(x= Sepal.Width, y=Sepal.Length, color=Species, size= Petal.Length)) +
	     geom_point() +
	     scale_color_manual(values=alpha(c("coral","cornflowerblue","darkorchid"),0.5)) +
	     scale_size_continuous(range=c(1,10)) # note that it doesn't change the legend - real values / visual values
B<-
A + 
coord_cartesian(xlim=c(1,6),ylim=c(4,8)) + # min and max on x-axis and y-axis 
guides(size="none",color="legend") + # deletes the size part of the legend
labs(title="Iris",x="Sepal width",y="Sepal length",color="Species names",size="Petal length") # Labels


### theme #########################################################################################################

B +
theme(plot.title= element_text(hjust=0.5,family="serif",face="bold",color="grey40",size=30),
      panel.background= element_rect(fill="white"),
      axis.line= element_line(color="grey40",size=1,lineend="round",arrow=arrow(angle=30,length=unit(2.5,"mm"),type="open")),
      axis.ticks.length= unit(2,"mm"),
      axis.ticks= element_line(color="grey40",size=1,lineend="round"),
      axis.text= element_text(size=15,face="bold",color="grey40")
      )

B + theme_grey() # default
B + theme_bw() 
B + theme_minimal()
B + theme_classic() 
B + theme_void()
B + theme_linedraw()
B + theme_dark()

B + theme_dark() + theme(plot.title= element_text(hjust=0.5)) # customize an existing theme

### Layout ##########################################################################################################
A + facet_grid(Species~.)	
A + facet_grid(.~Species)

# with the package gridExtra

SETOSA <- ggplot(data=subset(iris,Species=="setosa"), aes(x= Sepal.Width, y=Sepal.Length, color=Species, size= Petal.Length)) +
	           geom_point(color="coral")
VERSICOLOR <- ggplot(data=subset(iris,Species=="versicolor"), aes(x= Sepal.Width, y=Sepal.Length, color=Species, size= Petal.Length)) +
	           geom_point(color="cornflowerblue")
VIRGINICA <- ggplot(data=subset(iris,Species=="virginica"), aes(x= Sepal.Width, y=Sepal.Length, color=Species, size= Petal.Length)) +
	           geom_point(color="darkorchid")

quartz(width=5,height=7)
grid.arrange(SETOSA,VERSICOLOR,VIRGINICA,nrow=3,ncol=1)







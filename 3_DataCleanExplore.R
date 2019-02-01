###------------Working with Data Frames-----------------------------------------
# By Danielle Walkup (with lots of help from Google) 
# OSOS 2018 Workshop, August 2018
#
# This script goes with the intro pdf and will take you through the basic intro
# to R. 
# 
###------------Packages and Directory-------------------------------------------
# 
## Lets be good and set up any packages we are going to use in this script:
#install.packages(c("tidyverse",""))
install.packages("tidyverse")
library(tidyverse)  
#
## And double check our working directory:
getwd()  #we are still in the OSOS_IntroR folder where we want to be!
#setwd()  #but we could change it if we needed to
#
###------------Load our Practice Data Set---------------------------------------
#
## We've already done this at the end of our last script, but let's make sure 
## we have the correct data set loaded and ready to go
dir("data")  #I can never remember the exact file name, so lets check the dir
#
liz.file <- "data/LizardData.csv"
liz.data <- read.csv(liz.file)
# and check that it loaded ok:
head(liz.data)
tail(liz.data)  #I like to check the end too to make sure there're no blanks
#
###------------Cleaning our Data Set--------------------------------------------
#
# Let's check the summary again, cause we had spotted some issues previously
summary(liz.data)  
# Some issues:
# Mark - we have 101 before a blank - that could indicate some issues, possibly 
# Sex - we have some duplicate categories (M vs. Male) and an age class (J)
# SVL - looks ok generally 
# Regen - We have No and numbers, that's not good, this should just be numbers
# Recap - again, with the duplicate categories! (N vs no vs No)
#
# Let's double check the structure and make sure everything is the way we want it:
str(liz.data)
# ID = species code, should be a factor, let's double check the levels
levels(liz.data$ID)  #and we see an issue immediately, with the white space!
#
# let's reload the data and strip the white spaces
## NOTE: normally, I'd just edit the read.csv(liz.file) above, but we'll just do
## it here instead so we can keep track of the work flow
#
liz.data <- read.csv(liz.file, strip.white = T)
# and double check
levels(liz.data$ID)  #these look ok now
str(liz.data) #lets keep looking
#
# Mark is a factor, with 95 levels. This looks good for now. Even though the Marks
# are numbers, they identify individual lizards so we want to leave them as as factor
#
# Grid is also a factor, with 35 levels which is fine, because I know there were
# 36 available grids, except there are some blank ones (the ""), and some with
# only 2 letters, when I know it should be a 3 letter code where all start with E.
#
# Trap is an integer (should range from 1 - 9), we can check that in a minute
#
# Sex is a factor with 5 levels. Really should either be F, M, or blank in this 
# context.
#
# SVL, Tail, Regen, and Mass should actually be numeric, these are measurements
# that we are going to want to work with.
#
# Notes is a factor. If I had assigned colClasses I probably would have made it 
# a character, but we won't be using it here, so it shouldn't matter too much.
#
# Recap is a factor with 6 levels. Should be either Y or N. 
#
# Date is a factor here, but we actually want a date. 
#
## So now that we've looked at everything, we could go back through and reassign
## the individual columns like so:
liz.data$SVL <- as.numeric(liz.data$SVL)  #Note that we assign this column with 
                                          #the changes so they are "saved"
class(liz.data$SVL)
#
## OR since this data set isn't very big, we can just assign colClasses 
head(liz.data,2)  ##I'm going to look at the data frame so I know the column order
liz.data <- read.csv(liz.file, strip.white = T
                     , colClasses = c("factor", "factor", "character", "integer"
                                      , "factor", "numeric", "numeric", "numeric"
                                      , "numeric", "character", "factor", "Date"))
#
## BUT we run into an error: expected 'a real', got 'Yes' - From prior experience,
## I suspect that the No in the Regen column is probably the issue - R expected
## to see a real number, but got a word instead, so let's change the numeric to 
## a character for now:
liz.data <- read.csv(liz.file, strip.white = T
                     , colClasses = c("factor", "factor", "character", "integer"
                                      , "factor", "numeric", "numeric", "character"
                                      , "numeric", "character", "factor", "Date"))
#
## OH and another error. So charToDate(x) is telling me that it is having trouble
## reading my dates as dates. This may be because people were entering the dates
## in different formats in excel, so lets just leave that as a character for now
liz.data <- read.csv(liz.file, strip.white = T
                     , colClasses = c("factor", "factor", "character", "integer"
                                      , "factor", "numeric", "numeric", "character"
                                      , "numeric","character", "factor", "character"))
#
## Woohoo, it worked this time!...But let's double check
head(liz.data)  #Mmmm look at that Date column...there's our issue!
str(liz.data)  #lets double check that columns were properly assigned
#
#
## Now we can tackle some of the pesky issues:
# let me introduce you to a girl's best friend - the tidyverse! 
# A collection of R packages for data science: https://www.tidyverse.org/
# R for Data Science by Hadley Wickham and Garrett Grolemund: http://r4ds.had.co.nz/
#
# First lets get rid of those no's (and probable yes's) in the Regen
# I'm just going to run a table to see what we have going on
table(liz.data$Regen)  #so we have 82 blanks, 3 No's, 1 Yes, and the weird 38/6
#
# let's check out that weird 38/6, remember the bracket's ([row,col]) we used in 
# the last script to pull out elements of the matrices and data.frames? We can 
# use them here to find the row that matches the one weird record:
liz.data[liz.data$Regen == "38/6", ]  #so here I'm telling R that I want the one row 
                                     #from the Regen column that matches the 
                                     #character "38/6", then I use the ", ]" which
                                     #says I want all the columns
# Other ways to subset: 
liz.data[liz.data$Regen %in% "38/6", ] 
which(liz.data$Regen == "38/6")  #tells us the row:
liz.data[47,]  #you can use that actual row OR
liz.data[which(liz.data$Regen == "38/6"), ]
?subset
subset(liz.data, Regen == "38/6")
#
# so the notes tells me that there were two areas of tail regeneration, so I'm just
# going to change this to 38
# using dplyr::recode
liz.data$Regen <- recode(liz.data$Regen, "38/6" = "38")
# and we can double check:
table(liz.data$Regen) #and our "38/6" is gone, and we have an 3rd 38 - that's good
# and get rid of the No and Yes
liz.data$Regen <- recode(liz.data$Regen, "No" = "")  #we just want blanks here
liz.data[liz.data$Regen == "Yes", ]  #lets see if they measured the regen...
# nope they sure didn't. Since the total tail length includes the regen and we
# won't be doing much with the regen, I'm just going to leave it blank. If 
# you were using this variable, you may have to account for this in another way.
liz.data$Regen <- recode(liz.data$Regen, "Yes" = "")
# and one last table to double check
table(liz.data$Regen)  #looks good
# so lets make that numeric now.
liz.data$Regen <- as.numeric(liz.data$Regen)
#
## Let's clean up the sex column, because we do want to use that:
table(liz.data$Sex)
# lets change the Male to M - capitilization matters!
liz.data$Sex <- recode(liz.data$Sex, "Male" = "M")  #TIP: This is a nice function
# because the recode changes the factor levels as well. Sometimes when you are 
# working with factors, the levels can get complicated, so this is convenient
#
# and the J to blank, since it was small it was probably too hard to determine sex
liz.data[liz.data$Sex == "J",]  #Juv ASMA are too small to check sex
liz.data$Sex <- recode(liz.data$Sex, "J" = "")
class(liz.data$Sex)  #this is still a factor, and...
levels(liz.data$Sex)  #now we are down to the three levels we wanted
#
## So now that we have those basic columns cleaned up, lets subset the data frame
## down to just the columns we want to use
head(liz.data,2)
liz.sub <- liz.data[, c(1:2, 5:9)]  #here we are going to keep just some of the cols
head(liz.sub)
# Alternative ways to subset:
#liz.sub1 <- liz.data[, c("ID", "Mark", "Sex", "SVL", "Tail", "Regen", "Mass")]
#liz.sub2 <- subset(liz.data, select = c("ID", "Mark", "Sex", "SVL", "Tail", "Regen", "Mass")
#
## So many NA's - what if we wanted to create a subset of our data frame with 
## no NA's? 
liz.subna <- liz.sub[!is.na(liz.sub$Sex), ]
is.na(liz.subna$Sex)  #that's a lot of falses, lets summarize that
sum(is.na(liz.subna$Sex))  #sum counts FALSE as 0 and TRUE as 1, letting us get 
                           # a count of na's
#
# BUT! because this was a factor that had levels assigned, just because it got
# subsetted doesn't mean those factors disappear! One way to get around this is
# to change the column to numeric or character, subset, then change back to factor
levels(liz.subna$Sex)
#
#
## Finally I'm going to export my clean data frame so that I can use it in other
## Places as needed
dir.create("outputs/data")  #first I'm going to add a folder to the directory
write.csv(liz.sub, "outputs/data/LizardData_Clean.csv")
#
###------------Descriptive Statistics-------------------------------------------
#
# since we are only working with this one data frame, I'm going to attach it here
# so I can just type the column names instead of dataframe$columnname
attach(liz.sub)  # just don't forget to detach at the end! 
mean(Regen)  #Wait, we changed regen to numeric, why isn't it working???
mean(Regen, na.rm = T)  #R can't process it with the na's so we need to remove them
# so many decimal points!
round(mean(Regen, na.rm = T), 2)  #you can nest functions
# 
sd(Regen, na.rm = T)
max(Regen, na.rm = T)
min(Regen, na.rm = T)
median(Regen, na.rm = T)
range(Regen, na.rm = T)
quantile(Regen, na.rm = T)
#
# Apply functions
apply(liz.sub[, 4:7], 2, mean, na.rm = T)

apply(liz.sub[, 4:7], 2, function(x) mean(x, na.rm = T))

tapply(SVL, ID, mean, na.rm = T)  

detach(liz.sub)
#
## What if you just want a table of summary information???
liz.summ <- liz.sub %>% group_by(ID) %>%
            summarise(avgSVL = mean(SVL, na.rm = T), sdSVL = sd(SVL, na.rm = T)
                      , maxSVL = max(SVL, na.rm = T), minSVL = min(SVL, na.rm = T)
                      , avgTail = mean(Tail, na.rm=T), sdTail=sd(Tail, na.rm = T) 
                      , avgMass = mean(Mass, na.rm=T), sdMass=sd(Mass, na.rm=T)
                      , Nliz = n()
  )

## Whoa, whoa, whoa, where did those "%>%" come from?! The package magrittr (which
## is called automatically through tidyverse) uses %>% essentially as a pipeline,
## breaking what we would normally nest in parentheses and telling R to take the
## value of that which is to the left and pass it to the right as an argument.
## So to translate what we just told R above: Here's the data frame (liz.sub), 
## we want to evaluate for each species (group_by(ID)), and what we want to evaluate
## is everything in the summarise function. 
#
# As a more digestible example, consider:
liz.sub$SVL %>% mean(na.rm = T)
liz.sub %>% with(SVL) %>% mean(na.rm = T)
liz.sub %>% .$SVL %>% mean(na.rm = T)  #note the ".$" which sends R back to the prior argument
# VS:
mean(liz.sub$SVL, na.rm = T)
#
# so we've essentially just rearranged the order we type, but R can still evaluate
# it fine. This takes practice, and isn't always better, but it definitely can 
# make writing some more complex or nested code clearer. There are almost always
# multiple ways you can write code in R, so it's just becoming comfortable with 
# what you know, but also working on writing clearer and more concise code.
#
## One other thing to be aware of, when working in the tidyverse: the tibble.
class(liz.summ)
head(liz.summ, 2)
# so now liz.summ has multiple classese associated with it, and now when you look
# at the data frame, we see it is called a tibble and you have more info about
# each column. Tibbles are data frames but they do much less: it never changes 
# the type of the inputs (e.g. it never converts strings to factors!), it never 
# changes the names of variables, and it never creates row names., but they tweak 
# some older behaviours to make life a little easier. But we don't want to jump
# into those now. But for more info: http://r4ds.had.co.nz/tibbles.html
#
#
# because we want to keep this as a data frame, we are going to add one argument
# at the end of the code to tell R to turn it back to a data frame once the 
# summarising is done:
liz.summ <- liz.sub %>% group_by(ID) %>%
  summarise(avgSVL = mean(SVL, na.rm = T), sdSVL = sd(SVL, na.rm = T)
            , maxSVL = max(SVL, na.rm = T), minSVL = min(SVL, na.rm = T)
            , avgTail = mean(Tail, na.rm=T), sdTail=sd(Tail, na.rm = T) 
            , avgMass = mean(Mass, na.rm=T), sdMass=sd(Mass, na.rm=T)
            , Nliz = n()) %>%
            as.data.frame()
#
# and again we can save that summary output:
write.csv(liz.summ, "outputs/data/LizardSummaryData.csv")
#
###------------Graphing the Data-------------------------------------------------
#
## R has a number of basic plotting functionalities that I'll show examples of 
## here. There is also ggplot2, lattice, and many other packages, which I won't cover here.
#
## NOTE: I'm going to attach liz.sub here again to make our lives easier:
attach(liz.sub)  # TIP: when you write attach(), go down a couple lines and add 
                 # detach() that way you don't forget to close it out!
# Basic plot types:
?plot  #so we can see the plot format of (x,y,...), where "..." is a myriad of arguments
#
plot(SVL, Tail)  #for a basic scatterplot
plot(Tail ~ SVL)  #we can also use the "~", here the format is y ~ x though
hist(SVL)  #we have different types of plots
boxplot(SVL ~ ID)  #more plots 
plot(SVL ~ ID)  #but R can be smart about formatting the plots based on the data
#
# we can change different aspects:
plot(Tail ~ SVL)
plot(Tail ~ SVL, pch = 15)  #pch controls the shape 
plot(Tail ~ SVL, cex = 2)  #cex give a relative size control
plot(Tail ~ SVL, col = "purple")  #you can change the color
plot(Tail ~ SVL, col = ID)  #you can plot different colors for different factors
plot(Tail ~ SVL, col = Sex)
plot(Tail ~ SVL, col = ID, xlab = "Snout-vent Length (mm)", ylab = "Tail Length (mm)")
# we can add a legend:
?legend
legend(15, 225, legend = levels(ID), fill = 1:6, cex = 0.5)

# Let's look at some of the other arguments:
boxplot(SVL ~ ID)
points(SVL ~ ID)  #we can actually add the points
points(SVL ~ jitter(as.numeric(ID)), col = "green")  #NOTE: we can't use jitter 
                                                     # on a factor, so we adjust it
# we can add a fit line to the plot
plot(Tail ~ SVL)
abline(lm(Tail ~ SVL))  #lm() fits a linear regression
#
## Before we go let's export a plot:
?jpeg
dir.create("outputs/figures")
jpeg(filename = "outputs/figures/SVL_Tail_Scatter.jpg", width = 1200, height = 1200
     , units = "px", res = 300)
plot(Tail ~ SVL, col = ID, xlab = "Snout-vent Length (mm)"
          , ylab = "Tail Length (mm)")
legend(15, 225, legend = levels(ID), fill = 1:6, cex = 0.5)
dev.off()
#
# we can do other file types too!
png(filename = "outputs/figures/SVL_Tail_Scatter.png", width = 1200, height = 1200
     , units = "px", res = 300, bg = "transparent")
plot(Tail ~ SVL, col = ID, xlab = "Snout-vent Length (mm)"
     , ylab = "Tail Length (mm)")
legend(15, 225, legend = levels(ID), fill = 1:6, cex = 0.5)
dev.off()
#
detach(liz.sub)
#
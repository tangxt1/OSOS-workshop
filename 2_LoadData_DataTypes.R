###------------Setup and Understanding Data Types-----------------------------
# By Danielle Walkup (with lots of help from Google) 
# OSOS 2018 Workshop, August 2018
#
# This script goes with the intro pdf and will take you through the working 
# directory, loading data, and data types 
# 
###------------Packages---------------------------------------------------------
#
## One of the earlier parts of your script should include a list of packages that
## will be used in the script. I generally set it up as a commented out install.packages()
## command (because I typically have them already loaded), along with a set of
## library(), that loads each package
#
# For example, some packages you might like: 
#install.packages(c("ggplot2","gplots","dplyr","plyr"))  #plotting and data manipulation
#install.packages(c("sp","rgdal","rgeos","ggmap","raster"))  #some handy spatial packages
# and one we will use in this script
install.packages("openxlsx")  #note the quotes here
library(openxlsx)  #don't have to have quotes here
#
###------------The working directory--------------------------------------------
#
## The working directory is the location on your computer that R is working in,
## here you can read files from it and write files to the working directory
# To check your current directory:
getwd()  #the default directory when you open RStudio is the Documents folder
dir()  #shows what is currently in the working directory

## Remember you can also see what is in the working directory by clicking on
## "files" in the bottom left window. 

## TIP: If you open an R script from somewhere else in your computer, the
## working directory defaults to the folder where your R script was stored.
## Note that even that folder may not be where you actually want to work from

# We can change the working directory: 
#setwd("")  #the easiest way to do this is to open the folder and copy and paste
           #the file name into the quotes.
dir()

## TIP: You can see what is is sub-folders in the directory
dir("")  #choose one of the folder names and type it between the quotes to see 
#what's in it.

## NOTE: 
# 1) We double-checked to make sure setwd() worked by using dir() again - always  
#    be troubleshooting your code!
# 2) On pc's you need to use / in the path, \ is used as an escape character in 
#    R, so if you copy-paste, make sure you change them to the forward slash
# 3) If it just isn't working and you need to get on with your life, you can use
#    Session -> Set Working Directory -> Choose Directory OR ctrl-shift-H

## This may be a good time to talk about organizing your project (beyond script
## organization) - see the pdf for more information.
#
###------------Types of data-------------------------------------------------
## Some examples:
?class()  #we can learn a little something about the classes in R
#
# The classes can vary depending on the type of data:
liz.wt.num <- c(1.4, 5.6, 8.3, 5.6, 5.0)
class(liz.wt.num)  #returns numbers

liz.wt.ch <- c("1.4", "5.6", "8.3", "5.6", "5.0")
class(liz.wt.ch)  #returns characters

# if you load a data set and need to change the class, you can:
liz.wt.change <- as.numeric(liz.wt.ch)
class(liz.wt.change)

liz.wt.change2 <- as.character(liz.wt.num)
class(liz.wt.change2)

# Notice what happens when we change them to integers:
liz.wt.int <- as.integer(liz.wt.ch)
class(liz.wt.int)
liz.wt.int

## Factors
# Ordering of factors defaults to alphabetical:
fruit <- factor(c("apple","pear","banana","grape"))
fruit
# But we can change that if we want to:
fruit2 <- factor(c("apple","pear","banana","grape")
                  , levels = c("apple","pear","banana","grape"))
fruit2
#
# We can also create an ordinal variable:
fruit.ord <- factor(c("apple",'pear',"banana","grape"), ordered = TRUE)
fruit.ord  #note the < between the levels now AND our levels changed back to alphabetical
fruit.ord2 <- factor(c("apple",'pear',"banana","grape")
                     , levels = c("apple","pear","banana","grape")
                     , ordered = TRUE)
fruit.ord2  #Much better - if you like grapes...
#
# Notice there are some constraints on classes:
fruit.ch <- as.character(fruit)
class(fruit.ch)
fruit.ch

fruit.num <- as.numeric(fruit.ch)  #It'll do it, but it'll do it badly.
class(fruit.num)
fruit.num
#
# BUT, be careful, because we can coerce factors to numbers or integers:
fruit.num2 <- as.numeric(fruit)  #using the alphabetically ordered fruit
class(fruit.num2)
fruit.num2  #Note that it keeps the ordering

fruit.int <- as.integer(fruit2)  #using our fruit orders
class(fruit.int)
fruit.int  #Again, note that it keeps the changed ordering
# 
## Data Structure Examples:
# Vectors - collection of elements of the same type
a <- c(1, 2, 3, 4, 5)
b <- c("apple", "pear", "banana", "grape")
# We can see elements in the vectors:
b[3] #the single bracket lets us see the element in the 3rd place in the vector
b[8] #there's nothing in here - because we only have the 4 fruits!
# We can see all sorts of things about the vectors:
class(a)  #notice this returns the atomic vector type
length(b)
is.na(a)  #a handy function to check for missing values
sum(a)  #we can run functions specific to the given class
sum(b)  #error because we have no numbers to add!
str(a)
#
# Lists
my.list <- list(1, "a", TRUE, 1+4i)
class(my.list)  #now we see this is a list, with its special list properties!
# We can still see the different elements and characteristics
my.list[2]
length(my.list)
str(my.list)
# You can also name the elements in each list
big.list <- list(a = "Testing", b = 1:10, flowers = head(iris))
#
# now if we want to see what's in the list:
names(big.list)  #we can also see the names
big.list[2]  #and what's in the list
big.list$b  #alternatively, if we have elements in the list named, we can use the
            # '$' to choose the different names and show what's in them
length(big.list)  #but we still only have 3 things in the list
#
# Matrices
?matrix
my.mat <- matrix(1:10, nrow = 2)
my.mat
my.mat2 <- matrix(1:10, nrow = 2, byrow = TRUE)   
#TIP: instead of writing out 1,2,3,4,5,6,7,8,9,10, we use 1:10 to give us the 
#     sequence of numbers
my.mat2
#
# and we can see characteristics:
class(my.mat)
str(my.mat)
length(my.mat)
dim(my.mat)  #Now we can see the dimensions!
my.mat[2,1]  #now that we have 2 dimensions, we can use [row,column] to id an element
my.mat[,2]  #or see just a column
my.mat[2,]  #or see just a row
sum(my.mat)  #can still do math on a numeric matrix - 
t(my.mat)  #can also transpose a matrix 
#
# Data frames
# here we will create a data frame with 3 columns: id, height, and width
my.df <- data.frame(id = rep(c("a","b","c"),4), height = 1:12, width = 12:1)
my.df  #lets make sure it did what we expected
#
# and check out some of its characteristics:
class(my.df)
str(my.df)
summary(my.df)
length(my.df)  #we can still get a length, but it may not quite be the info we want
dim(my.df)  
t(my.df)  #we can still transpose the data frame
#
# and we can see the different parts:
my.df$id  #note that id has levels, so it is a factor
class(my.df$id)  #which we can double check here
class(my.df$width)  #and it has defaulted width to integer, which we could change:
as.numeric(my.df$width)
class(my.df$width)  #wait, I though we changed this?!
# with data frames we need to re-assign the column to "save" the changes
my.df$width <- as.numeric(my.df$width)
class(my.df$width)
#
# We could even do math within the data frame:
sum(my.df$width)
mean(my.df$width)
#
###------------Loading in data from a file--------------------------------------
#
## read.csv or read.table are the typical functions we will use to retrieve data
?read.csv  #lets check out the parts of the function
#
# First, lets make sure the file is where we think it is!
dir("data")  #looks good, plus now we can copy/paste and not worry about typos

# I'll set a file path here (makes it more easily accessible)
liz.file <- "data/LizardData.csv"  #NOTE: by using data/ i'm telling R to look in 
                                   #that folder for the file

## If the file is saved as a .csv we can simply read it in:
liz.data <- read.csv(liz.file)
head(liz.data)  #double check that it worked
#
## If we have a text file, we can still read it in using read.csv
liz.file.txt <- "data/LizardData.txt"
liz.data.txt <- read.csv(liz.file.txt, sep = "\t")  #sep = "\t" tells R its a tab-
                                                    #delimited text file
head(liz.data.txt)  #and it looks the same as above!
#
## read.csv has a ton of options to read in your data set, check out the different arguments:
# header  - tell it whether or not there is a head row
# col.names - can change the names of the columns
# row.names - or add row names
# colClasses - can specify the column classes
# strip.white - removes leading or trailing white spaces
# blank.lines.skip - skips empty rows
# na.strings - what values should be considered NA
#
# and we can check out our new data frame:
class(liz.data)
head(liz.data)  #look it automatically reads our headings!
str(liz.data)  #tells us the column classes and info about the data.frame
dim(liz.data)
summary(liz.data)  #gives us a brief overview of each column, already, I can see 
#some indicators of a messy data set: check out the Sex, Regen,
#and the Recap column summaries!
#
## Finally, we can also load the excel file using our package openxlsx:
liz.file.xl <- "data/LizardData.xlsx"
liz.data.xl <- read.xlsx(liz.file.xl)
head(liz.data.xl)
# but note the differences in how it default loads the data:
str(liz.data.xl)
str(liz.data)
str(liz.data.txt)
#
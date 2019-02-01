###-------------Intro to R and Rstudio------------------------------------------
# By Danielle Walkup (with lots of help from Google) 
# OSOS 2018 Workshop, August 2018
#
# This script goes with the intro pdf and will take you through the basic intro
# to R. 
# 
###-------------Familiarizing yourself with Rstudio-----------------------------
## The 4 windows in Rstudio (see associated pdf)
## The top menus (see associated pdf)

## Getting started with Good Coding Practices
# 1) commenting - anything preceded by a '#' will not be evaluated by R
#    Get in the habit of commenting your code, explaining WHY, even if what you 
#    are doing seems obvious at the time. Future you will thank you! 
#
# 2) Use a consistent style within your code (naming conventions, line length,
#    spacing around operators, indentation)
#
# 3) Use meaningful (but short) names: bad: mydata, x; better: lizard.df
#
# 4) Things you can do, but probably shouldn't:
#    Use = instead of <-. Use <- for assignment, and = within functions and definitions
#    Assign new data to reserved functions (e.g. data <- 5, mean <- 8)
#
###---------------Working in RStudio--------------------------------------------
## The obligatory R can be used as a calculator tutorial:
## You can do basic arithmetic with R
3+5+8
## It will follow order of operations rules
5*9+14
5*(9+14)
## Other operators:
12^2  #can do exponents
sqrt(100)  #and square roots
pi*3  #there are some built in constants
log(5)  #log in R equals the natural log (i.e. ln)
log10(5)  #this will give you log base 10

## Handy Functions:
## "<-" is the assignment operator: (some example data:)
ex.data <- c(4,6,3,6,7,3,4,6,7,2)
# The c() means to concatenate, where all the numbers are joined together in a 
# vector. We use c() quite a lot.

# We can check to make sure it's there
ex.data

# and check out some of its properties:
mean(ex.data)
min(ex.data)
max(ex.data)
median(ex.data)
sd(ex.data)

## Some basic tools that help you understand and check your objects: 
summary(ex.data)
str(ex.data)
dim(ex.data) #NULL here, better for dataframes or other objects
length(ex.data)  #so we'll try length() instead of dim()
head(ex.data)  #by default returns the 1st 6 things in the object
head(ex.data, 2)  #but we can tell it how many we actually want (> or < 6)
tail(ex.data, 3)
#
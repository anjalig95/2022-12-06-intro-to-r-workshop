#   _____ _             _   _                        _ _   _       _____        _        
#  / ____| |           | | (_)                      (_| | | |     |  __ \      | |       
# | (___ | |_ __ _ _ __| |_ _ _ __   __ _  __      ___| |_| |__   | |  | | __ _| |_ __ _ 
#  \___ \| __/ _` | '__| __| | '_ \ / _` | \ \ /\ / | | __| '_ \  | |  | |/ _` | __/ _` |
#  ____) | || (_| | |  | |_| | | | | (_| |  \ V  V /| | |_| | | | | |__| | (_| | || (_| |
# |_____/ \__\__,_|_|   \__|_|_| |_|\__, |   \_/\_/ |_|\__|_| |_| |_____/ \__,_|\__\__,_|
#                                    __/ |                                               
#                                   |___/                                                
#
# Based on: https://datacarpentry.org/R-ecology-lesson/02-starting-with-data.html


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Topic: Downloading, reading, and inspecting the data
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Lets download some data (make sure the data folder exists)
download.file(url = "https://ndownloader.figshare.com/files/2292169",
              destfile = "data_raw/portal_data_joined.csv")

#load the tidyverse library
library(tidyverse)

# now we will read this "csv" into an R object called "surveys"
surveys <- read_csv("data_raw/portal_data_joined.csv")


# and take a look at it
view(surveys)
head(surveys)
tail(surveys)

# BTW, we assumed our data was comma separated, however this might not
# always be the case. So we may been to tell read.csv more about our file.



# So what kind of an R object is "surveys" ?



# ok - so what are dataframes ?



# --------------------
# Exercise/Challenge
# --------------------
#
# What is the class of the object surveys?
#
# Answer:

str(surveys)

# How many rows and how many columns are in this survey ?
#
# Answer:


# Bonus functions 

names(surveys)
summary(surveys)

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Topic: Sub-setting
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# first element in the first column of the data frame (as a vector)

surveys[1,1]

# first element in the 6th column (as a vector)

surveys[1, 6]

# first column of the data frame (as a vector)

surveys[, 1]

# first column of the data frame (as a data frame)

surveys$record_id

# first row (as a data frame)

surveys[1, ]

# first three elements in the 7th column (as a vector)

surveys[1:3, 7]

# the 3rd row of the data frame (as a data.frame)

surveys[3, ]

# equivalent to head(metadata)


# looking at the 1:6 more closely


# we also use other objects to specify the range

surveys[c(2, 4, 6), ]


# We can omit (leave out) columns using '-'

surveys[-c(2, 4, 6), ]

# --------------------
# Exercise/Challenge
# --------------------
#Using slicing, see if you can produce the same result as:
#
#   head(surveys)
#
# i.e., print just first 6 rows of the surveys dataframe
#
# Solution:

surveys[1:6, ]
surveys[-(7:nrow(surveys)), ]


# column "names" can be used in place of the column numbers and $ operator to isolate

surveys["month"]
surveys[c("month", "year")]
surveys$species_id

# --------------------
# Exercise/Challenge
# --------------------

#Bonus functions:

# What's the average weight of survey animals
#

mean(surveys$weight, na.rm = TRUE)

#
# Answer:

# Are there more Birds than Rodents ?
#
#
# Answer:

table(surveys$taxa)


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Topic: Factors (for categorical data)
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

summary(surveys$sex)

#Turning characters into levels

surveys$sex <- factor(surveys$sex)
summary(surveys$sex)

# factors that have an order

temperature <- factor(c("hot", "cold", "hot", "warm"))
temperature
levels(temperature)

temperature <- factor(temperature, levels = c("cold", "warm", "hot"))
levels(temperature)
nlevels(temperature)

# --------------------
# Exercise/Challenge
# --------------------
#   1. Change the columns taxa and genus in the surveys data frame into a factor.
#   2. Using the functions you learned before, can you find out…
#        a. How many rabbits were observed?
#        b. How many different genera are in the genus column?

surveys$genus <- factor(surveys$genus)
surveys$taxa <- factor(surveys$taxa)

summary(surveys$taxa)
nlevels(surveys$genus)


# Converting factors


surveys$year <- factor(surveys$year)
levels(surveys$year)
as.numeric(as.character(surveys$year))
nlevels(surveys$year)

# can be tricky if the levels are numbers


# so does our survey data have any factors

# Renaming factors



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Topic:  Dealing with Dates
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# R has a whole library for dealing with dates ...



# R can concatenated things together using paste()


# 'sep' indicates the character to use to separate each component


# paste() also works for entire columns


# let's save the dates in a new column of our dataframe surveys$date 


# and ask summary() to summarise 


# but what about the "Warning: 129 failed to parse"



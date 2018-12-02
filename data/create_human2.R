# Gabrielle Mantell
# This dataset originates from the United Nations Development Programme.
# Original data source: http://hdr.undp.org/en/content/human-development-index-hdi

# load libraries
library(stringr); library(dplyr)

# import data
human <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt", sep  =",", header = T)

# explore structure
str(human) # this data has 195 obs and 19 variables. It is data taken from the UN Development Programme and looks at human development indicators (HDI) on a per country basis
names(human)

# look at column GNI in human database
str(human$GNI)

# remove the commas from GNI and print out a numeric version of it
str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric(human$GNI)

# columns to keep
keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

# select the 'keep' columns
human <- select(human, one_of(keep))

# print out a completeness indicator of the 'human' data
complete.cases(human)

# print out the data along with a completeness indicator as the last column
data.frame(human[-1], comp = complete.cases(human))

# filter out all rows with NA values
human_ <- filter(human, complete.cases(human))
print(human_)

# look at the last 10 observations of human
tail(human, 10)

# define the last indice we want to keep
last <- nrow(human) - 7

# choose everything until the last 7 observations
human_ <- human[1:last,]

# add countries as rownames
rownames(human_) <- human_$Country

# remove the Country variable
human_ <- select(human, -Country)

# Save file
write.csv(human, file ="human.csv")
read.csv("human.csv")
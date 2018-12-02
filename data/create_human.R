# Gabrielle Mantell - 25 November 2018
# IODS 2018 R Studio Exercise 4

# Load libraries
library(dplyr); library(stringr)

# Import data
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# Explore the structure and dimensions of the data
dim(hd) # this dataset consists of 195 rows and 8 columns
str(hd) # and 195 obs. of  8 variables
summary(hd)

dim(gii) # this dataset consists of 195 rows and 10 columns
str(gii) # and 195 obs. of  10 variables
summary(gii)

# Rename variables
colnames(hd)
colnames(hd)[1] <- "hdirank"
colnames(hd)[2] <- "country"
colnames(hd)[3] <- "hdi"
colnames(hd)[4] <- "life"
colnames(hd)[5] <- "expted"
colnames(hd)[6] <- "meaned"
colnames(hd)[7] <- "gni"
colnames(hd)[8] <- "gniminhdi"

colnames(gii)
colnames(gii)[1] <- "giirank"
colnames(gii)[2] <- "country"
colnames(gii)[3] <- "gii"
colnames(gii)[4] <- "matmort"
colnames(gii)[5] <- "adbirth"
colnames(gii)[6] <- "parl"
colnames(gii)[7] <- "ed2f"
colnames(gii)[8] <- "ed2m"
colnames(gii)[9] <- "labfem"
colnames(gii)[10] <- "labmal"

# Mutate the "Gender inequality" data and create two new variables.
secondary_ed <- c("ed2f", "ed2m")
ed_columns <- select(gii, one_of(secondary_ed)) %>% mutate(ratio = ed2f/ed2m)
summary(ed_columns)

labour_part <- c("labfem", "labmal")
lab_columns <- select(gii, one_of(labour_part)) %>% mutate(ratio = labfem/labmal)
summary(lab_columns)

# Join the two datasets 
 join_by <- c("country")
human <- inner_join(hd, gii, by = join_by, suffix = c(".hd", ".gii"))

# Save file
write.csv(human, file ="human.csv")
read.csv("human.csv")

# Exercise 5

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


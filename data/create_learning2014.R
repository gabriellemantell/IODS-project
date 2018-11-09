# Gabrielle Mantell - 06 November 2018
# IODS 2018 R Studio Exercise 2

# Load libraries
library(dplyr)

# Import data
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# Explore the structure and dimensions of the data
dim(lrn14) # this dataset consists of 183 rows and 60 columns
str(lrn14) # and 183 obs. of  60 variables


# Create an analysis dataset
# Combine variables and scale by mean
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

deep <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep)
surf <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surf)
stra <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(stra)

lrn14$Attitude <- lrn14$Attitude / 10


# Select columns to keep
keep_columns <- c("gender","Age","Attitude", "deep", "stra", "surf", "Points")
learning2014 <- select(lrn14, one_of(keep_columns))

# Exclude observations where the exam points variable is zero
learning2014 <- filter(learning2014, Points != 0)

# Save analysis dataset
write.csv(learning2014, file ="learning2014.csv")
read.csv("learning2014.csv")
str(learning2014)
head(learning2014)
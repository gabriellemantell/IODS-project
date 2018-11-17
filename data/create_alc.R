# Gabrielle Mantell - 17 November 2018
# IODS 2018 R Studio Exercise 3

# load libraries
library(dplyr); library(ggplot2)

# import data
math <- read.table("student-mat.csv", sep=";", header=TRUE)
por <- read.table("student-por.csv", sep=";", header=TRUE)

# explore dimensions and structure of data
dim(math)
str(math)
dim(por)
str(por)

# join the two data sets and only keep students present in both
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")
math_por <- inner_join(math, por, by = join_by, suffix = c(".math", ".por"))
alc <- select(math_por, one_of(join_by))
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

# explore structure and dimensions of joined data
str(math_por)
dim(math_por)

# combine duplicated answers in the joined data
for(column_name in notjoined_columns) {
  two_columns <- select(math_por, starts_with(column_name))
  first_column <- select(two_columns, 1)[[1]]
  
  if(is.numeric(first_column)) {
    alc[column_name] <- round(rowMeans(two_columns))
  } else { 
    alc[column_name] <- first_column
  }
}

# take the average of answers related to weekday and weekend alc consumption to create new column alc_use and high_use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
alc <- mutate(alc, high_use = alc_use > 2)


# inspect joined data
glimpse(alc)
str(alc)
dim(alc)

# save data
write.csv(alc, file ="alc.csv")
read.csv("alc.csv")
str(alc)
head(alc)


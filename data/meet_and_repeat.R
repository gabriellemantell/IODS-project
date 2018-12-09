# Gabrielle Mantell - 09 December 2018
# IODS 2018 R Studio Exercise 6
# Analysing Longitudinal Data

# Load libraries
library(dplyr); library(tidyr)

# Import data and explore structure
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)
names(BPRS)
str(BPRS) # data has 40 observations and 11 variables
summary(BPRS)
glimpse(BPRS)

RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')
names(RATS)
str(RATS) # data has 16 observations and 13 variables
summary(RATS)

# Convert the categorical variables of both data sets to factors
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

# Convert the data sets to long form
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)

RATSL <- RATS %>% gather(key = WD, value = Weight, -ID, -Group) %>% mutate(Time = as.integer(substr(WD,3,4))) 

# Extract the week number
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))

# Look at new data
glimpse(BPRSL)
glimpse(RATSL)

# By converting the data sets to long form and extracting the week number/time we make signifiantly expand the dataset. BPRS goes from 40 observations to 360 and the RATS data goes from 16 observations to 176. 
# Also combined multiple columns and collapses them into key-value pairs which condenses the number of variables.

# Save file
write.csv(RATSL, file = "ratsl.csv")
write.csv(BPRSL, file = "bprsl.csv")


#### Workspace setup ####
library(tidyverse)
library(readxl)

#### Clean data ####
#### get from excel

#1
fear.xlsx <- read_excel("data/raw_data/fear.xlsx")
View(fear.xlsx)

#2
Gender <- read_excel("data/raw_data/Gender.xlsx")
View(Gender)

#3
Health <- read_excel("data/raw_data/Health.xlsx")
View(Health)  

#4
Age <- read_excel("data/raw_data/Age.xlsx")
View(Age)  

#5
Race <- read_excel("data/raw_data/Race.xlsx")
View(Race)  



################################################ Repeat 32 - 42 for the other excel files
#### Tidy up Data ####

##  1

fear.xlsx <- fear.xlsx |> 
  slice(7:8)
fear.xlsx[1,1]<-"Year"
names(fear.xlsx)[1]<-"C1"

#### PIVOT LONGER ####

fear.xlsx <- fear.xlsx[-1] |> t() |> as.data.frame()


####continue 
names(fear.xlsx) <- c("Year", "Total Americans in Favour")

##### new lines to fix the num in brackets #####

fear.xlsx$'Total Americans in Favour' <- sapply(fear.xlsx$'Total Americans in Favour', function(x) { gsub("[\r\n]", "", x) })

fear.xlsx[c('Total','Y')] <- str_split_fixed(fear.xlsx$'Total Americans in Favour', ' ', 2)

fear.xlsx <- fear.xlsx |>
  select(c("Year", "Total"))

names(fear.xlsx) <- c("Year", "Total Americans in Favour")






##  2

Gender <- Gender |> 
  slice(7:9)



#### PIVOT LONGER #### 

Gender <- Gender[-1] |> t() |> as.data.frame()

names(Gender)[1]<-"Year"
names(Gender)[2]<-"Female"
names(Gender)[3]<-"Male"

##### new lines to fix the num in brackets #####

Gender$'Female' <- sapply(Gender$'Female', function(x) { gsub("[\r\n]", "", x) })

Gender[c('F','Y')] <- str_split_fixed(Gender$'Female', ' ', 2)

#### Male Data () removal

Gender$'Male' <- sapply(Gender$'Male', function(x) { gsub("[\r\n]", "", x) })

Gender[c('M','YY')] <- str_split_fixed(Gender$'Male', ' ', 2)

#### remove the unwanted collumbs ####
Gender <- Gender |>
  select(c("Year", "F", "M"))

names(Gender) <- c("Year", "Female", "Male")  




##  3

Health <- Health |> 
  slice(7:10)
Health[1,1]<-"Year"
names(Health)[1]<-"C1"

#### PIVOT LONGER ####

## new line

names(Health)[1]<-"Year"
names(Health)[2]<-"Excellent"
names(Health)[3]<-"Good"
names(Health)[4]<-"Fair"
#### old lines

Health <- Health[-1] |> t() |> as.data.frame()

names(Health) <- c("Year", "Excellent", "Good","Fair")



##### new lines to fix the num in brackets #####

Health$'Excellent' <- sapply(Health$'Excellent', function(x) { gsub("[\r\n]", "", x) })

Health[c('D','extra')] <- str_split_fixed(Health$'Excellent', ' ', 2)

##### repeat Line 122 - 124 with other variables #####
## Highschool

Health$'Good' <- sapply(Health$'Good', function(x) { gsub("[\r\n]", "", x) })

Health[c('High','extra2')] <- str_split_fixed(Health$'Good', ' ', 3)

## no Highschool


Health$'Fair' <- sapply(Health$'Fair', function(x) { gsub("[\r\n]", "", x) })

Health[c('NoH','extra3')] <- str_split_fixed(Health$'Fair', ' ', 4)


#### remove the unwanted collumbs ####
Health <- Health |>
  select(c("Year","D","High","NoH"))

names(Health) <- c("Year", "Excellent", "Good","Fair")  




##  4

Age <- Age |>
  slice(7:10)
Age[1,1]<-"Year"
names(Age)[1]<-"C1"

## New line
#names(RaceAndGunlaw)[1]<-"Year"
#names(RaceAndGunlaw)[2]<-"White"
#names(RaceAndGunlaw)[3]<-"Black"
#names(RaceAndGunlaw)[4]<-"Other"

#### PIVOT LONGER ####

Age <- Age[-1] |> t() |> as.data.frame()
names(Age) <- c("Year", "White", "Black", "Other")


##### New lines to fix the num in brackets #####

Age$'White' <- sapply(Age$'White', function(x) { gsub("[\r\n]", "", x) })
Age[c('White',' ')] <- str_split_fixed(Age$'White', ' ', 2)  # Assuming space separates values

# BLACK

Age$'Black' <- sapply(Age$'Black', function(x) { gsub("[\r\n]", "", x) })
Age[c('Black',' ')] <- str_split_fixed(Age$'Black', ' ', 2)  # Assuming space separates values

# Others

Age$'Other' <- sapply(Age$'Other', function(x) { gsub("[\r\n]", "", x) })
Age[c('Other',' ')] <- str_split_fixed(Age$'Other', ' ', 2)  # Assuming space separates values


#### remove the unwanted collumbs ####
Age <- Age |>
  select(c("Year","White","Black","Other"))

### LINE IS REDUNDANT
#names(RaceAndGunlaw) <- c("Year", "White", "Black", "Other")







##  5

Race <- Race |>
  slice(7:10)
Race[1,1]<-"Year"
names(Race)[1]<-"C1"

## New line
#names(RaceAndGunlaw)[1]<-"Year"
#names(RaceAndGunlaw)[2]<-"White"
#names(RaceAndGunlaw)[3]<-"Black"
#names(RaceAndGunlaw)[4]<-"Other"

#### PIVOT LONGER ####

Race <- Race[-1] |> t() |> as.data.frame()
names(Race) <- c("Year", "White", "Black", "Other")


##### New lines to fix the num in brackets #####

Race$'White' <- sapply(Race$'White', function(x) { gsub("[\r\n]", "", x) })
Race[c('White',' ')] <- str_split_fixed(Race$'White', ' ', 2)  # Assuming space separates values

# BLACK

Race$'Black' <- sapply(Race$'Black', function(x) { gsub("[\r\n]", "", x) })
Race[c('Black',' ')] <- str_split_fixed(Race$'Black', ' ', 2)  # Assuming space separates values

# Others

Race$'Other' <- sapply(Race$'Other', function(x) { gsub("[\r\n]", "", x) })
Race[c('Other',' ')] <- str_split_fixed(Race$'Other', ' ', 2)  # Assuming space separates values


#### remove the unwanted collumbs ####
Race <- Race |>
  select(c("Year","White","Black","Other"))

### LINE IS REDUNDANT
#names(RaceAndGunlaw) <- c("Year", "White", "Black", "Other")








#### Save data #### 

write_csv(fear, "data/analysis_data/fear.csv")

write_csv(Gender, "data/analysis_data/Gender.csv")

write_csv(Health, "data/analysis_data/Health.csv")

write_csv(Age, "data/analysis_data/Age.csv")

write_csv(Race, "data/analysis_data/Race.csv")














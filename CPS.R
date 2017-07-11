# Loading dataset
  CPS = read_csv("~/Documents/Dataset_Explanation/Demographic_Data/CPSData.csv")
  View(CPS)

# see the number of interviewer using str and summary
  summary(CPS)
  str(CPS)  

# Most common industry of employment
  table(CPS$Industry) # Educational and health services

# we can sort region and state to find out the min and max
  sort(table(CPS$Region))
  sort(table(CPS$State))

# see that 123,712 of the 131,302 interviewees are citizens of the United States (either native or naturalized)  
  table(CPS$Citizenship)

# breakdown of race and ethnicity
  table(CPS$Race, CPS$Hispanic)

# for seeing the NA values
  summary(CPS)  

# returns a vector of TRUE/FALSE values for whether the Married variable is missing
  is.na(CPS$Married)

# breakdown of whether Married is missing based on the reported value of the Region  
  table(CPS$Region, is.na(CPS$Married))

# how many of all are living metro and non-metro in any state
  table(CPS$State, is.na(CPS$MetroAreaCode))

# number of interviewees not living in a metropolitan area, broken down by region
  table(CPS$Region, is.na(CPS$MetroAreaCode))

# proportion of interviewees living in a non-metropolitan area
  sort(tapply(is.na(CPS$MetroAreaCode), CPS$State, mean))

# read dataset MetroAreaCodes and CountryCodes
  MetroAreaMap <- read.csv("~/Documents/Dataset_Explanation/Demographic_Data/MetroAreaCodes.csv")
  CountryMap <- read.csv("~/Documents/Dataset_Explanation/Demographic_Data/CountryCodes.csv")
 
# number of observation of 
  str(MetroAreaMap)
  str(CountryMap)

# merges the two data frames on these columns
  CPS = merge(CPS, MetroAreaMap, by.x="MetroAreaCode", by.y="Code", all.x=TRUE)  

# summary of merged CPS
  summary(CPS)

# largest number of interviewees
  table(CPS$MetroArea) 

# proportion of interviewees of Hispanic ethnicity by metro-city
  sort(tapply(CPS$Hispanic, CPS$MetroArea, mean))

# number of metropolitan areas in the United States from which at least 20% of interviewees are Asian
  sort(tapply(CPS$Race == "Asian", CPS$MetroArea, mean))

# sorted list of proportions by metropolitan area
  sort(tapply(CPS$Education == "No high school diploma", CPS$MetroArea, mean, na.rm=TRUE))

# merging in the metropolitan area information into CPS
  CPS = merge(CPS, CountryMap, by.x="CountryOfBirthCode", by.y="Code", all.x=TRUE)

# which country outside N.A. has most common place of birth
  sort(table(CPS$Country))

# interviewees from the "NY-NJ-PA" metropolitan area have a country of birth that is not the United States
  table(CPS$MetroArea == "New York-Northern New Jersey-Long Island, NY-NJ-PA", CPS$Country != "United States")  

# largest number of interviewees with a country of birth in a particular country
  sort(tapply(CPS$Country == "India", CPS$MetroArea, sum, na.rm=TRUE))
  sort(tapply(CPS$Country == "Brazil", CPS$MetroArea, sum, na.rm=TRUE))
  sort(tapply(CPS$Country == "Somalia", CPS$MetroArea, sum, na.rm=TRUE))

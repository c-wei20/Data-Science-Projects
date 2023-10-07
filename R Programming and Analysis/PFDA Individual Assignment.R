#CLARENCE LEE CHEE WEI
#TP062572

#Import usable packages
library(ggplot2)
library(dplyr)
library(crayon)

#Import data set
employee_attrition <- read.csv(file="F:\\APU\\APU Level2 SEM1\\PFDA\\Assignment\\employee_attrition.csv",
                               header=TRUE, sep=",")

#View data set
View(employee_attrition)

#data pre-processing
#Check the data type of each attribute
str(employee_attrition)

#Change the data type of every date attributes from char to Date.
employee_attrition$recorddate_key <- as.Date(employee_attrition$recorddate_key, format =  "%m/%d/%Y %H:%M")
employee_attrition$birthdate_key <- as.Date(employee_attrition$birthdate_key, format =  "%m/%d/%Y")
employee_attrition$orighiredate_key <- as.Date(employee_attrition$orighiredate_key, format =  "%m/%d/%Y")
employee_attrition$terminationdate_key <- as.Date(employee_attrition$terminationdate_key, format =  "%m/%d/%Y")

str(employee_attrition)

#filter the last record data of each Employee ID
employee_attrition_filter = employee_attrition %>% group_by(EmployeeID) %>% 
  filter(recorddate_key == max(recorddate_key))

View(employee_attrition_filter)

#Checking number of missing value in the filtered data set
sum(is.na(employee_attrition_filter))

summary(employee_attrition_filter)

#Identify inconsistent data
#age
inconsistent_age = 
  ifelse(employee_attrition_filter$age != as.integer(as.numeric(difftime(employee_attrition_filter$recorddate_key,
                                                                         employee_attrition_filter$birthdate_key,
                                                                         unit = "days"))/365.25), 1, 0)
sum(inconsistent_age)
#replace inconsistent age
employee_attrition_filter$age = 
  ifelse(
    employee_attrition_filter$age !=  as.integer(as.numeric(difftime(employee_attrition_filter$recorddate_key,
                                                                     employee_attrition_filter$birthdate_key,
                                                                     unit = "days"))/365.25),
         as.integer((employee_attrition_filter$recorddate_key - employee_attrition_filter$birthdate_key)/365.25), 
         employee_attrition_filter$age)

#length_of_service
inconsistent_service = 
  ifelse(as.integer(as.numeric(difftime(employee_attrition_filter$recorddate_key,
                                        employee_attrition_filter$orighiredate_key, 
                                        unit = "days"))/365.25) != employee_attrition_filter$length_of_service, 1, 0)
sum(inconsistent_service)
#replace inconsistent length_of_service
employee_attrition_filter$length_of_service = 
  ifelse(
    employee_attrition_filter$length_of_service != as.integer(as.numeric(difftime(employee_attrition_filter$recorddate_key, 
                                                                                  employee_attrition_filter$orighiredate_key, 
                                                                                  unit = "days"))/365.25),
    as.integer((employee_attrition_filter$recorddate_key - employee_attrition_filter$orighiredate_key)/365.25), 
    employee_attrition_filter$length_of_service)

#status
inconsistent_status = 
  ifelse(employee_attrition_filter$STATUS == "ACTIVE" & employee_attrition_filter$recorddate_key != "2015-12-31", 1, 0)
sum(inconsistent_status)
#replace inconsistent status
employee_attrition_filter$STATUS = 
  ifelse(employee_attrition_filter$STATUS == "ACTIVE" & employee_attrition_filter$recorddate_key != "2015-12-31", 
         "TERMINATED", employee_attrition_filter$STATUS)

#status year
inconsistent_status_year = 
  ifelse(employee_attrition_filter$STATUS_YEAR != format(employee_attrition_filter$recorddate_key, format= "%Y"), 1, 0)
sum(inconsistent_status_year)

#termreason_desc & termtype_desc
inconsistent_term = ifelse(employee_attrition_filter$STATUS == "TERMINATED" & 
                                   employee_attrition_filter$termreason_desc=="Not Applicable" & 
                                   employee_attrition_filter$termtype_desc=="Not Applicable", 1, 0)
sum(inconsistent_term)
employee_attrition_filter %>% 
  filter(STATUS == "TERMINATED" & termreason_desc=="Not Applicable" & termtype_desc=="Not Applicable")
#find mode of termreason_desc and termtype_desc
#age <= 20
employee_attrition_filter %>% 
  filter(STATUS == "TERMINATED" & age <= 20) %>% ggplot(aes(termreason_desc)) + geom_bar()
employee_attrition_filter %>% 
  filter(STATUS == "TERMINATED" & age <= 20) %>% ggplot(aes(termtype_desc)) + geom_bar()
#age between 20 to 30
employee_attrition_filter %>% 
  filter(STATUS == "TERMINATED" & age > 20 & age <= 30) %>% ggplot(aes(termreason_desc)) + geom_bar()
employee_attrition_filter %>% 
  filter(STATUS == "TERMINATED" & age > 20 & age <= 30) %>% ggplot(aes(termtype_desc)) + geom_bar()
#age > 60
employee_attrition_filter %>% 
  filter(STATUS == "TERMINATED" & age > 60) %>% ggplot(aes(termreason_desc)) + geom_bar()
employee_attrition_filter %>% 
  filter(STATUS == "TERMINATED" & age > 60) %>% ggplot(aes(termtype_desc)) + geom_bar()
#replace inconsistent termreason_desc & termtype_desc with mode according to age
employee_attrition_filter = employee_attrition_filter %>% 
  mutate(termreason_desc = case_when(STATUS == "TERMINATED" & termreason_desc=="Not Applicable" & age <= 20 ~ "Resignaton",
                                     STATUS == "TERMINATED" & 
                                       termreason_desc=="Not Applicable" & age > 20 & age <= 30 ~ "Resignaton",
                                     STATUS == "TERMINATED" & termreason_desc=="Not Applicable" & age > 60 ~ "Retirement",
                                     TRUE ~ termreason_desc))
employee_attrition_filter = employee_attrition_filter %>% 
  mutate(termtype_desc = case_when(STATUS == "TERMINATED" & termtype_desc=="Not Applicable" ~ "Voluntary",
                                     TRUE ~ termtype_desc))

#Correct spelling error in termreason_desc
employee_attrition_filter$termreason_desc = ifelse(employee_attrition_filter$termreason_desc == "Resignaton", 
                                                 "Resignation", employee_attrition_filter$termreason_desc)

#termination date (TERMINATED)
library(lubridate)
inconsistent_termination = 
  ifelse(employee_attrition_filter$STATUS != "ACTIVE" & 
           as.integer(as.numeric(difftime(employee_attrition_filter$terminationdate_key, 
                                          employee_attrition_filter$orighiredate_key, 
                                          unit = "days"))/365.25) != employee_attrition_filter$length_of_service, 1, 0)
sum(inconsistent_termination)
#replace inconsistent termination date
employee_attrition_filter = employee_attrition_filter %>% 
  mutate(terminationdate_key = 
           case_when(STATUS != "ACTIVE" & as.integer(as.numeric(difftime(terminationdate_key, 
                                                                         orighiredate_key, 
                                                                         unit = "days"))/365.25) 
                     != length_of_service ~ orighiredate_key %m+% days(as.integer((length_of_service*365.25)+1)),
                     TRUE ~ terminationdate_key))

#termination date (ACTIVE)
inconsistent_termination_active = ifelse(employee_attrition_filter$STATUS == "ACTIVE" & 
                                           employee_attrition_filter$terminationdate_key != "1900-01-01", 1, 0)
sum(inconsistent_termination_active)

#gender(Male)
inconsistent_male = ifelse(employee_attrition_filter$gender_short == "M" & 
                             employee_attrition_filter$gender_full != "Male", 1, 0)
sum(inconsistent_male)
#gender(Female)
inconsistent_female = ifelse(employee_attrition_filter$gender_short == "F" & 
                             employee_attrition_filter$gender_full != "Female", 1, 0)
sum(inconsistent_female)

#new dataset
new_employee_attrition = employee_attrition_filter


#-------------------------------------------------------------------------------------------------------------------


#data analysis

#Question 1
#Analysis 1
new_employee_attrition %>% filter(STATUS == "TERMINATED") %>% 
  ggplot(aes(y=job_title, fill = termreason_desc)) + geom_bar()

#Analysis 2
new_employee_attrition %>% filter(STATUS == "TERMINATED") %>% 
  ggplot(aes(termreason_desc,age, fill = termreason_desc)) + geom_violin(scale = "area")

#analysis 3
new_employee_attrition %>% filter(STATUS == "TERMINATED") %>% 
  ggplot(aes(termtype_desc, length_of_service, fill = termreason_desc)) + geom_violin()


#------------

#Question 2
#Analysis 1
new_employee_attrition %>% filter(STATUS == "TERMINATED" & termreason_desc == "Layoff") %>% 
  ggplot(aes(y=job_title, fill = gender_full)) + geom_bar() + facet_wrap(~gender_full)

#Analysis 2
new_employee_attrition %>% filter(STATUS == "TERMINATED" & termreason_desc == "Layoff") %>% 
  ggplot(aes(y = age, fill = gender_full)) + geom_bar()

#Analysis 3
new_employee_attrition %>% filter(STATUS == "TERMINATED" & termreason_desc == "Layoff") %>% 
  ggplot(aes(length_of_service, job_title)) + geom_count(aes(color = ..n.., size = ..n..)) +
  guides(color = 'legend')


#------------

#Question 3
#Analysis 1
new_employee_attrition %>% filter(STATUS == "TERMINATED" & termreason_desc == "Resignation") %>% 
  ggplot(aes(y=job_title, fill = gender_full)) + geom_bar() + facet_wrap(~gender_full)

#Analysis 2
new_employee_attrition %>% filter(STATUS == "TERMINATED" & termreason_desc == "Resignation") %>% 
  ggplot(aes(y = age, fill = gender_full)) + geom_bar()

#Analysis 3
new_employee_attrition %>% filter(STATUS == "TERMINATED" & termreason_desc == "Resignation") %>% 
  ggplot(aes(y = length_of_service, fill = gender_full)) + geom_bar()


#------------

#Question 4
#Analysis 1
new_employee_attrition %>% filter(STATUS=="ACTIVE") %>% group_by(job_title) %>% 
  ggplot(aes(y=job_title, fill = gender_full)) + geom_bar() + facet_wrap(~ gender_full)


#Analysis 2
new_employee_attrition %>% filter(STATUS=="ACTIVE") %>% group_by(job_title) %>% 
  ggplot(aes(age, job_title)) + geom_count(aes(color = ..n.., size = ..n..)) +
  guides(color = 'legend')

#Analysis 3


#------------

#Question 5
#Analysis 1
new_employee_attrition %>% filter(STATUS=="TERMINATED") %>% group_by(STATUS_YEAR) %>%
  ggplot(aes(STATUS_YEAR)) +   geom_bar()

#Analysis 2
new_employee_attrition %>% filter(STATUS=="TERMINATED") %>% group_by(STATUS_YEAR) %>%
  ggplot(aes(gender_full, fill = gender_full)) + geom_bar() + facet_wrap(~STATUS_YEAR)

#Analysis 3
new_employee_attrition %>%
  ggplot(aes(BUSINESS_UNIT, fill = STATUS)) + geom_bar()



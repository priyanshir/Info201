# Pick a state interactive graphs/plots, Melinda & Carolyn
library(dplyr)
library(ggplot2)
library(ggthemes)
library(lintr)
library(shiny)
library(styler)
library(lintr)

data <- read.csv("data/admissions_discharges_prefilter.csv",
  stringsAsFactors = F
)

# selecting columns to reduce amount of data
data_for_page_three <- data %>%
  select(EMPLOY.x, DETNLF.x, GENDER.x, EDUC.x, STFIPS.x, DSMCRIT.y)

# Rename values for gender
data_for_page_three$GENDER.x <- replace(
  data_for_page_three$GENDER.x, data_for_page_three$GENDER.x == "1", "Male"
)
data_for_page_three$GENDER.x <- replace(
  data_for_page_three$GENDER.x, data_for_page_three$GENDER.x == "2", "Female"
)

# Renaming values for DETNLF (not in labor force) column
data_for_page_three$DETNLF.x <- replace(
  data_for_page_three$DETNLF.x, data_for_page_three$DETNLF.x == "1",
  "Homemaker"
)
data_for_page_three$DETNLF.x <- replace(
  data_for_page_three$DETNLF.x, data_for_page_three$DETNLF.x == "2", "Student"
)
data_for_page_three$DETNLF.x <- replace(
  data_for_page_three$DETNLF.x, data_for_page_three$DETNLF.x == "3",
  "Retired / disabled"
)
data_for_page_three$DETNLF.x <- replace(
  data_for_page_three$DETNLF.x, data_for_page_three$DETNLF.x == "4",
  "Resident of institution"
)
data_for_page_three$DETNLF.x <- replace(
  data_for_page_three$DETNLF.x, data_for_page_three$DETNLF.x == "5",
  "Not in Labor Force - Other"
)
data_for_page_three$DETNLF.x <- replace(
  data_for_page_three$DETNLF.x, data_for_page_three$DETNLF.x == "-9", "Unknown"
)

# Replace "4" (Not in Labor Force) values in employment column with more
# detailed information from the Not in Labor Force column
find.four <- data_for_page_three$EMPLOY.x %in% "4"
data_for_page_three[find.four, "EMPLOY.x"] <- data_for_page_three[
  find.four,
  "DETNLF.x"
]

# Renaming values for EMPLOY (employment type) column
data_for_page_three$EMPLOY.x <- replace(
  data_for_page_three$EMPLOY.x, data_for_page_three$EMPLOY.x == "1",
  "Full-time"
)
data_for_page_three$EMPLOY.x <- replace(
  data_for_page_three$EMPLOY.x, data_for_page_three$EMPLOY.x == "2",
  "Part-time"
)
data_for_page_three$EMPLOY.x <- replace(
  data_for_page_three$EMPLOY.x, data_for_page_three$EMPLOY.x == "3",
  "Unemployed"
)

# Renaming values for Education
data_for_page_three$EDUC.x <- replace(
  data_for_page_three$EDUC.x, data_for_page_three$EDUC.x == "1",
  "8 years or less"
)
data_for_page_three$EDUC.x <- replace(
  data_for_page_three$EDUC.x, data_for_page_three$EDUC.x == "2", "9-11 years"
)
data_for_page_three$EDUC.x <- replace(
  data_for_page_three$EDUC.x, data_for_page_three$EDUC.x == "3",
  "12 years (or GED)"
)
data_for_page_three$EDUC.x <- replace(
  data_for_page_three$EDUC.x, data_for_page_three$EDUC.x == "4", "13-15 years"
)
data_for_page_three$EDUC.x <- replace(
  data_for_page_three$EDUC.x, data_for_page_three$EDUC.x == "5",
  "16 years or more"
)

# Renaming values for state
data_for_page_three$STFIPS.x <- as.character(data_for_page_three$STFIPS.x)
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "1"] <-
  "Alabama"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "2"] <-
  "Alaska"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "4"] <- "Arizona"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "5"] <- "Arkansas"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "6"] <-
  "California"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "8"] <- "Colorado"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "9"] <-
  "Connecticut"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "10"] <- "Delaware"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "11"] <-
  "District of Columbia"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "12"] <- "Florida"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "15"] <- "Hawaii"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "16"] <- "Idaho"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "17"] <-
  "Illinois"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "18"] <-
  "Indiana"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "19"] <- "Iowa"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "20"] <- "Kansas"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "21"] <-
  "Kentucky"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "22"] <-
  "Louisiana"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "23"] <- "Maine"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "24"] <- "Maryland"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "25"] <-
  "Massachusetts"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "26"] <- "Michigan"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "27"] <-
  "Minnisota"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "28"] <-
  "Mississippi"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "29"] <- "Missouri"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "30"] <- "Montana"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "31"] <- "Nebraska"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "32"] <- "Nevada"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "33"] <-
  "New Hampshire"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "34"] <-
  "New Jersey"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "35"] <-
  "New Mexico"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "36"] <- "New York"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "37"] <-
  "North Carolina"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "38"] <-
  "North Dakota"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "39"] <- "Ohio"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "40"] <- "Oklahoma"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "42"] <-
  "Pennsylvania"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "44"] <-
  "Rhode Island"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "45"] <-
  "South Carolina"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "46"] <-
  "South Dakota"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "47"] <-
  "Tennessee"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "48"] <- "Texas"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "49"] <- "Utah"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "50"] <- "Vermont"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "51"] <- "Virginia"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "53"] <-
  "Washington"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "54"] <-
  "West Virginia"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "55"] <-
  "Wisconsin"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "56"] <- "Wyoming"
data_for_page_three$STFIPS.x[data_for_page_three$STFIPS.x == "72"] <-
  "Puerto Rico"

# change values for diagnosis
data_for_page_three$DSMCRIT.y <- as.character(data_for_page_three$DSMCRIT.y)
data_for_page_three$DSMCRIT.y[data_for_page_three$DSMCRIT.y == "1"] <-
  "Alcohol-induced disorder"
data_for_page_three$DSMCRIT.y[data_for_page_three$DSMCRIT.y == "2"] <-
  "Substance-induced disorder"
data_for_page_three$DSMCRIT.y[data_for_page_three$DSMCRIT.y == "3"] <-
  "Alcohol intoxication"
data_for_page_three$DSMCRIT.y[data_for_page_three$DSMCRIT.y == "4"] <-
  "Alcohol dependence"
data_for_page_three$DSMCRIT.y[data_for_page_three$DSMCRIT.y == "5"] <-
  "Opiod dependence"
data_for_page_three$DSMCRIT.y[data_for_page_three$DSMCRIT.y == "6"] <-
  "Cocaine dependence"
data_for_page_three$DSMCRIT.y[data_for_page_three$DSMCRIT.y == "7"] <-
  "Cannabis dependence"
data_for_page_three$DSMCRIT.y[data_for_page_three$DSMCRIT.y == "8"] <-
  "Other substance dependence"
data_for_page_three$DSMCRIT.y[data_for_page_three$DSMCRIT.y == "9"] <-
  "Alcohol abuse"
data_for_page_three$DSMCRIT.y[data_for_page_three$DSMCRIT.y == "10"] <-
  "Cannabis abuse"
data_for_page_three$DSMCRIT.y[data_for_page_three$DSMCRIT.y == "11"] <-
  "Other substance abuse"
data_for_page_three$DSMCRIT.y[data_for_page_three$DSMCRIT.y == "12"] <-
  "Opioid abuse"
data_for_page_three$DSMCRIT.y[data_for_page_three$DSMCRIT.y == "13"] <-
  "Cocaine abuse"
data_for_page_three$DSMCRIT.y[data_for_page_three$DSMCRIT.y == "14"] <-
  "Anxiety disorders"
data_for_page_three$DSMCRIT.y[data_for_page_three$DSMCRIT.y == "15"] <-
  "Depressive disorders"
data_for_page_three$DSMCRIT.y[data_for_page_three$DSMCRIT.y == "16"] <-
  "Schizophrenia/other psychotic disorders"
data_for_page_three$DSMCRIT.y[data_for_page_three$DSMCRIT.y == "17"] <-
  "Bipolar disorders"
data_for_page_three$DSMCRIT.y[data_for_page_three$DSMCRIT.y == "18"] <-
  "Attention deficit/disruptive behavior disorders"
data_for_page_three$DSMCRIT.y[data_for_page_three$DSMCRIT.y == "19"] <-
  "Other mental health condition"


# changing column names
colnames(data_for_page_three)[colnames(data_for_page_three) == "EMPLOY.x"] <-
  "Employment"
colnames(data_for_page_three)[colnames(data_for_page_three) == "GENDER.x"] <-
  "Sex"
colnames(data_for_page_three)[colnames(data_for_page_three) == "EDUC.x"] <-
  "Education"
colnames(data_for_page_three)[colnames(data_for_page_three) == "STFIPS.x"] <-
  "State"
colnames(data_for_page_three)[colnames(data_for_page_three) == "DSMCRIT.y"] <-
  "Diagnosis"

# Summarizing counts
data_for_page_three <- data_for_page_three %>%
  select(State, Sex, Employment, Education, Diagnosis) %>%
  filter(Sex != "-9", Education != "-9", Employment != "-9",
         Diagnosis != "-9")

# List of states for input
state_choices <- data_for_page_three %>%
  select(State) %>%
  group_by(State) %>%
  summarize()

# List of characteristics
patient_characteristics <- data_for_page_three %>%
  select(Employment, Education, Diagnosis) %>%
  colnames()


page_three <- tabPanel(
  titlePanel("States"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "state_one",
        label = strong("State 1"),
        choices = state_choices
      ),
      selectInput(
        inputId = "state_two",
        label = strong("State 2"),
        choices = state_choices
      ),
      selectInput(
        inputId = "column_choice",
        label = strong("Patient Characteristic"),
        choices = patient_characteristics
      )
    ),
    mainPanel(
      h3("State 1"),
      plotOutput("state_one_chart"),
      h3("State 2"),
      plotOutput("state_two_chart")
    )
  )
)

# USA interactive map page

# Load necessary packages
library(dplyr)
library(shiny)
library(ggplot2)
library(leaflet)
library(tidyverse)
library(leaflet)
library(maps)

# Load in original dataset
df <- read.csv("data/admissions_discharges_prefilter.csv", stringsAsFactors = F)
# Change -9 values to "NA"
df[df == -9] <- "NA"

# Select columns of interest to make dataset smaller and easier to work with
pg_two_data <- df %>%
  select(STFIPS.x, DSMCRIT.y, GENDER.x)

# Rename values in STFIPS.x column to match the disorders they represent
pg_two_data$STFIPS.x <- as.character(pg_two_data$STFIPS.x)
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "1"] <- "Alabama"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "2"] <- "Alaska"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "4"] <- "Arizona"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "5"] <- "Arkansas"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "6"] <- "California"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "8"] <- "Colorado"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "9"] <- "Connecticut"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "10"] <- "Delaware"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "11"] <- "District of Columbia"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "12"] <- "Florida"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "15"] <- "Hawaii"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "16"] <- "Idaho"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "17"] <- "Illinois"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "18"] <- "Indiana"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "19"] <- "Iowa"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "20"] <- "Kansas"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "21"] <- "Kentucky"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "22"] <- "Louisiana"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "23"] <- "Maine"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "24"] <- "Maryland"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "25"] <- "Massachusetts"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "26"] <- "Michigan"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "27"] <- "Minnesota"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "28"] <- "Mississippi"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "29"] <- "Missouri"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "30"] <- "Montana"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "31"] <- "Nebraska"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "32"] <- "Nevada"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "33"] <- "New Hampshire"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "34"] <- "New Jersey"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "35"] <- "New Mexico"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "36"] <- "New York"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "37"] <- "North Carolina"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "38"] <- "North Dakota"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "39"] <- "Ohio"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "40"] <- "Oklahoma"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "42"] <- "Pennsylvania"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "44"] <- "Rhode Island"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "45"] <- "South Carolina"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "46"] <- "South Dakota"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "47"] <- "Tennessee"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "48"] <- "Texas"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "49"] <- "Utah"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "50"] <- "Vermont"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "51"] <- "Virginia"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "53"] <- "Washington"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "54"] <- "West Virginia"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "55"] <- "Wisconsin"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "56"] <- "Wyoming"
pg_two_data$STFIPS.x[pg_two_data$STFIPS.x == "72"] <- "Puerto Rico"

# Rename values in DSMCRIT.x column to match the disorders they represent
pg_two_data$DSMCRIT.y[pg_two_data$DSMCRIT.y == "1"] <-
  "Alcohol-induced Disorder"
pg_two_data$DSMCRIT.y[pg_two_data$DSMCRIT.y == "2"] <-
  "Substance-induced Disorder"
pg_two_data$DSMCRIT.y[pg_two_data$DSMCRIT.y == "3"] <-
  "Alcohol Intoxication"
pg_two_data$DSMCRIT.y[pg_two_data$DSMCRIT.y == "4"] <-
  "Alcohol Dependence"
pg_two_data$DSMCRIT.y[pg_two_data$DSMCRIT.y == "5"] <- "Opioid Dependence"
pg_two_data$DSMCRIT.y[pg_two_data$DSMCRIT.y == "6"] <- "Cocaine Dependence"
pg_two_data$DSMCRIT.y[pg_two_data$DSMCRIT.y == "7"] <- "Cannabis Dependence"
pg_two_data$DSMCRIT.y[pg_two_data$DSMCRIT.y == "8"] <-
  "Other Substance Dependence"
pg_two_data$DSMCRIT.y[pg_two_data$DSMCRIT.y == "9"] <- "Alcohol Abuse"
pg_two_data$DSMCRIT.y[pg_two_data$DSMCRIT.y == "10"] <- "Cannabis Abuse"
pg_two_data$DSMCRIT.y[pg_two_data$DSMCRIT.y == "11"] <- "Other Substance Abuse"
pg_two_data$DSMCRIT.y[pg_two_data$DSMCRIT.y == "12"] <- "Opioid Abuse"
pg_two_data$DSMCRIT.y[pg_two_data$DSMCRIT.y == "13"] <- "Cocaine Abuse"
pg_two_data$DSMCRIT.y[pg_two_data$DSMCRIT.y == "14"] <- "Anxiety Disorders"
pg_two_data$DSMCRIT.y[pg_two_data$DSMCRIT.y == "15"] <- "Depressive Disorders"
pg_two_data$DSMCRIT.y[pg_two_data$DSMCRIT.y == "16"] <- "Psychotic Disorders"
pg_two_data$DSMCRIT.y[pg_two_data$DSMCRIT.y == "17"] <- "Bipolar Disorder"
pg_two_data$DSMCRIT.y[pg_two_data$DSMCRIT.y == "18"] <-
  "Disruptive Behavior Disorders"
pg_two_data$DSMCRIT.y[pg_two_data$DSMCRIT.y == "19"] <-
  "Other Mental Health Conditions"
pg_two_data$DSMCRIT.y[pg_two_data$DSMCRIT.y == "NA"] <-
  "Missing/Unknown/Deferred"

# Rename column names to more descriptive names
colnames(pg_two_data)[colnames(pg_two_data) == "STFIPS.x"] <- "State"
colnames(pg_two_data)[colnames(pg_two_data) == "DSMCRIT.y"] <- "Diagnosis"

# Group together the totals for related disorders
states_map_data <- pg_two_data %>%
  filter(Diagnosis != "Missing/Unknown/Deferred") %>%
  group_by(State, Diagnosis) %>%
  summarize(num_of_people = n())

states_map_data <- states_map_data %>%
  mutate(state = tolower(State))

state_shape <- map_data("state")

colnames(state_shape)[colnames(state_shape) == "region"] <- "state"

joined <- right_join(states_map_data, state_shape, by = "state")

diagnosis_opts <- pg_two_data %>%
  filter(Diagnosis != "Missing/Unknown/Deferred") %>%
  select(Diagnosis) %>%
  group_by(Diagnosis) %>%
  summarize(num_of_people = n()) %>%
  top_n(5)

blank_theme <- theme_bw() +
  theme(
    axis.line = element_blank(), # remove axis lines
    axis.text = element_blank(), # remove axis labels
    axis.ticks = element_blank(), # remove axis ticks
    axis.title = element_blank(), # remove axis titles
    plot.background = element_blank(), # remove gray background
    panel.grid.major = element_blank(), # remove major grid lines
    panel.grid.minor = element_blank(), # remove minor grid lines
    panel.border = element_blank()
  )

page_two <- tabPanel(
  titlePanel("USA"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "diagnosis",
        label = strong("Diagnosis"),
        choices = diagnosis_opts$Diagnosis
      ),
      selectInput(
        inputId = "color",
        label = strong("Color (high)"),
        choices = c("red", "green", "blue")
      )
    ),
    mainPanel(
      h3("United States Mental Health - 2017"),
      plotOutput("usa_map")
    )
  )
)

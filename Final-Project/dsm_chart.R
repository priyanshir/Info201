
# Load in necessary packages
library(dplyr)
library(tidyr)
library(ggplot2)

# Load in the data
data <- read.csv("data/chart_dataset.csv", stringsAsFactors = F)

# Change -9 values to "NA" 
data[data == -9] <- "NA"

# Columns of Interest:
#   DSMCRIT.x: DSM diagnosis for admitted patients

# Select and wrangle dsm data for chart
dsm_data <- na.omit(data) %>%
  select(DSMCRIT.x) %>%
  group_by(DSMCRIT.x) %>%
  summarize(dsm_cat_tots = sum(n(), na.rm = TRUE))
dsm_data

# Rename values in DSMCRIT.x column to match the disorders they represent
dsm_data$DSMCRIT.x[dsm_data$DSMCRIT.x == "1"] <- "Alcohol-induced Disorder"
dsm_data$DSMCRIT.x[dsm_data$DSMCRIT.x == "2"] <- "Substance-induced Disorder"
dsm_data$DSMCRIT.x[dsm_data$DSMCRIT.x == "3"] <- "Alcohol Intoxication"
dsm_data$DSMCRIT.x[dsm_data$DSMCRIT.x == "4"] <- "Alcohol Dependence"
dsm_data$DSMCRIT.x[dsm_data$DSMCRIT.x == "5"] <- "Opioid Dependence"
dsm_data$DSMCRIT.x[dsm_data$DSMCRIT.x == "6"] <- "Cocaine Dependence"
dsm_data$DSMCRIT.x[dsm_data$DSMCRIT.x == "7"] <- "Cannabis Dependence"
dsm_data$DSMCRIT.x[dsm_data$DSMCRIT.x == "8"] <- "Other Substance Dependence"
dsm_data$DSMCRIT.x[dsm_data$DSMCRIT.x == "9"] <- "Alcohol Abuse"
dsm_data$DSMCRIT.x[dsm_data$DSMCRIT.x == "10"] <- "Cannabis Abuse"
dsm_data$DSMCRIT.x[dsm_data$DSMCRIT.x == "11"] <- "Other Substance Abuse"
dsm_data$DSMCRIT.x[dsm_data$DSMCRIT.x == "12"] <- "Opioid Abuse"
dsm_data$DSMCRIT.x[dsm_data$DSMCRIT.x == "13"] <- "Cocaine Abuse"
dsm_data$DSMCRIT.x[dsm_data$DSMCRIT.x == "14"] <- "Anxiety Disorders"
dsm_data$DSMCRIT.x[dsm_data$DSMCRIT.x == "15"] <- "Depressive Disorders"
dsm_data$DSMCRIT.x[dsm_data$DSMCRIT.x == "16"] <- "Psychotic Disorders"
dsm_data$DSMCRIT.x[dsm_data$DSMCRIT.x == "17"] <- "Bipolar Disorder"
dsm_data$DSMCRIT.x[dsm_data$DSMCRIT.x == "18"] <- "Disruptive Behavior
                                                   Disorders"
dsm_data$DSMCRIT.x[dsm_data$DSMCRIT.x == "19"] <- "Other Mental Health
                                                   Conditions"
dsm_data$DSMCRIT.x[dsm_data$DSMCRIT.x == "NA"] <- "Missing/Unknown/Deferred"

# Group together the totals for related disorders
dsm_data <- dsm_data %>%
  spread(key = DSMCRIT.x, value = dsm_cat_tots) %>%
  mutate("Alcohol-Related Disorders" =
         sum(`Alcohol-induced Disorder`, `Alcohol Abuse`,
             `Alcohol Dependence`, `Alcohol Intoxication`)) %>%
  mutate("Other Substance-related Disorders" =
         sum(`Other Substance Abuse`, `Other Substance Dependence`,
             `Substance-induced Disorder`)) %>%
  mutate("Opioid Use" = sum(`Opioid Dependence`, `Opioid Abuse`)) %>%
  mutate("Cannabis Use" = sum(`Cannabis Abuse`, `Cannabis Dependence`)) %>%
  mutate("Cocaine Use" = sum(`Cocaine Abuse`, `Cocaine Dependence`))

# Remove columns that are included in more general categories/columns
dsm_data$`Alcohol-induced Disorder` <- NULL
dsm_data$`Alcohol Abuse` <- NULL
dsm_data$`Alcohol Dependence` <- NULL
dsm_data$`Alcohol Intoxication` <- NULL
dsm_data$`Cannabis Abuse` <- NULL
dsm_data$`Cannabis Dependence` <- NULL
dsm_data$`Cocaine Abuse` <- NULL
dsm_data$`Cocaine Dependence` <- NULL
dsm_data$`Opioid Abuse` <- NULL
dsm_data$`Opioid Dependence` <- NULL
dsm_data$`Other Substance Abuse` <- NULL
dsm_data$`Other Substance Dependence` <- NULL
dsm_data$`Substance-induced Disorder` <- NULL

# Reshape dsm_data 
dsm_data <- dsm_data %>%
  gather(key = Diagnosis, value = Frequency) %>%
  arrange(Frequency)

# Create chart 
dsm_chart <- ggplot(dsm_data) +
  geom_col(mapping = aes(x = reorder(Diagnosis, Frequency), y = Frequency)) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  xlab("Type of Diagnosis") +
  ylab("Number of People") +
  ggtitle("People Admitted for Mental Health Treatment by DSM Diagnosis")

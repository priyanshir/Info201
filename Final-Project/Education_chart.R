# Load packages
library(dplyr)
library(ggplot2)
library(lintr)

data <- na.omit(read.csv("data/chart_dataset.csv",
                         stringsAsFactors = F))

# Turn -9 values in dataset into "NA"
data[data == -9] <- "NA"

# New data frame with education column
data_for_chart <- data %>%
  select(X, EDUC.x) %>%
  filter(EDUC.x != "Missing") %>%
  group_by(EDUC.x) %>%
  summarize(Number_of_people = n()) %>%
  arrange(-Number_of_people)

# Assigning labels to values
data_for_chart$EDUC.x <- as.character(data_for_chart$EDUC.x)
data_for_chart$EDUC.x[data_for_chart$EDUC.x == "1"] <- "8 years or less"
data_for_chart$EDUC.x[data_for_chart$EDUC.x == "2"] <- "9–11 years"
data_for_chart$EDUC.x[data_for_chart$EDUC.x == "3"] <- "12 years (or GED)"
data_for_chart$EDUC.x[data_for_chart$EDUC.x == "4"] <- "13-15 years"
data_for_chart$EDUC.x[data_for_chart$EDUC.x == "5"] <- "16 years or more"

# Building bar chart
education_chart <- ggplot(data_for_chart, aes(Number_of_people, EDUC.x)) +
  geom_segment(mapping = aes(x = 0, xend = Number_of_people,
                         y = reorder(EDUC.x, Number_of_people),
                         yend = EDUC.x)) +
  geom_point(size = 3) +
  ggtitle("People Admitted for Mental Health Care by Level of Education") +
  ylab("Education Level") +
  xlab("Number of People")

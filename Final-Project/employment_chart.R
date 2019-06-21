data <- read.csv("data/chart_dataset.csv")

library(dplyr)
library(ggplot2)
library(ggthemes)
options(scipen = 999)

# selecting columns to reduce amount of data
data_for_emp_chart <- data %>%
  select(EMPLOY.x, DETNLF.x, GENDER.x)

# Renaming values for GENDER column
data_for_emp_chart$GENDER.x <- replace(
  data_for_emp_chart$GENDER.x, data_for_emp_chart$GENDER.x == "1", "Male")
data_for_emp_chart$GENDER.x <- replace(
  data_for_emp_chart$GENDER.x, data_for_emp_chart$GENDER.x == "2", "Female")

# Renaming values for DETNLF (not in labor force) column
data_for_emp_chart$DETNLF.x <- replace(
  data_for_emp_chart$DETNLF.x, data_for_emp_chart$DETNLF.x == "1", "Homemaker")
data_for_emp_chart$DETNLF.x <- replace(
  data_for_emp_chart$DETNLF.x, data_for_emp_chart$DETNLF.x == "2", "Student")
data_for_emp_chart$DETNLF.x <- replace(
  data_for_emp_chart$DETNLF.x, data_for_emp_chart$DETNLF.x == "3",
  "Retired / disabled")
data_for_emp_chart$DETNLF.x <- replace(
  data_for_emp_chart$DETNLF.x, data_for_emp_chart$DETNLF.x == "4",
  "Resident of institution")
data_for_emp_chart$DETNLF.x <- replace(
  data_for_emp_chart$DETNLF.x, data_for_emp_chart$DETNLF.x == "5",
  "Not in Labor Force - Other")
data_for_emp_chart$DETNLF.x <- replace(
  data_for_emp_chart$DETNLF.x, data_for_emp_chart$DETNLF.x == "-9", "Unknown")

# Replace "4" (Not in Labor Force) values in employment column with more
# detailed information from the Not in Labor Force column
find.four <- data_for_emp_chart$EMPLOY.x %in% "4"
data_for_emp_chart[find.four, "EMPLOY.x"] <- data_for_emp_chart[find.four,
                                                                "DETNLF.x"]

# Renaming values for EMPLOY (employment type) column
data_for_emp_chart$EMPLOY.x <- replace(
  data_for_emp_chart$EMPLOY.x, data_for_emp_chart$EMPLOY.x == "1", "Full-time")
data_for_emp_chart$EMPLOY.x <- replace(
  data_for_emp_chart$EMPLOY.x, data_for_emp_chart$EMPLOY.x == "2", "Part-time")
data_for_emp_chart$EMPLOY.x <- replace(
  data_for_emp_chart$EMPLOY.x, data_for_emp_chart$EMPLOY.x == "3", "Unemployed")
data_for_emp_chart$EMPLOY.x <- replace(
  data_for_emp_chart$EMPLOY.x, data_for_emp_chart$EMPLOY.x == "-9", "Unknown")

# Summarizing counts
data_for_emp_chart <-  data_for_emp_chart %>%
  select(EMPLOY.x, GENDER.x) %>%
  filter(GENDER.x != "-9") %>%
  group_by(EMPLOY.x, GENDER.x) %>%
  summarize(num_of_people = n()) %>%
  arrange(num_of_people)

# Renaming columns
colnames(data_for_emp_chart)[colnames(data_for_emp_chart) == "EMPLOY.x"] <-
  "Employment"
colnames(data_for_emp_chart)[colnames(data_for_emp_chart) == "GENDER.x"] <-
  "Sex"

# Final Chart
employment_chart <- ggplot(data_for_emp_chart,
                           aes(x = Employment,
                               y = num_of_people, fill = Sex)) +
  geom_bar(stat = "identity", width = .6) +
  coord_flip() +
  ggtitle(
    "Patients Admitted for Mental Health Care \nby Employment Type & Gender") +
  ylab("Number of People") +
  xlab("Employment Type") +
  theme(plot.title = element_text(hjust = .5),
        axis.ticks = element_blank()) +
  scale_fill_brewer(palette = "Pastel1")
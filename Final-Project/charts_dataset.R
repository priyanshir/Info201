data <- read.csv("data/admissions_discharges_joined.csv")

chart_dataset <- data %>%
  select(X, EDUC.x, EMPLOY.x, DETNLF.x, GENDER.x, DSMCRIT.x, AGE.x)

write.csv(chart_dataset,"data/chart_dataset.csv", row.names = FALSE)

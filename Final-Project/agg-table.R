library(dplyr)

# For the United States, the top 10 states which have the most people
# having sought treatment for a mental health condition before
top_10_treatment_states <- function(data) {
top_treatment_states <- na.omit(data) %>%
  group_by(state) %>%
  filter(treatment == "Yes") %>%
  mutate(total_people = length(treatment)) %>%
  summarise(total_people = sum(total_people)) %>%
  arrange(-total_people) %>%
  head(10)
return(top_treatment_states)
}
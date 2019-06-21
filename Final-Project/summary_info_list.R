library(dplyr)
library(stringr)
library(ggplot2)
#returns a list of summary info based on responses from survey
get_summary_info <- function(our_data) {
  final_list <- list("Most common repsonse to if the person would bring up a
                     mental health issue with a potential
                     employer in an interview"
                     = find_mode(our_data$mental_health_interview),
                     "Percentage of people who have an employer
                    that provides mental health benefits" =
                       percent_of_people_agreeing(our_data$benefits, our_data),
                     "Most common answer to if employer knew
                    of options for mental health care provided by employer" =
                       find_mode(our_data$care_options),
                     "Percentage of the people surveyed know what
                    care options are available to them" =
percent_of_people_agreeing(our_data$care_options, our_data),
                     "Percentage of people that would feel comfortable
                  talking to their coworkers at work about
                   their problems seriously?" =
                       percent_of_people_agreeing(our_data$coworkers, our_data),
                     "Percentage of people that would feel comfortable
                    talking to their supervisors seriously
                     about their mental health" =
percent_of_people_agreeing(our_data$supervisor, our_data))
  return(final_list)
}

#Figures out most common response for given question asked in the survey
find_mode <- function(data_col_name) {
  return(tail(names(sort(table(data_col_name))), 1))
}

#Finds out the percentage (rounded to the nearest hundredth) of people that agreed
#with the question being asked using our dataset
percent_of_people_agreeing <- function(data_col_name, our_data) {
  total_num_of_people <- nrow(our_data)
  num_of_people_agreeing <- pull(our_data %>% filter(data_col_name == "Yes") %>%
                                   summarise(count = n()))
  percentage <- round( (num_of_people_agreeing / total_num_of_people) * 100,
                       digits = 2)
  return(percentage)
}

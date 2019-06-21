#loading all necessary libraries
library(dplyr)
library(ggplot2)
library(plotly)
library(leaflet)
library(knitr)
library(stringr)

#loading the main dataframe
df <- read.csv("data/shootings-2018.csv", stringsAsFactors = F)
#creating a new data frame with additional column, "total impact" which is the number of people killed
# + the number of people injured
added_df <- df %>% mutate("total_impact" = num_killed + num_injured)
#number of shootings occurred
shootings_occurred <- nrow(df)
#number of people killed(total)
lives_lost <- sum(df$num_killed)

#city with most "impact" would be the city with the most killings, since
# killings are more serious than injuries.
city_with_most_impact <- df %>% filter(num_killed ==
                                         max(num_killed)) %>% select(city)

#choice insights: most injured city (with number of injuries)
#most hurt city = the city with the maximum number of killings and injuries combined
most_injured_city <- df %>% filter(num_injured == max(num_injured)) %>%
  select(city, num_injured)
most_hurt_city <- df %>% mutate(hurt = num_killed + num_injured) %>%
  filter(hurt == max(hurt)) %>% select(city)

#Summary Table:
#Takes the total number of killings in each unique state, sorts by the the
#top 10 states with the highest number of killings
summary_df <- df %>% select(state, num_killed, num_injured) %>%
  group_by(state) %>%
  mutate("total_killings" = sum(num_killed)) %>%
  select(-num_killed, -num_injured)
states_with_killings <- unique(summary_df) %>%
  arrange(-total_killings) %>% head(10)

#Description of a particular incident: State, location, and number of casualties in 
#most in particular shooting
#Most number of people killed in one shooting: Parkland Florida school shooting
state_with_most_killings <- pull(df %>%
                                   filter(num_killed == max(num_killed))  %>%
                                   select(state))
location_with_most_killings <- pull(df %>%
                                      filter(num_killed ==
                                               max(num_killed))  %>%
                                      select(city))
num_impacted <- pull(df %>% filter(num_killed == max(num_killed))  %>%
                       summarise(num_killed + num_injured))
most_num_killed <- pull(df %>% filter(num_killed == max(num_killed))  %>%
                          select(num_killed))
most_num_injured <- pull(df %>% filter(num_killed == max(num_killed))  %>%
                           select(num_injured))

#Building the Interactive Map using Leaflet
#circle size is based on the number of total impact (number of people killed + 
#number of people injured) with
#circle location based on the longitude and latitude of the shootings
interactive_map <- leaflet(added_df) %>% addTiles() %>%
  addCircleMarkers(lat = ~lat, lng = ~long,
                   radius = ~ total_impact,
                   stroke = F, popup =
                     ~paste("Number Killed:", added_df$num_killed, "<br>",
                            "Number Injured:",
                            added_df$num_injured, "<br>", "Date Occurred:",
                            added_df$date, "<br>"), fillOpacity = 2)
#Building Plot to answer specific question about the dataset
#Question to Answer: which month had the most number of killings
#creating a data frame with an additional "months" column and the number of 
#killings that occurred in each month
month_df <- df %>% mutate(numeric_month =
                            as.Date(date, format = "%B %d, %Y")) %>%
  mutate(months = months(numeric_month)) %>%
  select(months, num_killed)  %>%
  group_by(months)  %>% mutate(num_of_killings = sum(num_killed)) %>%
  select(months, num_of_killings)
month_df <- unique(month_df)

months_vs_killing_plot <- ggplot(data = month_df) +
  geom_point(mapping = aes(x = months, y = num_of_killings)) +
  geom_col(mapping = aes(x = months, y = num_of_killings)) +
  labs(
    title = "Number Killed Each Month",
    x = "Months",
    y = "Number Killed")
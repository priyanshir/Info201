library(dplyr)
library(httr)
library(jsonlite)
library(ggplot2)
library(stringr)
library(lubridate)
source("api-keys.R")
#set up
api_call <- "https://api.propublica.org/congress/v1/"
chamber <- "house" #since we're looking at the house of representatives
state <- "WA" #choose state corresponding to address
resource <- "members"
endpoint <- paste0(api_call, resource, "/",
                   chamber, "/", state, "/current.json")

#House of Representatives Data
response <- GET(endpoint, add_headers ("X-API-KEY" = propublica_api_key) )
body <- content(response, "text")
propublica_results <- fromJSON(body)

#creating a data frame with count of Male and Female representatives
male_female_df <- data.frame(gender = propublica_results$results$gender) %>%
  group_by(gender)  %>% summarise(count = n())
male_female_df$gender <- gsub("F", "Females", male_female_df$gender)
male_female_df$gender <- gsub("M", "Males", male_female_df$gender)

#plotting the number of male vs. female representatives
propublica_gender_plot <- ggplot(data = male_female_df,
                                 aes (x = gender,
                                  y = count) ) +
  geom_bar(position = "dodge", stat = "identity") +
  coord_flip() +
  labs(
    title = "Male vs. Female Representatives",
    x = "Male or Female",
    y = "Number of Representatives")

#creating a data frame that has the number of republicans and democrat representatives
party_df <- data.frame(dem_repub = propublica_results$results$party) %>%
  group_by(dem_repub) %>% summarise(count = n())

party_df$dem_repub <- gsub("D", "Democrats", party_df$dem_repub)
party_df$dem_repub <- gsub("R", "Republicans", party_df$dem_repub)

#plotting the number of democrats vs. number of republicans
party_plot <- ggplot(data = party_df,
                     aes(x = dem_repub,
                         y = count)) +
  geom_bar(position = "dodge", stat = "identity") +
  coord_flip() +
  labs(
    title = "Democrat vs. Republican Representatives",
    x = "Democrat or Republican",
    y = "Number of Representatives")


#Selected Representative Information
selected_member_endpoint <- paste0(api_call, resource, "/",
                                   propublica_results$results$id[1], ".json")
selected_member_response <- GET(selected_member_endpoint,
                                add_headers("X-API-Key" = propublica_api_key))
member_results <- fromJSON(content(selected_member_response, "text"))

member_name <- paste(member_results$results$first_name,
                     member_results$results$middle_name,
                     member_results$results$last_name)
member_twitter <- member_results$results$twitter_account

#creating the hyperlink to member's twitter account
twitter_link <- paste0("[", member_twitter, "]", "(https://twitter.com/",
                      member_twitter, ")")

#calculating the age of the member
d_o_b <- member_results$results$date_of_birth
date <- ymd(d_o_b)
age_period <- interval(ymd(date), ymd(Sys.Date()))
member_age <- trunc(time_length(age_period, "year"))

#setting up the voting results
selected_member_vote_endpoint <- paste0(api_call, resource, "/",
                                      propublica_results$results$id[1],
                                      "/votes.json")
selected_member_vote_response <- GET(selected_member_vote_endpoint,
                                    add_headers("X-API-Key" =
                                                  propublica_api_key))
voted_member_results <- fromJSON(content(selected_member_vote_response, "text"))

voted_df <- data.frame(position =
                         voted_member_results$results$votes[[1]]$position,
                       result =
                         voted_member_results$results$votes[[1]]$result)

#calculating the percentage of agreed upon votes
total_votes <- nrow(voted_df)
passed_votes <- voted_df %>%
  filter( (position == "Yes" & result == "Passed") )
failed_votes <- voted_df %>% filter( (position == "No" & result == "Failed") )
agreed_percentage <- ( (nrow(passed_votes) + nrow(failed_votes) ) /
                         total_votes) * 100

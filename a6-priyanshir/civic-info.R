library(dplyr)
library(httr)
library(jsonlite)
#Set up
address <- "4700 241st AVE SE Issaquah, WA 98029"
api_call <- "https://www.googleapis.com/civicinfo/v2/"
resource <- "representatives"
endpoint <- paste0(api_call, resource)
query_parameters <- list(address = address,
                         key = "AIzaSyCSehpKlbSW5Pd0m-q8ckCaGmbRMzddoCM")

response <- GET(endpoint, query = query_parameters)
body <- content(response, "text")
results <- fromJSON(body)

# expand offices using the indices column
offices <- results$offices
officials <- results$officials
num_to_rep <- unlist(lapply(results$offices$officialIndices, length))
expanded <- offices[rep(row.names(offices), num_to_rep), ]
officials <- officials %>% mutate(index = row_number() - 1)
expanded <- expanded %>% mutate(index = row_number() - 1) %>%
  rename(position = name)

#joining the officials and offices by the index
new_df <- left_join(officials, expanded, by = "index")

#Representatives table including information such as
#name, position, party, email, phone, photo with hyperlinks
new_df <- new_df %>% mutate(
  name = paste0("[", name, "]", "(", urls, ")"),
  emails = paste0("<", emails, ">"),
  emails = replace(emails, emails == "<NULL>", "Not Available"),
  photo = paste0("![](", photoUrl, ")"),
  photo = replace(photo, photo == ("![](NA)"), "Not Available")) %>%
  select(name, party, position, emails, phones, photo)

#renaming the columns names
colnames(new_df) <- c("Name", "Position", "Party", "Email", "Phone", "Photo")
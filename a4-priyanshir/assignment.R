# A4 Data Wrangling

# Loading and Exploring Data -------------------------------- (**28 points**)

# To begin, you'll need to download the Kickstarter Projects data from the
# Kaggle website: https://www.kaggle.com/kemical/kickstarter-projects
# Download the `ks-projects-201801.csv` file into a new folder called `data/`

# Load the `dplyr` package
library(dplyr)

# Load your data, making sure to not interpret strings as factors
df <- read.csv("data/ks-projects-201801.csv", stringsAsFactors = F)

# To start, write the code to get some basic information about the dataframe:
# - What are the column names? ID, name, category, main_category, currency, deadline,
#   goal, launched, pledged, state, backers, country, usd.pledged, usd_pledged_real,
#   usd_goal_real.
# - How many rows is the data frame? 378661 rows
# - How many columns are in the data frame? 15 columns

# Use the `summary` function to get some summary information
summarise(df, avg_backers = mean(backers))

# Unfortunately, this doesn't give us a great set of insights. Let's write a
# few functions to try and do this better.
# First, let's write a function `get_col_info()` that takes as parameters a
# column name and a dataframe. If the values in the column are of type *double*,
# the function should return a list with the keys:
# - `min`: the minimum value of the column
# - `max`: the maximum value of the column
# - `mean`: the mean value of the column
# If the column is *not* double and there are fewer than 10 unique values in
# the column, you should return a list with the keys:
# - `n_values`: the number of unique values in the column
# - `unique_values`: a vector of each unique value in the column
# If the column is *not* double and there are 10 or *more* unique values in
# the column, you should return a list with the keys:
# - `n_values`: the number of unique values in the column
# - `sample_values`: a vector containing a random sample of 10 column values
# Hint: use `typeof()` to determine the column type
get_col_info <- function(col_name, df) {
  if (typeof(df[, col_name]) == "double") {
    return(list(
      "min" = min(df[, col_name]),
      "max" = max(df[, col_name]),
      "mean" = mean(df[, col_name])
    ))
  } else if (length(unique(df[, col_name])) < 10) {
    return(list(
      "n_values" = length(unique(df[, col_name])),
      "unique_values" = unique(df[, col_name])
    ))
  } else {
    return(list(
      "n_values" = length(unique(df[, col_name])),
      "sample_values" = sample_n(df[col_name], 10)
    ))
  }
}
# Demonstrate that your function works by passing a column name of your choice
# and the kickstarter data to your function. Store the result in a variable
# with a meaningful name
pledged_col_info <- get_col_info("pledged", df)

# To take this one step further, write a function `get_summary_info()`,
# that takes in a data frame  and returns a *list* of information for each
# column (where the *keys* of the returned list are the column names, and the
# _values_ are the summary information returned by the `get_col_info()` function
# The suggested approach is to use the appropriate `*apply` method to
# do this, though you can write a loop
get_summary_info <- function(df) {
  df_col_names <- colnames(df)
  return(setNames(as.list(lapply(
    df_col_names,
    get_col_info, df
  )), df_col_names))
}

# Demonstrate that your function works by passing the kickstarter data
# into it and saving the result in a variable
kickstarter_data_summary <- get_summary_info(df)

# Take note of 3 observations that you find interesting from this summary
# information (and/or questions that arise that want to investigate further)
# YOUR COMMENTS HERE
# LIKELY ON MULTIPLE LINES
#     For the currency column summary, there are 14 different currencies, but from the 10 samples picked,
#     most of them were in USD or GBP. Another observation that I found interesting was that for the goal column
#     name, the highest goal was $10,000,000 and the lowest goal was $0.01 with the average being $49080.79.
#     I also looked into the pledged column, and was surprised to see that the mean pledged value was $9682.979,
#     the max was $20,338,986, and that the min was was $0.
# Asking questions of the data ----------------------------- (**29 points**)

# Write the appropriate dplyr code to answer each one of the following questions
# Make sure to return (only) the desired value of interest (e.g., use `pull()`)
# Store the result of each question in a variable with a clear + expressive name
# If there are multiple observations that meet each condition, the results
# can be in a vector. Make sure to *handle NA values* throughout!
# You should answer each question using a single statement with multiple pipe
# operations!

# What was the name of the project(s) with the highest goal?
highest_goal_project <- pull(highest_goal <- df %>%
                               filter(goal == max(goal, na.rm = T)) %>%
                               select(name))

# What was the category of the project(s) with the lowest goal?
lowest_goal_category <- pull(highest_goal <- df %>%
                               filter(goal == min(goal, na.rm = T)) %>%
                               select(name))

# How many projects had a deadline in 2018? 3272 projects
deadline_2018_projects <- pull(
  dealine_2018 <- df %>%
    filter(substr(deadline, 1, 4) == 2018) %>%
    summarise(count = n(), na.rm = T) %>% select(count)
)

# What proportion or projects weren't successful? Your result can be a decimal 0.6462377
not_successful <- pull(
  df %>%
    filter(state != "successful") %>%
    summarise(no_success = n()) %>% mutate(
      proportion_unsuccessful =
        no_success / nrow(df),
      na.rm = T
    ) %>%
    select(proportion_unsuccessful)
)

# What was the amount pledged for the project with the most backers?
amount_pledged_for_most_backers <- pull(most_backers <- df %>%
                                          filter(backers ==
                                                   max(backers, na.rm = T)) %>%
                                          select(pledged))

# Of all of the projects that *failed*, what was the name of the project with
# the highest amount of money pledged?
failed_and_highest_pledged_project <-
  pull(
    highest_pledged_and_failed <- df %>%
      filter(state == "failed") %>%
      filter(pledged == max(pledged, na.rm = T)) %>%
      select(name)
  )

# How much total money was pledged to projects that weren't successful?
total_unsuccessful_pledged <- sum(df %>%
                                    filter(state != "successful") %>%
                                    select(pledged), na.rm = T)

# Write (and answer) two meaningful questions of the data that can be answered
# using similar operations (`filter`, `pull`, `summarize`, `mutate`, etc.).
# Add a column that has the difference between the goal and pledged of the projects:
df_with_goal_pledge_difference <-
  df %>% mutate(reality = goal - pledged, na.rm = T)
# Summarize the average of the usd_goal_real:
usd_goal_real_avg <-
  df %>% summarise(avg_usd_goal_real = mean(usd_goal_real, na.rm = T))
# Performing analysis by *grouped* observations ----------------- (38 Points)

# Which category had the most money pledged (total)?
highest_total_pledged_category <- pull(
  df %>% group_by(category) %>%
    summarise(total_pledged =
                sum(pledged, na.rm = T)) %>%
    filter(total_pledged == max(total_pledged, na.rm = T)) %>% select(category)
)

# Which country had the most backers?
country_with_most_backers <-
  pull(df %>% filter(backers == max(backers, na.rm = T))
       %>% select(country))

# Which year had the most money pledged (hint: you may have to create a new
# column)?
most_money_pledged_year <-
  pull(
    df %>% mutate(year_launched = substr(launched, 1, 4), na.rm = T) %>%
      group_by(year_launched) %>%
      summarise(sum_pledged = sum(pledged, na.rm = T)) %>%
      filter(sum_pledged == max(sum_pledged, na.rm = T)) %>%
      select(year_launched)
  )

# What were the top 3 main categories in 2018 (as ranked by number of backers)?
top_three_categ_2018 <-
  pull(
    df %>% mutate(year_launched = substr(launched, 1, 4), na.rm = T) %>%
      filter(year_launched == "2018") %>%
      arrange(-backers) %>% head(3, na.rm = T) %>% select(category)
  )

# What was the most common day of the week on which to launch a project?
# (return the name of the day, e.g. "Sunday", "Monday"....)
most_common_launching_day <-
  pull(
    df %>% mutate(days = weekdays(as.Date(
      deadline, "%Y-%m-%d"
    )), na.rm = T) %>%
      group_by(days) %>%
      mutate(count = n(), na.rm = T) %>% ungroup() %>%
      filter(count == max(count, na.rm = T)) %>%
      summarise(days = max(days, na.rm = T)) %>% select(days)
  )

# What was the least successful day on which to launch a project? In other
# words, which day had the lowest success rate (lowest proportion of projects
# that were successful)? This might require some creative problem solving....
least_successful_launching_day <-
  pull(
    df %>% mutate(days = weekdays(as.Date(
      deadline, "%Y-%m-%d"
    )), na.rm = T) %>% group_by(days) %>%
      mutate(count_state = n(), na.rm = T) %>% group_by(days, state) %>%
      filter(state != "successful") %>%
      mutate(count_unsuccessful = n()) %>%
      mutate(prop = (count_unsuccessful / count_state)) %>% ungroup() %>%
      filter(prop == min(prop, na.rm = T)) %>%
      select(days) %>% head(1)
  )

# Write (and answer) two meaningful questions of the data that can be answered
# by _grouping_ the data and performing summary calculations:
# Which category had the (total) most backers?
most_backers_category <- pull(
  df %>% group_by(category) %>%
    summarise(sum_backers =
                sum(backers, na.rm = T)) %>%
    filter(sum_backers == max(sum_backers, na.rm = T)) %>%
    select(category)
)
# Which currency had the most goal?
most_goal_currency <- pull(
  df %>% group_by(currency, na.rm = T) %>%
    summarise(sum_goal = sum(goal, na.rm = T)) %>%
    filter(sum_goal == max(sum_goal, na.rm = T)) %>% select(currency)
)

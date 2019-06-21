# a3-using-data
install.packages("dplyr")
library(lintr)
# Before you get started, set your working directory using the Session menu

###################### Data Frame Manipulation (24 POINTS) #####################

# Create a vector `students` holding 1,000 values representing students
# They should have the values "Student 1", "Student 2",..., "Student 1000"
students <- c(paste("Student", seq(1, 1000)))

# Create a vector `math_grades` that holds 1000 random values in it
# (these represent grades in a math course)
# These values should be normally distributed with a mean of 88 and a
# standard deviation of 10
math_grades <- rnorm(n = 1000, mean = 88, sd = 10)

# Replace any values in the `math_grades vector` that are above 100 with
# the number 100
math_grades[math_grades > 100] <- 100

# Create a vector `spanish` that holds 1000 random values in it
# (these represent grades in a spanish course)
# These values should be normally distributed with a mean of 85 and a
# standard deviation of 12
spanish <- rnorm(n = 1000, mean = 85, sd = 12)

# Replace any values in the `spanish_grades` that are above 100 with
# the number 100
spanish[spanish > 100] <- 100

# Create a data.frame variable `grades` by combining
# the vectors `first_names`, `math_grades`, and `spanish_grades`
# Make sure to properly handle strings
grades <- data.frame(students, math_grades, spanish, stringsAsFactors = FALSE)

# Create a variable `num_students` that contains the
# number of rows in your dataframe `grades`
num_students <- nrow(grades)

# Create a variable `num_courses` that contains the number of columns
# in your dataframe `grades` minus one (b/c of their names)
num_courses <- ncol(grades) - 1

# Add a new column `grade_diff` to your dataframe, which is equal to
# `students$math_grades` minus `students$spanish_grades`
grades$grade_diff <- grades$math_grades - grades$spanish

# Add another column `better_at_math` as a boolean (TRUE/FALSE) variable that
# indicates that a student got a better grade in math
grades$better_at_math <- grades$grade_diff > 0

# Create a variable `num_better_at_math` that is the number
# (i.e., one numeric value) of students better at math
num_better_at_math <- nrow(grades[grades$better_at_math == TRUE, ])

# Write your `grades` dataframe to a new .csv file inside your data/ directory
# with the filename `grades.csv`. Make sure *not* to write row names.
# (you'll need to create the `data/` directory, which you can do outside of R)
write.csv(grades, "data/grades.csv", row.names = FALSE)

########################### Built in R Data (28 points) ########################

# In this section, you'll work with the `Titanic` data set
# Which is built into the R environment.
# This data set actually loads in a format called a *table*
# See https://cran.r-project.org/web/packages/data.table/data.table.pdf
# Use the `is.data.frame()` function to test if it is a table.
is.data.frame("Titanic")

# Create a variable `titanic_df` by converting `Titanic` into a data frame;
# you can use the `data.frame()` function or `as.data.frame()`
# Be sure to **not** treat strings as factors!
titanic_df <- data.frame(Titanic, stringsAsFactors = FALSE)

# It's important to understand the _meaning_ of each column before analyzing it
# Using comments below, describe what information is stored in each column
# For categorical variables, list all possible values
# Class: 1st, 2nd, 3rd, Crew
# Sex: Female, Male
# Age: Child, Adult
# Survived: No, Yes
# Freq: any number from 0-670



# Create a variable `children` that are the *only* the rows of the data frame
# with information about the number children on the Titanic.
children <- titanic_df[titanic_df$Age == "Child", ]

# Create a variable `num_children` that is the total number of children.
# Hint: remember the `sum()` function!
num_children <- sum(nrow(children))

# Create a variable `most_lost` which has the *row* with the
# largest absolute number of losses (people who did not survive).
# Tip: if you want, you can use multiple statements (lines of code)
# if you find that helpful to create this variable.
non_survivors <- titanic_df[titanic_df$Survived == "No", ]
most_lost <- max(non_survivors$Freq)
  
# Define a function called `survival_rate()` that takes in two arguments:
# - a ticket class (e.g., "1st", "2nd"), and
# - the dataframe itself (it's good practice to explicitly pass in data frames)
# This function should return the following
# sentence that states the *survival rate* (# survived / # in group)
# of adult men and "women and children" in that ticketing class.
# It should read (for example):
# Of Crew class, 87% of women and children survived and 22% of men survived.
# The approach you take to generating the sentence to return is up to you.
# A good solution will likely utilize filtering to produce the required data.
# You must round values and present them as percentages in the sentence.
survival_rate <- function(given_class, titanic_df) {
    class_df <- titanic_df[titanic_df$Class == given_class, ]
    men_df <- class_df[class_df$Sex == "Male" & class_df$Age != "Child", ]
    children_female_df <- class_df[class_df$Sex == "Female" |
    class_df$Age == "Child", ]
    men_total <- sum(men_df$Freq)
    men_survived <- sum(men_df$Freq[men_df$Survived == "Yes"])
    children_female_survived <- sum(children_female_df$Freq[
      children_female_df$Survived == "Yes"])
    children_female_total <- sum(children_female_df$Freq)
    men_rate <- round( (men_survived / men_total) * 100)
    children_female_rate <- round( (children_female_survived /
                                     children_female_total) * 100)
    return(paste0("Of ", given_class, " class ", children_female_rate,
                  "% of women and children survived and ", men_rate,
                  "% of men survived."))
}
# Create variables `first_survived`, `second_survived`, `third_survived` and
# `crew_survived` by passing each class and the `titanic_df` data frame
# to your `survival_rate` function
# (`Crew`, `1st`, `2nd`, and `3rd`), passing int
first_survived <- survival_rate("1st", titanic_df)
second_survived <- survival_rate("2nd", titanic_df)
third_survived <- survival_rate("3rd", titanic_df)
crew_survived <- survival_rate("Crew", titanic_df)

# What notable differences do you observe in the survival rates across classes?
# Note at least 2 observations.
# ANSWER: Across all of the classes, almost 100% of the women and children in 1st class survived whereas less than half
# of the women and children in the 2nd class survived.

# What notable differences do you observe in the survival rates between the
# women and children versus the men in each group?
# Note at least 2 observations.
# ANSWER: across all of the classes, the survival rate for female adults and all children combined was higher than
# the survival rate for men adults. The first class had the highest survival rates for everyone combined.


########################### Reading in Data (43 points)#########################
# In this section, you'll work with .csv data of life expectancy by country
# First, you should download a .csv file of Life Expectancy data from GapMinder:
# https://www.gapminder.org/data/
# You should save the .csv file into your `data` directory

# Before getting started, you should explore the GapMinder website to understand
# the *original* source of the data (e.g., who calculated these estimates)
# Place a brief summary of the each data source here (e.g., 1 - 2 sentences
# per data source)
# SUMMARY: The data was collected from several places in four steps. The period from 1990 to
# 2015 uses data collected from Institute for Health Metrics and Evaluation from their
# Global Burden of Disease Study in 2015. Data before 1990 uses Gapminder Historic Life
# Expectancy data, and data before 1970 are collected of estimates of average life expectancy
# from different sources like including Human Mortality Database,
# World Population Prospects: The 2010 Revision / United Nations Population Division, with
# projections, Publications and files by history prof. James C Riley, Human Lifetable Database,
# and other miscellaneous sources. Where no estimates are available form any source, 
# before 1950, they constructed, a simple model for showing levels and changes in historical 
# life expectancy, mainly based on Infant Mortality Rate data.

# Using the `read.csv` function, read the life_expectancy_years.csv file into
# a variable called `life_exp`. Makes sure not to read strings as factors
life_exp <- read.csv("data/life_expectancy_years.csv", stringsAsFactors = FALSE)

# Write a function `get_col_mean()` that takes in a column name and a data frame
# and returns the mean of that column. Make sure to properly handle NA values
get_col_mean <- function(col_name, life_exp = life_exp) {
  return(mean(life_exp[, col_name], na.rm = TRUE))
}
# Create a list `col_means` that has the mean value of each column in the
# data frame (except the `Country` column). You should use your function above.
my_list <- colnames(life_exp)
my_l <- my_list[-1]
col_means <- lapply(my_l, get_col_mean, life_exp = life_exp)

# Create a variable `avg_diff` that holds the difference in average country life
# expectancy between 1800 and 2018?
avg_2018 <- get_col_mean("X2018", life_exp)
avg_1800 <- get_col_mean("X1800", life_exp)
avg_diff <- avg_2018 - avg_1800

# Create a column `life_exp$change` that is the change
# in life expectancy from 2000 to 2018. Increases in life expectancy should
# be *positive*
life_exp$change <- life_exp$X2018 - life_exp$X2000

# Create a variable `most_improved` that is the *name* of the country
# with the largest gain in life expectancy
# Make sure to filter NA values!
most_improved <- life_exp$country[max(life_exp$change, na.rm = TRUE)]

# Create a variable `num_small_gain` that has the *number* of countries
# whose life expectance has improved less than 1 year between 2000 and 2018
# Make sure to filter NA values!
num_small_gain <- sum(life_exp$change < 1, na.rm = TRUE)

# Write a function `country_change()` that takes in a country's name,
# two (numeric) years, and the `life_exp` dataframe as parameters.
# It should return the phrase:
# "Between YEAR1 and YEAR2, the life expectancy in COUNTRY went DIRECTION by
# SOME_YEARS years".
# Make sure to properly indictate the DIRECTION as "up" or "down"
country_change <- function(country_name, year1, year2, life_exp, na.rm = TRUE) {
  year2_value <- life_exp[life_exp$country == country_name,
                          paste("X", year2, sep = "")]
  year1_value <- life_exp[life_exp$country == country_name,
                          paste("X", year1, sep = "")]
  change <- year2_value - year1_value
  if (change >= 0) {
    direction <- "up"
  }else {
    direction <- "down"
  }
  print(paste0("Between ", year1, " and ", year2, " the life expectancy in ",
               country_name, " went ", direction, " by ", abs(change),
               " years"))
}

# Using your `country_change()` function, create a variable `sweden_change`
# that is the change in life expectancy from 1960 to 1990 in Sweden
sweden_change <- country_change("Sweden", 1960, 1990, life_exp)

# Write a function `compare_change()` that takes in two country names and your
# `life_exp` data frame as parameters, and returns a sentence that describes
# their change in life expectancy from 2000 to 2018 (the `change` column)
# For example, if you passed the values "China", and "Bolivia" to you function,
# It would return this:
# "The country with the bigger change in life expectancy was China (gain=6.9),
#  whose life expectancy grew by 0.6 years more than Bolivia's (gain=6.3)."
# Make sure to round your numbers to one digit (though only after calculations!)
compare_change <- function(country1, country2, life_exp) {
  country1_change <- life_exp[life_exp$country == country1, "change"]
  country2_change <- life_exp[life_exp$country == country2, "change"]

  if (country1_change >= country2_change) {
    bigger_country <- country1
    more_change <- country1_change
    less_change <- country2_change
  }else {
    bigger_country <- country2
    more_change <- country2_change
    less_change <- country1_change
  }
  final_change <- more_change - less_change
  return(paste0("The country with the bigger change in life expectancy was ",
bigger_country, "(gain=", round(more_change, digit = 1), ").
 whose life expectancy grew by ", round(final_change, digit = 1),
" years more than ", country2, "'s (gain=",
 round(less_change, digit = 1), ")."))
}

# Using your `bigger_change()` function, create a variable `usa_or_france`
# that describes who had a larger gain in life expectancy (the U.S. or France)
usa_or_france <- compare_change("France", "United States", life_exp)

# Write your `life_exp` data.frame to a new .csv file to your
# data/ directory with the filename `life_exp_with_change.csv`.
# Make sure not to write row names.
write.csv(life_exp, "data/life_exp_with_change.csv", row.names = FALSE)
# a3-using-data
This rubric is intended to help guide expectations and increase transparency. However, it **is not** necessarily fully exhaustive. Make sure to read the detailed explanation on Canvas, and follow the best practices described in the course book and in class.

For full credit, make sure you match variable names **exactly**. Partial credit will be given where appropriate. 

## DataFrame Manipulation (**24 points**, 2 points each)

- Create a vector `students` holding 1,000 values representing students 
    - 1 if incorrect spacing (e.g., no space between "Student" and the number)

- Create a vector `math_grades` that holds 1000 random values in it
    - -1 if mean or standard deviation isn't properly set
    - -1 if values aren't normally distributed

- Replace any values in the `math_grades` vector that are above 100 with the number 100

- Create a vector `spanish_grades` that holds 1000 random values in it
    - -1 if mean or standard deviation isn't properly set
    - -1 if values aren't normally distributed

- Replace any values in the `spanish_grades` that are above 100 with the number 100

- Create a data.frame variable `grades` by combining your vectors `students`, `math_grades`, and `spanish_grades`. Make sure to properly handle strings 
    - -1 if data frame is created with any factor values

- Create a variable `num_students` that contains the number of rows in your data.frame `grades`

- Create a variable `num_courses` that contains the number of columns in your data.frame `grades` minus one (b/c of their names)
    - -1 if incorrect calculation
    - -1 if the number of columns isn't calculated using an appropriate R function

- Add a new column `grade_diff` to your dataframe, which is equal to the difference between the math and spanish grade columns

- Add another column `better_at_math` as a boolean (TRUE/FALSE) variable that indicates that a student got a better grade in math

- Create a variable `num_better_at_math` that is the number (i.e., one numeric value) of students better at math
    - -1 if the result isn't a single value

- Write your `grades` data.frame to a new .csv file inside your data/ directory with the filename `grades.csv`. Make sure not to write row names.
    - -1 if not written to the `data/` directory using a *relative* path
    - -1 if row names are written


## Built in R Data (**28 points**)
- Use the `is.data.frame()` function to test if it is a table. (**2 points**)

- Create a variable `titanic_df` by converting `Titanic` into a data frame (**2 points**)
    - -1 if strings are treated as factors

- Using comments below, describe what information is stored in each column (**4 poits**):
    - 1 point correct interpretation of for each column: categorical columns must have unique values listed.

- Create a variable `children` that are the rows of the data frame with information about children on the Titanic. (**2 points**)

- Create a variable `num_children` that is the total number of children on the Titanic. (**2 points**)

- Create a variable `most_lost` which has row with the largest absolute number of losses (people who did not survive) (**2 points**)


- Define a function called `survival_rate()` that takes in two arguments:... (**10 points**)
    - -2 if function doesn't take in the 2 arguments (and refer to them properly throughout)
    - -2 for mis-calculation of survival rate of adult men
    - -2 for mis-calculation of survival rate of women and children
    - -1 for not showing as a percentage
    - -1 for not rounding
    - -1 for sentence error (e.g., too many spaces or not enough spaces between values)
    - -1 for overly complex or difficult to follow approach

- Create variables `first_survived`, `second_survived`, `third_survived` and `crew_survived`(**4 points**)

- What notable differences do you observe in the survival rates across classes? (**2 points**)
    - 1 point per accurate observation

- What notable differences do you observe in the survival rates between the women and children versus the men in each group? (**2 points**)
    - 1 point per accurate observation


## Reading in Data (43 points)
- Downloads data into the `data/` directory (**2 points**). No need to write R code to do this, just use the web interface.
    - -1 if not in `data/` directory

- Place a brief summary of the each data source here (**3 points**)
    - 1 point for listing data source of each period

- Using the `read.csv` funciton, read the .csv file into a variable called `life_exp` (**2 points**)
    - -1 for not handling string variable properly 

- Write a function `get_col_mean()` that takes in a column name and a data frame, and returns the mean of that column. Make sure to properly handle NA values (**4 points**)
    - -1 if it doesn't take 2 arguments
    - -1 if it doesn't handle NA values

- Create a list `col_means` that has the mean value of each column in the data frame (except the `country` column). You should use your function above. (**5 points**)
    - -2 if a list isn't created
    - -1 if the `country`column is included
    - -2 if logic of calculation is incorrect

- Create a variable `avg_diff` that holds the difference in average country life expectancy between 1800 and 2018? (**2 points**)

- Create a column `life_exp$change` that is the change in life expectancy from 2000 to 2018 (**1 point**)
    - -1 if increases in life expectancy are not positive numbers

- Create a variable `most_improved` that is the name of the country with the largest gain in life expectancy (**2 points**)
    - -1 if not the _name_ of the country
    - -1 if NA values aren't properly filtered (which you have to do explicitly)

- Create a variable `num_small_gain` that has the number of countries whose life expectance has improved less than 1 year between 2000 and 2018 (**2 points**)
    - -1 if not the number of the countries
    - -1 if NA values aren't properly filtered (which you have to do explicitly)

- Write a function `country_change()`... (**6 points**)
    - -1 if argument names aren't meaningful (your choice, but should be clear)
    - -1 if data frame isn't properly reference by the argument name inside the function
    - -1 if the "direction" isn't properly computed
    - -1 if the difference isn't properly calculate4d
    - -1 if the value isn't rounded to one decimal place
    - -1 if the spacing in the sentence isn't appropriate (i.e., too many or not enough space)

- Using your `country_change()` funciton, create a variable `sweden_change` that is the change in life expectancy from 1960 to 1990 in Sweden (**2 points**)

- Write a function `compare_change()` that takes in two country names as parameters.... (**8 points**)
    - -1 if argument names aren't meaningful (your choice, but should be clear)
    - -1 if data frame isn't properly reference by the argument name inside the function
    - 1 point for identifying the country with the bigger change
    - 1 point for placing the countries in the right order in the sentence
    - 1 point for calculating the change (before rounding!)
    - 1 point for proper spacing in the sentence
    - 1 point for rounding each number in the sentence to 1 digit
    - -1 if overly complex

- Using your `compare_change()` funciton, create a variable `usa_or_france` that describes who had a larger gain in life expectancy (the United States or France) (**2 points**)

- Write your `life_exp` data.frame to a new .csv file to your data/ directory with the filename `life_expectancy_with_change.csv`. Make sure not to write row names. (**2 points**)
    - -1 if not written to the `data/` directory using a *relative* path
    - -1 if row names are written

## Code clarity (**5 points**)
To earn full points, you must not have any `lintr()` errors. 
- -1 point for 1 - 2 `lintr` errors
- -2 points for 3 - 4 `lintr` errors
- -3 points for 5 - 6 `lintr` errors
- -4 points for 7 - 8 `lintr` errors
- -5 points for 9+ `lintr` errors
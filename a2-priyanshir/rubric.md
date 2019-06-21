# a2-foundational-skills
This rubric is intended to help guide expectations and increase transparency. However, it **is not** necessarily fully exhaustive. Make sure to read the detailed explanation on Canvas, and follow the best practices described in the course book and in class.

For full credit, make sure you match variable names **exactly**. Partial credit will be given where appropriate. 

# Set up and Defining variables -------------------- (**12 points**)
- Load the the `stringr` package (**2 points**).

- Create a numeric variable `my_age` that is equal to your age (**2 points**, -1 if not numeric)

- Create a variable `my_name` that is equal to your first name (**2 points**)

- Using multiplication, create a variable `minutes_in_a_day` that is equal to the number of minutes in a day (**2 points**)
    - -1 if not using multiplication
    
- Using multiplication, create a variable `hours_in_a_year` that is the number of hours in a year (**2 points**)
    - -1 if not using multiplication

- Create a variable `more_minutes_than_hours` that is a boolean value (TRUE/FALSE) (**2 points**)
    - -1 if not calculated using a logical operator

## Working with functions ------------------------------ (**50 points**)

- Write a function called `make_introduction()` that takes in two arguments, `name`, and `age`... (**4 points**)
  - -1 for incorrect spacing
  - -1 for incorrect function or argument name
  - -2 for any logical errors

- Create a variable `my_intro` by passing your variables `my_name` and `my_age` into your `make_introduction()` function (**2 points**)


- Create the `casual_intro` variable using a substitution (**2 points**)

- Create the `loud_intro` variable using the appropriate function (**2 points**)

- Create the `quiet_intro` variable using the appropriate function (**2 points**)

- Create the `capitalized_intro` variable using the appropriate function (**2 points**)

- Create the `occurrences` variable using the appropriate function (**2 points**)

- Write a function `double()` that takes in a value and returns that value times two (**3 points**)
    - -1 for incorrect function name
    - -1 for returning the incorrect value

- Using your `double()` function, create a variable `minutes_in_two_days` (**2 points**)
  - -1 if doesn't use `minutes_in_a_day`


- Write a function `cube()` that takes in a value and returns that value cubed (**3 points**)
    - -1 for incorrect function name
    - -1 for returning the incorrect value

- Create a variable `twenty_seven` by passing 3 to your `cube()` function (**2 points**)

- Create a variable `inches_tall` that is your (numeric) height in inches (**2 points**)

- Create a function `inches_to_cm` that converts from inches to centimeters (**3 points**)
  - -1 for incorrect function name or argument name that isn't related to the topic (argument name should be _meaningful_ but is up to you)
  - -1 for incorrect calculation

- Using your `inches_to_cm` function and your `inches_tall` variable, create a variable `cm_tall` that is your height in centimeters (**2 points**)
  - -1 if it doesn't use the function/variables listed

- Write the `has_more_zs` function (**10 points**):
  - -2 if it doesn't work for upper or lower case
  - -2 if it doesn't contain the logic to return _"Neither string contains the letter z"_
  - -2 if it doesn't contain the logic to return _"The strings have the same number of Zs."_
  - -2 if it doesn't contain the logic to return the parameter with more Zs (-1 if it returns a modified version of the parameter)
  - -2 for any errors in the logic

- Create a variable `more_zs` by passing two strings of your choice to your `has_more_zs` function (**2 points**)

- Write a function `remove_digits` that will remove all digits (i.e., 0 through 9) from all elements in a *vector of strings*. (**5 points**)
  - -1 if the logic is unnecessarily complex (e.g., longer than, say, 4 lines of code)
  - -1 if it doesn't remove all digits
  - -1 if it removes characters that aren't digits

- Demonstrate that your approach is successful by passing a vector of courses to your function. (**2 points**)

## Vectors --------------------------- (**24 points**)

- Create a vector `movies` that contains the names of six movies you like (**2 points**)

- Create a vector `top_three` that only contains the first three movies in the vector (**2 points**) 
  - -1 if it doesn't use subsetting

- Using your vector and the paste method, create a vector `excited` that adds the phrase " is a great movie!" to the end of each element in your movies vector (**2 points**)

- Create a vector `without_four` that has your first three movies, and your 5th and 6th movies. You should do this using a _negative index_ (**2 points**)
  - -1 if it doesn't use a negative index

- Create a vector `multiples_of_4` that is every number divisible by 4 between 4 and 400 (**2 points**)

- Create a vector `multiples_of_8` by filtering your `multiples_of_4` variable down to only elements that are divisible by 8 (**2 points**)


- Create a vector `numbers` that is the numbers 700 through 999  (**2 points**)

- Using the built in length function, create a variable `numbers_len` that is equal to the length of your vector `numbers` (**2 points**)

- Using the `mean` function, create a variable `numbers_mean` that is the mean of your vector `numbers` (**2 points**)

- Using the `median` function, create a variable `numbers_median` that is the mean of your vector `numbers` (**2 points**)

- Create a vector `lower_numbers` that the values in your `numbers` vector that are lower than `numbers_mean` (you should do this using vector filtering) (**2 points**)

- Create a vector `higher_numbers` that the values in your `numbers` vector that are higher than `numbers_mean` (again, using vector filtering)
(**2 points**)
  
# Lists ------------------------------------------- (**9 points**)

- Create a list called `summary_info` in which you'll store summary information about the `numbers` vector above (**3 points**):
  - 1 point each for mean, median, length


- Now, write a function called `summarize_vector` that takes in a vector of numbers, and returns a list of summary information about that vector (including the mean, median, and length). (**4 points**)
  - 1 point for each for mean, median, length
  - 1 point for the function working properly

- Create a vector `summary_1_to_100` by passing a vector of the values one through one hundred to your `summarize_vector` function (**2 points**)

## Code clarity ------------------------------------- (**5 points**)
To earn full points, you must not have any `lintr()` errors. 
- -1 point for 1 - 2 `lintr` errors
- -2 points for 3 - 4 `lintr` errors
- -3 points for 5 - 6 `lintr` errors
- -4 points for 7 - 8 `lintr` errors
- -5 points for 9+ `lintr` errors

# A6 API Report
This rubric is intended to help guide expectations and increase transparency. However, it **is not** necessarily fully exhaustive. Make sure to read the detailed explanation on Canvas, and follow the best practices described in the course book and in class.

Partial credit will be given where appropriate. 

## Set up (**15 points**)
- Creates each file with the appropriate file name (**4 points**)
- Ignores the file containing API keys (**2 points**)
- Sources files appropriately into the `.Rmd` file using relative paths (**2 points**)
- Add a link the the hosted report in the `README.md` file (**2 points**)
- Create a second level header (`##`) for each section of the report (**5 points**)

## Introduction (**10 points**)
- Introduce the purpose of the project (**2 points**)
- Include a link to each API (you should hyperlink some text, _not_ display a URL) (**4 points**)
- Displays the address chosen for the report (**2 points**)
- Uses both bold and italics (**2 points**)

## Table of Representatives (**26 points**)
- Requests and processes data from appropriate endpoint (**5 points**)
- Performs data join properly, as described on Canvas (**2 points**)
- Creates a data frame to display as a table with the following columns:
    - The name of the representative, which should be hyperlinked to their website (**5 points**)
    - Position (**2 points**)
    - Party (**2 points**)
    - Email, set up as a link with NA where not available (**4 points**)
    - Phone number of the candidate (**2 points**)
    - Photo, set up as a link with NA where not available (**4 points**)
- Displays the dataframe as a table (**2 points**)
- Has well formatted column headers (**2 points**)

## House of Representatives Charts (**20 points**)
- Requests and processes data from appropriate endpoint (**5 points**)
- Uses appropriate package to compute summary information for the plots (**5 points**)
- Creates a horizontal bar chart of gender with title/axis labels (**5 points**)
- Creates a horizontal bar chart of political affiliation with title/axis labels (**5 points**)

## Selected Representative Information (**17 points**)
- Write a paragraph clearly expressing the desired information (**3 points**)
- Requests and processes data from appropriate endpoint (**5 points**)
- Calculates age of representative (**3 points**)
- Extracts twitter link (**2 points**)
- Accurately calculates percentage of time agreed with a vote (**4 points**)

## Code clarity (**12 points**)
To earn full points, you must not have any `lintr()` errors (in _any_ `.R` file you create): 
- -1 point for 1 - 2 `lintr` errors
- -2 points for 3 - 4 `lintr` errors
- -3 points for 5 - 6 `lintr` errors
- -4 points for 7 - 8 `lintr` errors
- -5 points for 9+ `lintr` errors

- 3 points for appropriate use of `dplyr` to perform data manipulation throughout
- 2 points for use of comments to describe purpose of code
- 2 points for excluding all undesired content in the report (e.g., warnings, code, messages)
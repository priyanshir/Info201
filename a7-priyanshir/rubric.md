# A7 Shiny App
This rubric is intended to help guide expectations and increase transparency. However, it **is not** necessarily fully exhaustive. Make sure to read the detailed explanation on Canvas, and follow the best practices described in the course book and in class.

Partial credit will be given where appropriate. 

## Set up (**8 points**)
- Creates `app.R` file (**1 point**)
- Creates `app_ui.R` file (**1 point**)
- Creates `app_server.R` file (**1 point**)
- Adds shinyapp.io link to `README.md` (**1 point**)
- Creates a user interface that has a navigable multi-page layout (**4 points**)

## Interactive pages (**32 points**, 16 each)
Each interactive page must contain the following:
- A `sideBarlayout` to appropriately organize content (**2 points**)
- One labeled and working widget that controls the data being displayed in a chart (**4 points**)
- A second labeled and working widget that controls either the data being displayed, or a visual setting of the chart, such as the color (**4 points**)
- A visual representation of the data (**6 points**), making sure to include appropriate titles, labels, legends, and encodings

## Code clarity and Submission (**10 points**)
- Successfully hosts project on `shinyapps.io` (**3 points**)

To earn full points, you must not have any `lintr()` errors (in _any_ `.R` file you create): 
- -1 point for 1 - 2 `lintr` errors
- -2 points for 3 - 4 `lintr` errors
- -3 points for 5 - 6 `lintr` errors
- -4 points for 7 - 8 `lintr` errors
- -5 points for 9+ `lintr` errors

- 1 point for appropriately organizing UI elements (e.g., you store elements of the UI in separate variables)
- 1 points for use of comments to describe purpose of code
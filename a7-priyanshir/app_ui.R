#loading libraries
library(shiny)
library(leaflet)
library(dplyr)
library(ggplot2)

df <- subset(midwest, select = -c(PID, county, inmetro, category))
names(df)[1] <- paste("State")
names(df)[2] <- paste("Total_Population")
names(df)[3] <- paste("Population_Density")
names(df)[4] <- paste("White_Population")
names(df)[5] <- paste("Black_Population")
names(df)[6] <- paste("American_Indian_Population")
names(df)[7] <- paste("Asian_Population")
names(df)[8] <- paste("Other_Population")
names(df)[9] <- paste("Percent_White")
names(df)[10] <- paste("Percent_Black")
names(df)[11] <- paste("Percent_American_Indian")
names(df)[12] <- paste("Percent_Asian")
names(df)[13] <- paste("Percent_Other")
names(df)[14] <- paste("Adult_Population")
names(df)[15] <- paste("Percent_HighSchooled")
names(df)[16] <- paste("Percent_College_Educated")
names(df)[17] <- paste("Percent_Profession")
names(df)[18] <- paste("Percent_Poverty_Known")
names(df)[19] <- paste("Percent_Poverty_Known")
names(df)[20] <- paste("Percent_Below_Poverty")
names(df)[21] <- paste("Percent_Child_Below_Poverty")
names(df)[22] <- paste("Percent_Adult_Poverty")
names(df)[23] <- paste("Percent_Elderly_Poverty")
#column names to choose from for x axis
select_col_values <- c("State", "White_Population", "Black_Population",
                       "American_Indian_Population", "Asian_Population", "Other_Population")
x_input <- selectInput(
  inputId = "x_variable_to_analyze",
  label = "Variable of Analysis (X Axis)",
  choices = select_col_values,
  selected = "State"
)
#column names to choose from for y axis
y_input <- selectInput(
  inputId = "y_variable_to_analyze",
  label = "Variable of Analysis (Y Axis)",
  choices = select_col_values,
  selected = "White_Population"
)
#manipulating the size of the circles based on user input
size_input <- sliderInput(
  inputId = "size",
  label = "Size of Circles",
  min = 1,
  max = 10,
  value = 5
)
#creating first page with scatter plot
page_one <- tabPanel(
  "First Page", # label for the tab in the navbar
  titlePanel("Midwest Demographics Plot"), # show with a displayed title

  # This content uses a sidebar layout
  sidebarLayout(
    sidebarPanel(
      x_input,
      y_input,
      size_input
    ),
    mainPanel(
      h3("Midwest Demographic Scatter Plot"),
      plotOutput(
        outputId = "scatter_plot"
      )
    )
  )
)
#choices for x axis of line graph on page two
land_choices <- c("county", "area", "Population_Density", "")

#selected x axis variable of analysis
x_chosen <- selectInput(
  inputId = "chosen_x",
  label = "Chosen  X variable of analysis",
  choices = land_choices,
  selected = "area"
)
#selected y axis variable of analysis
y_chosen <- selectInput(
  inputId = "chosen_y",
  label = "Y variable to analyze",
  choices = land_choices,
  selected = "Population_density"
)

#creating page two with line graph
page_two <- tabPanel(
  "Second Page", # label for the tab in the navbar
  titlePanel("Midwest Line Graph"), # show with a displayed title

  # This content uses a sidebar layout
  sidebarLayout(
    sidebarPanel(
      x_chosen,
      y_chosen
    ),
    mainPanel(
      h3("Line Graph based on Physical Attributes of the Various Places"),
      plotOutput("land_line_graph")
    )
  )
)
#putting all the pages together
my_ui <- navbarPage(
  "Midwest Demographics",
  page_one,
  page_two
)
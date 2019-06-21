library(shiny)
library(ggplot2)
library(leaflet)
library(dplyr)
source("app_ui.R")

 my_server <- function(input, output) {
  # Define a map to render in the UI
  output$scatter_plot <- renderPlot({
   # Construct a color palette (scale) based on chosen demogaphics
    palette_fn <- colorFactor(
      palette = ("Dark2"),
      domain = df[[input$x_variable_to_analyze]]
    )
    # Create and return the map
    ggplot(data = df) +
      geom_point(mapping = aes_string(x = input$x_variable_to_analyze,
                                      y = input$y_variable_to_analyze),
                 size = input$size,
                 color = "red") +
      labs(x = input$x_variable_to_analyze,
           y = input$y_variable_to_analyze,
           title = paste0(input$x_variable_to_analyze, " v.s. ",
                          input$y_variable_to_analyze))
    })

  output$land_line_graph <- renderPlot({
    #creating and returning second line graph based on different selections
    ggplot(data = df) +
      geom_line(mapping = aes_string(x = input$chosen_x,
                                      y = input$chosen_y),
                 size = input$size,
                 color = "red") +
      labs(x = input$chosen_x,
           y = input$chosen_y,
           title = paste0(input$chosen_x, " v.s. ",
                          input$chosen_y))
  })
 }
# Mental Health in Tech survey
# interactive something something
# Priyanshi and Divij
library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)

#creating dataframe using tech survey dataset
my_df <- read.csv("data/tech-survey.csv")

# Creation of a mainPanel that would, in turn, output the pie chart
main_panel_2 <- mainPanel(
  plotlyOutput("pie", height = "600px", width = "800px")
)

# Creation of a sidebarPanel that would, in turn,
# create variables `s_input` and `chart_type_input` that store a `selectInput()`
sidebar_2 <- sidebarPanel(
  s_input <- selectInput(
    "s_var",
    label = "State",
    choices = na.omit(unique(my_df$state))
  ),
  col_input <- selectInput(
    "col_var",
    label = "Type Variable",
    choices = colnames(my_df)[c(6, 7, 8, 11, 12, 26)]
  ),
  chart_type_input <- selectInput(
    "chart_type",
    label = "Chart Type",
    choices = list("2-D Pie Chart" = "2d", "Donut Chart" = "donut")
  )
)

# Creation of a tabPanel that consists of the second page of the app
plot2_tab <- tabPanel(
  titlePanel("Pie Chart"),
  h3("Exploring Tech Suvery Dataset:
  Pie/Donut Chart Having Population % Based
             on the Selected Variable"),
  sidebarLayout(
    sidebar_2,
    main_panel_2
  )
)

library(ggplot2)
library(shiny)
library(dplyr)

source("page_one.R")
source("page_two.R")
source("page_three.R")
source("page_four.R")
source("page_five.R")

ui <- navbarPage(
    "Mental Health Exploration",
    page_one,
    page_two,
    page_three,
    plot2_tab,
    page_five,
    fluidPage(includeCSS("www/style.css"))
)

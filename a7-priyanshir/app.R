library(shiny)
library(dplyr)
library(rsconnect)
library(ggplot2)
source("app_ui.R")
source("app_server.R")
rsconnect::setAccountInfo(name='priyanshir', token='44299544243A19569776C80B90EA7468',
                      secret='wOueQmXoFST18pp21RFrlu23oE++BWBDkl+4SvQz')
shinyApp(ui = my_ui, server = my_server)
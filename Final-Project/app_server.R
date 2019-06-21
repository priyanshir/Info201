library(lintr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(ggthemes)
options(scipen = 999)
library(leaflet)
library(shiny)
library(styler)

source("page_one.R")
source("page_two.R")
source("page_three.R")
source("page_four.R")
source("page_five.R")

server <- function(input, output) {

  # usa map
  output$usa_map <- renderPlot({
    if (input$diagnosis == "Alcohol Dependence") {
      diagnosis_chart <- joined %>%
        select(state, long, lat, Diagnosis, num_of_people, group) %>%
        filter(Diagnosis == "Alcohol Dependence")
      usa_chart <- ggplot(diagnosis_chart) +
        geom_polygon(
          mapping = aes(x = long, y = lat, group = group, fill = num_of_people),
          color = "white",
          size = .1
        ) +
        scale_fill_continuous(low = "#132B43", high = input$color) +
        labs(fill = "Prevalence of Alcohol Dependence in Mental Health
             Admittance") +
        blank_theme
      usa_chart
    }
    else if (input$diagnosis == "Cannabis Dependence") {
      diagnosis_chart <- joined %>%
        select(state, long, lat, Diagnosis, num_of_people, group) %>%
        filter(Diagnosis == "Cannabis Dependence")
      usa_chart <- ggplot(diagnosis_chart) +
        geom_polygon(
          mapping = aes(x = long, y = lat, group = group, fill = num_of_people),
          color = "white",
          size = .1
        ) +
        scale_fill_continuous(low = "#132B43", high = input$color) +
        labs(fill = "Prevalence of Cannabis Dependence in Mental Health
             Admittance") +
        blank_theme
      usa_chart
    }
    else if (input$diagnosis == "Opioid Dependence") {
      diagnosis_chart <- joined %>%
        select(state, long, lat, Diagnosis, num_of_people, group) %>%
        filter(Diagnosis == "Opioid Dependence")
      usa_chart <- ggplot(diagnosis_chart) +
        geom_polygon(
          mapping = aes(x = long, y = lat, group = group, fill = num_of_people),
          color = "white",
          size = .1
        ) +
        scale_fill_continuous(low = "#132B43", high = input$color) +
        labs(fill = "Prevalence of Opioid Dependence in Mental Health
             Admittance") +
        blank_theme
      usa_chart
    }
    else if (input$diagnosis == "Other Mental Health Conditions") {
      diagnosis_chart <- joined %>%
        select(state, long, lat, Diagnosis, num_of_people, group) %>%
        filter(Diagnosis == "Other Mental Health Conditions")
      usa_chart <- ggplot(diagnosis_chart) +
        geom_polygon(
          mapping = aes(x = long, y = lat, group = group, fill = num_of_people),
          color = "white",
          size = .1
        ) +
        scale_fill_continuous(low = "#132B43", high = input$color) +
        labs(fill = "Prevalence of Other Mental Health Conditions in Mental
             Health Admittance") +
        blank_theme
      usa_chart
    }
    else if (input$diagnosis == "Other Substance Dependence") {
      diagnosis_chart <- joined %>%
        select(state, long, lat, Diagnosis, num_of_people, group) %>%
        filter(Diagnosis == "Other Substance Dependence")
      usa_chart <- ggplot(diagnosis_chart) +
        geom_polygon(
          mapping = aes(x = long, y = lat, group = group, fill = num_of_people),
          color = "white",
          size = .1
        ) +
        scale_fill_continuous(low = "#132B43", high = input$color) +
        labs(fill = "Prevalence of Other Substance Dependence in Mental
             Health Admittance") +
        blank_theme
      usa_chart
    }
  })

  # State 1 Bar Chart
  output$state_one_chart <- renderPlot({
    if (input$column_choice == "Education") {
      state_one_choice <- data_for_page_three %>%
        select(State, Sex, Education) %>%
        filter(State == input$state_one) %>%
        group_by(Education, Sex) %>%
        summarize(num_of_people = n())
      bar_chart <- ggplot(state_one_choice) +
        geom_col(mapping = aes(
          x = reorder(Education, num_of_people),
          y = num_of_people, fill = Sex
        )) +
        ggtitle(paste0("Distribution of the Education Levels of Mental
                       Health Patients in: ", input$state_one)) +
        ylab("Number of People") +
        xlab("Education") +
        theme(
          plot.title = element_text(hjust = .5),
          axis.ticks = element_blank()
        ) +
        scale_fill_brewer(palette = "Pastel1")
      bar_chart
    }
    else if (input$column_choice == "Employment") {
      state_one_choice <- data_for_page_three %>%
        select(State, Sex, Employment) %>%
        filter(State == input$state_one) %>%
        group_by(Employment, Sex) %>%
        summarize(num_of_people = n())
      bar_chart <- ggplot(state_one_choice) +
        geom_col(mapping = aes(
          x = reorder(Employment, num_of_people),
          y = num_of_people, fill = Sex
        )) +
        coord_flip() +
        ggtitle(paste0("Distibution of Employment Type of Mental Health
                       Patients in: ", input$state_one)) +
        ylab("Number of People") +
        xlab("Employment") +
        theme(
          plot.title = element_text(hjust = .5),
          axis.ticks = element_blank()
        ) +
        scale_fill_brewer(palette = "Pastel1")
      bar_chart
    }
    else if (input$column_choice == "Diagnosis") {
      state_one_choice <- data_for_page_three %>%
        select(State, Sex, Diagnosis) %>%
        filter(State == input$state_one) %>%
        group_by(Diagnosis, Sex) %>%
        summarize(num_of_people = n())
      bar_chart <- ggplot(state_one_choice) +
        geom_col(mapping = aes(
          x = reorder(Diagnosis, num_of_people),
          y = num_of_people, fill = Sex
        )) +
        coord_flip() +
        ggtitle(paste0(
          "Distribution of Mental Health Diagnosis Type in: ",
          input$state_one
        )) +
        ylab("Number of People") +
        xlab("Diagnosis") +
        theme(
          plot.title = element_text(hjust = .5),
          axis.ticks = element_blank()
        ) +
        scale_fill_brewer(palette = "Pastel1")
      bar_chart
    }
  })

  # State 2 Chart
  output$state_two_chart <- renderPlot({
    if (input$column_choice == "Education") {
      state_two_choice <- data_for_page_three %>%
        select(State, Sex, Education) %>%
        filter(State == input$state_two) %>%
        group_by(Education, Sex) %>%
        summarize(num_of_people = n())
      bar_chart <- ggplot(state_two_choice) +
        geom_col(mapping = aes(
          x = reorder(Education, num_of_people),
          y = num_of_people, fill = Sex
        )) +
        ggtitle(paste0("Distribution of the Education Levels of Mental
                       Health Patients in: ", input$state_two)) +
        ylab("Number of People") +
        xlab("Education") +
        theme(
          plot.title = element_text(hjust = .5),
          axis.ticks = element_blank()
        ) +
        scale_fill_brewer(palette = "Pastel1")
      bar_chart
    }
    else if (input$column_choice == "Employment") {
      state_two_choice <- data_for_page_three %>%
        select(State, Sex, Employment) %>%
        filter(State == input$state_two) %>%
        group_by(Employment, Sex) %>%
        summarize(num_of_people = n())
      bar_chart <- ggplot(state_two_choice) +
        geom_col(mapping = aes(
          x = reorder(Employment, num_of_people),
          y = num_of_people, fill = Sex
        )) +
        coord_flip() +
        ggtitle(paste0("Distibution of Employment Type of Mental Health
                       Patients in: ", input$state_two)) +
        ylab("Number of People") +
        xlab("Employment") +
        theme(
          plot.title = element_text(hjust = .5),
          axis.ticks = element_blank()
        ) +
        scale_fill_brewer(palette = "Pastel1")
      bar_chart
    }
    else if (input$column_choice == "Diagnosis") {
      state_two_choice <- data_for_page_three %>%
        select(State, Sex, Diagnosis) %>%
        filter(State == input$state_two) %>%
        group_by(Diagnosis, Sex) %>%
        summarize(num_of_people = n())
      bar_chart <- ggplot(state_two_choice) +
        geom_col(mapping = aes(
          x = reorder(Diagnosis, num_of_people),
          y = num_of_people, fill = Sex
        )) +
        coord_flip() +
        ggtitle(paste0(
          "Distribution of Mental Health Diagnosis Type in: ",
          input$state_two
        )) +
        ylab("Number of People") +
        xlab("Diagnosis") +
        theme(
          plot.title = element_text(hjust = .5),
          axis.ticks = element_blank()
        ) +
        scale_fill_brewer(palette = "Pastel1")
      bar_chart
    }
  })
  # Output of 'pie'
  output$pie <- renderPlotly({

    # creating dataframe using tech survey dataset
    my_df <- read.csv("data/tech-survey.csv")

    # Number of rows of data in the dataset, given a state
    num_rows_state <- my_df %>%
      filter(state == input$s_var & !is.na(input$col_var)) %>%
      nrow()

    # Choice of data frame
    if (input$col_var == "self_employed") {
      chart_title <- "Type of Employment"

      df_variable <- my_df %>%
        group_by(state) %>%
        filter(state == input$s_var & self_employed == "No") %>%
        summarise(
          No = (length(self_employed) / num_rows_state),
          Yes = 1 - No
        )
    }
    else if (input$col_var == "family_history") {
      chart_title <- "Family History Of Mental Illness?"

      df_variable <- my_df %>%
        group_by(state) %>%
        filter(state == input$s_var & family_history == "No") %>%
        summarise(
          No = (length(family_history) / num_rows_state),
          Yes = 1 - No
        )
    }
    else if (input$col_var == "treatment") {
      chart_title <- "Have Sought Treatment?"

      df_variable <- my_df %>%
        group_by(state) %>%
        filter(state == input$s_var & treatment == "Yes") %>%
        summarise(
          Yes = (length(treatment) / num_rows_state),
          No = 1 - Yes
        )
    }
    else if (input$col_var == "obs_consequence") {
      chart_title <- "Have heard of or observed negative consequences
        for coworkers with mental health conditions in your workplace?"

      df_variable <- my_df %>%
        group_by(state) %>%
        filter(state == input$s_var & obs_consequence == "No") %>%
        summarise(
          No = (length(obs_consequence) / num_rows_state),
          Yes = 1 - No
        )
    }
    else if (input$col_var == "tech_company") {
      chart_title <- "Is the person's employer primarily a tech
        company/organization?"

      df_variable <- my_df %>%
        group_by(state) %>%
        filter(state == input$s_var & tech_company == "No") %>%
        summarise(
          No = (length(tech_company) / num_rows_state),
          Yes = 1 - No
        )
    }
    else if (input$col_var == "remote_work") {
      chart_title <- "Does the person work remotely
        at least 50% of the time?"

      df_variable <- my_df %>%
        group_by(state) %>%
        filter(state == input$s_var & remote_work == "No") %>%
        summarise(
          No = (length(remote_work) / num_rows_state),
          Yes = 1 - No
        )
    }
    variable_values <- t(df_variable[-c(1)])
    var_vals <- variable_values[, 1]

    # Margin values
    m <- list(
      l = 150,
      r = 150,
      b = 100,
      t = 120,
      pad = 4
    )

    # Creation of a pie chart, given a type
    if (input$chart_type == "2d") {
      pie_plot <- plot_ly(df_variable,
        labels = rownames(variable_values),
        values = var_vals, type = "pie"
      ) %>%
        layout(
          title = chart_title,
          xaxis = list(
            showgrid = FALSE, zeroline = FALSE,
            showticklabels = FALSE
          ),
          yaxis = list(
            showgrid = FALSE, zeroline = FALSE,
            showticklabels = FALSE
          ),
          margin = m
        )
      pie_plot
    } else {
      pie_plot_2 <- df_variable %>%
        plot_ly(
          labels = rownames(variable_values),
          values = var_vals
        ) %>%
        add_pie(hole = 0.6) %>%
        layout(
          title = chart_title,
          xaxis = list(
            showgrid = FALSE, zeroline = FALSE,
            showticklabels = FALSE
          ),
          yaxis = list(
            showgrid = FALSE, zeroline = FALSE,
            showticklabels = FALSE
          ),
          margin = m
        )
      pie_plot_2
    }
  })
}

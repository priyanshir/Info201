# Summary/takeaways go here
# Everyone contribute something about their interactive pages
library(shiny)
library(dplyr)
library(ggplot2)
library(tidyr)
#source("dsm_chart.R")
page_five <- tabPanel(
  titlePanel("Summary"),
  h3("Prevalence Findings"),
  p("Interestingly, the data showed that New York state had the highest
    prevalence rate for admittance and discharges by a landslide in
    comparison to any other state in the U.S. In addition, some surrounding
    states had noticeably higher prevalence rates in comparison to other
    states across the U.S."),
  p("The map below illustrates the stark difference between the number of
    people who seek mental health treatment in New York:"),
  img(src = 'map.jpg', height = 250, width = 400, align = "center"),
  p("This insight may raise further questions and concerns about mental health
    issues and mental health treatment in New York versus other states.
    For instance, is there a reason that more people in New York are
    diagnosed with or admitted/discharged for a mental illness?
    If so, is it due to better access to and
    awareness of mental health treatment options?
    Additional considerations can be beneficial to mental health
    treatment across the U.S."),
  h3("Diagnoses Findings"),
  p("The main takeaway from analyzing the frequencies of
    diagnoses for treament admittance and
    discharges is that substance- and alcohol-related
    disorders were the most common diagnoses. This means
    the more 'invisible' diseases (such as depression,
    anxiety, schizophrenia) or disorders that are less
    physically observable are not as commonly addressed as other disorders."),
  p("The chart illustrates the prevalence of all the
    different drug- and substance-related disorders
    in comparison the less physically observable
    disorders such as depression and anxiety."),
  img(src = "summary_bar.png", height = 300, width = 400, align = "center"),
  p("The broader implication of this finding is that
    physically observable disorders are addressed more often
    other, potentially more harmful 'invisible'
    disorders, which raises a number of points for future considerations."),
  h3("Tech Survey Dataset Findings"),
  p("One of the most notable observations that can
    be made from this data is that a majority of people
    in tech companies are uncomfortable with
    acknowledging and addressing their mental health issues,
    despite the lack of negative consequences they
    would experience in the workplace for doing so."),
  p("According to the data from the survey, 37.89% of people
    have an employer that provides mental health benefits,
    but only 40.98% of people reported that they would
    feel comfortable having a serious conversation with
    their supervisor about their mental health problems.
    Furthermore, a majority of people would not mention
    their mental health issues in an interview, and a
    majority of people say that did not know about mental
    health options provided by their employer. These
    data illustrate people's discomfort about discussing
    mental health issues and options for treatment."),
  p("The broader implication of these findings is that
    those who experience mental health issues do not
    get the help/treatment they need. This raises
    questions about whether this is due to stigma, lack of
    general awareness or acceptance for mental
    health treatment, or other factors. It may also encourage
    thoughts for possible courses of action people
    (whether they are employers, co-workers, or others)
    can or should take to remedy this problem."),
  img(src = "summary_table.png", height = 250, width = 300, align = "center")
)
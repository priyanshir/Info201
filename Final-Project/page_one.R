#Overview page
#build add overview info and photo here
#Priyanshi
library(shiny)
page_one <- tabPanel(
      titlePanel("Introduction"),
      h3("Mental Health Analysis of Causes/Diagnoses"),
      img("",
              src =
              "https://3.bp.blogspot.com/-Z1VuQaxwrcU/WREm26x7CmI/
AAAAAAAAAHU/EqQVnN-3d1EKKrrFmDM-ebhmIPFjinP8gCPcB/s1600/
iStock-590587586.jpg",
              height = 250, width = 300, align = "center"),
      h3("Introduction"),
      p("Our group focused on mental health because it is a meaningful
        topic that interests us both academically and personally.
        Mental health can affect anyone at some point in their life -
        people can become mentally ill, get diagnosed with a mental health
        disorder, or know someone (family, friend, colleague) who is
        challenged by mental health. This universal experience is an
        interesting topic to study due to its widespread impact.
        We are primarily interested in prevalence, access to treatment
        or care, external factors such as poverty/wealth, and education
        level, all related to geographic location."),
     h3("Datasets Used"),
     p("Our group decided to go with two major datasets,
       the first of which is a
       Mental Health in Tech Survey.
       This data was collected from a 2014 survey conducted by
       “Open Sourcing Mental Illness”,
       a non-profit corporation dedicated to raising awareness,
       educating, and providing
       resources to support mental wellness in the tech and open
       source communities.
       The survey explored the perspective of people in the tech
       industry towards their own mental health,
       the culture and attitudes surrounding mental health,
       and the prevalence
       of mental health disorders.
       Our second dataset comes from the Mental Health
       Admissions and Discharges dataset.
       It is an annual survey that is designed to collect statistical
       information on the services and features of all known mental
       health treatment facilities in the United States.
       Every other year, starting in 2014, N-MHSS also collects information
       on the numbers and demographics of persons served in these treatment
       centers. N-MHSS complements the information gathered through the
       National Survey of Substance AbuseTreatment Services (N-SSATS).
       N-SSATS is SAMHSA’s survey of substance abuse treatment facilities.
       We combined the two datasets (admissions and discharges) by the caseIDs
       and used that as our resulting dataset. We then created a smaller
       dataset from that for use with the charts below to speed up
       processing time."),
      h3("Questions to Answer"),
      p("Our group wanted to answer a variety of
        questions from the datasets
        we were able to find. From the Tech Survey dataset
        we wanted to focus on
        the percentage of the people surveyed (and from which states)
        that said yes and no to specifically chosen
        questions that we wanted to focus on, such as
        the percentage of people hearing any negative
        consequences for people with mental health issues
        in their workplace. For our other dataset we focused on
        where these patients are relative to the U.S map based
        on their mental health diagnosis and the number
        of patients with it as well."),
      p("From our larger dataset we were able to look at
        even more specific questions.
        Compare states and their rate of occurence of different
        patient characteristics
        (patients are diagnosed with various mental health illnesses")
)

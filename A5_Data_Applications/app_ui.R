library(shiny)
library(tidyr) 
library(plotly)
library(ggplot2)
library(tidyverse)
library(shinythemes)

intro_page <- tabPanel(
  "Introduction",
  titlePanel(strong("Welcome to Assignment 5!")),
    mainPanel(
      p("For this assignment, I will be analyzing a dataset from Our World In Data. I will be focusing on these two variables: 'co2_including_luc_per_capita' and 'ghg_per_capita'.
        'co2_including_luc_per_capita' is the annual production-based emissions of carbon dioxide (CO₂), including land-use change, measured in tonnes per person.
        This is based on territorial emissions, which do not account for emissions embedded in traded goods.
        And 'ghg_per_capita' is the total greenhouse gas emissions including land-use change and forestry, measured in tonnes of carbon dioxide-equivalents per capita."),
      br(),
      p("The average value of 'co2_including_luc_per_capita' across all the countries in 2021 is:"),
      uiOutput("answer1"),
      p("tonnes"),
      br(),
      p("The country with the highest 'co2_including_luc_per_capita' in 2021 is:"),
      uiOutput("answer2"),
      br(),
      p("The country with the lowest co2_including_'luc_per_capita' in 2021 is:"),
      uiOutput("answer3"),
      br(),
      p("The change that variable 'ghg_per_capita' had over the last 29 years (1990 - 2019) was:"),
      uiOutput("answer4"),
      p("tonnes"),
      br(),
      p("I will be creating a chart that displays the trends of production-based emissions of CO2 and Greenhouse gas per capita for different countries ranging from 1990 to 2022 by using this dataset."),
    )
)

viz_page <- tabPanel(
  "Interactive Visualization",
    titlePanel(strong("CO2 and Greenhouse gas")),
  sidebarLayout(
    sidebarPanel(
      uiOutput("selectCountry"),
      uiOutput("selectFeature"),
    ),
    mainPanel(
      plotlyOutput("total_co2_ghg_plot"),
    )
  )
)

ui <- navbarPage(
  "A5: Data Applications",
  intro_page,
  viz_page
)

shinyUI(fluidPage(
  theme = shinythemes("yeti"),
  ui
))
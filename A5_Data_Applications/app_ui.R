library(shiny)
library(tidyr) 
library(plotly)
library(ggplot2)
library(tidyverse)
library(shinythemes)

intro_page <- tabPanel(
  "Introduction",
  titlePanel(strong("Welcome to Assignment 5!")),
  sidebarLayout(
    sidebarPanel(
      h1("*change*"),
    ),
    mainPanel(
      p("blah is .."),
      uiOutput("answer1"),
      br(),
      p("max is .."),
      uiOutput("answer2"),
      br(),
      p("min is .."),
      uiOutput("answer3"),
      br(),
      p("change is .."),
      uiOutput("answer4"),
    )
  )
)

viz_page <- tabPanel(
  "Visualization",
  titlePanel(strong("Interactive Visualization")),
  sidebarLayout(
    sidebarPanel(
      uiOutput("selectCountry"),
    ),
    mainPanel(
      h1("*change*"),
      plotlyOutput("fertility_education_scatterplot"),
    )
  )
)

ui <- navbarPage(
  "A5: Data Applications",
  intro_page,
  viz_page
)

shinyUI(fluidPage(
  theme = shinytheme("flatly"),
  ui
))
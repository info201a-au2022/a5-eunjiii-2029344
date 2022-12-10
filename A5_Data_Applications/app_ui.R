library(shiny)
library(dplyr)
library(ggplot2)
library(shinythemes)

intro_page <- tabPanel(
  "Introduction",
  titlePanel(strong("Welcome to Assignment 5!")),
  sidebarLayout(
    sidebarPanel(
      h1("*change*"),
    ),
    mainPanel(
      h1("*change*"),
    )
  )
)

viz_page <- tabPanel(
  "Visualization",
  titlePanel(strong("Interactive Visualization")),
  sidebarLayout(
    sidebarPanel(
      h1("*change*"),
      selectInput("select", label = h3("Select Countries"), 
                  choices = list("United States" = 1, "United Kingdom" = 2, "China" = 3), 
                  selected = 1),
      
      hr(),
      fluidRow(column(3, verbatimTextOutput("value"))),
    ),
    mainPanel(
      h1("*change*"),
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

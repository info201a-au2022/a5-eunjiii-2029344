library(shiny)
library(tidyr) 
library(plotly)
library(ggplot2)
library(tidyverse)
library(shinythemes)

co2_data <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

# Making a new data frame with year 2021 only and removing unnecessary rows (non-countries such as European Unions, World, etc.)
co2_data_2021 <- co2_data %>% 
  select(country, year, co2_including_luc_per_capita, ghg_per_capita) %>% 
  filter(year == 2021)
co2_data_2021 <- co2_data_2021[-c(2, 3, 15, 16, 17, 46, 74, 75, 76, 77, 78, 79, 80, 103, 110, 135, 136, 152, 171, 172, 173, 174, 178, 179, 180, 218, 219, 249, 257),]


# Answering: "What is the average value of my variable across all the counties (in the current year)?"
avg_co2_per_capita <- co2_data_2021 %>% 
  summarize(avg = mean(co2_including_luc_per_capita, na.rm = TRUE))

# Answering: "Where is my variable the highest / lowest?"
max_co2_per_capita <- co2_data_2021 %>% 
  filter(co2_including_luc_per_capita == max(co2_including_luc_per_capita, na.rm = TRUE)) %>% 
  pull(country)

min_co2_per_capita <- co2_data_2021 %>% 
  filter(co2_including_luc_per_capita == min(co2_including_luc_per_capita, na.rm = TRUE)) %>% 
  pull(country)

# Answering: "How much has my variable change over the last 29 years (1990 - 2019)?"
change_over_years <- co2_data %>% 
  select(country, year, ghg_per_capita) %>% 
  filter(year == 1990 | year == 2019) %>% 
  group_by(year) %>% 
  summarize(avg = mean(ghg_per_capita, na.rm = TRUE)) %>% 
  mutate(change = avg - lag(avg, n = 1L, default = NA))
change_over_years <- change_over_years[2, 3]


# Making a new data frame for data visualization (cutting down unnecessary rows after choosing necessary features and years)
data_viz_df <- co2_data %>% 
  select(country, year, co2_including_luc_per_capita, ghg_per_capita) %>% 
  filter(year >= 1990) %>% 
  drop_na()

# Define server logic required to draw a line chart
server <- function(input, output) {
  output$answer1 <- renderUI({answer1 <- avg_co2_per_capita})
  output$answer2 <- renderUI({answer2 <- max_co2_per_capita})
  output$answer3 <- renderUI({answer3 <- min_co2_per_capita})
  output$answer4 <- renderUI({answer4 <- change_over_years})
  output$selectCountry <- renderUI({
    selectInput("Country", "Choose a Country", unique(data_viz_df$country))
  })
  output$selectFeature <- renderUI({
    radioButtons("Feature", "Choose a feature:", list("co2_including_luc_per_capita", "ghg_per_capita"), selected = "co2_including_luc_per_capita")
  })
  chart <- reactive({
    plotCountry <- data_viz_df %>% 
      filter(country %in% input$Country)
    line_chart <- ggplot(data = plotCountry) +
      geom_line(aes_string(x = "year", y = input$Feature)) +
      labs(title = "Each country's production-based emissions of CO2 and Greenhouse gas emissions per capita",
           x = "Year",
           y = input$Feature)
    ggplotly(line_chart)
  })
  output$total_co2_ghg_plot <- renderPlotly({
    chart()
  })
}
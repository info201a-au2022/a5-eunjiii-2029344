library(shiny)
library(tidyr) 
library(plotly)
library(ggplot2)
library(tidyverse)
library(shinythemes)

co2_data <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

# Making a new data frame with year 2021 only and removing unnecessary rows (non-countries such as European Unions, World, etc.)
co2_data_2021 <- co2_data %>% 
  select(country, year, co2_including_luc_growth_abs) %>% 
  filter(year == 2021)
co2_data_2021 <- co2_data_2021[-c(2, 3, 15, 16, 17, 46, 74, 75, 76, 77, 78, 79, 80, 103, 110, 135, 136, 152, 171, 172, 173, 174, 178, 179, 180, 218, 219, 249, 257),]


# Answering: "What is the average value of my variable across all the counties (in the current year)?"
avg_co2_growth <- co2_data_2021 %>% 
  summarize(avg = mean(co2_including_luc_growth_abs, na.rm = TRUE))

# Answering: "Where is my variable the highest / lowest?"
max_co2_growth <- co2_data_2021 %>% 
  filter(co2_including_luc_growth_abs == max(co2_including_luc_growth_abs, na.rm = TRUE)) %>% 
  pull(country)

min_co2_growth <- co2_data_2021 %>% 
  filter(co2_including_luc_growth_abs == min(co2_including_luc_growth_abs, na.rm = TRUE)) %>% 
  pull(country)

# Answering: "How much has my variable change over the last 71 years (1950 - 2021)?"
change_over_years <- co2_data %>% 
  select(country, year, co2_including_luc_growth_abs) %>% 
  filter(year == 1950 | year == 2021) %>% 
  group_by(year) %>% 
  summarize(avg = mean(co2_including_luc_growth_abs, na.rm = TRUE)) %>% 
  mutate(change = avg - lag(avg, n = 1L, default = NA))
change_over_years <- change_over_years[2, 3]


# ?**
df <- co2_data %>% 
  select(country, year, gdp, co2_including_luc_growth_abs) %>% 
  filter(year >= 1950) %>% 
  drop_na()

# Define server logic required to draw ??
server <- function(input, output) {
  output$answer1 <- renderUI({answer1 <- avg_co2_growth})
  output$answer2 <- renderUI({answer2 <- max_co2_growth})
  output$answer3 <- renderUI({answer3 <- min_co2_growth})
  output$answer4 <- renderUI({answer4 <- change_over_years})
  output$selectCountry <- renderUI({
    selectInput("Country", "Choose a Country", choices = unique(df$country))
  })
  plot <- reactive({
    plotCountry <- df %>% 
      filter(country %in% input$Country)
    scatterplot <- ggplot(data = plotCountry) +
      geom_point(aes(x = gdp, y = co2_including_luc_growth_abs)) +
      labs(title = "Education Level versus Fertility Rate in selected Continent",
           x = "GDP",
           y = "Fertility Rate")
    ggplotly(scatterplot)
  })
  output$fertility_education_scatterplot <- renderPlotly({
    plot()
  })
}
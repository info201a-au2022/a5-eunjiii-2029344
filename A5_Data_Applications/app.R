#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(ggplot2)
library(shinythemes)

source("app_server.R")
source("app_ui.R")

#co2_data <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

#write.csv(co2_data, "co2_data.csv")
#co2_data <- read_csv("co2_data.csv")

# Run the application 
shinyApp(ui = ui, server = server)

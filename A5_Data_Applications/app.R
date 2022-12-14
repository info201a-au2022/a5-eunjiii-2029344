#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyr) 
library(plotly)
library(ggplot2)
library(tidyverse)
library(shinythemes)

source("app_server.R")
source("app_ui.R")

# Run the application 
shinyApp(ui = ui, server = server)

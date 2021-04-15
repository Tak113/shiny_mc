library(shiny)
library(shinydashboard)
library(fresh) #bootstrap
library(shinyjs) #bootstrap support in dashboardBody and tooltip
library(tidyverse)
library(echarts4r) #interactivegraph
library(plotly) #interactive graph
library(shinyBS) #tooltip
library(caret) #machine learning library
library(DALEX) #prep library to run shap
library(shapper) #explainable AI
library(MASS) #for Boston dataset


# basic authentication ----------------------------------------------------

login_details <- data.frame(user = c("datak"),
                            pswd = c("555"))



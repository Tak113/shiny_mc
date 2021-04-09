library(shiny)
library(shinydashboard)
library(fresh) #bootstrap
library(shinyjs) #bootstrap support in dashboardBody and tooltip
library(shinyalert)
library(tidyverse)
library(echarts4r)


# basic authentication ----------------------------------------------------

login_details <- data.frame(user = c("datak"),
                            pswd = c("555"))



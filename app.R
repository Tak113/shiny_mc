# virtualenv_dir = Sys.getenv("VIRTUALENV_NAME")
# python_path = Sys.getenv("PYTHON_PATH")
# reticulate::virtualenv_create(envname = virtualenv_dir, python = python_path)
# reticulate::virtualenv_install(virtualenv_dir, packages = c("shap"), ignore_installed = TRUE)
# reticulate::use_virtualenv(virtualenv = virtualenv_dir)
# 
# if (!is_shap_available()) {
#   shapper::install_shap(method='virtualenv', envname='virtualenv_dir')
# }
# 
# import('shap', convert=FALSE)

library(shiny)
library(shinydashboard)
library(reticulate) #to run python



#import files3.5
source('ui.R', local = TRUE)
source('server.R', local = TRUE)
source('global.R', local = TRUE)

shinyApp(
  ui = ui,
  server = server,
  onStart = global # function that will be called before the app is actually run
)
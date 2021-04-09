
# load sub files for each pages -------------------------------------------
source('ui_readmefirst.R', local = TRUE)
# source('ui_shap.R', local = TRUE)
# source('ui_bayes.R', local = TRUE)
# source('ui_range.R', local = TRUE)
# source('ui_walk.R', local = TRUE)

# dashboard component -----------------------------------------------------
header <- dashboardHeader(title = "MC", titleWidth = "250px")

sidebar <- dashboardSidebar(width = "250px", collapsed = TRUE,
                            sidebarMenu(
                              
                              menuItem("Read me first", tabName = 'readmefirst', icon = icon("home")),
                              menuItem("Simulations", icon = icon("calculator"),
                                       menuSubItem("Explanable AI", tabName = 'shap', icon = icon("chart-bar")),
                                       menuSubItem("Uncertainty", tabName = 'bayes', icon = icon("chart-line")),
                                       menuSubItem("Range Interval", tabName = 'range', icon = icon("chart-area")),
                                       menuSubItem("Random Walk", tabName = 'walk', icon = icon("chart-line"))
                              ),
                              menuItem("Link", icon = icon("link"),
                                       menuSubItem("Factory RMS", icon = icon("database"),href="https://datak.shinyapps.io/db_rms/"),
                                       menuSubItem("Datak", icon = icon("home"),href="https://datak.biz")
                              )
                            )
)

body <- dashboardBody(
  tabItems(
    
    tabItem_readmefirst
    # tabItem_range,
    # tabItem_shap,
    # tabItem_bayes,
    # tabItem_retire
    
  ),
  
  #theme
  use_theme(
    create_theme(
      adminlte_global(
        content_bg = "#fafafa" #background color in body
      ),
      adminlte_sidebar(
        dark_bg = "#788878", #background color at side bar
        dark_hover_bg = "#4f7359", #hover color at side bar
        dark_submenu_hover_color = "#fff" #hover text color at side bar submenu
      ),
      adminlte_color(
        blue = "#798e99", #light blue
        green = "#4f7359",
        red = "#ba6667",
        purple = "#355667", #this 'purple' is used for a skin. this is dark blue
        yellow = "#a8ab5b",
        black = "#737373"
      )
    )
  ),
  
  #mini sidebar prep
  useShinyjs(),
  tags$head({tags$style(HTML("@media (min-width: 768px) {
                                            .content-wrapper,
                                            .right-side,
                                            .main-footer {
                                                margin-left: 230px;
                                            }
                                        }
                                        @media (max-width: 767px) {
                                            .sidebar-open .content-wrapper,
                                            .sidebar-open .right-side,
                                            .sidebar-open .main-footer {
                                                -webkit-transform: translate(250px, 0);
                                                -ms-transform: translate(250px, 0);
                                                -o-transform: translate(250px, 0);
                                                transform: translate(250px, 0);
                                            }
                                        }
                                        @media (max-width: 767px) {
                                            .main-sidebar,
                                            .left-side {
                                                -webkit-transform: translate(-250px, 0);
                                                -ms-transform: translate(-250px, 0);
                                                -o-transform: translate(-250px, 0);
                                                transform: translate(-250px, 0);
                                            }
                                        }
                                        @media (min-width: 768px) {
                                            .sidebar-collapse .main-sidebar,
                                            .sidebar-collapse .left-side {
                                                -webkit-transform: translate(-250px, 0);
                                                -ms-transform: translate(-250px, 0);
                                                -o-transform: translate(-250px, 0);
                                                transform: translate(-250px, 0);
                                            }
                                        }"))})
  
)


# dashboard framing -------------------------------------------------------
ui <- dashboardPage(skin = "green", header, sidebar, body)


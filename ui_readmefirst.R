tabItem_readmefirst <- 
  tabItem(tabName = "readmefirst",
          h2("Read me first"),
          fluidRow(
            column(4,
                   wellPanel(
                     tags$li(tags$a(href = "#Overview", "Overview"),style="list-style-type:square;"),
                     tags$li(tags$a(href = "#DataProductContents", "Data Product Contents"),style="list-style-type:square;"),
                     tags$li(tags$a(href = "#DevTools", "Dev Tools"),style="list-style-type:square;")
                   )
            ),
          ),
          br(),
          
          
          # Description -------------------------------------------------------------
          tags$hr(),
          h3("Overview", id="Overview"),
          tags$p(
            h5("This app showcases several usecases of monte carlo simulation")
          ),
          br(),
          
          
          # Data Products ----------------------------------------------------------
          tags$hr(),
          h3("Data Product Contents", id = "DataProductContents"),
          h5("This application holds 4 monte carlos simulations"),
          tags$ul(style="list-style-type:square",
                  tags$li(tags$b("Simulations"),
                          tags$ul(style = "list-style-type:circle",
                                  tags$li("Explanable AI : ", tags$br(), "Explanable AI gives interpretability to machine learning prediction. In this demo we use SHAP"),
                                  tags$li("Uncertainty : ", tags$br(), "Uncertainty bookends risks of the potential fluctuations on the prediction. Uncertainty is identified from stochastic regression using bayesian generalized additive model"),
                                  tags$li("Range Interval : ", tags$br(), "Simple use case of range based bottoms up simulation, also identifying major contributors from inputs"),
                                  tags$li("Random Walk : ", tags$br(), "Random walk tells us probability bands against time horizon, we will use retirement money simulation and will see how wide probability bands it can be")
                          )
                  )
          ),
          br(),
          
          # System Specification ----------------------------------------------------
          tags$hr(),
          h3("Link to Dev Tools", id = "DevTools"),
          tags$ul(style = "list-style-type:square;",
                  tags$li(
                    tags$a(href="https://github.com/Tak113/shiny_mc", "Github : version control")
                  ),
                  tags$li(
                    tags$a(href="https://shinyapps.io","Shinyapps.io : PaaS(hosting server)")
                  )
          )
          
  )
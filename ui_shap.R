tabItem_shap <- 
  tabItem(tabName = "shap",
    fluidPage(
      

# Header ------------------------------------------------------------------
      tags$h2('Explainable AI : Simulating contributions for each features'),
      p('The explainable AI is based on',
        tags$a(href='https://github.com/slundberg/shap', 'SHAP'),
        'and applied for',
        tags$a(href='http://lib.stat.cmu.edu/datasets/boston','Boston Housing Dataset'),
        ),
      p('*The boston housing data is from 1970s and does not reflect recent housing price'),
      code('*This application might include sensitive data which is originated from raw dataset.
        Please be noted that all analysis here is conducted without regard to race, color, religious creed,
        gender, or any other potential discrimination'),
      hr(),

# Input Panel -------------------------------------------------------------
      
      #input
      sidebarLayout(
        sidebarPanel(
          fluidRow(
            column(12,
              h4('Input (10 Features)'),
              h6('Slide what you would like to change. Features are already downselected from importance study.
                 Original value is from median of dataset')
            ),
            column(6,
              sliderInput('lstat', 'Low Income (%)', min=1, max=40, value=10, step=1), #original lstat = lstat
                bsTooltip('lstat','(lstat) Percentage of Low Income over a population'),
              sliderInput('ptratio', 'Student / Teacher', min=12, max=22, value=18, step=1), #original ptratio = ptratio
                bsTooltip('ptratio','(ptratio) Number of students per teacher'),
              sliderInput('dis', 'Cities Distance (Ml)', min=1, max=10, value=4, step=1), #original dis = dis
              sliderInput('black', 'Black Rate (%)', min=1, max=50, value=5, step=5), #original black = 1000(black/100-0.63)^2
              sliderInput('tax', 'Tax (%)', min=2, max=7, value=4, step=0.5) #original tax = 100 * tax
            ),
            column(6,
              sliderInput('rm', '# of Rooms', min=3, max=9, value=6, step=1), #origina rm = rm
              sliderInput('crim', 'Crim Rate (/ppl/yr)', min=0.05, max=1, value=0.2, step=0.05), #original crim = crim
              sliderInput('nox', 'NOx Density (ppm)', min=2, max=8, value=5, step=0.5), #original nox = nox * 0.1
              sliderInput('age', 'Old House Rate (%)', min=10, max=100, value=60, step=10), #original age = age
              sliderInput('indus', 'Non Retail Rate (%)', min=5, max=24, value=10, step=2) #original indus = indus
            ),
            column(12,
              br(),
              actionButton('runmodel', 'Run Model', icon('random'),
                           style = 'color: #fff; background-color: black;')
            )
          )
        ), #sidebarPanel


# Output Panel------------------------------------------------------------------

        #output
        mainPanel(
          
          tabsetPanel(type = 'tabs',
            #walk tab
            tabPanel('Walk',
              #point estimate
              column(12,
                h4('Model Output (Point Estimate)'),
                code('Set input and RUN MODEL to predict'),
                br(),
                textOutput('pred'),
                tags$head(tags$style('#pred{
                  font-size: 40px;
                  font-style: bold;
                  color: steelblue;
                }')),
                h6('Model expected performance : Output expects to have ~10% MAPE (Mean Absolute Percentage Error)'),
              ),
              br(),
              hr(),
              
              #walk
              column(12,
                h4('Model Output (Explainable AI)'),
                h6('Adding interpretability into prediction showing contributon on the change by SHAP (Shapley Additive Prediction)'),
                br(),
                plotlyOutput('plot_walk')
              ),
              br()
              
            ), #tabPanel2
            
            #validation tab
            tabPanel('Validation'
            ) #tabPanel2
          )
          
        ) #mainPanel
      ), #sidebarLayout

# Footer ------------------------------------------------------------------
      
      hr(),
      p('You will see how the model is developpted at google colab :',
        tags$ul(style='list-style-type:square',
          tags$li(
            tags$a(href='https:datak.biz','Data manipulation and Exploretory Data Analysis (EDA)')),
          tags$li(
            tags$a(href='https:datak.biz', 'Model Benchmark')),
          tags$li(
            tags$a(href='https:datak.biz', 'Explainable AI'))
        )
      ),
      tags$a(href='https:datak.biz', 'This Application Code is at Github')
      
    )
          
  )
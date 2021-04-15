server <- function(input, output, session) {
  

  
  # login modules -----------------------------------------------------------
  
  #set Logged = FLASE as defalt and showing loging window
  login = FALSE
  USER <- reactiveValues(login = login)
  
  # Return the UI for a modal dialog with data selection input. If 'failed' 
  # is TRUE, then display a message that the previous value was invalid.
  dataModal <- function(failed = FALSE) {
    modalDialog(
      textInput("userName", placeholder="Username", label = tagList(icon("user"), "Username")),
      passwordInput("passwd", placeholder="Password", label = tagList(icon("unlock-alt"), "Password")),
      h6("Basic Authentication"),
      h6('Username : datak, Password : 555'),
      if (failed)
        div(tags$b("Invalid crendentials. Use given username and password", style = "color: red;")),
      footer=tagList(
        actionButton("login", "Login")
      )
    )
  }
  
  # Show modal
  # This `observe` is suspended only whith right user credential otherwise keep showing model window
  obs1 <- observe({
    showModal(dataModal())
  })
  
  # When OK button is pressed, attempt to authenticate. If successful, remove the modal. 
  #login verification
  obs2 <- observe({ 
    if (USER$login == FALSE) {
      if (!is.null(input$login)) {
        if (input$login > 0) {
          Username <- isolate(input$userName)
          Password <- isolate(input$passwd)
          
          Id.username <- which(login_details$user %in% Username)
          Id.password <- which(login_details$pswd %in% Password)
          if (length(Id.username) > 0 & length(Id.password) > 0){
            if (Id.username == Id.password) {
              USER$login <-  TRUE
              obs1$suspend()
              removeModal()
            } else {
              showModal(dataModal(failed = TRUE))
            }
          }
        } 
      }
    }    
  })
  
  
  # mini sidebar setting ----------------------------------------------------
  
  #Make sidebar collapse into icons instead of nothing
  runjs({"
        var el2 = document.querySelector('.skin-green');
        el2.className = 'skin-green sidebar-mini';
        "})
  
  
  # load files --------------------------------------------------------------
  source('server_shap.R', local = TRUE)
  # source('server_range.R', local = TRUE)
  # source('server_bayes.R', local = TRUE)
  # source('server_retire.R', local = TRUE)
  
  
  # App virtualenv setup ----------------------------------------------------
    #ref : https://github.com/ranikay/shiny-reticulate-app
    # this only works for remote, do not follow local case at .Rprofile
  
  if (Sys.info()[['user']] == 'shiny') {
    
    virtualenv_dir = Sys.getenv('VIRTUALENV_NAME')
    python_path = Sys.getenv('PYTHON_PATH')
    
    # Define any Python packages needed for the app here:
    PYTHON_DEPENDENCIES = c('pip', 'numpy', 'shap', 'gbm')
      
    # Create virtual env and install dependencies
    reticulate::virtualenv_create(envname = virtualenv_dir, python = python_path)
    reticulate::virtualenv_install(virtualenv_dir, packages = PYTHON_DEPENDENCIES, ignore_installed=TRUE)
    reticulate::use_virtualenv(virtualenv_dir, required = T)
  }
  
}




# Load model,  input data modification ------------------------------------

# load model
pred <- readRDS('./www/model_xgb.rds')

# pass input to shiny reactive function
pred_input <- eventReactive(
  #run model button to handle all of input to pass to backend server
  input$runmodel,
  {
    data.frame(
      lstat = input$lstat,
      rm = input$rm,
      ptratio = input$ptratio,
      crim = input$crim,
      dis = input$dis,
      nox = input$nox * 0.1,
      black = 1000 * (input$black/100 - 0.63)^2,
      age = input$age,
      tax = input$tax * 100,
      indus = input$indus
    )
  }
)


# text prediction ---------------------------------------------------------

output$pred <- renderText({
  pred_output <- signif(predict(pred, newdata = pred_input()), 3)
  paste('$', pred_output, 'k')
})


# shap prep ---------------------------------------------------------------

#need exact sane N of columns/predictors as model to run shap()
predictors <- c('lstat', 'rm', 'ptratio', 'crim', 'dis',
                'nox', 'black', 'age', 'tax', 'indus')

#load boston data
data(Boston)
boston_shap <- Boston %>% dplyr::filter(medv < 50) %>% dplyr::select(all_of(predictors))

#prepare new explainer for shap by DALEX explain function
exp_model <- DALEX::explain(pred, data=boston_shap, label='boston_shap')

#shap
shap_model <- reactive({ shap(exp_model, new_observation = pred_input(), nsamples = 500) })

#sort order by major contribution
shap_model_sort <-  reactive({ arrange(shap_model(), desc(shap_model()$'_attribution_')) })


# plotly waterfall --------------------------------------------------------

#data set prep for waterfall
plotly_data <- reactive({
  data.frame(
    x = c('Mean', shap_model_sort()$'_vname_','Scenario'),
    measure = c('absolute', 'relative', 'relative', 'relative', 'relative', 'relative',
                'relative', 'relative', 'relative', 'relative', 'relative', 'total'),
    y = c(signif(mean(shap_model_sort()$'_yhat_mean_'),3), signif(shap_model_sort()$'_attribution_',3),
          signif(mean(shap_model_sort()$'_yhat_'),3)),
    text = c(signif(mean(shap_model_sort()$'_yhat_mean_'),3), signif(shap_model_sort()$'_attribution_',3),
             signif(mean(shap_model_sort()$'_yhat_'),3))
  )
})

#graph attributes
xform <- reactive({
  list(
    #follow plotly grammer for layout()
    categoriorder = 'array',
    categoryarray = plotly_data()$y,
    title = 'Contribution'
  )
})

#waterfall graph
output$plot_walk <- renderPlotly(
  
  #progress bar
  withProgress(
    message = 'creating a contribution for a walk for an explanation',
               style = 'notification', value = 0.5,
    {
      fig <- 
        plot_ly(
          plotly_data(), name = 'cost walk',
          type = 'waterfall', measure = ~measure, text = ~text,
          x = ~x, textposition = 'outside', y = ~y,
          connector = list(line = list(color = 'gray', width = 1)),
          decreasing = list(marker = list(color = '#798e99')),
          increasing = list(marker = list(color = 'ba6667')),
          totals = list(marker = list(color = '#788878')),
          opacity = 0.8,
          textfont = list(family = 'Arial', color = 'gray'),
          hoverlabel = list(bordercolor = 'transparent',
                            font = list(color = 'white'))
        ) %>%
        layout(
          title = 'SHAP Explainable AI Cost Walk',
          xaxis = xform(),
          yaxis = list(title = 'Housing Price (k$)', tickformat='$'),
          autosize = TRUE,
          showlegend = FALSE,
          paper_bgcolor = 'transparent',
          plot_bgcolor = 'transparent'
        )
    }
  )
  
)
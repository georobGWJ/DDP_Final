# Shiny Application server.R template

library(shiny)


# Load Data
minerals <- read.csv("mineral_data.csv")
  
# Create prediction model
if (file.exists("./final_model.rds")) {
    mfit <- readRDS("./final_model.rds")
  } else { 
    mfit <- train(minerals$mineral ~ ., data = minerals, method = "gbm")
    saveRDS(mfit, "./final_model.rds")
}



shinyServer(
  function(input, output) {
    
    output$prediction <- renderPrint({
      
    paste0("Waiting for data")
      
    input$predButton
      
    sample <- isolate(data.frame(spec.gravity = input$sg, 
                         hardness = input$hardness, 
                         color = as.factor(input$mcolor), 
                         streak = as.factor(input$scolor), 
                         hcl_rxn = as.factor(input$acid), 
                         metallic = as.factor(input$metal)))
      
      mineral_pred <- (predict(mfit, newdata=sample))
      
      isolate(paste0('The General Boosting Model predicts that the mineral 
                     you are describing is ', mineral_pred))
      

  })
})
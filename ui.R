# Shiny Application ui.R template

library(shiny)
library(caret)

shinyUI(pageWithSidebar(
  headerPanel("Crude Mineral Identification with R"),
  sidebarPanel(
    h3('Observed Characteristics'),
    sliderInput("hardness", label = h4("Mineral Hardness"),
                min = 1, max = 10, value = 7, step = 0.25),
    
    numericInput("sg", label = h3("Specific Gravity"), 
                 value = 2.65), 

    selectInput("mcolor", label = h4("Mineral Color"),
                choices = list("Colorless" = "colorless", 
                               "White" = "white",
                               "Green" = "green", 
                               "Brown" = "brown", 
                               "Red" = "red", 
                               "Blue" = "blue",
                               "Blue-Black" = "blue-black", 
                               "Olive-Green" = "olive-green", 
                               "Black" = "black"),
                                selected = "colorless"),

    selectInput("scolor", label = h4("Streak Color"),
                 choices = list("Colorless" = "colorless", 
                                "White" = "white",
                                "Green" = "green", 
                                "Brown" = "brown", 
                                "Red" = "red", 
                                "Blue" = "blue",
                                "Blue-Black" = "blue-black", 
                                "Olive-Green" = "olive-green", 
                                "Black" = "black"),
                                selected = "colorless"),
    
    fluidRow(
      column(4,
    radioButtons("acid", label = h4("Reaction to HCl (Acid)"),
                 choices = list("Strong" = "strong", "Weak" = "weak",
                                "None" = "none"),selected = "none")),
    
      column(4,
    radioButtons("metal", label = h4("Metallic Luster"),
                 choices = list("Yes" = "yes", "No" = "no"),
                                selected = "no"))
    ),
      
    actionButton('predButton', "Predict")
  ),
  mainPanel(
    #h4('The mineral you have described may be:'),
    h3(textOutput("prediction"))
  )
))
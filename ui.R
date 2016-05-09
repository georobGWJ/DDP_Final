# Shiny Application ui.R template

library(shiny)
library(caret)

shinyUI(pageWithSidebar(
  headerPanel("Crude Mineral Identification with R"),
  sidebarPanel(
    h3('Observed Characteristics'),
    sliderInput("hardness", label = h4("Mineral Hardness"),
                min = 1, max = 10, value = 7, step = 0.25),
    
    numericInput("sg", label = h4("Specific Gravity"), 
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
    h4("1. Hardness. The Mohs scale of mineral hardness is a qualitative scale that characterizes the scratch resistance of minerals through the ability of a harder material to scratch a softer material."),
    h4("2. Specific Gravity. A measure of density of a material (actually a ratio of densities.)"), 
    h4("3. Color. The color of the mineral. Some minerals are always a specific color but many have ranges."),
    h4("4. Streak Color. When a mineral is rubbed on porcelain, the powder color may be different from the mineral color."),
    h4("5. Reaction with Hydrochloric acid (HCl). Some minerals contain carbonate (CO2 or CO3). These will 'fizz' when HCl is applied to them."), 
    h4("6. Luster. Is the mineral metallic. There are other lusters that exist that weren't accounted for in this simple model."),
    h3("  "),
    h3(textOutput("prediction"))
  )
))
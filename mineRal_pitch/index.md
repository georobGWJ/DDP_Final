---
title       : Classifying Minerals
subtitle    : Using Machine Learning
author      : Rob Turner
job         : Geologist
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Introduction

#### A Mineral is a naturally occurring crystalline solid with a definite, but not necessarily fixed composition.  
  
<p>Over 3,500 minerals have been identified to date. Geologists typically learn to identify a few hundred of these using their natural, observable characteristics.

However, identifying minerals by easily observable characteristics can be very difficult for people who are just learning how to do so.

I have developed a proof of concept Shiny application that develops and uses a General Boosing Model to identify minerals based on a few of the most easily observable characteristics.

--- .class #id 

## Mineral Characteristics

The model I developed uses six characteristics:

1. Hardness. The Mohs scale of mineral hardness is a qualitative scale that characterizes the scratch resistance of minerals through the ability of a harder material to scratch a softer material. https://en.wikipedia.org/wiki/Mohs_scale_of_mineral_hardness
2. Specific Gravity. A measure of density of a material (actually a ratio of densities.) https://en.wikipedia.org/wiki/Specific_gravity
3. Color. The color of the mineral. Some minerals are always a specific color but many have ranges.
4. Streak Color. When a mineral is rubbed on porcelain, the powder color may be different from the mineral color.
5. Reaction with Hydrochloric acid (HCl). Some minerals contain carbonate (CO2 or CO3). These will 'fizz' when HCl is applied to them. 
6. Luster. Is the mineral metallic. There are other lusters that exist that weren't accounted for in this simple model.

--- 

## Model Creation

1. I first generated a simple data set as a data frame with the characteristics of 55 common minerals included as variables.

2. I then used the dataset to generate a Generalized Boosting Model (gbm)  prediction model. GBM is a gradient boosting machine learning technique that can be used for classification problems, and which produces a prediction model in the form of a suite of weak prediction models (typically decision trees). The model is built in a stage-wise fashion, similar to other boosting methods, and it is generalized by allowing optimization of an arbitrary differentiable loss function.</p>

<p>More information and formulae can be found at:
<p>https://en.wikipedia.org/wiki/Gradient_boosting 

---

## The Code


```r
# Load Data
minerals <- read.csv("mineral_data.csv")

# Create prediction model
    mfit <- train(minerals$mineral ~ ., data = minerals, method = "gbm")

# Take the characteristics from the Shiny page and
# predict the mineral
sample <- isolate(data.frame(spec.gravity = input$sg, 
                         hardness = input$hardness, 
                         color = as.factor(input$mcolor), 
                         streak = as.factor(input$scolor), 
                         hcl_rxn = as.factor(input$acid), 
                         metallic = as.factor(input$metal)))
      
mineral_pred <- (predict(mfit, newdata=sample))
```

---

## Lessons Learned

- This proof of concept Machine Learning method may not be the best for classifying minerals. It does not account for natural ranges (such as ranges of color or specific gravity.)
- A machine learning algorithm must be able to account for impossibilities. An example is that you can enter a mineral color of 'white' and depending on your other entries the model may predict you are looking at tourmaline. Tourmaline is always black.
- Adding additional covariates to the model creation should improve it's performance.

### Thank you!

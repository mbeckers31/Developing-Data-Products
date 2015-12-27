---
title       : Demonstration of some Shiny widgets
subtitle    : Data for air quality measurements in New York, May to September 1973 
author      : M. Beckers
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Introduction

This presentation discusses some of the features of **Shiny**. In particular two widgets will be used: the *Selection* and the *Checkbox* widget.

For this purpose the airquality data set that comes with R was used. Some variables were measured on different days in different months. Quality could be expressed as the amount of ozone.


```r
library(datasets)
names(airquality)
```

```
## [1] "Ozone"   "Solar.R" "Wind"    "Temp"    "Month"   "Day"
```

It would be interesting to try and discover a relation between one or more of the variables and the amount of ozone. 

--- .class #id 

## Shiny ui.R, Selection and checkboxes

Obviously, one should compare different regression models, univariate and multivariate. Since we were mainly interested in demonstrating shiny widgets we will stick to univariate linear regression. Using a Selection widget the user can select between the Solar.R, Wind and Temp variable to be displayed. Besides, the user can choose the Type of plot to be shown. The first checkbox ticked displays the amount of Ozone plotted against the selected variable. The plot also shows the *regression line*. The second checkbox ticked displays a boxplot of the selected variable. In the ui.R file this can be done using 


```r
   sidebarPanel(
    selectInput("variable", "Variable:",
                 list("Solar.R" = "Solar.R", 
                     "Temperature" = "Temp", 
                     "Wind" = "Wind")),
    checkboxInput("regplot", "Regression Lines", TRUE),
    checkboxInput("boxplot", "Box Plot", FALSE)
  ),
```

(only the relevant part of the code is shown)

--- .class #id 

## Shiny server.R, displaying 

The following code shows how the selected parts on the input side (ui.R) are used (reactively) in server.R


```r
   output$ozonePlot <- renderPlot({
    if (input$regplot){
            plot(as.formula(formulaText()),
            xlab = input$variable,
            ylab = "Ozone",
            data = ozoneData)
            abline(lm(as.formula(paste("Ozone"," ~ ",paste(input$variable,collapse="+"))),data=ozoneData), etc. >
    }
    if (input$boxplot){
            boxplot(as.formula(paste("Ozone"," ~ ",paste(input$variable,collapse="+"))),data=ozoneData, etc. 
```
                     
(only the relevant part of the code is shown)

--- .class #id 

## Shiny server.R, calculation 

To be able to calculate the regression coefficients for the selected variable and Ozone amount and display the resulting regression line, the *lm* function is used


```r
lm(as.formula(paste("Ozone"," ~ ",paste(input$variable,collapse="+"))),data=ozoneData), col=4, lwd=3)
```

In this case we have to introduce an additional step, i.e. to 'paste' content of the selected input variable in the parameters for the *lm* function.

These are the main aspects of this shiny application. The complete ui.R and server.R files can also be found on github. 

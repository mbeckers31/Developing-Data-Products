library(shiny)
library(datasets)
library(ggplot2)

ozoneData <- airquality

shinyServer(function(input, output) {
  
  formulaText <- reactive({
    paste("Ozone ~", input$variable)
  })
  
  output$caption <- renderText({
    formulaText()
  })
  
  output$ozonePlot <- renderPlot({
    if (input$regplot){
            plot(as.formula(formulaText()),
            xlab = input$variable,
            ylab = "Ozone",
            data = ozoneData)
            abline(lm(as.formula(paste("Ozone"," ~ ",paste(input$variable,collapse="+"))),data=ozoneData), col=4, lwd=3)
    }
    if (input$boxplot){
            boxplot(as.formula(paste("Ozone"," ~ ",paste(input$variable,collapse="+"))),data=ozoneData, xlab = input$variable, ylab = "Ozone")
    }
    
  })
})
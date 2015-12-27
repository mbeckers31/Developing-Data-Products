library(shiny)

shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Daily air quality measurements in New York"),
  
  sidebarPanel(
    selectInput("variable", "Variable:",
                list("Solar.R" = "Solar.R", 
                     "Temperature" = "Temp", 
                     "Wind" = "Wind")),
    checkboxInput("regplot", "Regression Lines", TRUE),
    checkboxInput("boxplot", "Box Plot", FALSE)
  ),
  
  mainPanel(
    h3(textOutput("caption")),
    plotOutput("ozonePlot")
  )
))
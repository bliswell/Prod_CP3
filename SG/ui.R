#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Sierpinski Gaskets"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            selectInput("n_corners", label = "Number of cornerss:",
                        choices = c(seq(from = 3, to = 10, by = 1)), selected = 3),
            
            sliderInput("step_adjust", label = "Step Size:",
                        min = 0.1, max = 2, value = 0.5, step = 0.05),
            
            sliderInput("number_of_points", label = "Step Size:",
                        min = 10, max = 500000, value = 100000, step = 1)
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("gasketPlot")
        )
    )
))

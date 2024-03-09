library(shiny)
library(ggplot2)
library(DT)

setwd("/Volumes/Extreme\ SSD/biostat\ 203B/biostat-203b-2024-winter/hw4")
mimic_icu_cohort<-readRDS("mimiciv_shiny/mimic_icu_cohort.rds")


# UI
ui <- fluidPage(
  titlePanel("ICU Cohort Shinny APP"),
  tabsetPanel(
    tabPanel("Paient characteristics",
             sidebarLayout(
               sidebarPanel(
                 selectInput(inputId = "VOI",
                             label = "Variable of interest:",
                             choices = c("Demographics", "Lab Measurements", "Vitals","Last Care Unit")),
                 checkboxInput(inputId = "RMO",
                             label = "Remove Outliers in IQR method for measurement?",
                             value = FALSE),
                 ),
               
               
                
               mainPanel(
                 plotOutput("plot1")
               )
              )
    ),
    tabPanel("Patient's ADT and ICU stay Information",
             sidebarLayout(
               sidebarPanel(
                 selectInput(inputId = "PID",
                             label = "Select a patient:",
                             choices = mimic_icu_cohort$subject_id),
               ),
               mainPanel(
                 plotOutput("plot2")
               )
             )
    )
  )
)

# Server
server <- function(input, output) {
  output$plot1 <- renderPlot({
    if (input$VOI == "Demographics") {
      ggplot(mimic_icu_cohort, aes(x=race)) + 
        geom_bar(stat="count",fill="blue") +
        labs(title = "Race distribution", x = "race", y = "count")
    }
    else if (input$VOI == "Lab Measurements") {

  }
  
  }
)
}

# Run the app
shinyApp(ui = ui, server = server)
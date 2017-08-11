library(shiny)
library(dplyr)
library(ggplot2)

data <- read.csv("expense.csv", header = TRUE)
data$Period <- as.Date(as.character(data$Period), "%m/%d/%y")
data <- mutate(data, Quarter=quarters(Period))
data$Quarter <- as.factor(data$Quarter)

shinyServer(function(input, output) {
        
        dataFilter <- reactive({
        data <- filter(data, Quarter == input$quarter, 
                 Type %in% input$category, 
                 Expense > input$amount[1],
                 Expense < input$amount[2])
        names(data) <- c("Date", "Item", "Amount", "Category", "Quarter")
        data <- mutate(data, Month=months(Date))
        })
        
        output$plot <- renderPlot({
        ggplot(dataFilter(), aes(x=factor(Month, levels = month.name), y = Amount, fill = Category)) + geom_bar(stat = "identity") + labs(title="Records in DKK") + labs(x="Months")
        }, height = 400)
 
        output$table <- renderDataTable({
                dataFilter()[,1:4]
        })
         
})

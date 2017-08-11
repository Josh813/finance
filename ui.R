#
library(shiny)
shinyUI(navbarPage("",
        
        tabPanel("Records",
        
                sidebarLayout(
                sidebarPanel(
                
                helpText("PERSONAL FINANCE 2017"),
                
                selectInput("quarter", "Period:",
                            list("Jan-Mar" = "Q1",
                                 "Apr-Jun" = "Q2",
                                 "Jul-Aug" = "Q3"), selected = "Q1"),
                
                        checkboxGroupInput('category', 'Category:', 
                            c("Groceries" = "Groceries",
                                "Loan" = "Loan",
                                "Rent" = "Rent",
                                "Transport" = "Transport",
                                "Savings" = "Savings"), selected = "Groceries"),
                        
                        sliderInput("amount", 
                                    "Amount:", 
                                    min=-1000, 
                                    max=10000, 
                                    value=c(-1000,10000), 
                                    step=100)),
        
                mainPanel(
                
                plotOutput("plot"),
                dataTableOutput("table")
               
                
                )
                )
        ),
        
        tabPanel("About",
        
                mainPanel(
                
                includeMarkdown("about.md")
                
                )
        )
)) 
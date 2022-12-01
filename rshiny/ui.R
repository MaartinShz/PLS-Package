
library(shiny)
ui <- fluidPage(
    navbarPage("PLS App",
               tabPanel("Import Data",

                        sidebarLayout(
                          sidebarPanel(
                            fileInput("file1", "Choose your File",
                                      accept = c(
                                        "text/csv",
                                        "text/comma-separated-values,text/plain",
                                        ".csv")
                            ),
                            tags$hr(),
                            radioButtons("type","Type: ",choices = c("Xlsx"="xlsx","Csv"="csv"), selected="csv",inline=TRUE),
                            checkboxInput("header", "Header", TRUE),
                            tags$hr(),
                            radioButtons("separator","Separator: ",choices = c(";",",",":"), selected=";",inline=TRUE),
                            numericInput("sheetnumber", "Sheetnumber:", 1, min = 1, max = 255),

                          ),
                          mainPanel(
                            dataTableOutput("contents")
                          )
                        )






                        ),
               tabPanel("Fit And Predict",
                        sidebarLayout(
                          sidebarPanel(

                            #formula, data
                            tags$hr(),
                            numericInput("Number of Composent", "ncomp:", 1, min = 1),
                            checkboxInput("vip", "Selection Variables", FALSE),
                            checkboxInput("center", "Centre-Reduire", TRUE),
                            tags$hr(),


                          ),
                          mainPanel(
                            #dataTableOutput("contents")
                          )
                        )







                        ),
               tabPanel("Plots")
    )

  )


#########################################################################################################################################

server <- function(input, output) {

  data = reactive({

    inFile <- input$file1
    if (is.null(inFile)){
      return(NULL)
    }
    else{
      if(input$type == "xlsx"){

        read_excel(path=inFile$datapath, sheet=input$sheetnumber, col_names=as.logical(input$header))

      }else if (input$type == "csv"){

        read.csv(inFile$datapath, header = input$header, sep = input$separator)

      } else {
        # statement

      }
    }


  })



  output$contents=renderDataTable({
    head(data(),10)
    })




}



library(shiny)
library(readxl)

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
                            mainPanel(dataTableOutput("contents"))
                                    #tableOutput("contents")
                        )






               ),
               tabPanel("Fit And Predict",
                        sidebarLayout(
                            sidebarPanel(

                                checkboxInput("split", "Split Data", TRUE),
                                radioButtons("datasplit","Data: ",choices = c("Test"="test", "Train"="train"), selected="test",inline=TRUE),
                                numericInput("pourcentagesplit", "Pourcentage Split:", 33, min = 1, max = 99),

                                tags$hr(),
                                uiOutput("xvar"),
                                uiOutput("yvar"),



                                tags$hr(),
                                numericInput("ncomp", "Number of Composent :", 1, min = 1),
                                checkboxInput("vip", "Selection Variables", FALSE),
                                checkboxInput("center", "Centre-Reduire", TRUE),
                                tags$hr(),


                            ),
                            mainPanel(dataTableOutput("fit"))
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
                stop("file must be csv or xlsx")
            }
        }


    })



    output$contents=renderDataTable({head(data(),10)})
    #output$contents=renderTable({head(data(),10)})

    output$xvar=renderUI({
        NamesX=colnames(data())
        selectInput(inputId = "varx",
                    label = "Select your X variables",
                    choices = NamesX,
                    multiple=TRUE)})
    output$yvar=renderUI({
        NamesY=colnames(data())
        selectInput(inputId = "vary",
                    label = "Select your Y variables",
                    choices = NamesY,
                    multiple=FALSE)})



    fit = reactive({
        if(as.logical(input$split)){

            if(input$datasplit == "test"){
                dataSplit = split_sample(data=data(), train_perc=(1-(input$pourcentagesplit*0.01)))
            }else if (input$dataplit == "train"){
                dataSplit = split_sample(data=data(), train_perc=(input$pourcentagesplit*0.01))
            }


        }
        #print(dataSplit$train)


        print(input$varx)
        print(input$vary)

        #ytrain =
        #xtrain =





        obj = plsda()
        #plsda_fit(obj,xxxxxxx, xxdatatrainxxxx, ncomp=input$ncomp, var.select = as.logical(input$vip), centre=as.logical(input$center))

    })


    output$fit=renderDataTable({fit()})














}


# Run the application
shinyApp(ui = ui, server = server)

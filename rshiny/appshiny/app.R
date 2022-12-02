library(shiny)
library(readxl)
library(dplyr)

ui <- fluidPage(
    navbarPage("PLS App",
               tabPanel("Import Data",

                        sidebarLayout(
                            sidebarPanel(
                                strong(h1("Import your data : ")),
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
                                radioButtons("separator","Separator: ",choices = c(";",",",":"), selected=",",inline=TRUE),
                                numericInput("sheetnumber", "Sheetnumber:", 1, min = 1, max = 255),
                            ),
                            mainPanel(dataTableOutput("contents"))
                            #tableOutput("contents")
                        )
               ),
               tabPanel("Fit And Predict",
                        sidebarLayout(
                            sidebarPanel(
                                strong(h1("Fit : ")),

                                checkboxInput("split", "Split Data", TRUE),
                                radioButtons("datasplit","Data: ",choices = c("Test"="test", "Train"="train"), selected="test",inline=TRUE),
                                numericInput("pourcentagesplit", "Pourcentage Split:", 33, min = 1, max = 99),

                                tags$hr(),
                                uiOutput("xvar"),
                                uiOutput("yvar"),




                                tags$hr(),
                                numericInput("ncomp", "Number of Composent :", 2, min = 1),
                                checkboxInput("vip", "Variables Selection", FALSE),
                                checkboxInput("center", "Centre-Reduire", TRUE),
                                tags$hr(),

                                actionButton("btnFit", "Fit model"),
                                tags$hr(),
                                strong(h1("Predict : ")),

                                tags$hr(),
                                actionButton("btnPredict", "Predict model"),
                                tags$hr(),

                                radioButtons("typePred","Prediction: ",choices = c("Posterior"="posterior", "Class"="class"), selected="posterior",inline=TRUE),
                                fileInput("fileTest", "Choose your File Test, if you don't split", accept = c("text/csv","text/comma-separated-values,text/plain", ".csv")),
                                radioButtons("typepred","Type: ",choices = c("Xlsx"="xlsx","Csv"="csv"), selected="csv",inline=TRUE),
                            ),
                            mainPanel(dataTableOutput("fit"), dataTableOutput("predict"))
                        )
               ),
               tabPanel("Plots"),
               tabPanel("Export",
                        sidebarLayout(
                            sidebarPanel(
                                actionButton("btnExport", "Export Prediction"),

                            ),
                            mainPanel(verbatimTextOutput("placeholder", placeholder = TRUE), tags$hr(),
                                      dataTableOutput("export"))
                        )


                        )
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
                    label = "Select your Y variable",
                    choices = NamesY,
                    multiple=FALSE)})


    fit = eventReactive(input$btnFit,{
      if(!is.null(data()))
      {
        varx = input$varx
        vary = input$vary

        datattrain = data()
        datattest = NULL

        if(is.null(varx)){
            varx = setdiff(colnames(data()), vary)
        }

    #fit = reactive({
        if(as.logical(input$split)){

          if(input$datasplit == "test"){
              dataSplit = split_sample(data=data(), train_perc=(1-(input$pourcentagesplit*0.01)))
          }
          else if (input$dataplit == "train"){
              dataSplit = split_sample(data=data(), train_perc=(input$pourcentagesplit*0.01))
          }
          datattrain = dataSplit$train[,c(varx,vary)]
          datattest= dataSplit$test[,c(varx,vary)]

        }
        formul = as.formula(paste(vary,"~",".",sep=""))

        if(!is.null(formul) & !is.null(datattrain) & !is.null(input$ncomp)){
            obj = plsda()
            obj = plsda_fit(obj,formula=formul, datattrain, ncomp=input$ncomp, var.select = as.logical(input$vip), centre=as.logical(input$center))
            fitReturn = list("obj" = obj, "newdata" = datattest, "target" = vary)
            return(fitReturn)
         }

      }

    })
    output$fit=renderDataTable({t(fit()$obj$coefficients)})


    predict = eventReactive(input$btnPredict,{

      if(!is.null(fit()))
      {

        obj = fit()$obj
        print(fit())
        target = fit()$target
        inFilepred <- input$fileTest

        if(is.null(inFilepred))
        {
          newdata =fit()$newdata
        }
        else{
          if(input$typepred == "xlsx"){
            newdata = read_excel(path=inFilepred$datapath)
          }else if (input$typepred == "csv"){
            newdata = read.csv(inFilepred$datapath)
          }

        }

        newdataX = newdata[,setdiff(colnames(newdata), target)]
        newdataY = newdata[,target]

        if(!is.null(obj) & !is.null(newdataX) & !is.null(input$typePred))
        {
            pred = as.data.frame(plsda_predict(obj,newdataX, input$typePred))
            return(pred)
        }
      }

    })
    output$predict=renderDataTable({predict()})

    export = eventReactive(input$btnExport,{

        output$placeholder <- renderText({ paste("Prediction Path : \n", getwd()) })
        if(!is.null(predict())){
            export.plsda(predict())
            return(predict())
        }

    })
    output$export=renderDataTable({export()})


}
# Run the application
shinyApp(ui = ui, server = server)

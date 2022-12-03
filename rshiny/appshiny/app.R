
checkinstall.shiny.plsda()
# Interface Part - front-end App
ui <- fluidPage(
    # Menu
    navbarPage("PLS App",
               # Page 1 For import Data
               tabPanel("Import Data",
                        sidebarLayout(
                            sidebarPanel(
                                # Informations to complete on the left side of the page 1
                                strong(h1("Import your data : ")),
                                fileInput("file1", "Choose your File", # Select and import a local file in the Rshiny App
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
                            mainPanel(dataTableOutput("contents")) # Principal Part of the page 1 to show content
                        )
               ),
               # Page 2 For use fit to the model and make prediction
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
                            mainPanel(dataTableOutput("fit"), dataTableOutput("predict")) # Principal Part show result of the function fit and predict
                        )
               ),
               # Page 3 for show plot based on fit result
               tabPanel("Plots"),
               # Page 4 for export prediction on a csv file based on predict result
               tabPanel("Export",
                        sidebarLayout(
                            sidebarPanel(
                                actionButton("btnExport", "Export Prediction"),# button to execute the exportation of prediction in the current directory
                                ),
                            mainPanel(verbatimTextOutput("placeholder", placeholder = TRUE), tags$hr(),dataTableOutput("export"))
                        )
                        )
    )
)


#########################################################################################################################################
# Server Part - back-end App

server <- function(input, output) {

    data = reactive({ # to import and show the data in the app shiny

        inFile <- input$file1
        if (is.null(inFile)){ # check if the data file is recuperate
            return(NULL)
        }
        else{
            if(input$type == "xlsx"){ # read data
                read_excel(path=inFile$datapath, sheet=input$sheetnumber, col_names=as.logical(input$header))

            }else if (input$type == "csv"){
                read.csv(inFile$datapath, header = input$header, sep = input$separator)

            } else {
                stop("file must be csv or xlsx")
            }
        }
    })
    output$contents=renderDataTable({head(data(),10)}) # Print the head of the data

    output$xvar=renderUI({ # print all variables of the data imported in explicative field # all can be select
        NamesX=colnames(data())
        selectInput(inputId = "varx",
                    label = "Select your X variables",
                    choices = NamesX,
                    multiple=TRUE)})
    output$yvar=renderUI({
        NamesY=colnames(data()) # print all variables of the data imported in target field # only one can be select
        selectInput(inputId = "vary",
                    label = "Select your Y variable",
                    choices = NamesY,
                    multiple=FALSE)})


    fit = eventReactive(input$btnFit,{ # call by page fit to return the result of fit function of pls package
      if(!is.null(data())){ # check if we get data
        varx = input$varx
        vary = input$vary

        datattrain = data()
        datattest = NULL

        if(is.null(varx)){
            varx = setdiff(colnames(data()), vary)
        }

        if(as.logical(input$split)){ # check if with cut the data in data test and data train

          if(input$datasplit == "test"){
              dataSplit = split_sample(data=data(), train_perc=(1-(input$pourcentagesplit*0.01))) # function from pls package
          }
          else if (input$dataplit == "train"){
              dataSplit = split_sample(data=data(), train_perc=(input$pourcentagesplit*0.01))
          }
          datattrain = dataSplit$train[,c(varx,vary)]
          datattest= dataSplit$test[,c(varx,vary)]

        }
        formul = as.formula(paste(vary,"~",".",sep="")) # create a variable in formula format for the fit

        if(!is.null(formul) & !is.null(datattrain) & !is.null(input$ncomp)){ # do fit only if all the minimum of variable is not null
            obj = plsda() # creation of the object plS
            obj = plsda_fit(obj,formula=formul, datattrain, ncomp=input$ncomp, var.select = as.logical(input$vip), centre=as.logical(input$center)) # fit function
            fitReturn = list("obj" = obj, "newdata" = datattest, "target" = vary)
            return(fitReturn)
         }

      }

    })
    output$fit=renderDataTable({t(fit()$obj$coefficients)}) # variable call by the interface, it call the function rshiny fit, just above


    predict = eventReactive(input$btnPredict,{

      if(!is.null(fit())) # check if we get the result of the fit
      {
        obj = fit()$obj
        target = fit()$target
        inFilepred <- input$fileTest

        if(is.null(inFilepred))
        {
          newdata =fit()$newdata # if we don't get the data file from local import we take the data test  of the fit
        }
        else{# possibility to the user to import his data test
          if(input$typepred == "xlsx"){
            newdata = read_excel(path=inFilepred$datapath)
          }else if (input$typepred == "csv"){ # import of the file data test
            newdata = read.csv(inFilepred$datapath)
          }

        }

        newdataX = newdata[,setdiff(colnames(newdata), target)] # transform data test in explicative test data
        newdataY = newdata[,target] # transform data test in target test data

        if(!is.null(obj) & !is.null(newdataX) & !is.null(input$typePred)) # check if we get all the data we need to run the predict function
        {
            pred = as.data.frame(plsda_predict(obj,newdataX, input$typePred)) # predict function from pls library
            return(pred)
        }
      }

    })
    output$predict=renderDataTable({predict()}) # variable call by the interface, it call the function rshiny predict, just above

    export = eventReactive(input$btnExport,{ # function to export prediction on a csv file

        output$placeholder <- renderText({ paste("Prediction Path : \n", getwd()) }) # print the path of the localisation of the file exported
        if(!is.null(predict())){ # check if we get the result of function predicton rshiny
            export.plsda(predict()) # use the function export from pls library
            return(predict())
        }

    })
    output$export=renderDataTable({export()})


}
# Run the application shiny
shinyApp(ui = ui, server = server)

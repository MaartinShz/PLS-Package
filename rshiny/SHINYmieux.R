# Load R packages

#install.packages("shiny")
#install.packages("shinythemes")
#install.packages("ggplot2")
#install.packages("DT")
library(DT)

library(shiny)
library(shinythemes)
library(ggplot2)


#exemple d'inspiration
#runExample("04_mpg")



# la page principale
ui <- fluidPage(theme = shinytheme("cyborg"),
                navbarPage(
                  # première page
                  "PLS package",
                  tabPanel("page pour ecrire des trucs",
                           sidebarPanel(
                             tags$h3("ce que tu veux:"),
                             textInput("txt1", "jsp:", ""),
                             textInput("txt2", "un truc:", ""),

                           ), # ça écrit les trucs que t'a rentré avant
                           mainPanel(
                             h1("titre"),

                             h4("sortie"),
                             verbatimTextOutput("txtout"),)),




                  tabPanel("importer des données dans le truc",
                           fileInput('target_upload', 'Choose file to upload',
                                     accept = c(
                                       'text/csv',
                                       'text/comma-separated-values',
                                       '.csv'
                                     )),
                           radioButtons("separator","Separator: ",choices = c(";",",",":"), selected=";",inline=TRUE),
                           DT::dataTableOutput("contents")
                  ),



                  tabPanel("plots des résultats",
                           pageWithSidebar(
                             headerPanel('Le plot de ton choix'),
                             sidebarPanel(

                               # c'est vide et ca se remplie quand le data est importé
                               selectInput('xcol', 'X Variable', ""),
                               selectInput('ycol', 'Y Variable', "", selected = "")

                             ),
                             mainPanel(
                               plotOutput('MyPlot')
                             )
                           )
                  )))



# server
server <- function(input, output) {

  output$txtout <- renderText({
    paste( input$txt1, input$txt2, sep = " " )})
  data <- reactive({read.csv(input$filedata$datapath)})


  output$table <- renderDT(
    data()
  )

  data <- reactive({
    req(input$target_upload)

    inFile <- input$target_upload

    df <- read.csv(ininFile$datapath, header = input$header, sep = input$sep,
                   quote = input$quote)

    updateSelectInput(session, inputId = 'xcol', label = 'X Variable',
                      choices = names(df), selected = names(df))
    updateSelectInput(session, inputId = 'ycol', label = 'Y Variable',
                      choices = names(df), selected = names(df)[2])

    return(df)
  })

  output$contents <- renderTable({
    data()
  })

  output$MyPlot <- renderPlot({
    x <- data()[, c(input$xcol, input$ycol)]
    plot(x)

  })

  df_products_upload <- reactive({
    inFile <- input$target_upload
    if (is.null(inFile))
      return(NULL)
    df <- read.csv(inFile$datapath, header = TRUE,sep = input$separator)
    return(df)
  })

  output$contents<- DT::renderDataTable({
    df <- df_products_upload()
    DT::datatable(df)
  })

}


# ca ouvre l'app shiny
shinyApp(ui = ui, server = server)

#y

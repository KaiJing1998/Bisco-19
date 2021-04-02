library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(DT)
library(RMySQL)

mydb <- dbConnect(MySQL(),
                  user = 'techvest_covidAdmin',
                  password = 'gRBOp;$[F[!g',
                  dbname = 'techvest_covid',
                  host = '143.198.217.144'
)

dbListTables(mydb)
dbListFields(mydb,'DAILYCASES')
rs = dbSendQuery(mydb, "SELECT * FROM DAILYCASES")
datatable = fetch (rs, n= -1)


dbListFields(mydb,'STATECASES')
rs1 = dbSendQuery(mydb, "SELECT * FROM STATECASES")
state_cases_table = fetch (rs1, n= -1)

View(state_cases_table)
View(datatable)


ui <- dashboardPage(
  skin = "yellow",
  dashboardHeader(title = "Covid-19 Malaysia Dashboard",
                  titleWidth = 350
                  ),
  
  dashboardSidebar(
    width = 350,
    
    sidebarMenu(
      img(src = "Capture.PNG", align = "center"),
      menuItem("Home Page", tabName = "home", icon = icon("home")),
      menuItem("State in Malaysia", tabName = "state", icon = icon("flag-checkered")),
        menuSubItem("Kuala Lumpur",tabName = "kuala lumpur"),
        menuSubItem("Selangor",tabName = "selangor"),
        menuSubItem("Johor",tabName = "johor"),
        menuSubItem("Penang",tabName = "penang"),
        menuSubItem("Perlis",tabName = "perlis"),
        menuSubItem("Kedah",tabName = "kedah"),
        menuSubItem("Kelantan",tabName = "kelantan"),
        menuSubItem("Terengganu",tabName = "terengganu"),
        menuSubItem("Melaka",tabName = "melaka"),
        menuSubItem("Pahang",tabName = "pahang"),
        menuSubItem("Labuan",tabName = "labuan"),
        menuSubItem("Putrajaya",tabName = "putrajaya"),
        menuSubItem("Negeri Sembilan",tabName = "negeri sembilan"),
        menuSubItem("Sabah",tabName = "sabah"),
        menuSubItem("Sarawak",tabName = "Sarawak"),
      menuItem("Symptoms of Covid-19", tabName = "symptoms", icon = icon("hand-holding-medical"))
    )
  ),
  dashboardBody(
    fluidRow(
      # A static value Box
      valueBox("941","New Cases", color = "red", width = 3),
      valueBox("5","New Deaths", color = "green",width = 3),
      valueBox("1,097","New Recovered", color = "blue",width = 3),
      valueBox("14,219","Active Cases", color = "maroon", width = 3),
    ),
    tabItems(
      tabItem("home",
              box(plotOutput("correlation_plot"), width =8),
              box(
                selectInput("malaysia_status","Malaysia Covid-19 Status:",
                            c("Total Cases","Daily New Cases","Active Cases","Total Deaths","Daily Deaths")), width = 4
              ),
             
             
      ),
      
      tabItem("state",
              fluidPage(
                h2("State in Malaysia"),
                  "updated",
                  em("March 28, 2021"),
                dataTableOutput("state_cases")
              )
      ),
      
      tabItem("selangor",
              fluidPage(
                h2("Selangor"),
                   "updated",
                   em("March 30, 2021"),
                   dataTableOutput("selangor")
              ))
    )
  )
)


#Where application logic lives
server <- function(input,output,session){
  
  output$correlation_plot <- renderPlot({
    plot(datatable$Date,datatable[[input$malaysia_status]],
         xlab = "Date", ylab = "Covid-19 Cases")
  })
  
  output$state_cases <- renderDataTable(
    
    state_cases_table
   
    )
  
  output$selangor <- renderDataTable(Selangor)
}

#Combine UI + server into a Shiny app and run it 
shinyApp(ui, server)
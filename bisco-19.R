library(shiny)
library(shinydashboard)
library(DT)
library(RMySQL)
library(dplyr)
library(ggplot2)
library(reshape2)
library(plotly)
library(maps)

Malaysia <- map_data("world") %>% filter(region == "Malaysia")

data <- world.cities %>% filter(country.etc == "Malaysia")


#Connect to database
mydb <- dbConnect(MySQL(),
                  user = 'techvest_covidAdmin',
                  password = 'gRBOp;$[F[!g',
                  dbname = 'techvest_covid',
                  host = '143.198.217.144'
)

#Retrieve data from MYSQL
dbListTables(mydb)


dbListFields(mydb,'DAILYCASES')
rs = dbSendQuery(mydb, "SELECT * FROM DAILYCASES")
datatable = fetch (rs, n= -1)

dbListFields(mydb,'STATECASES')
rs1 = dbSendQuery(mydb, "SELECT * FROM STATECASES")
state_cases_table = fetch (rs1, n= -1)

dbListFields(mydb,'DAILYSTATECASES')
rs2 = dbSendQuery(mydb, "SELECT * FROM DAILYSTATECASES")
daily_state_cases_table = fetch (rs2, n= -1)

dbListFields(mydb,'SELANGOR_DISTRICT')
rs3 = dbSendQuery(mydb, "SELECT * FROM SELANGOR_DISTRICT ")
selangor_district = fetch (rs3, n= -1)

dbListFields(mydb,'SELANGOR')
rs4 = dbSendQuery(mydb, "SELECT * FROM SELANGOR")
selangor = fetch (rs4, n= -1)

dbListFields(mydb,'KUALALUMPURDISTRICT')
rs5 = dbSendQuery(mydb, "SELECT * FROM KUALALUMPURDISTRICT")
kualalumpur_district = fetch (rs5, n= -1)

dbListFields(mydb,'KUALALUMPUR')
rs6 = dbSendQuery(mydb, "SELECT * FROM KUALALUMPUR")
kualalumpur = fetch (rs6, n= -1)

dbListFields(mydb,'JOHOR_DISTRICT')
rs7 = dbSendQuery(mydb, "SELECT * FROM JOHOR_DISTRICT")
johor_district = fetch (rs7, n= -1)

#View(state_cases_table)
#View(datatable)
#View(daily_state_cases_table)
#View(selangor_district)
#View(selangor)
#View(kualalumpur_district)
#View(kualalumpur)


ui <- dashboardPage(
  skin = "yellow",
  dashboardHeader(title = "Covid-19 Malaysia Dashboard",
                  titleWidth = 300
                  ),
  
  dashboardSidebar(
    width = 300,
    
    sidebarMenu(
      img(src = "Capture.PNG", align = "center"),
      menuItem("Dashboard", tabName = "home", icon = icon("dashboard")),
      menuItem("State in Malaysia", tabName = "state", icon = icon("flag-checkered")),
        menuSubItem("Kuala Lumpur",tabName = "kualalumpur"),
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
      valueBox("1,349","New Cases", color = "red", width = 3, icon = icon("arrow-alt-circle-up")),
      valueBox("2","New Deaths", color = "green",width = 3, icon = icon("arrow-alt-circle-up")),
      valueBox("1,270","New Recovered", color = "blue",width = 3, icon = icon("arrow-alt-circle-up")),
      valueBox("14,509","Active Cases", color = "maroon", width = 3, icon = icon("arrow-alt-circle-up")),
    ),
    
    tabItems(
      tabItem("home",
              tabsetPanel(
                            tabPanel("Daily New Cases",plotlyOutput("lineChart2")),
                            tabPanel("Acive Cases",plotlyOutput("lineChart3")),
                            tabPanel("Total Cases",plotlyOutput("lineChart")),
                            type = "tab"
      
              ),
              
              tabsetPanel(
                            tabPanel("Daily Deaths",plotlyOutput("lineChart5")),
                            tabPanel("Total Deaths",plotlyOutput("lineChart4")),
                            type = "tab"
      
              ),
                         
    
              
              
      #tabItem("home",
       #       plotlyOutput("linestate")),
      
      fluidRow(
        tabItem("home",
                box(title = "State Confirmed Cases", status = "primary", solidHearder = TRUE,
                    collapsible = TRUE,
                    plotlyOutput("stateBarGraph"))),
        
                box(title = "State Daily Cases", status = "primary", solidHeader = TRUE,
                    collapsible = TRUE,
                    plotlyOutput("linestate"))
      ),
      
     
     
      ),
    
      tabItem("state",
              fluidPage(
                h2("State in Malaysia"),
                  "updated",
                  em("April 4, 2021"),
                dataTableOutput("state_cases")
              )
      ),
      
      tabItem("kualalumpur",
              fluidPage(
                h2("Kuala Lumpur"),
                "updated",
                em("April 4, 2021"),
                plotlyOutput("kualaLumpurDistrict"),
                dataTableOutput("kualaLumpur")
              ),
      ),
      
      tabItem("selangor",
              fluidPage(
                h2("Selangor"),
                   "updated",
                   em("April 4, 2021"),
                  plotlyOutput("selangorDistrict"),
                  dataTableOutput("selangor")
              ),
      ),
      
      tabItem("johor",
              fluidPage(
                h2("Johor"),
                "updated",
                em("April 4, 2021"),
                plotlyOutput("johorDistrict"),
                dataTableOutput("johor")
              ),
      ),
      
      
      
      
    )
  )
)



#Where application logic lives
server <- function(input,output){
  
  # Total Cases 
  output$lineChart <- renderPlotly({
    
   p <- ggplot(data=datatable, aes(x= `Date`, y= `Total Cases`, group=1))+
     geom_line(color = 'lightyellow')+
     geom_point()+
     ylab("Total Cases")+
     xlab("Date")
   
   p<- ggplotly(p)
   p
  })
  
  #Daily Cases
  output$lineChart2 <- renderPlotly({
    
    ggplot(data=datatable, aes(x= `Date`, y= `Daily New Cases`, group=1))+
      #geom_bar(stat = "identity", color = "blue")+
      #theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))
      geom_line()+
      geom_point(colour = 'red')+
      theme_bw()+
      ylab("Daily New Cases")+
      xlab("Date")
  
    
  })
  
  #Active Cases
  output$lineChart3 <- renderPlotly({
    
    p2 <- ggplot(data=datatable, aes(x= `Date`, y= `Active Cases`, group=1))+
      geom_line(color = "salmon1")+
      geom_point(color="lightpink4")+
      ylab("Active Cases")+
      xlab("Date")
    
    p2<- ggplotly(p2)
    p2
    
  })
  
  #Total Deaths
  output$lineChart4 <- renderPlotly({
    
    p3 <- ggplot(data=datatable, aes(x= `Date`, y= `Total Deaths`, group=1))+
      geom_line(linetype = "dashed")+
      geom_point()+
      ylab("Total Deaths")+
      xlab("Date")
    
    p3<- ggplotly(p3)
    p3
    
  })
  
  #Daily Deaths
  output$lineChart5 <- renderPlotly({
    
    ggplot(data=datatable, aes(x= `Date`, y=`Daily Deaths`, group = 1))+
      geom_line()+
      geom_point(color = "turquoise")+
      theme_bw()+
      xlab("State")+
      ylab("Total Confirmed Cases")
     
    
   
  })
  
  #State
  output$linestate <- renderPlotly({
    color_group <- c("red","blue","green","orange","sky blue","tomato","snow","tan","ivory","lightsalmon","orchid4","indianred3","mintcream","palevioletred","linen","rosybrown4")
    
    ggplot() + 
      geom_line(data = daily_state_cases_table,aes(x = `Date`, y= `Perlis`, group = 1), color = "red") + 
      geom_line(data = daily_state_cases_table,aes(x = `Date`,y = `Kedah`, group = 1), color="blue") +
      geom_line(data = daily_state_cases_table,aes(x = `Date`,y = `Pulau_Pinang`, group = 1), color="green") +
      geom_line(data = daily_state_cases_table,aes(x = `Date`,y = `Perak`, group = 1), color="orange") +
      geom_line(data = daily_state_cases_table,aes(x = `Date`,y = `Selangor`, group = 1), color="sky blue") +
      geom_line(data = daily_state_cases_table,aes(x = `Date`,y = `Negeri Sembilan`, group = 1), color="tomato") +
      geom_line(data = daily_state_cases_table,aes(x = `Date`,y = `Melaka`, group = 1), color="snow") +
      geom_line(data = daily_state_cases_table,aes(x = `Date`,y = `Johor`, group = 1), color="tan") +
      geom_line(data = daily_state_cases_table,aes(x = `Date`,y = `Pahang`, group = 1), color="ivory") +
      geom_line(data = daily_state_cases_table,aes(x = `Date`,y = `Terengganu`, group = 1), color="lightsalmon") +
      geom_line(data = daily_state_cases_table,aes(x = `Date`,y = `Kelantan`, group = 1), color="orchid4") +
      geom_line(data = daily_state_cases_table,aes(x = `Date`,y = `Sabah`, group = 1), color="indianred3") +
      geom_line(data = daily_state_cases_table,aes(x = `Date`,y = `Sarawak`, group = 1), color="mintcream")+
      geom_line(data = daily_state_cases_table,aes(x = `Date`,y = `WP_Kuala_Lumpur`, group = 1), color="palevioletred")+
      geom_line(data = daily_state_cases_table,aes(x = `Date`,y = `WP_Putrajaya`, group = 1), color="linen") +
      geom_line(data = daily_state_cases_table,aes(x = `Date`,y = `WP_Labuan`, group = 1), color="rosybrown4") +
      theme_classic()+
      xlab("Day")+
      ylab("State")+
      
      scale_colour_manual(values = color_group)+
      labs(colour = "State")+
      ggtitle("Comfirmed Cases by State")
  
  })
  
  #State Bar Graph (Total Cases)
  output$stateBarGraph <- renderPlotly({
    stateBar <- ggplot(data = state_cases_table, aes(x= `State`, y = `Confirmed`)) +
      geom_bar(stat = "identity", color = "salmon3", fill="ivory" )+
      theme_minimal()+
      xlab("State") +
      ylab("Total Confirmed Cases")
    
    stateBar
    stateBar + coord_flip() 
    
  })
  
  output$state_cases <- renderDataTable(
    state_cases_table
  )
  

  # Selangor
  output$selangorDistrict <- renderPlotly({
    selangorDist <- ggplot(data= selangor_district, aes(x= `District`, y = `14 Day Total`))+
      geom_bar(stat ="identity")+
      theme_minimal()
    
    selangorDist
    
  })
  
  output$selangor <- renderDataTable(selangor)
  
  
  # Kuala Lumpur 
  output$kualaLumpurDistrict <- renderPlotly({
    klDist <- ggplot(data=kualalumpur_district , aes(x= `District`, y = `14 Day Total`))+
      geom_bar(stat ="identity")+
      theme_minimal()
    
    klDist
    
  })
  
  output$kualaLumpur <- renderDataTable(kualalumpur)
  
  #Johor
  
  output$johorDistrict <- renderPlotly({
    klDist <- ggplot(data=johor_district , aes(x= `District`, y = `14 Day Total`))+
      geom_bar(stat ="identity")+
      theme_minimal()
    
    klDist
    
  })
  
  output$johor <- renderDataTable(kualalumpur)
  
  
}

#Combine UI + server into a Shiny app and run it 
shinyApp(ui, server)
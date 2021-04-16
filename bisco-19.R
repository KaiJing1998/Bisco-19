library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(DT)
library(RMySQL)
library(dplyr)
library(ggplot2)
library(reshape2)
library(plotly)
#library(maps)

#Malaysia <- map_data("world") %>% filter(region == "Malaysia")

#data <- world.cities %>% filter(country.etc == "Malaysia")


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

dbListFields(mydb,'JOHOR')
rs8 = dbSendQuery(mydb, "SELECT * FROM JOHOR")
johor= fetch (rs8, n= -1)

dbListFields(mydb,'PERLIS_DISTRICT')
rs9 = dbSendQuery(mydb, "SELECT * FROM PERLIS_DISTRICT")
perlis_district = fetch (rs9, n= -1)

dbListFields(mydb,'PERLIS')
rs10 = dbSendQuery(mydb, "SELECT * FROM PERLIS")
perlis = fetch (rs10, n= -1)

dbListFields(mydb,'PPINANG_DISTRICT')
rs11 = dbSendQuery(mydb, "SELECT * FROM PPINANG_DISTRICT")
penang_district = fetch (rs11, n= -1)

dbListFields(mydb,'PPINANG')
rs12 = dbSendQuery(mydb, "SELECT * FROM PPINANG")
penang = fetch (rs12, n= -1)

dbListFields(mydb,'KEDAH_DISTRICT')
rs13 = dbSendQuery(mydb, "SELECT * FROM KEDAH_DISTRICT")
kedah_district = fetch (rs13, n= -1)

dbListFields(mydb,'KEDAH')
rs14 = dbSendQuery(mydb, "SELECT * FROM KEDAH")
kedah = fetch (rs14, n= -1)

dbListFields(mydb,'KELANTAN_DISTRICT')
rs15 = dbSendQuery(mydb, "SELECT * FROM KELANTAN_DISTRICT")
kelantan_district = fetch (rs15, n= -1)

dbListFields(mydb,'KELANTAN')
rs16 = dbSendQuery(mydb, "SELECT * FROM KELANTAN")
kelantan = fetch (rs16, n= -1)

dbListFields(mydb,'TERENGGANU_DISTRICT')
rs17 = dbSendQuery(mydb, "SELECT * FROM TERENGGANU_DISTRICT")
terengganu_district = fetch (rs17, n= -1)

dbListFields(mydb,'TERENGGANU')
rs18 = dbSendQuery(mydb, "SELECT * FROM TERENGGANU")
terengganu= fetch (rs18, n= -1)

dbListFields(mydb,'MELAKA_DISTRICT')
rs19 = dbSendQuery(mydb, "SELECT * FROM MELAKA_DISTRICT")
melaka_district = fetch (rs19, n= -1)

dbListFields(mydb,'MELAKA')
rs20 = dbSendQuery(mydb, "SELECT * FROM MELAKA")
melaka = fetch (rs20, n= -1)

dbListFields(mydb,'PAHANG_DISTRICT')
rs21 = dbSendQuery(mydb, "SELECT * FROM PAHANG_DISTRICT")
pahang_district = fetch (rs21, n= -1)

dbListFields(mydb,'PAHANG')
rs22 = dbSendQuery(mydb, "SELECT * FROM PAHANG")
pahang = fetch (rs22, n= -1)

dbListFields(mydb,'LABUAN_DISTRICT')
rs23 = dbSendQuery(mydb, "SELECT * FROM LABUAN_DISTRICT")
labuan_district = fetch (rs23, n= -1)

dbListFields(mydb,'LABUAN')
rs24 = dbSendQuery(mydb, "SELECT * FROM LABUAN")
labuan = fetch (rs24, n= -1)

dbListFields(mydb,'PUTRAJAYA_DISTRICT')
rs25 = dbSendQuery(mydb, "SELECT * FROM PUTRAJAYA_DISTRICT")
putrajaya_district = fetch (rs25, n= -1)

dbListFields(mydb,'PUTRAJAYA')
rs26 = dbSendQuery(mydb, "SELECT * FROM PUTRAJAYA")
putrajaya = fetch (rs26, n= -1)

dbListFields(mydb,'NSEMBILAN_DISTRICT')
rs27 = dbSendQuery(mydb, "SELECT * FROM NSEMBILAN_DISTRICT")
nsembilan_district = fetch (rs27, n= -1)

dbListFields(mydb,'NSEMBILAN')
rs28 = dbSendQuery(mydb, "SELECT * FROM NSEMBILAN")
nsembilan = fetch (rs28, n= -1)

dbListFields(mydb,'SABAH_DISTRICT')
rs29 = dbSendQuery(mydb, "SELECT * FROM SABAH_DISTRICT")
sabah_district = fetch (rs29, n= -1)

dbListFields(mydb,'SABAH')
rs30 = dbSendQuery(mydb, "SELECT * FROM SABAH")
sabah = fetch (rs30, n= -1)

dbListFields(mydb,'SARAWAK_DISTRICT')
rs31 = dbSendQuery(mydb, "SELECT * FROM SARAWAK_DISTRICT")
sarawak_district = fetch (rs31, n= -1)

dbListFields(mydb,'SARAWAK')
rs32 = dbSendQuery(mydb, "SELECT * FROM SARAWAK")
sarawak = fetch (rs32, n= -1)


#View(state_cases_table)
#View(datatable)
#View(daily_state_cases_table)
#View(selangor_district)
#View(selangor)
#View(kualalumpur_district)
#View(kualalumpur)
#View(johor_district)
#View(johor)
#View(perlis_district)
#View(perlis)
#View(penang_district)
#View(penang)
#View(kedah_district)
#View(kedah)
#View(kelantan_district)
#View(kelantan)
#View(terengganu_district)
#View(terengganu)
#View(melaka_district)
#View(melaka)
#View(pahang_district)
#View(pahang)
#View(labuan_district)
#View(labuan)
#View(putrajaya_district)
#View(putrajaya)
#View(nsembilan_district)
#View(nsembilan)
#View(sabah_district)
#View(sabah)
#View(sarawak_district)
#View(sarawak)


ui <- dashboardPage(
  skin = "yellow",
  dashboardHeader(title = "Covid-19 Malaysia Dashboard",
                  titleWidth = 300
                  ),
  footer = dashboardFooter(
    left = "Copyright 2021",
   
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
        menuSubItem("Negeri Sembilan",tabName = "negerisembilan"),
        menuSubItem("Sabah",tabName = "sabah"),
        menuSubItem("Sarawak",tabName = "Sarawak"),
      menuItem("Symptoms of Covid-19", tabName = "symptoms", icon = icon("hand-holding-medical"))
    )
  ),
  dashboardBody(
    fluidRow(
      # A static value Box
      valueBox("1,767","New Cases", color = "red", width = 3, icon = icon("arrow-alt-circle-up")),
      valueBox("12","New Deaths", color = "olive",width = 3, icon = icon("arrow-alt-circle-up")),
      valueBox("1,290","New Recovered", color = "light-blue",width = 3, icon = icon("arrow-alt-circle-up")),
      valueBox("16,300","Active Cases", color = "navy", width = 3, icon = icon("arrow-alt-circle-up")),
    ),
    
    tabItems(
      tabItem("home",
              tabsetPanel(
                            tabPanel("Daily New Cases",plotlyOutput("lineChart2")),
                            tabPanel("Acive Cases",plotlyOutput("lineChart3")),
                            tabPanel("Total Cases",plotlyOutput("lineChart")),
                            type = "tab"
      
              ),
              br(),
              
              tabsetPanel(
                            tabPanel("Daily Deaths",plotlyOutput("lineChart5")),
                            tabPanel("Total Deaths",plotlyOutput("lineChart4")),
                            type = "tab"
      
              ),
                    
              br(),     
      
      fluidRow(
        tabItem("home",
                box(title = "State Confirmed Cases",background = "black", solidHearder = TRUE,
                    collapsible = TRUE,
                    plotlyOutput("stateBarGraph"))),
            
        
                box(title = "State Daily Cases",background = "blue" , solidHeader = TRUE,
                    collapsible = TRUE,
                    plotlyOutput("linestate"))
      ),
      
     
     
      ),
    
      tabItem("state",
              fluidPage(
                h2("State in Malaysia"),
                  "updated",
                  em("April 13, 2021"),
                br(),
                dataTableOutput("state_cases")
              )
      ),
      
      tabItem("kualalumpur",
              fluidPage(
                h2("Kuala Lumpur"),
                "updated",
                em("April 13, 2021"),
                br(),
                plotlyOutput("kualaLumpurDistrict"),
                br(),
                dataTableOutput("kualaLumpur")
              ),
      ),
      
      tabItem("selangor",
              fluidPage(
                h2("Selangor"),
                   "updated",
                   em("April 13, 2021"),
                  br(),
                  plotlyOutput("selangorDistrict"),
                  br(),
                  dataTableOutput("selangor")
              ),
      ),
      
      tabItem("johor",
              fluidPage(
                h2("Johor"),
                "updated",
                em("April 13, 2021"),
                br(),
                plotlyOutput("johorDistrict"),
                br(),
                dataTableOutput("johor")
              ),
      ),
      
      tabItem("perlis",
              fluidPage(
                h2("Perlis"),
                "updated",
                em("April 13, 2021"),
                br(),
                plotlyOutput("perlisDistrict"),
                br(),
                dataTableOutput("perlis")
              ),
      ),
      
      tabItem("penang",
              fluidPage(
                h2("Penang"),
                "updated",
                em("April 13, 2021"),
                br(),
                plotlyOutput("penangDistrict"),
                br(),
                dataTableOutput("penang")
              ),
      ),
      
      tabItem("kedah",
              fluidPage(
                h2("Kedah"),
                "updated",
                em("April 13, 2021"),
                br(),
                plotlyOutput("kedahDistrict"),
                br(),
                dataTableOutput("kedah")
              ),
      ),
      
      tabItem("kelantan",
              fluidPage(
                h2("Kelantan"),
                "updated",
                em("April 13, 2021"),
                br(),
                plotlyOutput("kelantanDistrict"),
                br(),
                dataTableOutput("kelantan")
              ),
      ),
      
      tabItem("terengganu",
              fluidPage(
                h2("Terengganu"),
                "updated",
                em("April 13, 2021"),
                br(),
                plotlyOutput("terengganuDistrict"),
                br(),
                dataTableOutput("terengganu")
              ),
      ),
      
      tabItem("melaka",
              fluidPage(
                h2("Melaka"),
                "updated",
                em("April 13, 2021"),
                br(),
                plotlyOutput("melakaDistrict"),
                br(),
                dataTableOutput("melaka")
              ),
      ),
      
      tabItem("pahang",
              fluidPage(
                h2("Pahang"),
                "updated",
                em("April 13, 2021"),
                br(),
                plotlyOutput("pahangDistrict"),
                br(),
                dataTableOutput("pahang")
              ),
      ),
      
      tabItem("labuan",
              fluidPage(
                h2("Labuan"),
                "updated",
                em("April 13, 2021"),
                br(),
                plotlyOutput("labuanDistrict"),
                br(),
                dataTableOutput("labuan")
              ),
      ),
      
      
      tabItem("putrajaya",
              fluidPage(
                h2("Putrajaya"),
                "updated",
                em("April 13, 2021"),
                br(),
                plotlyOutput("putrajayaDistrict"),
                br(),
                dataTableOutput("putrajaya")
              ),
      ),
      
      tabItem("negerisembilan",
              fluidPage(
                h2("Negeri Sembilan"),
                "updated",
                em("April 13 2021"),
                br(),
                plotlyOutput("nsembilanDistrict"),
                br(),
                dataTableOutput("nsembilan")
              ),
      ),
      
      tabItem("sabah",
              fluidPage(
                h2("Sabah"),
                "updated",
                em("April 13, 2021"),
                br(),
                plotlyOutput("sabahDistrict"),
                br(),
                dataTableOutput("sabah")
              ),
      ),
      
      tabItem("Sarawak",
              fluidPage(
                h2("Sarawak"),
                "updated",
                em("April 13, 2021"),
                br(),
                plotlyOutput("sarawakDistrict"),
                br(),
                dataTableOutput("sarawak")
              ),
      ),
      
      tabItem("symptoms",
              fluidPage(
                h2("Symptoms of Covid-19", align = "center"),
                h3("COVID-19 affects different people in different ways. Most infected people will develop mild to moderate illness and recover without hospitalization."),
                
                code("Most common symptoms:"),
                h4(" - Fever"),
                h4(" - Dry cough"),
                h4(" - Tiredness"),
                br(),
                code("Less common symptoms:"),
                h4(" - Aches and pains"),
                h4(" - Sore throat"),
                h4(" - Diarrhoea"),
                h4(" - Conjunctivitis"),
                h4(" - Headache"),
                h4(" - Loss of taste or smell"),
                h4(" - A rash on skin, or discolouration on fingers or toes"),
                br(),
                code("Serious symptoms:"),
                h4(" - Difficulty breathing or shortness or breath"),
                h4(" - Chest pain or pressure"),
                h4(" - Loss of speech or movement"),
                br(),
                em("Seek immediate medical attention if you have serious symptoms. Always call before visiting your doctor or health facility. People with mild symptoms who are otherwise healthy should manage their symptoms at home. On average it takes 5 - 6 days from when someone is infected with the virus for symptoms to show, however it can take up to 14 days.")
                
              )
      )
      
      
      
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
      geom_point()+
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
      geom_bar(stat = "identity", color = "bisque3", fill="blue4" )+
      theme_minimal()+
      #xlab("State") +
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
      geom_bar(stat ="identity", color = "darkred")+
      theme_minimal()
    
    selangorDist
    
  })
  
  output$selangor <- renderDataTable(selangor)
  
  
  # Kuala Lumpur 
  output$kualaLumpurDistrict <- renderPlotly({
    klDist <- ggplot(data=kualalumpur_district , aes(x= `District`, y = `14 Day Total`))+
      geom_bar(stat ="identity", color = "darksalmon")+
      theme_minimal()
    
    klDist
    
  })
  
  output$kualaLumpur <- renderDataTable(kualalumpur)
  
  #Johor
  
  output$johorDistrict <- renderPlotly({
    johorDist <- ggplot(data=johor_district , aes(x= `District`, y = `14 Day Total`))+
      geom_bar(stat ="identity", color = "darkslategray4")+
      theme_minimal()
    
    johorDist
    
  })
  
  output$johor <- renderDataTable(johor)
  
  #Perlis
  
  output$perlisDistrict <- renderPlotly({
    perlisDist <- ggplot(data=perlis_district , aes(x= `District`, y = `14 Day Total`))+
      geom_bar(stat ="identity", color = "deepskyblue")+
      theme_minimal()
    
    perlisDist
    
  })
  
  output$perlis <- renderDataTable(perlis)
  
  #Penang
  
  output$penangDistrict <- renderPlotly({
    penangDist <- ggplot(data=penang_district , aes(x= `District`, y = `14 Day Total`))+
      geom_bar(stat ="identity", color = "cadetblue")+
      theme_minimal()
    
    penangDist
    
  })
  
  output$penang <- renderDataTable(penang)
  
  #Kedah
  
  output$kedahDistrict <- renderPlotly({
    kedahDist <- ggplot(data=kedah_district , aes(x= `District`, y = `14 Day Total`))+
      geom_bar(stat ="identity", color = "antiquewhite3")+
      theme_minimal()
    
    kedahDist
    
  })
  
  output$kedah <- renderDataTable(kedah)
  
  #Kelantan
  
  output$kelantanDistrict <- renderPlotly({
    kelantanDist <- ggplot(data=kelantan_district , aes(x= `District`, y = `14 Day Total`))+
      geom_bar(stat ="identity", color = "coral")+
      theme_minimal()
    
    kelantanDist
    
  })
  
  output$kelantan <- renderDataTable(kelantan)
  
  #Terengganu
  
  output$terengganuDistrict <- renderPlotly({
    terengganuDist <- ggplot(data=terengganu_district , aes(x= `District`, y = `14 Day Total`))+
      geom_bar(stat ="identity", color = "azure3")+
      theme_minimal()
    
    terengganuDist
    
  })
  
  output$terengganu <- renderDataTable(terengganu)
  
  #Melaka
  
  output$melakaDistrict <- renderPlotly({
    melakaDist <- ggplot(data=melaka_district , aes(x= `District`, y = `14 Day Total`))+
      geom_bar(stat ="identity", color = "darkseagreen2")+
      theme_minimal()
    
    melakaDist
    
  })
  
  output$melaka <- renderDataTable(melaka)
  
  #Pahang
  
  output$pahangDistrict <- renderPlotly({
    pahangDist <- ggplot(data=pahang_district , aes(x= `District`, y = `14 Day Total`))+
      geom_bar(stat ="identity", color = "lightcoral")+
      theme_minimal()
    
    pahangDist
    
  })
  
  output$pahang <- renderDataTable(pahang)
  
  #Labuan
  
  output$labuanDistrict <- renderPlotly({
    labuanDist <- ggplot(data=labuan_district , aes(x= `District`, y = `14 Day Total`))+
      geom_bar(stat ="identity", color = "lightcyan3")+
      theme_minimal()
    
    labuanDist
    
  })
  
  output$labuan <- renderDataTable(labuan)
  
  #Putrajaya
  
  output$putrajayaDistrict <- renderPlotly({
    putrajayaDist <- ggplot(data=putrajaya_district , aes(x= `District`, y = `14 Day Total`))+
      geom_bar(stat ="identity", color = "mediumpurple4")+
      theme_minimal()
    
    putrajayaDist
    
  })
  
  output$putrajaya <- renderDataTable(putrajaya)
  
  #Negeri Sembilan
  
  output$nsembilanDistrict <- renderPlotly({
    nsembilanDist <- ggplot(data=nsembilan_district , aes(x= `District`, y = `14 Day Total`))+
      geom_bar(stat ="identity", color = "lightslategrey")+
      theme_minimal()
    
    nsembilanDist
    
  })
  
  output$nsembilan <- renderDataTable(nsembilan)
  
  #Sabah
  
  output$sabahDistrict <- renderPlotly({
    sabahDist <- ggplot(data=sabah_district , aes(x= `District`, y = `14 Day Total`))+
      geom_bar(stat ="identity", color = "navyblue")+
      theme(axis.text.x=element_text(angle=90))+
      theme_minimal()
    
    sabahDist
    
  })
  
  output$sabah <- renderDataTable(sabah)
  
  #Sarawak
  
  output$sarawakDistrict <- renderPlotly({
    sarawakDist <- ggplot(data=sarawak_district , aes(x= `District`, y = `14 Day Total`))+
      geom_bar(stat = "identity", color = "blue")+
      theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))+
      theme_minimal()
    
    sarawakDist
    
  })
  
  output$sarawak <- renderDataTable(sarawak)
  
}

#Combine UI + server into a Shiny app and run it 
shinyApp(ui, server)
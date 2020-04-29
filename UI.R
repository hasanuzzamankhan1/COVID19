library(shiny)
library(shinydashboard)
library(xts)
library(plotly)
library(quantmod)
library(rlist)
library(billboarder)
library(breakDown)
library(DT)
library(readxl)
library(sf)
library(ggplot2)
library(tmap)
library(tmaptools)
library(leaflet)
library(dplyr)

covid19 = read_excel("input_data/COVID19.xlsx")

shinyUI(
  dashboardPage(title = "COVID-19 App", skin = "red",
    dashboardHeader(title = "COVID-19 Response"),
    dashboardSidebar(
      sidebarMenu(
      sidebarSearchForm("searchText","buttonSearch","Search"),
        menuItem("Dashboard", tabName = "dashboard"),
        menuSubItem("Detail Analysis", tabName = "Analysis"),
        menuSubItem("Storyboard", tabName = "board"),
        menuItem("Raw Data", tabName = "raw")),
      sliderInput("bins","Epidemological Week",1,52,50),
      fluidPage(
        selectInput("Division", "Choose a Division:",
                    list("Barisal", "Chattogram", "Dhaka", "Mymensigh", "Khulna", "Rajshahi","Rangpur","Sylhet")
                    ),
        
        tableOutput("result"),
        
     ##   fileInput("file","Upload Data Set"),
       
       ## checkboxInput("header","Header")
       )
      ),
    
    dashboardBody(
      
      tabItems(
        tabItem(tabName = "dashboard",
               
               fluidRow(
                  valueBoxOutput("labnumber"),
                  valueBoxOutput("TotalSample"),
                  valueBoxOutput("who_sup"),
                  valueBoxOutput("Trained"),
                  leafletOutput(outputId = "map"))
                  
                
               ),
            
         tabItem(tabName = "raw",
                h4("Data Set"),
                DT::dataTableOutput("data1")
                ), 
        
        
            tabItem(tabName = "Analysis",
                       
                    fluidRow(
                      tabBox(
                        title = "COVID-19 Reponse Analysis",
                        # The id lets us use input$tabset1 on the server to find the current tab
                        id = "tabset1", height = "250px",width = "450px", 
                        tabPanel("Samples", "Number of Samples by District",billboarderOutput("mybb1", width = "100%", height = "100%")),
                        tabPanel("District", "Vehicle Arrangment within District",billboarderOutput("mybb2", width = "100%", height = "100%")),
                        tabPanel("Govt.", "Vehicle Arrangment by Government",billboarderOutput("mybb3", width = "100%", height = "100%")),
                        tabPanel("IVD", "Vehicle Arrangment by IVD-WHO",billboarderOutput("mybb4", width = "100%", height = "100%")),
                        tabPanel("Division", "Vehicle Arrangment by DC-WHO",billboarderOutput("mybb5", width = "100%", height = "100%"))
                        
                        )),
                  
                  ),
                                   
            tabItem(tabName = "board",
                       h4("Storyboard")
                      )
                ),
      
            # tableOutput("input_file")
            
          )
      )
  )

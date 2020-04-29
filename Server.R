library(shiny)
library(shinydashboard)
library(billboarder)
library(breakDown)

shinyServer(function(input,output)
      {
      #  output$input_file<-({
          
         # file_to_read=input$file
          
         # if(is.null(file_to_read)){
            
         #   return()
        #  }
        #  read.table(file_to_read$datapath,header = input$header)
          
       # })
  
         output$mybb1 <- renderBillboarder({
    
          District1 <- data.frame(dist1=covid19$District,Samples=covid19$Total.Samples)
      
          dat <- as.data.frame(District1)
    
          billboarder() %>%
          bb_barchart(data=dat)
          })
            
          #output$mybb1 <- renderPlot({
            
           # covid19$District2<-factor(covid19$District,levels=levels(covid19$District)[c("BARGUNA","BARISAL","BARISAL CC.","BHOLA","JHALAKATI","PATUAKHALI","PEROJPUR","BANDARBAN","BRAHMANBARIA","CHANDPUR","CHITTAGONG","CHITTAGONG CC.","COMILLA","COMILLA CC.","COX'S BAZAR","FENI
          #","KHAGRACHARI","LAKSHMIPUR","NOAKHALI","RANGAMATI","DHAKA","DHAKA NORTH CC.","DHAKA SOUTH CC.","FARIDPUR","GAZIPUR","GAZIPUR CC.","GOPALGANJ","JAMALPUR","KISHOREGANJ","MADARIPUR","MANIKGANJ","MUNSHIGANJ","MYMENSINGH","MYMENSINGH CC.","NARAYANGANJ","NARAYANGANJ CC.","NARSINGDHI","NETROKONA","RAJBARI","SARIATPUR","SHERPUR","TANGAIL")])
                  
                  ## plot(covid19$Total.Samples~District2,covid19)
                 ## barplot(samples~Dist,data = covid19)
                ##})
 
        output$mybb2 <- renderBillboarder({
    
           Divi1 <- data.frame(
             Div1,
              Sup_Dis<-covid19$Sample.Transporatation.supported.within.District
             )
            billboarder()%>% 
            bb_piechart(data = Divi1, bbaes(Div1, Sup_Dis))
       
           })
  
  
  output$mybb3 <- renderBillboarder({
    
    Divi1 <- data.frame(
      Div1,
      Sup_Gov<-covid19$Sample.sent.to.LAB.by.Government
    )
    billboarder()%>% 
      bb_piechart(data = Divi1, bbaes(Div1, Sup_Gov))
    
  })
  
  
  output$mybb4 <- renderBillboarder({
    
    Divi1 <- data.frame(
      Div1,
      Sup_IVD<-covid19$Samples.Sent.to.LAB.by.IVD.WHO
    )
    billboarder()%>% 
      bb_piechart(data = Divi1, bbaes(Div1, Sup_IVD))
    
  })  
  
  output$mybb5<- renderBillboarder({
    
    Divi1 <- data.frame(
      Div1,
      Sup_DV<-covid19$Number.of.Vehicles.Hired.by.DC.WHO
    )
    billboarder()%>% 
      bb_piechart(data = Divi1, bbaes(Div1, Sup_DV))
    
  }) 
  
  
  output$labnumber <- renderValueBox({
            valueBox(sum(COVID19$lab_Fun),"Number of Lab Functioning",icon=icon("hospital-o"),width = 6)
          
         })
  
  output$TotalSample <- renderValueBox({
    valueBox(sum(COVID19$Gov_sup,COVID19$who_sup),"Total Number of Sample",icon=icon("medkit"),color = "yellow",width = 6)
    
         })
  
  output$who_sup <- renderValueBox({
    valueBox(sum(COVID19$who_sup),"WHO Supported Sample Transportation",icon=icon("user-plus"), color = "orange",width = 6)
    
  })
  
  #output$Trained <- renderValueBox({
   # valueBox(sum(COVID19$staff_orient),"Total Number of Staff Oriented",icon=icon("user-plus"), color = "green",width = 6)
    
    #    })
  
  output$data1 <-DT::renderDataTable({
    covid19
         })
    
   output$result <- renderText({
    paste("You chose", input$Division)
         })
   
   output$map<-renderLeaflet({
     
     mydata<-read_excel("input_data/MAP.xlsx")
     
     mymap<-st_read("input_data/district.shp", stringsAsFactors=FALSE)
     
     str(mymap)
     
     #sample_t=mydata$Total_Sample,
     map_and_Data <- inner_join(mydata,mymap)
     
     
     #ggplot(map_and_data) +
     #geom_sf(fill=mydata$Total_Sample)
   #Number_of_Samples<-mydata$Total_Sample
   #ggplot(map_and_data) +
     #geom_sf(aes(fill= Number_of_Samples)) +
     #scale_fill_gradient(low ="yellow",high="red",na.value = NA)
     
   
   pal <- colorBin("YlOrRd", domain = map_and_data$Total_Sample, bins = 5)
   
   labels <- sprintf("%s: %g", map_and_data$DISTNAME, map_and_data$Total_Sample) %>%
     lapply(htmltools::HTML)
   
   l <- leaflet(map_and_data) %>%
     addTiles() %>%
     addPolygons(
       fillColor = ~ pal(Total_Sample),
       color = "white",
       dashArray = "3",
       fillOpacity = 0.7,
       label = labels
     ) %>%
     leaflet::addLegend(
       pal = pal, values = ~Total_Sample,
       opacity = 0.7, title = NULL
     )
   
   })
  
})
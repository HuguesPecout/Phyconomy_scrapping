library(RSelenium)
library(stringr)


rD <- rsDriver(port = 4445L, browser =  "firefox")
remDr <- rD[["client"]]
remDr$open()
Sys.sleep(5)

page <- "http://www.theses.fr/fr/?q=G%C3%A9ographie-Cit%C3%A9s&fq=dateSoutenance:[1965-01-01T23:59:59Z%2BTO%2B2022-12-31T23:59:59Z]&checkedfacets=&status=status:soutenue&access=&access=&prevision=&filtrepersonne=&zone1=titreRAs&val1=&op1=AND&zone2=auteurs&val2=&op2=AND&zone3=etabSoutenances&val3=&op3=AND&zone4=dateSoutenance&val4a=&val4b=&type="
remDr$navigate(page)


# Test
webElems <- remDr$findElement("id", "resultat")
webElems2 <- webElems$findElement("class name", "informations")
test <- unlist(str_split(webElems2$getElementText(), "\n"))

test2 <- test[test != "Accéder en ligne"]
test3 <- test2[str_detect(test2, "...")]
test4 <- test3[!str_detect(test3, "\\.\\.\\.")]

counter <- seq(0,140,10)
javascript:encode('&start=100')

webElems <- remDr$findElement(using = 'xpath' , "//div[@id='FLOWCHART2014_1744_3_tableTool']")
webElems$clickElement()


Titre <- remDr$findElements(using = 'xpath' , "//div[@id='resultat']//div[@class='encart arrondi-10']//div[@class='informations']/h2/a")
unlist(Titre@value)
print()


Titre[[1]]$value[1]
ok <-
resHeaders <- unlist(lapply(webElems, function(x){x$getElementText()}))
resHeaders 
####


webElems <- remDr$findElement(using = 'class' , 'informations')

??findElement

webElems$clickElement()
webElems <- remDr$findElement(using = 'id' , 'FLOWCHART2014_1744_title')
webElems$clickElement()
webElems <- remDr$findElement(using = 'xpath' , "//span[@id='FLOWCHART2014_1744_3_title']")
webElems$clickElement()
webElems <- remDr$findElement(using = 'xpath' , "//div[@id='FLOWCHART2014_1744_3_tableTool']")
webElems$clickElement()


# webElems <- remDr$findElement(using = 'xpath' , "//div[@id='dgrid_0-row-0']/table/tr/td/div")
# webElems <- remDr$findElement(using = 'class name' , 'dgrid-row-table')
# resHeaders <- unlist(lapply(webElems, function(x){x$getElementText()}))

tt <- data.frame(NULL)
library(stringr)
# i<-3600
i <- 0
num <- seq(10,3650, 10)  
for (i in 0:3649){
  link <- paste0('dgrid_0-row-', i)  
  webElems <- remDr$findElement(using = 'id' , link)
  ok <- unlist(str_split(webElems$getElementText()[[1]][1], "\n"))
  print(i)
  print(ok)
  tt <- rbind(tt, ok)
  
  if(i %in% num){
    webElems <- remDr$findElement(using = 'id' , link)
    webElems$clickElement()
    webElems$sendKeysToElement(list(key="page_down"))
    Sys.sleep(1)
  }

}

ttt <- tt
colnames(ttt) <- c("CITY_PAIR", "Y2012", "Y2013", "Y2014", 
  "DEP3LET", "ARR3LET", "DEPARTURE", "ARRIVAL", 'NM_Dist')

write.csv(ttt, "FLOWCHART2014_2101to46512.csv")

# webElems <- remDr$findElement(using = 'class' , 'dgrid-scroller')
# webElems$sendKeysToElement(list(key = "end"))
# webElems$sendKeysToElement(list(key="down_arrow"))
# 
# 
# webElems <- remDr$findElement(using = 'id' , link)
# webElems$clickElement()
# webElems$sendKeysToElement(list(key="page_down"))
# webElems$sendKeysToElement(list(key="page_down"))
# webElems$sendKeysToElement(list(key="page_down"))
# webElems$sendKeysToElement(list(key="page_down"))
# webElems$sendKeysToElement(list(key="page_down"))
# webElems$sendKeysToElement(list(key="page_down"))
# 
# webElems$sendKeysToElement(list(key="enter"))
# Sys.sleep(2)
# webElems$sendKeysToElement(list(key = "home"))
# 
# 
# 
# webElems <- remDr$findElement(using = 'id' , 'dgrid_0-row-0')
# webElems$getElementText()[[1]][1]
# 
# webElems <- remDr$findElement(using = 'id' , 'dgrid_0-row-1')
# webElems$getElementText()[[1]][1]
# 
# webElems <- remDr$findElement(using = 'id' , 'dgrid_0-row-2')
# webElems$getElementText()[[1]][1]
# 
# webElems <- remDr$findElement(using = 'id' , 'dgrid_0-row-3')
# webElems$getElementText()[[1]][1]
# 
# webElems <- remDr$findElement(using = 'id' , 'dgrid_0-row-4')
# webElems$getElementText()[[1]][1]
# 
# webElems <- remDr$findElement(using = 'id' , 'dgrid_0-row-5')
# webElems$getElementText()[[1]][1]
# 
# webElems <- remDr$findElement(using = 'id' , 'dgrid_0-row-6')
# webElems$getElementText()[[1]][1]
# 
# webElems <- remDr$findElement(using = 'id' , 'dgrid_0-row-7')
# webElems$getElementText()[[1]][1]
# 
# webElems <- remDr$findElement(using = 'id' , 'dgrid_0-row-8')
# webElems$getElementText()[[1]][1]
# 
# webElems <- remDr$findElement(using = 'id' , 'dgrid_0-row-9')
# webElems$getElementText()[[1]][1]
# 
# webElems <- remDr$findElement(using = 'id' , 'dgrid_0-row-10')
# webElems$getElementText()[[1]][1]
# 
# webElems <- remDr$findElement(using = 'id' , 'dgrid_0-row-11')
# webElems$getElementText()[[1]][1]
# 
# webElems <- remDr$findElement(using = 'id' , 'dgrid_0-row-12')
# webElems$getElementText()[[1]][1]
# 
# webElems <- remDr$findElement(using = 'id' , 'dgrid_0-row-13')
# webElems$getElementText()[[1]][1]
# 
# webElems <- remDr$findElement(using = 'id' , 'dgrid_0-row-14')
# webElems$getElementText()[[1]][1]
# 
# webElems <- remDr$findElement(using = 'id' , 'dgrid_0-row-15')
# webElems$getElementText()[[1]][1]


################################
# Deconnexion/fermeture du navigateur
remDr$close()
# stop the selenium server
rD[["server"]]$stop()


###### Table 2
remDr$navigate(page)
Sys.sleep(5)

webElems <- remDr$findElement(using = 'id' , 'webmap-details-legend-content')
webElems$clickElement()
webElems <- remDr$findElement(using = 'id' , 'FLOWCHART2014_1744_title')
webElems$clickElement()
webElems <- remDr$findElement(using = 'xpath' , "//span[@id='FLOWCHART2014_1744_4_title']")
webElems$clickElement()
webElems <- remDr$findElement(using = 'xpath' , "//div[@id='FLOWCHART2014_1744_4_tableTool']")
webElems$clickElement()


tt2 <- data.frame(NULL)
library(stringr)
# i<-3600
i <- 0
num <- seq(10,4799, 10)  
for (i in 0:4799){
  link <- paste0('dgrid_0-row-', i)  
  webElems <- remDr$findElement(using = 'id' , link)
  ok <- unlist(str_split(webElems$getElementText()[[1]][1], "\n"))
  print(i)
  print(ok)
  tt2 <- rbind(tt2, ok)
  
  if(i %in% num){
    webElems <- remDr$findElement(using = 'id' , link)
    webElems$clickElement()
    webElems$sendKeysToElement(list(key="page_down"))
    Sys.sleep(1)
  }
  
}

ttt <- tt2
colnames(ttt) <- c("CITY_PAIR", "Y2012", "Y2013", "Y2014", 
                   "DEP3LET", "ARR3LET", "DEPARTURE", "ARRIVAL", 'NM_Dist')

write.csv(ttt, "FLOWCHART2014_1001to2100.csv")

###### Table 3
library(RSelenium)
remDr <- remoteDriver( port = 4445L, browserName = "firefox")
remDr$open()
page <- "https://icao.maps.arcgis.com/home/webmap/viewer.html?webmap=001e485610484d198c91f0703bc5740a"
remDr$navigate(page)
Sys.sleep(3)


webElems <- remDr$findElement(using = 'id' , 'webmap-details-legend-content')
webElems$clickElement()
webElems <- remDr$findElement(using = 'id' , 'FLOWCHART2014_1744_title')
webElems$clickElement()
webElems <- remDr$findElement(using = 'xpath' , "//span[@id='FLOWCHART2014_1744_5_title']")
webElems$clickElement()
webElems <- remDr$findElement(using = 'xpath' , "//div[@id='FLOWCHART2014_1744_5_tableTool']")
webElems$clickElement()
Sys.sleep(5)


# webElems2 <- remDr$findElement(using = 'id' , 'featureTable')
# webElems2$getElementAttribute('innerHTML')[[1]][1]
# 
# 
# webElems3 <- remDr$findElement(using = 'id' , 'dgrid-scroller')


tt3 <- data.frame(NULL)
library(stringr)
i<-0
num <- seq(10,7487, 10)  
for (i in 0:7487){
  link <- paste0('dgrid_0-row-', i)  
  webElems <- remDr$findElement(using = 'id' , link)
  ok <- unlist(str_split(webElems$getElementText()[[1]][1], "\n"))
  print(i)
  print(ok)
  tt3 <- rbind(tt3, ok)
  
  if(i %in% num){
    webElems <- remDr$findElement(using = 'id' , link)
    webElems$clickElement()
    webElems$sendKeysToElement(list(key="page_down"))
    Sys.sleep(1.5)
  }
  
}



ttt <- unique(tt3)
colnames(ttt) <- c("CITY_PAIR", "Y2012", "Y2013", "Y2014", 
                   "DEP3LET", "ARR3LET", "DEPARTURE", "ARRIVAL", 'NM_Dist')

write.csv(ttt, "FLOWCHART2014_401to1000.csv")

###### Table 4
rD <- rsDriver(port = 4445L, browser =  "firefox")
remDr <- rD[["client"]]
page <- "https://icao.maps.arcgis.com/home/webmap/viewer.html?webmap=001e485610484d198c91f0703bc5740a"
remDr$navigate(page)
Sys.sleep(3)


webElems <- remDr$findElement(using = 'id' , 'webmap-details-legend-content')
webElems$clickElement()
webElems <- remDr$findElement(using = 'id' , 'FLOWCHART2014_1744_title')
webElems$clickElement()
webElems <- remDr$findElement(using = 'xpath' , "//span[@id='FLOWCHART2014_1744_6_title']")
webElems$clickElement()
webElems <- remDr$findElement(using = 'xpath' , "//div[@id='FLOWCHART2014_1744_6_tableTool']")
webElems$clickElement()
Sys.sleep(3)


tt4 <- data.frame(NULL)
library(stringr)
i<-0
num <- seq(10,9056,10)  
for (i in 0:9056){
  link <- paste0('dgrid_0-row-', i)  
  webElems <- remDr$findElement(using = 'id' , link)
  ok <- unlist(str_split(webElems$getElementText()[[1]][1], "\n"))
  print(i)
  print(ok)
  tt4 <- rbind(tt4, ok)
  
  if(i %in% num){
    webElems <- remDr$findElement(using = 'id' , link)
    webElems$clickElement()
    webElems$sendKeysToElement(list(key="page_down"))
    Sys.sleep(1)
  }
  
}

ttt <- tt4
colnames(ttt) <- c("ET_ID","ID","DEP_LONG","DEP_LAT","ARR_LONG","ARR_LAT","CITY_PAIR", "Y2012", "Y2013", "Y2014", 
                   "DEP3LET", "ARR3LET", "DEPARTURE", "ARRIVAL", 'NM_Dist')

write.csv(ttt, "FLOWCHART2014_166to400.csv")

###### Table 5
rD <- rsDriver(port = 4445L, browser =  "firefox")
remDr <- rD[["client"]]
page <- "https://icao.maps.arcgis.com/home/webmap/viewer.html?webmap=001e485610484d198c91f0703bc5740a"
remDr$navigate(page)
Sys.sleep(3)


webElems <- remDr$findElement(using = 'id' , 'webmap-details-legend-content')
webElems$clickElement()
webElems <- remDr$findElement(using = 'id' , 'FLOWCHART2014_1744_title')
webElems$clickElement()
webElems <- remDr$findElement(using = 'xpath' , "//span[@id='FLOWCHART2014_1744_7_title']")
webElems$clickElement()
webElems <- remDr$findElement(using = 'xpath' , "//div[@id='FLOWCHART2014_1744_7_tableTool']")
webElems$clickElement()
Sys.sleep(3)


tt5 <- data.frame(NULL)
library(stringr)
i<-0
num <- seq(10,21558,10)  
for (i in 0:21558){
  link <- paste0('dgrid_0-row-', i)  
  webElems <- remDr$findElement(using = 'id' , link)
  ok <- unlist(str_split(webElems$getElementText()[[1]][1], "\n"))
  print(i)
  print(ok)
  tt5 <- rbind(tt5, ok)
  
  if(i %in% num){
    webElems <- remDr$findElement(using = 'id' , link)
    webElems$clickElement()
    webElems$sendKeysToElement(list(key="page_down"))
    Sys.sleep(1)
  }
  
}

ttt <- tt5
colnames(ttt) <- c("CITY_PAIR", "Y2012", "Y2013", "Y2014", 
                   "DEP3LET", "ARR3LET", "DEPARTURE", "ARRIVAL", 'NM_Dist')

write.csv(ttt, "FLOWCHART2014_1to165.csv")


#### LAT / LONG

library(RSelenium)

rD <- rsDriver(port = 4445L, browser =  "firefox")
remDr <- rD[["client"]]
page <- "https://icao.maps.arcgis.com/home/webmap/viewer.html?webmap=001e485610484d198c91f0703bc5740a"
remDr$navigate(page)
Sys.sleep(3)

webElems <- remDr$findElement(using = 'id' , 'webmap-details-legend-content')
webElems$clickElement()
webElems <- remDr$findElement(using = 'id' , 'FLOWCHART2014_1744_title')
webElems$clickElement()
webElems <- remDr$findElement(using = 'xpath' , "//span[@id='FLOWCHART2014_1744_0_title']")
webElems$clickElement()
webElems <- remDr$findElement(using = 'xpath' , "//div[@id='FLOWCHART2014_1744_0_tableTool']")
webElems$clickElement()


tt <- data.frame(NULL)
library(stringr)
# i<-3600
i <- 0
num <- seq(10,3179, 10)  
for (i in 0:3179){
  link <- paste0('dgrid_0-row-', i)  
  webElems <- remDr$findElement(using = 'id' , link)
  ok <- unlist(str_split(webElems$getElementText()[[1]][1], "\n"))
  print(i)
  print(ok)
  tt <- rbind(tt, ok)
  
  if(i %in% num){
    webElems <- remDr$findElement(using = 'id' , link)
    webElems$clickElement()
    webElems$sendKeysToElement(list(key="page_down"))
    Sys.sleep(1)
  }
  
}

ttt <- tt
colnames(ttt) <- c("CITY", "2012", "2013", "2014", 
                   "Lat", "Lont")

write.csv(ttt, "FLOWCHART2014_Mouv2014_LatLong.csv")


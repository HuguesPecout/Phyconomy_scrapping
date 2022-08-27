################################################################################
#                                                                              #     
#                          SCRAPPING Database                                  #
#                           Pyconomy Sweave                                    #
#                                                                              #
################################################################################

#------------------------ LIBRARY ---------------------------------------------#
library(RSelenium)


#--------------------------- NAVIGUATEUR --------------------------------------#
rD <- rsDriver(port = 4468L, browser =  "firefox")
remDr <- rD[["client"]]
remDr$open()
remDr$maxWindowSize()

# remDr$closeall()
# remDr$closeWindow()
# remDr$closeServer()
#--------------------------- NAVIGUATION --------------------------------------#

# webElems <- remDr$findElements(using = 'xpath' , "//div[@class='cell primary read']")
# webElems[[1]]$clickElement()
# webElems[[1]]$sendKeysToElement(list(key="home"))

page <- "https://airtable.com/shrGYaj6CikiaXEhH/tblZFNBiWgVocM5BA/viwpawOq6LL8eHnqL"
remDr$navigate(page)
Sys.sleep(5)



#------------------------------------------------------------------------------#
#---------------------------------- SCRAPING ----------------------------------#
#------------------------------------------------------------------------------#


#--------------------------- ALGAE SPECIES ------------------------------------#

#----------------------------- PREPARATION TABLE ------------------------------#

# Ouverture onglet research institutes
webElems <- remDr$findElements(using = 'xpath' , "//div[@class='flex relative flex-none text-size-default tableTabContainer darkBase']")
webElems[[7]]$clickElement()

## Clotûre du panneau View
webElems <- remDr$findElement(using = 'id' , 'viewSidebarToggleButton')
webElems$clickElement()
Sys.sleep(0.2)

## Show hidden column
# Open panel
webElems <- remDr$findElements(using = 'xpath' , "//div[@class='focus-visible mr1']")
webElems[[1]]$clickElement()
# True value setting
webElems <- remDr$findElements(using = 'xpath' , "//div[@class='flex items-center flex-auto text-blue-focus px-half rounded darken1-hover pointer']")
webElems[[3]]$clickElement()

webElems <- remDr$findElements(using = 'xpath' , "//div[@class='focus-visible mr1']")
webElems[[1]]$clickElement()

# Data frame vide
algae <- data.frame(Algae_Species=as.character(NULL))




#-------------------- COLLECT  ALGAE SPECIES  NAME --------------------------#

for (i in 1:(round(109/23,0))){

  webElems <- remDr$findElements(using = 'xpath' , "//div[@class='cell primary read']")
  Sys.sleep(0.2)
  resHeaders <- unlist(lapply(webElems, function(x){x$getElementText()}))
  resHeaders <- resHeaders[resHeaders != ""]

    algae <- rbind(algae, data.frame(Algae_Species=resHeaders))

  
  webElems <- remDr$findElements(using = 'xpath' , "//div[@class='cell read']")
  webElems[[1]]$clickElement()
  Sys.sleep(0.6)
  webElems[[1]]$sendKeysToElement(list(key="page_down"))
  Sys.sleep(0.7)
  
}


algae2 <- unique(algae)
algae2$ID <- 1:nrow(algae2)
algae2 <- algae2[,2:1]








# webElems <- remDr$findElements(using = 'xpath' , "//div[@class='flex relative flex-none text-size-default tableTabContainer darkBase']")
# webElems[[2]]$clickElement()
# webElems <- remDr$findElements(using = 'xpath' , "//div[@class='flex relative flex-none text-size-default tableTabContainer darkBase']")
# webElems[[7]]$clickElement()


#----------------- COLLECT OTHER VARIABLE PARTIE 1-----------------------------#

# Click première ligne première colonne
webElems[[1]]$sendKeysToElement(list(key="home"))
webElems <- remDr$findElements(using = 'xpath' , "//div[@class='cell primary read']")
webElems[[24]]$clickElement()




# Creation dtata frame vide
algae3 <- data.frame(NULL)

# Boucle de scraping

for (i in 1:(round(109/23,0))){

webElems <- remDr$findElements(using = 'xpath' , "//div[@class='cell read']")
resHeaders <- unlist(lapply(webElems, function(x){x$getElementText()}))
resHeaders

if(i==1){

mat <- matrix(resHeaders[c(6:120)], 23, byrow = TRUE)
test <- as.data.frame(mat, stringsAsFactors = FALSE)
test <- test[order(nrow(test):1),]


} else if (i==2) {
  
  mat <- matrix(resHeaders[c(1:5,21:130)], 23, byrow = TRUE)
  test <- as.data.frame(mat, stringsAsFactors = FALSE)

} else if (i==5) {

  mat <- matrix(resHeaders[c(11:105)], 19, byrow = TRUE)
  test <- as.data.frame(mat, stringsAsFactors = FALSE)
  test <- test[3:nrow(test),]
} else {
  
  mat <- matrix(resHeaders[c(16:130)], 23, byrow = TRUE)
  test <- as.data.frame(mat, stringsAsFactors = FALSE)
  
}
 
webElems2 <- remDr$findElements(using = 'xpath' , "//div[@class='headerRow rightPane']")
resHeaders2 <- unlist(lapply(webElems2, function(x){x$getElementText()})) 
v <- unlist(strsplit(resHeaders2, split = "\n"))
colnames(test) <- v[c(1,2,6,3,4)]

algae3 <- rbind(algae3, test)
  
webElems[[1]]$sendKeysToElement(list(key="page_down"))
Sys.sleep(0.8)

}

algae4 <- cbind(algae2, algae3)
write.csv(algae4, file = "Algae_Species.csv", row.names = TRUE)


#------------------------- COLLECT FINAL COLUMN -----------------------------#

# Click première ligne première colonne
webElems[[1]]$sendKeysToElement(list(key="home"))



last <- c(NULL)

for (i in 1:(round(109/23,0))){
  
  webElems <- remDr$findElements(using = 'xpath' , "//div[@class='cell read lastColumn']")
  resHeaders <- unlist(lapply(webElems, function(x){x$getElementText()}))
  resHeaders
  
  if(i==1){
    
    last <- c(last, rev(resHeaders[2:24]) )

    
  } else if (i == 2 ){ 
    
    last <- c(last, resHeaders[c(1,5:26)] )
    
  } else if (i ==5 ){ 
    
    last <- c(last, resHeaders[c(5:21)] )
    
    
  } else  {
    
    last <- c(last, resHeaders[c(4:26)] )
  
  }
  
  webElems <- remDr$findElements(using = 'xpath' , "//div[@class='cell primary selected cursor read']")
  webElems[[1]]$sendKeysToElement(list(key="page_down"))
  Sys.sleep(0.7)
  
}






algae4$Common_name <- last
write.csv(algae4, file = "Algae_Species.csv", row.names = TRUE)



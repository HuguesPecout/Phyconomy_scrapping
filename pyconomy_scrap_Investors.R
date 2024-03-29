################################################################################
#                                                                              #     
#                          SCRAPPING Database                                  #
#                           Pyconomy Sweave                                    #
#                                                                              #
################################################################################

#------------------------ LIBRARY ---------------------------------------------#
library(RSelenium)


#--------------------------- NAVIGUATEUR --------------------------------------#
rD <- rsDriver(port = 4458L, browser =  "firefox")
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
Sys.sleep(2)



#------------------------------------------------------------------------------#
#---------------------------------- SCRAPING ----------------------------------#
#------------------------------------------------------------------------------#


#-------------------------------- Investors -----------------------------------#

#----------------------------- PREPARATION TABLE ------------------------------#

# Ouverture onglet research institutes
webElems <- remDr$findElements(using = 'xpath' , "//div[@class='flex relative flex-none text-size-default tableTabContainer darkBase']")
webElems[[2]]$clickElement()

## Clotûre du panneau View
webElems <- remDr$findElement(using = 'id' , 'viewSidebarToggleButton')
webElems$clickElement()
Sys.sleep(0.2)


# Data frame vide
investors <- data.frame(Name=as.character(NULL))





#-------------------- COLLECT INVESTORS NAME --------------------------#

for (i in 1:(round(179/36,0))){

  webElems <- remDr$findElements(using = 'xpath' , "//div[@class='cell primary read']")
  Sys.sleep(0.2)
  resHeaders <- unlist(lapply(webElems, function(x){x$getElementText()}))
  # resHeaders <- resHeaders[resHeaders != ""]
  
  if (i == 1){
    investors <- rbind(investors, data.frame(Name = resHeaders[1:36]))
    
  } else {
  investors <- rbind(investors, data.frame(Name = resHeaders[4:39]))
  
  }
  
  webElems <- remDr$findElements(using = 'xpath' , "//div[@class='cell read']")
  webElems[[1]]$clickElement()
  Sys.sleep(0.6)
  webElems[[1]]$sendKeysToElement(list(key="page_down"))
  Sys.sleep(0.7)
  
}


investors2 <- data.frame(Name = investors[1:179,])
investors2$ID <- 1:nrow(investors2)
investors2 <- investors2[,2:1]





## Show hidden column
# Open panel
webElems <- remDr$findElements(using = 'xpath' , "//div[@class='focus-visible mr1']")
webElems[[1]]$clickElement()
# True value setting
webElems <- remDr$findElements(using = 'xpath' , "//div[@class='flex items-center flex-auto text-blue-focus px-half rounded darken1-hover pointer']")
webElems[[7]]$clickElement()

webElems <- remDr$findElements(using = 'xpath' , "//div[@class='focus-visible mr1']")
webElems[[1]]$clickElement()

Sys.sleep(1)

webElems <- remDr$findElements(using = 'xpath' , "//div[@class='flex relative flex-none text-size-default tableTabContainer darkBase']")
webElems[[2]]$clickElement()
webElems <- remDr$findElements(using = 'xpath' , "//div[@class='flex relative flex-none text-size-default tableTabContainer darkBase']")
webElems[[2]]$clickElement()


#----------------- COLLECT OTHER VARIABLE PARTIE 1-----------------------------#

# Click première ligne première colonne
webElems <- remDr$findElements(using = 'xpath' , "//div[@class='cell primary read']")
webElems[[1]]$clickElement()
webElems[[1]]$sendKeysToElement(list(key="home"))
Sys.sleep(2)
webElems <- remDr$findElements(using = 'xpath' , "//div[@class='cell primary selected cursor read']")
webElems[[1]]$clickElement()



# Creation dtata frame vide
investors3 <- data.frame(NULL)

# Boucle de scraping

for (i in 1:(round(179/36,0))){

webElems <- remDr$findElements(using = 'xpath' , "//div[@class='cell read']")
resHeaders <- unlist(lapply(webElems, function(x){x$getElementText()}))
resHeaders

if(i==1){

mat <- matrix(resHeaders[c(1:108)], 36, byrow = TRUE)
test <- as.data.frame(mat, stringsAsFactors = FALSE)
test <- test[order(nrow(test):1),]

mat2 <- matrix(resHeaders[c(118:189)], 36, byrow = TRUE)
test2 <- as.data.frame(mat2, stringsAsFactors = FALSE)
test2 <- test2[order(nrow(test2):1),]

test <- cbind(test,test2)

} else if (i==5) {
  
  
  mat <- matrix(resHeaders[c(10:117)], 36, byrow = TRUE)
  test <- as.data.frame(mat, stringsAsFactors = FALSE)

  mat2 <- matrix(resHeaders[c(121:192)], 36, byrow = TRUE)
  test2 <- as.data.frame(mat2, stringsAsFactors = FALSE)


  test <- cbind(test,test2)

} else {
  
  mat <- matrix(resHeaders[c(10:117)], 36, byrow = TRUE)
  test <- as.data.frame(mat, stringsAsFactors = FALSE)
  
  mat2 <- matrix(resHeaders[c(133:204)], 36, byrow = TRUE)
  test2 <- as.data.frame(mat2, stringsAsFactors = FALSE)

  
  test <- cbind(test,test2)

}
  
colnames(test) <- c("Headquarters", "Of investments", "Investments", "Type", "Focus" )
  
investors3 <- rbind(investors3, test)
  
webElems[[1]]$sendKeysToElement(list(key="page_down"))
Sys.sleep(0.4)

}


investors4 <- cbind(investors2, investors3[1:179,])
# write.csv(investors4, file = "Investors.csv", row.names = TRUE)


#------------------------- COLLECT FINAL COLUMN -----------------------------#

# Click première ligne première colonne
webElems <- remDr$findElements(using = 'xpath' , "//div[@class='cell primary read']")
webElems[[1]]$clickElement()
webElems[[1]]$sendKeysToElement(list(key="home"))
webElems <- remDr$findElements(using = 'xpath' , "//div[@class='cell primary selected cursor read']")
webElems[[1]]$clickElement()


last <- c(NULL)

for (i in 1:(round(179/36,0))){
  
  webElems <- remDr$findElements(using = 'xpath' , "//div[@class='cell read lastColumn']")
  resHeaders <- unlist(lapply(webElems, function(x){x$getElementText()}))
  resHeaders
  
  if(i==1){
    
    last <- c(last, rev(resHeaders[1:36]) )

    
  } else if (i == 5){ 
    
    last <- c(last, resHeaders[c(4:39)] )
    
    
  } else  {
    
    last <- c(last, resHeaders[c(4:39)] )
  
  }
  
  webElems <- remDr$findElements(using = 'xpath' , "//div[@class='cell primary selected cursor read']")
  webElems[[1]]$sendKeysToElement(list(key="page_down"))
  Sys.sleep(0.4)
  
}





investors4$Website <- last[1:179]
write.csv(investors4, file = "Phyconomy_data/Investors.csv", row.names = TRUE)



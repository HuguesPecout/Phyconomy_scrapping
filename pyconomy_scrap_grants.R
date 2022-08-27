################################################################################
#                                                                              #     
#                          SCRAPPING Database                                  #
#                           Pyconomy Sweave                                    #
#                                                                              #
################################################################################

#------------------------ LIBRARY ---------------------------------------------#
library(RSelenium)


#--------------------------- NAVIGUATEUR --------------------------------------#
rD <- rsDriver(port = 4436L, browser =  "firefox")
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


#----------------------------------- GRANTS -----------------------------------#

#----------------------------- PREPARATION TABLE ------------------------------#

# Ouverture onglet research institutes
webElems <- remDr$findElements(using = 'xpath' , "//div[@class='flex relative flex-none text-size-default tableTabContainer darkBase']")
webElems[[3]]$clickElement()

## Clotûre du panneau View
webElems <- remDr$findElement(using = 'id' , 'viewSidebarToggleButton')
webElems$clickElement()
Sys.sleep(0.2)


# Data frame vide
Grants <- data.frame(Name=as.character(NULL))





#-------------------- COLLECT GRANTS NAME --------------------------#

for (i in 1:(round(286/23,0)+1)){

  webElems <- remDr$findElements(using = 'xpath' , "//div[@class='cell primary read']")
  Sys.sleep(0.2)
  resHeaders <- unlist(lapply(webElems, function(x){x$getElementText()}))
  # resHeaders <- resHeaders[resHeaders != ""]
  
  if (i == 1){
    Grants <- rbind(Grants, data.frame(Amount = resHeaders[1:23]))
  } else {
  Grants <- rbind(Grants, data.frame(Amount = resHeaders[4:26]))
  
  }
  
  webElems <- remDr$findElements(using = 'xpath' , "//div[@class='cell read']")
  webElems[[1]]$clickElement()
  Sys.sleep(0.6)
  webElems[[1]]$sendKeysToElement(list(key="page_down"))
  Sys.sleep(0.7)
  
}


Grants2 <- data.frame(Amout = Grants[c(1:275,284:294),])
Grants2$ID <- 1:nrow(Grants2)
Grants2 <- Grants2[,2:1]




# Up to haut de page
webElems <- remDr$findElements(using = 'xpath' , "//div[@class='cell primary read']")
webElems[[1]]$clickElement()
webElems[[1]]$sendKeysToElement(list(key="home"))


#----------------- COLLECT OTHER VARIABLE PARTIE 1-----------------------------#

# Click première ligne première colonne
webElems <- remDr$findElements(using = 'xpath' , "//div[@class='cell primary read']")
webElems[[1]]$clickElement()
webElems[[1]]$sendKeysToElement(list(key="home"))


# for (i in 1:8){
#   webElems[[1]]$sendKeysToElement(list(key="right_arrow"))
# }
# for (i in 1:8){
#   webElems[[1]]$sendKeysToElement(list(key="left_arrow"))
# }

# Creation dtata frame vide
Grants3 <- data.frame(NULL)

# Boucle de scraping

for (i in 1:(round(286/23,0)+1)){

webElems <- remDr$findElements(using = 'xpath' , "//div[@class='cell read']")
resHeaders <- unlist(lapply(webElems, function(x){x$getElementText()}))
resHeaders

if(i==1){

mat <- matrix(resHeaders[c(7:144)], 23, byrow = TRUE)
test <- as.data.frame(mat, stringsAsFactors = FALSE)
test <- test[order(nrow(test):1),]

} else if (i==2) {
  
mat <- matrix(resHeaders[c(1:6,25:156)], 23, byrow = TRUE)
test <- as.data.frame(mat, stringsAsFactors = FALSE)


} else if (i==13) {

  mat <- matrix(resHeaders[c(19:156)], 23, byrow = TRUE)
  test <- as.data.frame(mat, stringsAsFactors = FALSE)

} else {
  
  mat <- matrix(resHeaders[c(19:156)], 23, byrow = TRUE)
  test <- as.data.frame(mat, stringsAsFactors = FALSE)

  
}
  
webElems2 <- remDr$findElements(using = 'xpath' , "//div[@class='headerRow rightPane']")
resHeaders2 <- unlist(lapply(webElems2, function(x){x$getElementText()}))
colnames(test) <-unlist(strsplit(resHeaders2, split = "\n"))
  
Grants3 <- rbind(Grants3, test)
  
webElems[[1]]$sendKeysToElement(list(key="page_down"))
Sys.sleep(0.8)
# Click première ligne première colonne
# webElems <- remDr$findElements(using = 'xpath' , "//div[@class='cell primary selected cursor read']")
# webElems[[1]]$clickElement()
}


Grants4 <- Grants3[c(1:275,284:294),]

Grants_F <- cbind(Grants2, Grants4)
write.csv(Grants_F, file = "Grants.csv", row.names = TRUE)



#----------------- COLLECT OTHER VARIABLE PARTIE 2 ----------------------------#




################################################################################
################################################################################

#--------------------------- NAVIGUATEUR --------------------------------------#
rD <- rsDriver(port = 4462L, browser =  "firefox")
remDr <- rD[["client"]]

remDr$maxWindowSize()
page <- "https://airtable.com/shrGYaj6CikiaXEhH/tblZFNBiWgVocM5BA/viwpawOq6LL8eHnqL"
remDr$navigate(page)
Sys.sleep(5)

# Clotûre du panneau View
webElems <- remDr$findElement(using = 'id' , 'viewSidebarToggleButton')
webElems$clickElement()
Sys.sleep(0.2)

webElems <- remDr$findElements(using = 'xpath' , "//div[@class='flex relative flex-none text-size-default tableTabContainer darkBase']")
webElems[[3]]$clickElement()


## Show hidden column
# Open panel
webElems <- remDr$findElements(using = 'xpath' , "//div[@class='focus-visible mr1']")
webElems[[1]]$clickElement()
# True value setting
webElems <- remDr$findElements(using = 'xpath' , "//div[@class='flex items-center flex-auto text-blue-focus px-half rounded darken1-hover pointer']")
for (i in c(1:6)){
  webElems[[i]]$clickElement()
}
webElems <- remDr$findElements(using = 'xpath' , "//div[@class='focus-visible mr1']")
webElems[[1]]$clickElement()


# Click première ligne première colonne
webElems <- remDr$findElements(using = 'xpath' , "//div[@class='cell primary read']")
webElems[[1]]$clickElement()
webElems[[1]]$sendKeysToElement(list(key="home"))




# Creation dtata frame vide
Grantsoth <- data.frame(NULL)

# Boucle de scraping

for (i in 1:(round(286/23,0)+1)){
  
  webElems <- remDr$findElements(using = 'xpath' , "//div[@class='cell read']")
  resHeaders <- unlist(lapply(webElems, function(x){x$getElementText()}))
  resHeaders
  
  if(i==1){
    
    mat <- matrix(resHeaders[c(1:92)], 23, byrow = TRUE)
    test <- as.data.frame(mat, stringsAsFactors = FALSE)
    
    
  } else {
    
    mat <- matrix(resHeaders[c(13:104)], 23, byrow = TRUE)
    test <- as.data.frame(mat, stringsAsFactors = FALSE)
    
    
  }
  
  webElems2 <- remDr$findElements(using = 'xpath' , "//div[@class='headerRow rightPane']")
  resHeaders2 <- unlist(lapply(webElems2, function(x){x$getElementText()}))
  colnames(test) <-unlist(strsplit(resHeaders2, split = "\n"))[-5]
  
  Grantsoth <- rbind(Grantsoth, test)
  
  webElems[[1]]$sendKeysToElement(list(key="page_down"))
  Sys.sleep(0.8)
  # Click première ligne première colonne
  # webElems <- remDr$findElements(using = 'xpath' , "//div[@class='cell primary selected cursor read']")
  # webElems[[1]]$clickElement()
}


Grantsoth_f <- Grantsoth[c(1:276,285:294),]


Grants_F <- cbind(Grants_F, Grantsoth_f)
write.csv(Grants_F, file = "Grants.csv", row.names = TRUE)


#------------------------- COLLECT FINAL COLUMN -----------------------------#

rD <- rsDriver(port = 4464L, browser =  "firefox")
remDr <- rD[["client"]]

remDr$maxWindowSize()
page <- "https://airtable.com/shrGYaj6CikiaXEhH/tblZFNBiWgVocM5BA/viwpawOq6LL8eHnqL"
remDr$navigate(page)
Sys.sleep(5)

# Clotûre du panneau View
webElems <- remDr$findElement(using = 'id' , 'viewSidebarToggleButton')
webElems$clickElement()
Sys.sleep(0.2)

webElems <- remDr$findElements(using = 'xpath' , "//div[@class='flex relative flex-none text-size-default tableTabContainer darkBase']")
webElems[[3]]$clickElement()


## Show hidden column
# Open panel
webElems <- remDr$findElements(using = 'xpath' , "//div[@class='focus-visible mr1']")
webElems[[1]]$clickElement()
# True value setting
webElems <- remDr$findElements(using = 'xpath' , "//div[@class='flex items-center flex-auto text-blue-focus px-half rounded darken1-hover pointer']")
for (i in c(1:6)){
  webElems[[i]]$clickElement()
}
webElems <- remDr$findElements(using = 'xpath' , "//div[@class='focus-visible mr1']")
webElems[[1]]$clickElement()


# Click première ligne première colonne
webElems <- remDr$findElements(using = 'xpath' , "//div[@class='cell primary read']")
webElems[[1]]$clickElement()
webElems[[1]]$sendKeysToElement(list(key="home"))



last <- c(NULL)

for (i in 1:(round(286/23,0)+1)){
  
  webElems <- remDr$findElements(using = 'xpath' , "//div[@class='cell read lastColumn']")
  resHeaders <- unlist(lapply(webElems, function(x){x$getElementText()}))
  resHeaders
  
  if(i==1){
    
    last <- c(last, resHeaders[1:23] )
    
  } else if (i == 13 ) {
    
    last <- c(last, resHeaders[c(4:26)] )
    
  } else { 
    
    last <- c(last, resHeaders[c(4:26)] )
  
  }
  
  webElems <- remDr$findElements(using = 'xpath' , "//div[@class='cell primary selected cursor read']")
  webElems[[1]]$sendKeysToElement(list(key="page_down"))
  Sys.sleep(0.7)
  
}



last_F <- last[c(1:276,285:294)]


Grants_F$Source_2 <- last_F
write.csv(Grants_F, file = "Grants.csv", row.names = TRUE)



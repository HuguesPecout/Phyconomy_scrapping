################################################################################
#                                                                              #     
#                          SCRAPPING Database                                  #
#                           Pyconomy Sweave                                    #
#                                                                              #
################################################################################

#------------------------ LIBRARY ---------------------------------------------#
library(RSelenium)


#--------------------------- NAVIGUATEUR --------------------------------------#
rD <- rsDriver(port = 4441L, browser =  "firefox")
remDr <- rD[["client"]]
remDr$open()
remDr$maxWindowSize()

# remDr$closeall()
# remDr$closeWindow()
# remDr$closeServer()
#--------------------------- NAVIGUATION --------------------------------------#
page <- "https://airtable.com/shrGYaj6CikiaXEhH/tblZFNBiWgVocM5BA/viwpawOq6LL8eHnqL"
remDr$navigate(page)
Sys.sleep(5)



#------------------------------------------------------------------------------#
#---------------------------------- SCRAPING ----------------------------------#
#------------------------------------------------------------------------------#


#---------------------------- RESEARCH INSTITUTES -----------------------------#

#----------------------------- PREPARATION TABLE ------------------------------#

# Ouverture onglet research institutes
webElems <- remDr$findElements(using = 'xpath' , "//div[@class='flex relative flex-none text-size-default tableTabContainer darkBase']")
webElems[[6]]$clickElement()

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
for (i in c(5:8)){
  webElems[[i]]$clickElement()
}
webElems <- remDr$findElements(using = 'xpath' , "//div[@class='focus-visible mr1']")
webElems[[1]]$clickElement()

# Data frame vide
Institutes <- data.frame(Name=as.character(NULL))





#-------------------- COLLECT RESARCH INSTITUES NAME --------------------------#

for (i in 1:(round(224/23,0))){

  webElems <- remDr$findElements(using = 'xpath' , "//div[@class='cell primary read']")
  Sys.sleep(0.2)
  resHeaders <- unlist(lapply(webElems, function(x){x$getElementText()}))
  resHeaders <- resHeaders[resHeaders != ""]
  Institutes <- rbind(Institutes, data.frame(resHeaders) )
  
  webElems <- remDr$findElements(using = 'xpath' , "//div[@class='cell read']")
  webElems[[1]]$clickElement()
  Sys.sleep(0.6)
  webElems[[1]]$sendKeysToElement(list(key="page_down"))
  Sys.sleep(0.7)
  
}

duplicated(Institutes)
# Suppression des doublons
Institutes <- unique(Institutes)

Institutes$ID <- 1:nrow(Institutes)

Institutes <- Institutes[,2:1]

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
Inst_oth <- data.frame(NULL)

# Boucle de scraping

for (i in 1:(round(224/23,0))){

webElems <- remDr$findElements(using = 'xpath' , "//div[@class='cell read']")
resHeaders <- unlist(lapply(webElems, function(x){x$getElementText()}))

if(i==1){

mat <- matrix(resHeaders[c(8:168)], 23, byrow = TRUE)
test <- as.data.frame(mat, stringsAsFactors = FALSE)
test <- test[order(nrow(test):1),]

} else if (i==2) {
  
mat <- matrix(resHeaders[c(1:7,29:182)], 23, byrow = TRUE)
test <- as.data.frame(mat, stringsAsFactors = FALSE)


} else (i==10) {
  29-147
  118/7
  mat <- matrix(resHeaders[c(29:147)], 17, byrow = TRUE)
  test <- as.data.frame(mat, stringsAsFactors = FALSE)

} else {
  
  mat <- matrix(resHeaders[c(22:182)], 23, byrow = TRUE)
  test <- as.data.frame(mat, stringsAsFactors = FALSE)

  
}
  
webElems2 <- remDr$findElements(using = 'xpath' , "//div[@class='headerRow rightPane']")
resHeaders2 <- unlist(lapply(webElems2, function(x){x$getElementText()}))
colnames(test) <-unlist(strsplit(resHeaders2, split = "\n"))[-8]
  
Inst_oth<- rbind(Inst_oth, test)
  
webElems[[1]]$sendKeysToElement(list(key="page_down"))
Sys.sleep(0.8)
# Click première ligne première colonne
# webElems <- remDr$findElements(using = 'xpath' , "//div[@class='cell primary selected cursor read']")
# webElems[[1]]$clickElement()
}


# Comp_oth2 <- unique(Comp_oth)
# rownames(Inst_oth) <- 1:nrow(Inst_oth)
# Comp_oth2 <- Comp_oth[c(1:1137,1153:nrow(Comp_oth)),]
# rownames(Comp_oth2) <- 1:nrow(Comp_oth2)


OK2 <- cbind(Institutes, Inst_oth)
write.csv(OK2, file = "institutes.csv", row.names = TRUE)



#----------------- COLLECT OTHER VARIABLE PARTIE 2 ----------------------------#




################################################################################
################################################################################

#--------------------------- NAVIGUATEUR --------------------------------------#
rD <- rsDriver(port = 4458L, browser =  "firefox")
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
webElems[[6]]$clickElement()


## Show hidden column
# Open panel
webElems <- remDr$findElements(using = 'xpath' , "//div[@class='focus-visible mr1']")
webElems[[1]]$clickElement()
# True value setting
webElems <- remDr$findElements(using = 'xpath' , "//div[@class='flex items-center flex-auto text-blue-focus px-half rounded darken1-hover pointer']")
for (i in c(1:4,8)){
  webElems[[i]]$clickElement()
}
webElems <- remDr$findElements(using = 'xpath' , "//div[@class='focus-visible mr1']")
webElems[[1]]$clickElement()




# Click première ligne première colonne
webElems <- remDr$findElements(using = 'xpath' , "//div[@class='cell primary read']")
webElems[[1]]$clickElement()
webElems[[1]]$sendKeysToElement(list(key="home"))
webElems <- remDr$findElements(using = 'xpath' , "//div[@class='cell primary selected cursor read']")
webElems[[1]]$clickElement()

last <- c(NULL)

#------------------------- COLLECT COMPAGNIE NAME -----------------------------#

for (i in 1:(round(224/23,0))){
  
  webElems <- remDr$findElements(using = 'xpath' , "//div[@class='cell read lastColumn']")
  Sys.sleep(0.2)
  resHeaders <- unlist(lapply(webElems, function(x){x$getElementText()}))
  
  if(i==1){
    
    last <- c(last, resHeaders[1:23] )
    
  } else if (i==round(224/23,0)) {
    
    last <- c(last, resHeaders[5:26] )
    
  } else {
    
    last <- c(last, resHeaders[4:26] )
    
  }
  
  length(resHeaders[3:25])
  
  webElems <- remDr$findElements(using = 'xpath' , "//div[@class='cell primary selected cursor read']")
  webElems[[1]]$sendKeysToElement(list(key="page_down"))
  Sys.sleep(0.7)
  
}
dd <- as.data.frame( last)
View(dd)


OK2$value.chain <- last[1:224]
# 
# write.csv(test, "institute.csv")

# remDr$close()
# 
# OK2 <- cbind(OK2, Inst_oth_last)
write.csv(OK2, file = "institutes.csv", row.names = FALSE)

yy <- read.csv("institutes.csv")
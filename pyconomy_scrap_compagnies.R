################################################################################
#                                                                              #     
#                          SCRAPPING Database                                  #
#                           Pyconomy Sweave                                    #
#                                                                              #
################################################################################

#------------------------ LIBRARY ---------------------------------------------#
library(RSelenium)


#--------------------------- NAVIGUATEUR --------------------------------------#
rD <- rsDriver(port = 4445L, browser =  "firefox")
remDr <- rD[["client"]]
remDr$open()
remDr$maxWindowSize()


#--------------------------- NAVIGUATION --------------------------------------#
page <- "https://airtable.com/shrGYaj6CikiaXEhH/tblZFNBiWgVocM5BA/viwpawOq6LL8eHnqL"
remDr$navigate(page)
Sys.sleep(5)



#------------------------------------------------------------------------------#
#---------------------------------- SCRAPING ----------------------------------#
#------------------------------------------------------------------------------#


#-------------------------------- COMPAGNIES ----------------------------------#

#----------------------------- PREPARATION TABLE ------------------------------#
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
for (i in c(13,16:21)){
  webElems[[i]]$clickElement()
}
webElems <- remDr$findElements(using = 'xpath' , "//div[@class='focus-visible mr1']")
webElems[[1]]$clickElement()

# Data frame vide
Compagnies <- data.frame(Name=as.character(NULL))





#------------------------- COLLECT COMPAGNIE NAME -----------------------------#

for (i in 1:(round(1168/35,0)+1)){

  webElems <- remDr$findElements(using = 'xpath' , "//div[@class='cell primary read']")
  Sys.sleep(0.2)
  resHeaders <- unlist(lapply(webElems, function(x){x$getElementText()}))
  resHeaders <- resHeaders[resHeaders != ""]
  Compagnies <- rbind(Compagnies, data.frame(resHeaders) )
  
  webElems <- remDr$findElements(using = 'xpath' , "//div[@class='cell read']")
  webElems[[1]]$clickElement()
  Sys.sleep(0.6)
  webElems[[1]]$sendKeysToElement(list(key="page_down"))
  Sys.sleep(0.7)
  
}

# Suppression des doublons
Compagnies_ok <- unique(Compagnies)

# Up to haut de page
webElems <- remDr$findElements(using = 'xpath' , "//div[@class='cell primary read']")
webElems[[1]]$clickElement()
webElems[[1]]$sendKeysToElement(list(key="home"))


#----------------- COLLECT OTHER VARIABLE PARTIE 1-----------------------------#
# Click première ligne première colonne
webElems <- remDr$findElements(using = 'xpath' , "//div[@class='cell primary read']")
webElems[[1]]$clickElement()
webElems[[1]]$sendKeysToElement(list(key="home"))


# Creation dtata frame vide
Comp_oth <- data.frame(NULL)

# Boucle de scraping

for (i in 1:(round(1168/36,0)+1)){

webElems <- remDr$findElements(using = 'xpath' , "//div[@class='cell read']")
resHeaders <- unlist(lapply(webElems, function(x){x$getElementText()}))

if(i==1){

mat <- matrix(resHeaders[c(1:324)], 36, byrow = TRUE)
test <- as.data.frame(mat, stringsAsFactors = FALSE)
test <- test[order(nrow(test):1),]

} else if (i==33) {
  
mat <- matrix(resHeaders[c(163:306)], 16, byrow = TRUE)
test <- as.data.frame(mat, stringsAsFactors = FALSE)


} else {
  
  mat <- matrix(resHeaders[c(28:351)], 36, byrow = TRUE)
  test <- as.data.frame(mat, stringsAsFactors = FALSE)
  
  
}
  
webElems2 <- remDr$findElements(using = 'xpath' , "//div[@class='headerRow rightPane']")
resHeaders2 <- unlist(lapply(webElems2, function(x){x$getElementText()}))
colnames(test) <-unlist(strsplit(resHeaders2, split = "\n"))
  
Comp_oth <- rbind(Comp_oth, test)
  
webElems[[1]]$sendKeysToElement(list(key="page_down"))
Sys.sleep(0.8)
# Click première ligne première colonne
# webElems <- remDr$findElements(using = 'xpath' , "//div[@class='cell primary selected cursor read']")
# webElems[[1]]$clickElement()
}


# Comp_oth2 <- unique(Comp_oth)
rownames(Comp_oth ) <- 1:nrow(Comp_oth )
# Comp_oth2 <- Comp_oth[c(1:1137,1153:nrow(Comp_oth)),]
# rownames(Comp_oth2) <- 1:nrow(Comp_oth2)


OK <- cbind(Compagnies_ok, Comp_oth)
write.csv(OK, file = "compagnies.csv", row.names = TRUE)




#----------------- COLLECT OTHER VARIABLE PARTIE 2 ----------------------------#

# Click première ligne première colonne
webElems <- remDr$findElements(using = 'xpath' , "//div[@class='cell primary read']")
webElems[[1]]$clickElement()
webElems[[1]]$sendKeysToElement(list(key="home"))
for (i in 1:21){
  webElems[[1]]$sendKeysToElement(list(key="right_arrow"))
}
# for (i in 1:11){
#   webElems[[1]]$sendKeysToElement(list(key="left_arrow"))
# }
webElems <- remDr$findElement(using = 'id' , 'viewSidebarToggleButton')
webElems$clickElement()
Sys.sleep(2)
webElems <- remDr$findElement(using = 'id' , 'viewSidebarToggleButton')
webElems$clickElement()
# webElems$clickElement()

webElems <- remDr$findElements(using = 'xpath' , "//div[@class='cell primary read']")
webElems[[1]]$clickElement()


# webElems[[19]]$clickElement()
# webElems[[19]]$sendKeysToElement(list(key="home"))
# webElems <- remDr$findElements(using = 'xpath' , "//div[@class='cell primary read']")
# webElems[[1]]$clickElement()
# webElems[[19]]$sendKeysToElement(list(key="home"))


# Creation dtata frame vide
Comp_oth <- data.frame(NULL)

# Boucle de scraping

for (i in 1:(round(1168/36,0)+1)){



  webElems <- remDr$findElements(using = 'xpath' , "//div[@class='cell read']")
  resHeaders <- unlist(lapply(webElems, function(x){x$getElementText()}))
  
  if(i==1){
    
    mat <- matrix(resHeaders[c(1:468)], 36, byrow = TRUE)
    test <- as.data.frame(mat, stringsAsFactors = FALSE)
    # test <- test[order(nrow(test):1),]
    # test[1:2,2] <- test[1:2,3]
    # test[1:2,3] <- ""   
        
  } else if (i==33) {
    
    mat <- matrix(resHeaders[c(235:442)], 16, byrow = TRUE)
    test <- as.data.frame(mat, stringsAsFactors = FALSE)
    
    
  } else {
    
    mat <- matrix(resHeaders[c(40:507)], 36, byrow = TRUE)
    test <- as.data.frame(mat, stringsAsFactors = FALSE)
    
    
  }
  
  webElems2 <- remDr$findElements(using = 'xpath' , "//div[@class='headerRow rightPane']")
  resHeaders2 <- unlist(lapply(webElems2, function(x){x$getElementText()}))
  colnames(test) <- unlist(strsplit(resHeaders2, split = "\n"))[c(1,2,3,4,5,8,6,7,9,10,11,12,13)]
  # test <- test[, -2]
  # test <- test[, c(2:12,1)]
  
  Comp_oth <- rbind(Comp_oth, test)
  
  webElems[[1]]$sendKeysToElement(list(key="page_down"))
  Sys.sleep(0.8)
  # Click première ligne première colonne
  # webElems <- remDr$findElements(using = 'xpath' , "//div[@class='cell primary selected cursor read']")
  # webElems[[1]]$clickElement()
}


# OK <- read.csv("compagnies.csv")
# OK <- cbind(OK1, Comp_oth)

OK_F <- cbind(OK, Comp_oth)
OK_F <- OK_F[, c(-12,-13)]
colnames(OK_F)[1] <- "rowname"

write.csv(OK_F, file = "compagnies.csv", row.names = TRUE)


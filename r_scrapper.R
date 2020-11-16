rm(list = ls())

# Parsing of HTML/XML files  
setwd("K:/DATA SCIENCE/CORONA DATA/Corona Scrapping Data/")
library(rvest)   

page = read_html("https://www.worldometers.info/coronavirus/")
data = page %>% 
  html_nodes(xpath = '//*[(@id = "main_table_countries_today")]') %>% 
  html_table()

data = data[[1]]

write.csv(data,
          paste0("K:/DATA SCIENCE/CORONA DATA/Corona Scrapping Data/", 
                 format(Sys.time(), "%d-%b-%Y %H.%M"), ".csv"))

rm(list = ls())
setwd("K:/DATA SCIENCE/CORONA DATA/Corona Scrapping State Wise India/")

library(rvest)
URL = "https://www.mohfw.gov.in/"
page = read_html(URL)
data = page %>% 
  html_nodes(xpath = '//*[@id="state-data"]/div/div/div/div/table/tbody') %>% 
  html_text()
library(stringr)
data = str_split_fixed(data, "\n\t", n = 5*33)
data = as.vector(data)
df = matrix(data[1:155], nrow = 31, byrow = TRUE)
df = df[,-1]  # (Including 71 foreign Nationals) in total confirmed cases
colnames(df) = c('Name of State / UT', 'Total Confirmed cases', 'Cured/Discharged/Migrated', 'Death')

write.csv(df,
          paste0("K:/DATA SCIENCE/CORONA DATA/Corona Scrapping State Wise India/",
                 format(Sys.time(), "%d-%b-%Y %H.%M"), ".csv"))
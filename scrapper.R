# Country Wise Data ------- From Worldmeter -------------------(1)----------
rm(list = ls())
setwd("K:/ /CORONA DATA/Corona Scrapping Data/")

library(rvest)   
page = read_html("https://www.worldometers.info/coronavirus/")
data = page %>% 
  html_nodes(xpath = '//*[(@id = "main_table_countries_yesterday")]') %>% 
  html_table()

data = data[[1]]

write.csv(data,
          paste0("K:/ /CORONA DATA/Corona Scrapping Data/", 
                 format(Sys.time(), "%d-%b-%Y %H.%M"), ".csv"))

# State Wise Data --------- From Indian Govt ------------------(2)----------
rm(list = ls())
setwd("K:/ /CORONA DATA/Corona Scrapping State Wise India/")

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
          paste0("K:/ /CORONA DATA/Corona Scrapping State Wise India/",
                 format(Sys.time(), "%d-%b-%Y %H.%M"), ".csv"))

# State Wise Data --------- From Wikipedia --------------------(3)----------
rm(list = ls())
setwd("K:/ /CORONA DATA/Wikipedia/India/")
library(rvest)
URL = "https://en.wikipedia.org/wiki/2020_coronavirus_pandemic_in_India"
page = read_html(URL)
data = page %>% 
  html_nodes(xpath = '//*[@id="mw-content-text"]/div/table[3]/tbody') %>% 
  html_text()

library(stringr)
p = str_split_fixed(data,'\n\n', n = 6*32)
q = str_split(p,'\n',n=2)
r = unlist(q)
s = matrix(as.vector(r[8:193]), nrow = 31, byrow = T)
t = as.data.frame(s[,-1])
colnames(t) = c("State/Union Territory","Total cases","Deaths","Recoveries","Active cases")
write.csv(t,paste0("K:/ /CORONA DATA/Wikipedia/India/",
                   format(Sys.time(),"%d-%b-%Y %H.%M.%S"),".csv"))

rm(list = ls())


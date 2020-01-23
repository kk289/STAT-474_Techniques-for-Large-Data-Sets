library(tidyverse)
library(stringr)


## automating file downloading
http://stat-computing.org/dataexpo/2009/1987.csv.bz2

url <- str_c("http://stat-computing.org/dataexpo/2009/", 1987, ".csv.bz2")
url

url_1 <- str_c("http://stat-computing.org/dataexpo/2009/", 1987:2002, ".csv.bz2")
url_1

## to know how many url are there by using seq_along
url <- str_c("http://stat-computing.org/dataexpo/2009/", 1987:2008, ".csv.bz2")
for(i in seq_along(url)){
 download.file(url[i]) 
}

url <- str_c("http://stat-computing.org/dataexpo/2009/", 1987:2008, ".csv.bz2")
for(i in 1:3){
  download.file(url[i], destfile = "c:/") 
}

#function_01. 패키지를 확인하고 생성, library에 올리는 함수
package_based <- function(package_name){
  
  install.packages(package_name)
  library(package_name)
  return(search())
}


#function_02.동일한 위치에 있는 파일이름을 넣으면 엑셀을 가지고 오는 함수

ex_new <- function(file_name){
  
  file_name <- read.csv(file_name, header=TRUE)
  
  return(file_name)
}

#function_3. data.frame의 기본적인 속성을 파악하는 함수

check <- function(data){
  
  dim(data)
  class(data)
  head(data)
  str(data)
  names(data)
  
}

#function_04 Scraping  함수 x : value(source) 이름 y : class 또는 id 이름

scrap <- function(source_name, class_id_name){
  
  library(rvest)
  library(dplyr)
  library(stringr)  
  library(readr)     
  library(data.table)
  library(readtext)
  library(htmltab)
  
  source_name <- read_html(source_name)

  source_name <- source_name %>% 
    html_nodes(class_name) %>% 
    html_text()
  
  return(source_name)
}


# x = n61_2021, y = n61_202201, z = n61_202202 return = n61_2022
rr <- function(x, y, z){
  
  a <- rbind(x, y)
  b <- rbind(a, z)
  
  return(b)
}


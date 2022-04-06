#참고사이트 -> https://givitallugot.github.io/articles/2020-03/R-visualization-1-seoulmap

#function_01. 패키지를 확인하고 생성, library에 올리는 함수
package_based <- function(package_name){
  
  search()
  install.packages("package_name")
  library(package_name)
}

#function_02.동일한 위치에 있는 파일이름을 넣으면 엑셀을 가지고 오는 함수

ex_new <- function(file_name){
  
  file_name  <- read.csv("file_name", header=TRUE)
}

#function_3. data.frame의 기본적인 속성을 파악하는 함수

check <- function(data){
  
  dim(data)
  class(data)
  head(data)
  str(data)
  names(data)
  
}

#function_04 Scraping  함수 x : value(source) 이름 y : class 이름

scrap <- function(source_name, class_name){
  
  scrap_new <- source_name %>% 
    html_nodes(paste("\"",class_name,"\"")) %>% 
    html_text();
}



###########################
install.packages("maptools")
install.packages("rgdal")
install.packages("ggmap")
install.packages("ggplot2")
install.packages("raster")
install.packages("rgeos")
install.packages("readr")
install.packages("tidyverse")
install.packages("sf")
installed.packages()

library(readxl)
library(maptools)
library(rgdal)
library(ggmap)
library(ggplot2)
library(raster)
library(rgeos)
library(dplyr)
library(readr)
library(tidyverse)
search()

#서울시 고유아이디 번호 가지고 오기
seoul_id <- read.csv("team2/seoul_id.csv", header=TRUE)
colnames(seoul_id) <- c("자치구", "id")

#엑셀에서 차트하나로 정리한 주거지역이랑 상업지역가지고 오기
seoul_used <- read.csv("team2/서울 용도지역 현황 통계.csv", header=TRUE)
head(seoul_used)

# - 로 되어있는 것 NA로 바꿔주기
seoul_used$전용주거지역 <- ifelse(seoul_used$전용주거지역 == "-", NA, seoul_used$전용주거지역)
head(seoul_used)

#캐릭터를 정수로 변경해주기
seoul_used$전용주거지역 <- as.numeric(seoul_used$전용주거지역)

#지역의 고유번호(id)가 나오게 조인
seoul <- full_join(seoul_id, seoul_used)
seoul

#서울 지도 가지고 오기
map <- shapefile("team2/SIG_201703/TL_SCCO_SIG.shp")
class(map)
str(map)
head(map)

#지도확인하기 -우리나라 지도

map <- spTransform(map, CRSobj = CRS('+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs'))
map
head(map)

# map을 dataframe으로 변환. region으로 SIG_CD가 id로 변환
new_map <- fortify(map, region = 'SIG_CD')
head(new_map)
str(new_map)


#서울시 id가 11740 이하
new_map$id <- as.numeric(new_map$id)
head(new_map)

seoul_map <- new_map[new_map$id <= 11740,]
P_merge <- merge(seoul_map, seoul, by='id')
seoul_map

# 지도 각 구 중앙에 라벨붙이기 위한 데이터처리
seoul_text <- P_merge %>% 
  dplyr::select(자치구, long, lat,상업소계) %>% 
  group_by(자치구,상업소계) %>% 
  summarise(m_long=mean(long), m_lat=mean(lat)) %>% 
  distinct(자치구, .keep_all = TRUE) 

seoul_text  

#서울시 지도
ggplot() + geom_polygon(data = P_merge, aes(x=long, y=lat, group=group), fill = 'white', color='black')

options(scipen=999)


#데이터 확인
head(seoul)
ggplot() + geom_polygon(data = P_merge, aes(x=long, y=lat, group=group, fill = 일반주거지역))

home_total <- ggplot() + geom_polygon(data = P_merge, aes(x=long, y=lat, group=group, fill = 일반주거지역), color="black")

home_total

biz_total <- ggplot() + geom_polygon(data = P_merge, aes(x=long, y=lat, group=group, fill = 상업소계), color="black")

biz_total


ht_scale <- home_total + scale_fill_gradient(low = "#ffe5e5", high = "#ff3232", space = "Lab", guide = "colourbar")+ 
  theme_bw() + labs(title = "서울시 일반주거지역 분포")+ 
  geom_text(data = seoul_text, aes(x = m_long, y = m_lat,
                                   label = paste(자치구, 상업소계, sep = "\n")))

ht_scale

bt_scale <- biz_total + scale_fill_gradient(low = "#ffe5e5", high = "#ff3232", space = "Lab", guide = "colourbar")+ 
  theme_bw() + labs(title = "서울시 상업소계 분포") + 
  geom_text(data = seoul_text, aes(x = m_long, y = m_lat, 
                                   label = paste(자치구, 상업소계, sep = "\n")))
ht_scale
 
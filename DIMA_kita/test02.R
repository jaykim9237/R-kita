#function_01. 타입변경 함수(numeric)
make_num <- function(x){
  
  x <- as.numeric(x)
}


#function_02.동일한 위치에 있는 파일이름을 넣으면 엑셀을 가지고 와서 바로 확인 할 수 있는 함수

ex_new <- function(file_name){
  
  file_name <- read.csv(file_name, header=TRUE)
  
  return(file_name)
}

#function_3. data.frame의 기본적인 속성을 파악하는 함수

check <- function(data){
  
  c_a <- dim(data)
  c_b <- class(data)
  c_c <- head(data)
  c_d <- colnames(data)
  c_f <- names(data)
  
  return(list(c_a, c_b, c_c, c_d,  c_f))
  
}

rm(c_f)


##################
# 0.pkg

install.packages("maptools")
install.packages("rgdal")
install.packages("ggmap")
install.packages("ggplot2")
install.packages("raster")
install.packages("rgeos")
install.packages("readr")
install.packages("tidyverse")


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


##

jdbc_D <- JDBC(driverClass = "oracle.jdbc.OracleDriver",
               classPath = "C:/Database/app/user/product/18.0.0/dbhomeXE/jdbc/lib/ojdbc8.jar")
db_con1 <- dbConnect(jdbc_D,"jdbc:oracle:thin:@localhost:1521:XE",
                     "hr","hr")

#서울시 고유아이디 번호 가지고 오기. db에 저장된 seoul_id

#함수02 사용
seoul_id <- ex_new("seoul_id.csv")

#컬럼명 변경
colnames(seoul_id) <- c("자치구", "id")

#함수03 사용
check(seoul_id)

#엑셀에서 차트하나로 정리한 주거지역이랑 상업지역가지고 오기
seoul_used <- ex_new("서울 용도지역 현황 통계.csv")
  
check(seoul_used)

# - 로 되어있는 것 NA로 바꿔주기
seoul_used$전용주거지역 <- ifelse(seoul_used$전용주거지역 == "-", NA, seoul_used$전용주거지역)
check(seoul_used)


#캐릭터를 정수로 변경해주기
seoul_used$전용주거지역 <- as.numeric(seoul_used$전용주거지역)

#지역의 고유번호(id)가 나오게 조인
seoul <- full_join(seoul_id, seoul_used)
check(seoul)

#서울 지도 가지고 오기
map <- shapefile("SIG_201703/TL_SCCO_SIG.shp")
check(map)


#지도확인하기 -우리나라 지도
map <- spTransform(map, CRSobj = CRS('+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs'))
map

# map을 dataframe으로 변환. region으로 SIG_CD가 id로 변환
new_map <- fortify(map, region = 'SIG_CD')
check(new_map)
str(new_map)


#서울시 id가 11740 이하
make_num(new_map$id)
check(new_map)
str(new_map)

seoul_map <- new_map[new_map$id <= 11740,]
P_merge <- merge(seoul_map, seoul, by='id')
seoul_map

check(seoul_map)


# DB
names(P_merge)
str(P_merge)
colnames(P_merge) <- c("아이디","위도","경도","오더","홀","피스","그룹","자치구","기간","용도지역총합계","일반주거지역","전용주거지역","상업소계")
names(P_merge)
head(P_merge)
str(P_merge)
P_merge[is.na(P_merge)] <- 0
ppp <- P_merge
dim(ppp)
dim(P_merge)
dbWriteTable(db_con1,"P_merge", P_merge)

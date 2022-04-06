

###########################
install.packages("maptools")
install.packages("rgdal")
install.packages("ggmap")
install.packages("ggplot2")
install.packages("raster")
install.packages("rgeos")
install.packages("readr")
install.packages("tidyverse")
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

jdbc_D <- JDBC(driverClass = "oracle.jdbc.OracleDriver",
               classPath = "C:/Database/app/user/product/18.0.0/dbhomeXE/jdbc/lib/ojdbc8.jar")
db_con1 <- dbConnect(jdbc_D,"jdbc:oracle:thin:@localhost:1521:XE",
                     "hr","hr")

#서울시 고유아이디 번호 가지고 오기. db에 저장된 seoul_id
seoul_id <- read.csv("seoul_id.csv", header=TRUE)
colnames(seoul_id) <- c("자치구", "id")
str(seoul_id)
colnames(seoul_id)
head(seoul_id)

#엑셀에서 차트하나로 정리한 주거지역이랑 상업지역가지고 오기
seoul_used <- read.csv("서울 용도지역 현황 통계.csv", header=TRUE)
str(seoul_used)
names(seoul_used)

# - 로 되어있는 것 NA로 바꿔주기
seoul_used$전용주거지역 <- ifelse(seoul_used$전용주거지역 == "-", NA, seoul_used$전용주거지역)
head(seoul_used)

#캐릭터를 정수로 변경해주기
seoul_used$전용주거지역 <- as.numeric(seoul_used$전용주거지역)

#지역의 고유번호(id)가 나오게 조인
seoul <- full_join(seoul_id, seoul_used)
seoul

#서울 지도 가지고 오기
map <- shapefile("SIG_201703/TL_SCCO_SIG.shp")
class(map)
str(map)
head(map)

#지도확인하기 -우리나라 지도

map <- spTransform(map, CRSobj = CRS('+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs'))
map

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



# DB
names(P_merge)
str(P_merge)
colnames(P_merge) <- c("아이디","위도","경도","오더","홀","피스","그룹","자치구","기간","용도지역총합계","일반주거지역","전용주거지역","상업소계")
names(P_merge)
head(P_merge)
str(P_merge)
P_merge[is.na(P_merge)] <- 0
ppp <- P_merge
View(ppp)
dim(ppp)
dim(P_merge)
dbWriteTable(db_con1,"P_merge", P_merge)

View(P_merge)
class(P_merge)
P_merge <- P_merge %>% arrange(오더)

q2 <- "select * from P_merge"
P_merge <- dbGetQuery(db_con1,q2)
dim(P_merge)

# 지도 각 구 중앙에 라벨붙이기 위한 데이터처리
seoul_text <- P_merge %>% select(자치구,위도,경도,상업소계,일반주거지역) %>% group_by(자치구,상업소계, 일반주거지역) %>% summarise(위도평균=mean(위도), 경도평균=mean(경도)) %>% distinct(자치구, .keep_all = TRUE)

# DB
dbWriteTable(db_con1,"seoul_text", seoul_text, rownames=FALSE, overwrite = TRUE, append = FALSE)

q1 <- "select * from seoul_text"
seoul_text <- dbGetQuery(db_con1, q1)

# 버스정류장 좌표
bus_xy <- read.csv("버스좌표.csv", header=TRUE)
bus_xl <- read_excel("busdata.xlsx", sheet=1, col_names=T)

bus_xll <- bus_xl %>% select(버스정류장ARS번호,노선번호) %>% dplyr::filter(노선번호 == "N61")
bus61_xy <- left_join(bus_xll,bus_xy,by="버스정류장ARS번호")



#서울시 지도
ggplot() + geom_polygon(data = P_merge, aes(x=위도, y=경도, group=그룹), fill = 'white', color='black')
# 숫자 자리수 제한 늘이기
options(scipen=999)

home_total <- ggplot() + geom_polygon(data = P_merge, aes(x=위도, y=경도, group=그룹, fill = 일반주거지역), color="black")
biz_total <- ggplot() + geom_polygon(data = P_merge, aes(x=위도, y=경도, group=그룹, fill = 상업소계), color="black")

ht_scale <- home_total + scale_fill_gradient(low = "#ffe5e5", high = "#ff3232", space = "Lab", guide = "colourbar")+
  theme_bw() + labs(title = "서울시 일반주거지역 분포") +
  geom_text(data = seoul_text, aes(x = 위도평균, y = 경도평균,
                                   label = paste(자치구, 일반주거지역, sep = "\n")))+
  geom_point(data=bus61_xy, aes(x=X좌표,y=Y좌표),
             size=1, alpha=0.8, col="green")
bt_scale <- biz_total + scale_fill_gradient(low = "white", high = "skyblue", space = "Lab", guide = "colourbar")+
  theme_bw() + labs(title = "서울시 상업소계 분포") +
  geom_text(data = seoul_text, aes(x = 위도평균, y = 경도평균,
                                   label = paste(자치구, 상업소계, sep = "\n")))+
  geom_point(data=bus61_xy, aes(x=X좌표,y=Y좌표),
             size=1, alpha=0.8, col="green")

# 인터렉티브 맵
ggplotly(ht_scale)
ggplotly(bt_scale)
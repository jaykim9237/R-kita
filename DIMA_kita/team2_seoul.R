#참고사이트 ->https://givitallugot.github.io/articles/2020-03/R-visualization-1-seoulmap

library(readxl)

#서울시 고유아이디 번호 가지고 오기
seoul_id <- read_csv("team2/seoul_id.csv",locale=locale('ko',encoding='euc-kr'))

seoul_id

colnames(seoul_id) <- c("자치구", "id")

#엑셀에서 차트하나로 정리한 주거지역이랑 상업지역가지고 오기

seoul_used <- read_xls("team2/서울 용도지역 현황 통계.xls")
head(seoul_used)

# - 로 되어있는 것 NA로 바꿔주기
seoul_used$전용주거지역 <- ifelse(seoul_used$전용주거지역 == "-", NA, seoul_used$전용주거지역)
head(seoul_used)

#캐릭터를 정수로 변경해주기
seoul_used$전용주거지역 <- as.numeric(seoul_used$전용주거지역)

library(dplyr)

#지역의 고유번호(id)가 나오게 조인
seoul <- full_join(seoul_id, seoul_used)
seoul

install.packages("maptools")
install.packages("rgdal")
install.packages("ggmap")
install.packages("ggplot2")
install.packages("raster")
install.packages("rgeos")

library(maptools)
library(rgdal)
library(ggmap)
library(ggplot2)
library(raster)
library(rgeos)

#서울 지도 가지고 오기
seoul_map <- readOGR("team2/SIG_201703/TL_SCCO_SIG.shp")
class(seoul_map)
str(seoul_map)
View(seoul_map)

#지도확인하기 -우리나라 지도
plot(seoul_map)

seoul_map$SIG_CD <- as.numeric(seoul_map$SIG_CD)

map <- fortify(seoul_map, region = 'SIG_CD') 
head(map)
str(map)
View(map)

#서울시 id가 11740 이하
map$id <- as.numeric(map$id)
head(map)

seoul_map <- map %>% dplyr::filter(map$id <=180)
P_merge <- merge(seoul_map, seoul, by='id')

#서울시 지도 ㅠㅠ 진짜 감동적 ㅠㅠㅠ
ggplot() + geom_polygon(data = P_merge, aes(x=long, y=lat, group=group), fill = 'white', color='black')

#데이터 확인
head(seoul)
home_total <- ggplot() + geom_polygon(data = P_merge, aes(x=long, y=lat, group=group, fill = "주거소계"))
home_total
home_total + scale_fill_gradient(low = "#ffe5e5", high = "#ff3232", space = "Lab", guide = "colourbar")

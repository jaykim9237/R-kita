# dima_map.R

# 0. package & datasets

# 0-1. pkg

install.packages("devtools") #devtool::install_github() 이용

install.packages("ggiraphExtra") #코로프레스도
devtools::install_github("cardiomoon/kormaps2014")

library(ggiraphExtra)
library(ggplot2)
library(dplyr)
library(kormaps2014)

# 0-2. datasets

data(package = "kormaps2014")
#+ korpop1 : 인구조사(시도별)
#+ korpop2 : 인구조사(시군구별)
#+ korpop3 : 인구조사(읍면동별)

#+ kormap1 : map(시도별)
#+ kormap2 : map(시군구별)
#+ kormap3 : map(읍면동별)


#인구데이터
dim(korpop1)  # 읍면동으로 갈 수록 데이터가 많아지는 것을 볼 수있다. 행 개수는 동일 
names(korpop1)
dim(korpop2)
dim(korpop3)

dim(kormap1)  # 읍면동으로 갈 수록 데이터가 많아지는 것을 볼 수있다. 행 개수는 동일 
names(kormap1)
dim(kormap2)
dim(kormap3)

str(korpop1) #에러
str(changeCode(korpop1))

# 1. data pre-processing ----

# 1-1. dataset copy ----
my_pop2 <- korpop2;head(my_pop2)
my_map2 <- kormap2;head(my_map2)

str(my_pop2)
nchar(my_pop2, type = "w", allowNA = TRUE)

# 1-2. encoding ----
my_pop2 <- changeCode(my_pop2)
class(my_pop2)
str(my_pop2)

my_pop2$C행정구역별_읍면동

# 1-3. 변수명 변경 ----
names(my_pop2)

my_pop2 <- rename(my_pop2, 
       t_top = "총인구_명",
       r_name = "행정구역별_읍면동",
       house_in_building = "비거주용_건물내_주택_호", 
       place_not_house = "주택이외의_거처_호",
       r_code = "code")

str(my_pop2)

# 1-4. data type 변경 ----

my_pop2[c("house_in_building", "place_not_house")] <- 
  as.numeric(c(my_pop2$house_in_building,
               my_pop2$place_not_house))
str(my_pop2)

# 2. 시각화 ----

# 2-1. 시군구별 
names(my_pop2)

ggChoropleth(data=my_pop2, 
             map=my_map2,
             interactive = T,
             aes(fill = house_in_building,
                 map_id = r_code,
                 tooltip = r_name),
             title = "비주거용 건물 내 주택현황"
)

names(my_pop2)


my_pop2 %>% 
  select(r_name, t_top, house_in_building, r_code) %>% 
  arrange(-house_in_building) %>% head(5)

# 2-2. 시도별

#dataset copy
my_pop1 <- korpop1
my_map1 <- kormap1

#encoding
my_pop1 <- changeCode(my_pop1)

  my_pop1 <- rename(my_pop1, 
                    t_top = "총인구_명",
                    r_name = "행정구역별_읍면동",
                    house_in_building = "비거주용_건물내_주택_호", 
                    place_not_house = "주택이외의_거처_호",
                    r_code = "code")


  my_pop1[c("house_in_building", "place_not_house")] <- 
    as.numeric(c(my_pop1$house_in_building,
                 my_pop1$place_not_house))

#시각화
  ggChoropleth(data=my_pop1, 
               map=my_map1,
               interactive = T,
               aes(fill = house_in_building,
                   map_id = r_code,
                   tooltip = r_name),
               title = "비주거용 건물 내 주택현황(시도별)"
  )

  my_pop1 %>% 
    select(r_name, t_top, house_in_building, r_code) %>% 
    arrange(-house_in_building) %>% head(5)
    
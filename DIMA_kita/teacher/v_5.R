# 시각화(Visualization)

# 1. 산점도(scatter plot) ----

my_mpg <- ggplot2::mpg
my_mpg$t_ch <- (my_mpg$cty + my_mpg$hwy)/2
my_mpg$test <- ifelse(my_mpg$t_ch >= 25, "Pass", "Fail")
my_mpg$grade <- ifelse(my_mpg$t_ch >=31, "Excellent", 
                       ifelse(my_mpg$t_ch >=21, "Good",
                              ifelse(my_mpg$t_ch >=15, "Normal",
                                     "Poor")))

# 1-1. 기본 plot() ----
?base::plot()
plot(my_mpg$hwy)

# 1-2. 산점도 행렬  # 상관관계 ----
#pairs(x)  # x=숫자
?pairs()    # graphics ----

names(my_mpg);str(my_mpg)
par(mar=c(1,1,1,1))
pairs(my_mpg[c(8,9)])

# 1-3. 산점도 행렬-2   * ----

install.packages("psych")
library(psych);library(ggplot2)
search()
pairs.panels(my_mpg[c(8,9)])
 
# 1-4. ggplot() 활용 ----

?airquality   # datasets::
airquality
str(airquality)
names(airquality)

#par(mfrow=c(1,1))
pairs(airquality)          # base::
pairs.panels(airquality)   # psych:: *

# 1) airquality
ggplot(airquality, aes(x=Day, y=Temp))+geom_point()
ggplot(airquality, aes(x=Day, y=Temp))+
  geom_point(size=5, col="red")

# 2) my_mpg
names(my_mpg)
ggplot(data=my_mpg, aes(x=displ, y=hwy))+
  geom_point(size=10, col="blue")+
  xlim(4,6)+    # x축 범위 지정
  ylim(20,30)   # y축 범위 지정

# data = economics
# 3) economics
names(economics)
ggplot(data = economics, aes(x=pce, y=psavert))+
  geom_point()+
  xlim(5000,10000)
  
# 2. 선 & 파이 그래프 (line & pie) ----

# 2-1. pie ----
?pie

# 1) 
pie.sales <- c(0.12, 0.3, 0.26, 0.16, 0.04, 0.12)
names(pie.sales) <- c("Blueberry", "Cherry",
                      "Apple", "Boston Cream", "Other", "Vanilla Cream")
pie(pie.sales) # default colours
pie(pie.sales, col = c("purple", "violetred1", "green3",
                       "cornsilk", "cyan", "white"))

# pie(pie.sales, col = gray(seq(0.4, 1.0, length.out = 6)))
# pie(pie.sales, density = 10, angle = 15 + 10 * 1:6)
# pie(pie.sales, clockwise = TRUE, main = "pie(*, clockwise = TRUE)")
# segments(0, 0, 0, 1, col = "red", lwd = 2)
# text(0, 1, "init.angle = 90", col = "red")

# 2) 
table(my_mpg$test)
pie(table(my_mpg$test),main = "Pie",
    edges=2000,col=c("red", "white"))

# 2-2. line ----
# 1) plot()
?base::plot()
plot(my_mpg$hwy, type="l", col="red")

# 2) ggplot()
ggplot(data=airquality, aes(x=Day, y=Temp))+
  geom_line()

ggplot(data = economics, aes(x=pce, y=psavert))+
  geom_line()+
  xlim(5000,10000)

# 3. 막대 그래프 (bar plot) ----
#+ 이산형 데이터를 주로 다루는 그래프

# Error in .Call.graphics(C_palette2, .Call(C_palette2, NULL)) : invalid graphics state 
par(mar=c(1,1,1,1))
dev.off()

# 3-1. descr::freq()  # 대상: 범주형 데이터 ----
install.packages("descr")
library(help = "descr")  # 패키지 정보 확인

names(my_mpg);unique(my_mpg$grade)

descr::freq(my_mpg$grade, plot=F, main="자동차 등급비율")
descr::freq(my_mpg$grade, main="자동차 등급비율")
#+ plot = T (default)

# 3-2. graphics::barplot()  # default ----
#+ ylim: 출력할 y축
#+ main: 표제목
#+ xlab: x축 제목
#+ ylab: y축 제목
#+ names(): c(,) 활용, 각 구간의 제목
#+ col(): c(,) 활용, 각 구간별 색깔지정


str(my_mpg);unique(my_mpg$cyl)
barplot(my_mpg$cyl, main="test", xlab = "x축 이름")

# table() 활용

t_ch_bar <- table(my_mpg$t_ch)
barplot(t_ch_bar, ylim = c(0,30), main = "종합연비",
        xlab="연비", ylab="빈도")    # 인수=> 수치

?barplot()
bp_cyl <- table(my_mpg$cyl)
barplot(bp_cyl, main="test", xlab = "CYL", ylab="빈도",
        ylim = c(0,100), 
        col = c("lightblue", "red","navy", "lavender"))


# 3-3. ggplot2::ggplot() ----

search()
library(ggplot2)

mtcars
ggplot(data=mtcars, aes(x=cyl))+
  geom_bar(width = 1.5)

# 누적 그래프  # fill
ggplot(data=mtcars, aes(x=factor(cyl)))+
  geom_bar(aes(fill=factor(gear)))

# sunburst 
ggplot(data=mtcars, aes(x=factor(cyl)))+
  geom_bar(aes(fill=factor(gear)))+
  coord_polar()

# sunburst - 도넛형 *
ggplot(data=mtcars, aes(x=factor(cyl)))+
  geom_bar(aes(fill=factor(gear)))+
  coord_polar(theta = "y")

# 4. 히스토그램 = 상대도수/구간(계급)  ----
#+ 상대도수 = 해당구간의 빈도/전체빈도
#+ 연속형 데이터 다루겠다는 의미 **
#+ 막대그래프 형태

# 4-1. plot() ----
airquality
par(mfrow=c(1,2))   # 1행 2열
plot(airquality$Ozone, col="blue")
plot(airquality$Ozone, type="h", col="blue")

# 4-2. hist() ----
par(mfrow=c(1,2))   # 1행 2열
hist(airquality$Ozone)
hist(airquality$Temp)

# 4-3. ggplot() ----
ggplot(data=airquality, aes(Ozone))+
  geom_histogram()

ggplot(data=airquality, aes(Ozone))+
  geom_histogram(binwidth = 1.5)

# 5. 상자그림(boxplot) ----

# 5-1. boxplot() ----
?boxplot()   # graphics::
# car::Boxplot()

par(mfrow=c(1,2))   # 1행 2열

boxplot(my_mpg$cty, my_mpg$hwy,
        ylim=c(0,60),
        main= "연비비교(도심, 고속도로)",
        names=c("Cty","Hwy"),
        col=c("red","yellow"))

boxplot(my_mpg$cty, my_mpg$hwy,
        ylim=c(0,60),
        main= "연비비교(도심, 고속도로)",
        names=c("Cty","Hwy"),
        col=c("red","green"))


# 5-2. ggplot() ----

# 1) my_mpg
names(my_mpg)
ggplot(data=my_mpg, aes(x=drv, y=cty, group=F))+
  geom_boxplot()

ggplot(data=my_mpg, aes(x=drv, y=cty, group=drv))+
  geom_boxplot()

ggplot(data=my_mpg, aes(x=drv, y=(cty+hwy)/2))+
  geom_boxplot()
#+ 카테고리가 작으면 group = T 로 자동변환

# 2) airquality

airquality
dim(airquality)    # 153, 6
names(airquality)
length(unique(airquality$Day))   # 31

ggplot(data=airquality, aes(x=Day, y=Ozone))+
  geom_boxplot()
ggplot(data=airquality, aes(x=Day, y=Ozone, group=Day))+
  geom_boxplot()
ggplot(data=airquality, aes(x=Day, y=Temp, group=Day))+
  geom_boxplot()


# 6. 그래프 가독성 높이기 ----

# 6-1. 평행선 그래프: geom_hline() ----

library(ggplot2)

economics
names(economics)
ggplot(data=economics, aes(x=date, y=psavert))+
  geom_line()+
  geom_hline(yintercept = 7)

median(economics$psavert)
mean(economics$psavert)

ggplot(data=economics, aes(x=date, y=psavert))+
  geom_line()+
  geom_hline(yintercept = median(economics$psavert))

# 6-2. 사선 그래프: geom_abline() ----

names(economics)
ggplot(data=economics, aes(x=date, y=psavert))+
  geom_line()+
  geom_abline(intercept = 6, slope =0.0003)

# 6-3. 수직선 그리기: geom_vline() ----

names(economics)

# 저축률이 가장 높았던 시점
#+ Select date from economics where psavert = max(psavert)

x_max <- (economics[economics$psavert == max(economics$psavert),])$date

ggplot(data=economics, aes(x=date, y=psavert))+
  geom_line()+
  geom_vline(xintercept=x_max)

ggplot(data=economics, aes(x=date, y=psavert))+
  geom_line()+
  geom_vline(xintercept=as.Date("2005-07-01"))


# 6-4. txt 레이블 입력: geom_text() ----
#+ hjust=0, vjust=0: 해당 점의 오른쪽 위
#+ hjust / vjust= -값: 오른쪽 위 방향
#+ hjsut / vjust= +값: 외쪽 아래 방향

names(my_mpg)
head(my_mpg$test)
ggplot(data=my_mpg, aes(x=manufacturer, y=model))+
  geom_point()+
  geom_text(aes(label=test,hjust=0, vjust=0))

ggplot(data=my_mpg, aes(x=manufacturer, y=model))+
  geom_point()+
  geom_text(aes(label=test,hjust=-2, vjust=-0.7))

ggplot(data=my_mpg, aes(x=manufacturer, y=model))+
  geom_point()+
  geom_text(aes(label=grade, vjust=-2, hjust=-0.7))

# 6-5. 특정영역 강조: annotate() ----
#+ xmin: x_start, xmax: x_end
#+ ymin: y_start, ymax: y_end
library(ggplot2)

names(my_mpg)
ggplot(data=my_mpg, aes(x=manufacturer, y=class))+
  geom_point()+
  annotate("rect", xmin=10, xmax=16 ,
           ymin =1.7 , ymax =3.3, alpha=0.3,
           fill="blue")+
  annotate("segment", x=7, xend=11 ,
           y =1.5 , yend =2.5, col="red", size=2,
           arrow=arrow())+
  annotate("text", x=6, y =1.3, 
           label= "잘 팔이는 모델", size=6,
           col="darkblue")+
  labs(x="제조사", y="차종", title="제조사별 차종현황")+
  theme(plot.title = element_text(hjust = 0.5))

# 7. 데이터 결측치 (missing value) ----

# 7-1. NA 포함 dataset 생성 ----

data.frame(mw = c("M","M","F","M", NA, NA, "F", NA, "M", "F"),
           score = c(61, 98, 85, NA, 66, 72, 81, NA, 63, 74))

df_temp <- data.frame(mw = c("M","M","F","M", NA, NA, "F", NA, "M", "F"),
           score = c(61, 98, 85, NA, 66, 72, 81, NA, 63, 74))
df_temp

# 7-2. 결측치 확인 ----

is.na(df_temp)
table(is.na(df_temp))  # F-15, T-5

# 7-2-1. 결측치가 있으면 안되는 이유

mean(df_temp$score)
max(df_temp$score)

mean(df_temp$score, na.rm=T)
max(df_temp$score, na.rm=T)

# 7-2-2. 컬럼별로 결측치 확인

df_temp
table(is.na(df_temp$mw))     # F-7, T-3
table(is.na(df_temp$score))  # F-8, T-2

# 7-3. 결측치 제거 후, 분석방법 ----

library(dplyr)

# 7-3-1. 모든행 제거 방식

df_real <- na.omit(df_temp);df_real
mean(df_real$score)     # 77

# 7-3-2. 컬럼별 접근 제거

?filter()

df_temp
class(df_temp)

df_temp %>% dplyr::filter(!is.na(df_temp$mw))
df_temp %>% dplyr::filter(!is.na(df_temp$score))

df_real2 <- df_temp %>% dplyr::filter(!is.na(df_temp$score))
mean(df_real2$score)    # 75

# 7-4. 결측치 제외 방법 ----
#+ 나중에 NA가 측정될 것을 대비하는 것

# 7-4-1. 함수 레벨에서 결측치 제외
df_temp
mean(df_temp$score, na.rm=T)
sum(df_temp$score, na.rm=T)

# 7-4-2. NA값 제외 (실습)

# 1) dataset 로딩

temp_exam <- read.csv("ss_exam.csv")
temp_exam

# 2) NA 추가 및 확인

# NA 사전확인
names(temp_exam); dim(temp_exam)
table(is.na(temp_exam))
sum(is.na(temp_exam))

colSums(temp_exam)  # colSums() 함수 성격
colSums(is.na(temp_exam))  # colSums() 함수 성격

# NA 추가

head(temp_exam)
temp_exam[c(2,3,7,11,23,25), "database"] <- NA

# NA 재확인

table(is.na(temp_exam))
sum(is.na(temp_exam))
colSums(is.na(temp_exam))  # colSums() 함수 성격

colSums(temp_exam)  # database sum이 안됨 (NA때문)

# 3) NA값 제외

temp_exam %>% summarise(mean(database))   # X (NA)
temp_exam %>% summarise(m_db= mean(database, na.rm=T))   # O


# 7-5. 결측치 대체 방법 ----
#+ 자주 대체되는 값: min, max, mean, median, dima_mode, 0

# 7-5-1. 대체값 구하기
temp_exam2 <- read.csv("ss_exam.csv");temp_exam2
temp_exam2[c(2,3,7,11,23,25), "database"] <- NA  # NA처리

table(is.na(temp_exam2))

mean(temp_exam2$database, na.rm=T)    # 56.625
median(temp_exam2$database, na.rm=T)  # 50
subs <- median(temp_exam2$database, na.rm=T)  # 대체값으로 선정, 50
subs


# 7-5-2. NA를 대체값으로 처리 후, 분석

table(is.na(temp_exam2$database))
colSums(is.na(temp_exam2))  # colSums() 함수 성격

?ifelse()    # base::

temp_exam2$database

ifelse(is.na(temp_exam2$database), subs, temp_exam2$database)

temp_exam2$database <- ifelse(is.na(temp_exam2$database), subs, temp_exam2$database)

temp_exam2$database
temp_exam2 %>% 
  summarise(m_db = mean(database))   # 55.3


# 8. 이상치(Outlier) ----

# 8-1. 논리적인 이상치 ----

# 8-1-1. 이상치 dataset 생성
#+ 성별: 1~2, 설문: 1~5

t_out <- data.frame(mw=c(1,2,1,1,2,4),
           survey=c(1,3,5,4,10,3))
t_out

# 8-1-2. 논리적인 이상치 확인

table(t_out)
table(t_out$mw)
table(t_out$survey)

boxplot(t_out)
names(boxplot(t_out))
boxplot(t_out)$stats
boxplot(t_out$mw)$stats
boxplot(t_out$survey)$stats

car::Boxplot(t_out)
t_out[6,"mw"]
t_out[5,"survey"]

library(fBasics)
skewness(t_out$survey)

# 8-1-3. 논리적인 이상치 제거
#+ filter() -> NA변경 -> !is.na() 활용 분석

# t_out$mw
ifelse(t_out$mw==4, NA, t_out$mw)
t_out$mw <- ifelse(t_out$mw==4, NA, t_out$mw);t_out

# t_out$survey
ifelse(t_out$survey > 5, NA, t_out$survey)
t_out$survey <- ifelse(t_out$survey > 5, NA, t_out$survey);t_out

# 8-1-4. 결측치 제거 후, 분석

# 남녀 평균-설문점수

library(dplyr);search()

t_out

t_out %>% 
  dplyr::filter(!is.na(mw)&!is.na(survey)) %>% 
  group_by(mw) %>% 
  summarise(m_survey = mean(survey))

# 8-2. 극단적인 이상치 ----
#+ 논리적인 판단기준: 성인 사람의 키(0.5~2.5m)
#+ 통계적인 판단기준: sd+-3 이상/이하 or +- 1.5IQR 이상/이하

# 8-2-1. 극단적인 이상치 확인

out_mpg <- ggplot2::mpg
dim(out_mpg)

boxplot(out_mpg$hwy)
boxplot(out_mpg$hwy)$stats
car::Boxplot(out_mpg$hwy)

out_mpg[223,"hwy"]

# 8-2-2. 극단치 제거 (outlier -> NA)
#+ 조건에 부합하지 않는 값은 NA 변경 -> NA제외 분석
#+ 조건: 12~37

?ifelse      # base
ifelse(out_mpg$hwy <12 | out_mpg$hwy >37, NA, out_mpg$hwy)

table(ifelse(out_mpg$hwy <12 | out_mpg$hwy >37, NA, out_mpg$hwy))
table(ifelse(out_mpg$hwy <12 | out_mpg$hwy >37, NA, out_mpg$hwy),useNA = "ifany")

out_mpg$hwy <- ifelse(out_mpg$hwy <12 | out_mpg$hwy >37, NA, out_mpg$hwy)
table(is.na(out_mpg$hwy))

# 8-2-3. 결측치 제외 후 분석

dim(out_mpg)

out_mpg %>% 
  group_by(drv) %>% 
  summarise(mean(hwy))

out_mpg %>% 
  group_by(drv) %>% 
  summarise(m_hwy = mean(hwy, na.rm=T), n=n())


# A. map (코로플레스도, choropleth map) ----

# 0. packages & datasets ----
rm(list=ls())
ls()

# 0-1. pkgs ----
# 1) pkg: ggiraphExtra  # 단계별 구분도 관련 함수
                        #+ ggChoropleth(), 단계구분도 함수
# 2) pkg: mapproj       # 단계별 구분도 plotting 시에 필수
# 3) pkg: maps          # 지도정보
# 4) pkg: ggplot2       # map_data()
                        #+ map data를 data.frame으로 변환
# 5) pkg: tibble        # rownames_to_column()

install.packages("ggiraphExtra")
install.packages("mapproj")
install.packages("maps")
install.packages("tibble")

library(ggiraphExtra);search()
library(mapproj);search()
library(maps);search()
library(tibble);search()
library(ggplot2)

?map_data()
map_data("state")       # pkgs: ggplot2, maps
dim(map_data("state"))  # 15537, 6

# 0-2. dataset

data(package="datasets")
head(USArrests)
?USArrests

my_USArr <- USArrests  # *
names(my_USArr)

# 1. data 전처리 (data pre-processing)

?rownames_to_column()  # tibble::

names(USArrests)    # 4개
head(USArrests)
dim(USArrests)      # 50, 4

# 1-1. rowname -> column ----
my_USArr <- rownames_to_column(my_USArr, var = 'state')
names(my_USArr)  # 5개
head(my_USArr)
dim(my_USArr)    # 50, 5

# 1-2. state 대문자 -> 소문자 ----
?tolower()
my_USArr$state <- tolower(my_USArr$state)
head(my_USArr)

# 2. 지도 준비 (map preparation) ----

# 2-1. 지도확인 ----

maps::map("world")
maps::map("usa")
maps::map("state")   # *

# 2-2. 지도 data 가져오기 ----

USA_map <- map_data("state")
names(USA_map)
head(USA_map)
dim(USA_map)    # 15537, 6
str(USA_map)

# 3. 코로플레스도(단계구분도) ----

names(my_USArr)  # biz data
class(my_USArr)
dim(my_USArr)    # 50, 5
names(USA_map)   # map data
class(USA_map)
dim(USA_map)    # 15537, 6

?ggChoropleth
ggChoropleth(data = my_USArr,
             map = USA_map,
             aes(fill=Murder,
                 map_id=state),
             title = "USA Arrest Rate(Murder)",
             color = "darkblue"
)

# 4. 인터렉티브 map ----
#+ 코로플레스도

ggChoropleth(data = my_USArr,
             map = USA_map,
             aes(fill=c(Murder,Assault,Rape, UrbanPop),
                 map_id=state),
             title = "USA Arrest Rate",
             interactive = T
)


# 5. HTML 파일 저장하기

# B. 인터렉티브 그래프(Interactive Graph) ----

# 0-1. pkg
install.packages("plotly")
"plotly" %in% installed.packages()

library(plotly)
search()

# 0-2. dataset
my_mpg <- mpg
my_diamonds <- diamonds

names(my_mpg)
names(my_diamonds)

# 1. my_mpg

ggplot(data=my_mpg, aes(x=displ, y=hwy, col=drv))+
  geom_point()

mp <- ggplot(data=my_mpg, aes(x=displ, y=hwy, col=drv))+geom_point()

# 
?ggplotly() # plotly::
ggplotly(mp)

# 2. my_diamonds

names(my_diamonds)
str(my_diamonds)
levels(my_diamonds$cut)

ggplot(data=my_diamonds, aes(x=cut, fill=clarity))+
  geom_bar()

dp0 <- ggplot(data=my_diamonds, aes(x=cut, fill=clarity))+ geom_bar(position = "dodge")

ggplotly(dp0)

# C. R 마크다운(Markdown) ----
#+ 별도 페이지

# D. 데이터 수집 기본(Data Scraping Basics) ----

# 1-1. pkgs
install.packages("htmltab")

library(htmltab);search()

# 1-2. landing page url

url_01 <- "https://en.wikipedia.org/wiki/List_of_most_common_surnames_in_South_America"

url_01 <- "https://en.wikipedia.org/wiki/List_of_most_common_surnames_in_North_America"

url_01

# 1-3. htmltab() 활용

?htmltab

my_sur <- htmltab(doc = url_01,
        which = 2,
        encoding="UTF-8",
        stringAsFactors=F)
my_sur

dim(my_sur)
class(my_sur)
head(my_sur)
names(my_sur)
str(my_sur)
my_sur[,1]

# 2-1. pkgs

install.packages(c("rvest","readtext"))
library(rvest)
library(readtext)
search()


# 2-2. 랜딩페이지 url

url = "https://en.wikipedia.org/wiki/List_of_most_common_surnames_in_North_America"

url <- "https://en.wikipedia.org/wiki/List_of_most_common_surnames_in_North_America"

# 2-3. read_html() # Crawling
?read_html()

ss <- read_html(url) # 웹사이트 -> XML
ss
class(ss);length(ss)
head(ss);names(ss)
ss$node;ss$doc

# 2-4. 태그 활용 데이터 추출  # Scraping
?html_nodes    # rvest:;

ss %>% 
  html_nodes("p") %>%   # XML 객체에서 관련 노드 추출
  html_text()           # 관련 태그에서 데이터 추출


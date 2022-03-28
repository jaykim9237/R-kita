options("install.lock"=FALSE)
# 시각화

# 1. 산점도 (Scatter plot) ----

?base::plot()
plot(my_mpg$hwy)

# 1) 산점도 행렬  # 상관관계
# pairs(x)  # x=숫자 
?pairs()    # graphics ----

names(my_mpg)
str(my_mpg)
par(mar=c(1,1,1,1))
pairs(my_mpg[c(4,5,8,9)])

# 2) 산점도 행렬-2 **



install.packages("psych")
library(psych)
library(ggplot2)
search()

pairs.panels(my_mpg[c(8,9)])


# 3) ggplot() 활용

?airquality  # datasets::
airquality
str(airquality) # 전부 숫자임
names(airquality)

pairs(airquality)         # base::
pairs.panels(airquality)  # psych::

# airquality
ggplot(airquality, aes(x=Day, y=Temp))+geom_point()
ggplot(airquality, aes(x=Day, y=Temp))+
  geom_point(size=5, col="red")

# my_mpg
names(my_mpg)
ggplot(data=my_mpg, aes(x=displ, y=hwy))+geom_point()
ggplot(data=my_mpg, aes(x=displ, y=hwy))+
  geom_point()+
  xlim(4,6)+    # x축 범위 지정 (4에서 6까지)
  ylim(20,30)   # y축 범위 지정 (20에서 30까지)

# data = economics
names(economics)
?economics
View(economics)
str(economics)
ggplot(data=economics, aes(x=pce, y=psavert))+
  geom_point()+
  xlim(5000,10000)+
  ylim(0,10)

pairs.panels(economics)


# 2. 선 & 파이 그래프 (line & pie) ----

?base::plot()
plot(my_mpg$hwy, type="l", col="red")

# pie
table(my_mpg$test)
pie(table(my_mpg$test), main = "Pie",
    edges=2000, col=c("yellow","white"))

# ggplot()
ggplot(data=airquality, aes(x=Day, y=Temp))+
  geom_line()

ggplot(data=economics, aes(x=pce, y=psavert))+
  geom_line()+
  xlim(5000,10000)

# 3. 막대 그래프 (bar chart) ----
# 아래와 같이 에러나면 리셋한다:
#+ 이산형 데이터를 주로 다루는 그래프
#+ Error in .Call graphics(C_palette2, .Call(c_palette2, NULL)) : invalid graphics state
#+ par(mar=c(1,1,1,1))
#+ dev.off()

# 1) descr::freq()
??descr
install.packages("descr")
library(help = "descr")  # 패키지정보 
library(descr)

names(my_mpg)
unique(my_mpg$grade)

descr::freq(my_mpg$grade, plot=F, main="자동차 등급비율")
descr::freq(my_mpg$grade, main="자동차 등급비율")
#+ plot = T

# 2) graphics::barplot()
#+ ylim: 출력할 y축
#+ main: 표제목
#+ xlab: x축 제목
#+ ylab: y축 제목
#+ name(): c(,) 활용, 각 구간의 제목
#+ col(): c(,) 활용, 각 구간별 색깔지정
?barplot

str(my_mpg)
barplot(my_mpg$cyl, main="test", xlab = "x축이름")

# table ()활용
bp_cyl <- table(my_mpg$cyl)

barplot(bp_cyl, main="test", xlab = "빈도")
barplot(bp_cyl, main="test", xlab = "빈도", ylab = "빈도", ylim = c(0,100),
        col = c("lightblue", "red", "navy", "purple"))

#3)ggplot::ggplot()----

search()
library(ggplot2)

mtcars
ggplot(data=mtcars, aes(x=cyl))+geom_bar(width = 1.5)

# 누적 그래프 #fill
ggplot(data=mtcars, aes(x=factor(cyl)))+geom_bar(aes(fill=factor(gear)))

#sunburst
ggplot(data = mtcars, aes(x=factor(cyl))) + 
        geom_bar(aes(fill=factor(gear))) +
        coord_polar()

#sunburst - 도넛형
ggplot(data = mtcars, aes(x=factor(cyl))) + 
  geom_bar(aes(fill=factor(gear))) +
  coord_polar(theta = "y")

# 4. 히스토그램 = 상대도수/구간(계급) ----
#+ 상대도수 = 해당구간의 빈도/ 전체빈도
#+ 히스토그램을 한다는 것 == 연속형 데이터를 다루겠다는 의미 
#+ 즉 -> 막대 그래프 소속이나 연속형 데이터를 취급한다
#+ (통상적으로 막대 그래프는 이산형데이터를 취급함)

# 4-1. plot () ----
airquality
par(mfrow=c(1,2)) # 1행 2열 #mfrow -> 화면에 몇개 뿌릴것인지 
plot(airquality$Ozone, col="blue")
plot(airquality$Ozone, type="h", col="blue")

# 4-2. hist () ----
hist(airquality$Ozone)
hist(airquality$Temp)

# 4-2. ggplot() ----
ggplot(data=airquality, aes(Ozone))+
  geom_histogram()

ggplot(data=airquality, aes(Ozone))+
  geom_histogram(binwidth = 1.5)

# 5-1. boxplot() ----
?boxplot() # graphics::

boxplot(my_mpg$cty, my_mpg$hwy,
        ylim=c(0,60),
        main="연비비교(도심, 고속도로)",
        names=c("Cty","Hwy"),
        col=c("red","yellow"))

#  5-2. gglpot() ----

# 1) my_mpg
names(my_mpg)
ggplot(data=my_mpg, aes(x=drv, y=cty, group=F))+
  geom_boxplot()

ggplot(data=my_mpg, aes(x=drv, y=cty, group=drv))+
  geom_boxplot()

ggplot(data=my_mpg, aes(x=drv, y=cty))+
  geom_boxplot()
#+ 카테고리가 작으면 group =T로 자동변환

# 2) airquality

airquality
dim(airquality) #153, 6
names(airquality)
length(unique(airquality$Day)) #31

ggplot(data=airquality, aes(x=Day, y=Ozone))+
  geom_boxplot()
ggplot(data=airquality, aes(x=Day, y=Ozone, group=Day))+
  geom_boxplot() # box여러개 
ggplot(data=airquality, aes(x=Day, y=Temp, group=Day))+
  geom_boxplot()

###### 3/22 돌발퀴즈 ########

install.packages("DBI")
install.packages("rJava")
install.packages("RJDBC")
install.packages("odbc")

# package loading
library(DBI)
library(rJava)
library(RJDBC)
library(odbc)
search()

?odbcListDrivers() # odbc::

sort(unique((odbcListDrivers())[[1]]))
sort(unique((odbcListDrivers())[ ,1]))

unique((odbcListDrivers())[[1]])
sort(unique((odbcListDrivers())[[1]]))
order(unique((odbcListDrivers())[[1]]))

# sort()는 주어진 데이터를 직접 정렬해주는 함수이며 
# order()는 데이터를 정렬했을 때의 순서를 반환한다. index number 반환 
#+sort가 dataframe을 정렬할 수 없어서 (벡터만 sorting)
#+특정 열을 지정해주거나 대괄호에 , 를 지정해줘야한다. 
unique((odbcListDrivers())[1])
sort(unique((odbcListDrivers())[1]))
order(unique((odbcListDrivers())[1]))

###### 3/23 돌발퀴즈 ########
library(ggplot2)
search()
ggplot2::diamonds
names(diamonds)

# Q1 ----

# 1) cut 변수 활용 - 교수님 답안
ggplot(data = diamonds, aes(x=cut)) + 
  geom_bar(width=0.5)
# 1) cut 변수 활용 - DJ 답안
dfq <- ggplot2::diamonds
dfq
ggplot(data=dfq, aes(cut))+
  geom_bar(width = 0.5)

# 2) carat, price 변수 활용 - 교수님 답안 
ggplot(data=diamonds, aes(x=carat, y=price))+
  geom_line(col="blue")

# Q2 ----
# Q2 - 1. #ggplot2::economics 활용해서 날짜별 실업자 수에 대한 시계열 그래프를 그려라 

#+ 구연 답안:
ggplot2::economics
names(ggplot2::economics)
ggplot(data=economics, aes(x=date, y=unemploy)) + geom_line(color='red', lwd=1)

# 교수님 답안:
?economics
names(economics)
ggplot(data=economics, aes(x=date, y=unemploy))+ geom_line(color='red', size=3)

# Q3 ----               
# Q3 -1. ggplot2::economics를 활용해서 시계열 그래프 그리기 1. 날짜별 개인 저축률 그래프 + 2000년1월1일 - 2010년 12월 31일까지의 개인 저축율 그래프 

# Q3 - 1: 구연 답안
dataset <- ggplot2::economics
names(dataset)
ggplot(dataset, aes(x=date, y=psavert)) + geom_line(color='black', lwd=0.5)

# Q3 - 1:  교수님 답안
names(economics)
ggplot(data=economics, aes(x=date, y=psavert))+
  geom_line()

#+ Q3 - 2: 구연 답안
ddate <- subset(dataset, date >= as.Date("01/01/2000", format="%m%d%Y") & date < as.Date("12/31/2010",format="%m%d%Y"));ddate
ggplot(dataset, aes(x=ddate, y=psavert)) + geom_line(color='green', lwd=0.5)

#+ Q3 - 2: DJ 답안
ggplot(dataset, aes(date, psavert))+
  geom_line(col='green', size= 2)+
  scale_x_date(limits = as.Date(c("2001-01-01","2010-12-31")))

# Q3 -2: 교수님 답안 
str(economics);head(economics);class("2000-01-01")
as.Date("2000-01-01")
class(as.Date("2000-01-01"))

# Q4 ----               
# Q4 : my_mpg에서 구동방식별(drv)빈도 막대 그래프 & 속도로연비별(hwy) 빈도 막대그래프
#+ 구연 답안
names(my_mpg)
ggplot(data=my_mpg, aes(x=drv)) + geom_bar()

#+ 구연 답안
ggplot(data=my_mpg, aes(x=hwy)) + geom_bar()


# Q5 ----
#+ 구연 답안:
str(my_mpg)
names(my_mpg)
pairs.panels(my_mpg) 
ggplot(my_mpg, aes(x=cty, y=hwy))+geom_point(size=2, col="red")+geom_line(size=0.7, col="blue")

#+ 교수님 답안:
ggplot(data=my_mpg, aes(x=cty, y=hwy))+
  geom_point(size=2, col="red")+
  geom_line(col="blue")



#6. 그래프 가독성 높이기 ----

#6-1. 평생선 그래프 

economics
names(economics)
ggplot(data=economics, aes(x=data, y=psavert))+
  geom_line()+
  geom_hline(yintercept = 7) #y의 절편= intercept 를 셋팅 
median(economics$psavert)
mean(economics$psavert)

ggplot(data=economics, aes(x=date, y=psavert))+
  geom_line()+
  geom_hline(yintercept = median(economics$psavert))

# 6-2. 사선 그래프: geom_abline() ----

names(economics)
ggplot(data=economics, aes(x=date, y=psavert))+
  geom_line()+
  geom_abline(intercept = 6, slope = 0.0003)

# 6-3. 수직선 그리기: geom_vline ----

# 사용을 위해서는 xintercept 값을 잡아줘야함:

names(economics)

#저축률이 가장 높았던 시점
#+ SQL로 치면 -> select date from economics where psavert = max(psavert)

x_max <- (economics[economics$psavert == max(economics$psavert),])$date 

# option 1) 
ggplot(data=economics, aes(x=date, y=psavert))+
  geom_line()+
  geom_vline(xintercept = x_max)

# option 2)
ggplot(data=economics, aes(x=date, y=psavert))+
  geom_line()+
  geom_vline(xintercept = as.Date("2005-07-01"))

# 6-4. txt 레이블 입력: geom_text() ----
#+ hjust = 0, vjust=0: 해당 점의 오른쪽 위
#+ hjust / vjust = - 값: 오른쪽 위
#+ hjust / vjust = + 값: 왼쪽 아래 방향 
#+ horizontal just & vertical just 

names(my_mpg)
head(my_mpg$test)
ggplot(data=my_mpg, aes(x=manufacturer, y=model))+
  geom_point()+
  geom_text(aes(label=test, hjust=0, vjust=0))

ggplot(data=my_mpg, aes(x=manufacturer, y=model))+
  geom_point()+
  geom_text(aes(label=test, hjust=-2, vjust=-0.7))

# 6-5. 특정영역 강조: annotate() ----
#+ xmin: x_start, xmax: x_end 
#+ ymin: x_start, ymax: y_end

names(my_mpg)
ggplot(data=my_mpg, aes(x=manufacturer, y=class))+
  geom_point()+
  annotate("rect", xmin=10, xmax=16 , 
           ymin=1.7 , ymax=3.3, alpha=0.4,
           fill="blue")+
  annotate("segment", x=7, xend=11 , 
           y=1.5 , yend=2.5, col="red", size=2,
           arrow=arrow())+
  annotate("text", x=6, y=1.3 , 
           label="잘 팔리는 모델", size=6,
           col="darkblue")+
  labs(x="제조사", y="차종", title="제조사별 차종현황")+
  theme(plot.title = element_text(hjust = 0.5))



# 표본 추출(=sample) # 머신러닝 자주 사용 

?sample_n #dplyr::
#+ sample(dataset, n개) #n개 만큼 랜덤샘플 추출

sample_n(my_mpg,5)

set.seed(1234);sample_n(my_mpg,5)

?sample_frac #dplyr::
#+ sample(dataset, n비율) #n비율 만큼 랜덤샘플 추출 * 

sample_frac(my_mpg,0,01)

set.seed(234); sample_frac(my_mpg,0,01)

#VQ6. -----

#1. 구동방식별(drv) 평균 -hwy
install.packages("ggplot2")
library(ggplot2)

df_mpg <- my_mpg %>% 
  group_by(drv) %>% 
  summarise(m_hwy=mean(hwy))
df_mpg

# 2) 막대그래프 
#+ x: drv, y: m_hwy 

library(ggplot2)
search()
ggplot2::ggplot(data=df_mpg, aes(x=drv, y=m_hwy))+geom_col() 

# 막대그래프 정렬
ggplot(data=df_mpg, aes(x=reorder(drv, -m_hwy), y=m_hwy))+geom_col()

nrow(mtcars)
str(mtcars)

#7. 데이터 결측치 (missing value) ----
#7-1. NA 포함 dataset 생성

data.frame(mw=c("M", "M", "F", "M", NA, NA, "F", NA, "M", "F"),
           score = c(61, 98, 85, NA, 66, 72, 81, NA, 63, 74))

df_temp <- data.frame(mw=c("M", "M", "F", "M", NA, NA, "F", NA, "M", "F"),
           score = c(61, 98, 85, NA, 66, 72, 81, NA, 63, 74))

df_temp

#7-2.결측치 확인
is.na(df_temp)
table(is.na(df_temp))

# 7-2-1. 결측치가 있으면 안되는 이유
mean(df_temp$score)
max(df_temp$score)

#na가 있으면 평균을 구할 수가 없기 때문에 빼주고 계산하는 것
mean(df_temp$score, na.rm=T)
max(df_temp$score, na.rm=T)

# 7-2-2. 컬럼별로 결측치 확인

table(is.na(df_temp$mw))
table(is.na(df_temp$score))

# 7-3. 결측치를 제거 후, 분석 방법

library(dplyr)

# 7-3-1. 모든 행 제거 방식

df_real <- na.omit(df_temp)
mean(df_real$score)

# 7-3-2. 컬럼별 접근 제거

df_temp

df_temp %>% dplyr::filter(!is.na(df_temp$mw))
df_temp %>% dplyr::filter(!is.na(df_temp$score))

df_real12 <- df_temp %>% dplyr::filter(!is.na(df_temp$score)) 
mean(df_real12$score)


# 7-4. 결측치 제외 방법
#+ 나중에 NA가 측정될 것을 대비하는 것

# 7-4-1. 함수 레벨에서 결측치 제외
df_temp
mean(df_temp$score, na.rm = T)
sum(df_temp$score, na.rm = T)

# 7-4-2. NA값 제외 (실습)

#1) dataset 로딩

temp_exam <- read.csv("ss_exam.csv")
temp_exam

#2) NA 추가 및 

#NA 사전확인
names(temp_exam)

dim(temp_exam)
table(is.na(temp_exam))
sum(is.na(temp_exam))
colSums(temp_exam) #컬럼의 값들을 더해주는 것

#NA 추가

head(temp_exam)
temp_exam[c(2,3,7,11,23,25), "database"] <-NA

#NA 재확인
table(is.na(temp_exam))
sum(is.na(temp_exam))
colSums(temp_exam) #컬럼의 값들을 더해주는 것

colSums(temp_exam) # NA때문에 sum이 안된다.

#3) NA값 제외

temp_exam %>% summarise(mean(database))
temp_exam %>% summarise(mean(database, na.rm=T))

#7-5. 결측치 대체 방법
#+ 자주 대체되는 값: min, max, mean, median, dima_mode, 0

#7-5-1. 대체값 구하기
temp_exam2 <- read.csv("ss_exam.csv")
temp_exam2

temp_exam2[c(2,3,7,11,23,25), "database"] <- NA #NA처리

table(is.na(temp_exam2))

mean(temp_exam2$database, na.rm = T)
median(temp_exam2$database, na.rm = T)
subs <- median(temp_exam2$database, na.rm = T)
subs

#7-5-2. NA를 대체값으로 처리 후, 분석석

table(is.na(temp_exam2$database))
colSums(is.na(temp_exam2))

?ifelse()

temp_exam2$database

ifelse(is.na(temp_exam2$database), 333, temp_exam2$database)

temp_exam2$database <- ifelse(is.na(temp_exam2$database), subs, temp_exam2$database)

temp_exam2$database
temp_exam2 %>% summarise(m_db = mean(database))

#VQ7 ----

#1) mpg dataset에서 cty와 hwy 간의 관계파악을 위한 산점도를 구성하세요. 
#package & dataset : ggplot2::, ggplot2::mpg, ggplot2::miidwest
#x=cty, y=hwy

plot(x= my_mpg$cty, y = my_mpg$hwy)

#2) midwest dataset에서 전체인구(poptotl)와 popasian간의 관계를 확인하세요.
#산점도 : x=전체인구, y=아시안인구
#범위설정: 전체인구 <= 50만명, 아시아인구 <= 1만명
#산점도 그래프 저장(****.jpg)

midwext <- ggplot2::midwest

midwext
ggplot(midwest, aes(x=poptotal, y=popasian)) + geom_point()


# 2)
#+ 산점도: x=전체인구, y=아시아 인구
?midwest
ggplot(midwest, aes(x=poptotal, y=popasian))+
  geom_point()+
  xlim(0,500000)+
  ylim(0,10000)

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


# 2) 조장님
#+ 산점도: x=전체인구, y=아시아 인구
?midwest
ggplot(midwest, aes(x=poptotal, y=popasian))+
  geom_point()+
  xlim(0,500000)+
  ylim(0,10000)

# 7-1) 선생님 답안
search()

names(my_mpg)

gglot(data=my_mpg, aes(x= cty, y = hwy)) + geom_point()

# 7-2)
temp_mid <- ggplot(data=midwest, aes(x=poptotal, y=popasian))+ 
      geom_point()+ 
      xlim(0,500000)+ 
      ylim(0,10000)

class(temp_mid)

#저장

getwd()
?ggsave
ggsave(filename = "temp_mid.jpg", plot = temp_mid,
       width = 20, height = 15, units = 'cm', dpi=1000)

#unit = c("in", "cm", "mm", "px")

# 8. 이상치 (Outlier) ----
# 8-1. 논리적인 이상치

#8-1-1. 이상치 dataset 생성
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

# 8-3. 논리적인 이상치 제거
#+ filter() -> NA 변경 -> !is.na() 활용 분석석

# t_out$mw
ifelse(t_out$mw==4, NA, t_out$mw)

t_out$mw <- ifelse(t_out$mw==4, NA, t_out$mw)
t_out$mw


#t_out$survey
ifelse(t_out$survey > 5, NA, t_out$survey)
t_out$survey <- ifelse(t_out$survey > 5, NA, t_out$survey)

t_out$survey


# 8-1-4. 결측치 제거 후, 분석

library(dplyr);search()

t_out %>% 
  dplyr::filter(!is.na(mw)&!is.na(survey)) %>% 
  group_by(mw) %>% 
  summarise(m_survey = mean(survey))

# 8-2. 극단적인 이상치 ----
#+ 논리적인 판단 기준: 성인 사람의 키 (0.5~2.5m)
#+ 통계적인 판단 기준: sd+-3 이상/이하 or +- 1.5IQR 이상/이하

# 8-2-1. 극단적인 이상치 확인

install.packages(ggplot2)

out_mpg <- ggplot2::mpg
dim(out_mpg)
out_mpg

boxPlot(out_mpg$hwy)
boxPlot(out_mpg$hwy)$stats
car::Boxplot(out_mpg$hwy)

# 8-2-2. 극단치 제거
#+ 조건에 부합하지 않는 값은 NA 변경 -> NA 제외 분석
#+ 조건: 12~37

?ifelse
ifelse(out_mpg$hwy < 12 | out_mpg$hwy >37, NA, out_mpg$hwy)

table(ifelse(out_mpg$hwy < 12 | out_mpg$hwy >37, NA, out_mpg$hwy))
table((ifelse(out_mpg$hwy < 12 | out_mpg$hwy >37, NA, out_mpg$hwy)), useNA = "ifany")


out_mpg$hwy <- ifelse(out_mpg$hwy < 12 | out_mpg$hwy >37, NA, out_mpg$hwy)

table(is.na(out_mpg$hwy))

# 8-2-3. 결측치 제외 후 분석

dim(out_mpg)

out_mpg %>% 
  group_by(drv) %>% 
  summarise(mean(hwy))

out_mpg %>% 
  group_by(drv) %>% 
  summarise(m_hwy = mean(hwy, na.rm=T), n=n())

#VQ8. ----

# 1. 제조사의 class중 중형(midsize)의 평균 도시연비(cty)가 가장 높은 회사 5곳을 표기 하시오
#+ 단, 막대그래프는 도시연비가 높은 순으로 정렬
#+ ggplot2::mpg

View(out_mpg)

my_mpg <- ggplot2::mpg

names(my_mpg)
unique(my_mpg)



my_mpg %>% 
  select(1,2,11,cty) %>% 
  dplyr::filter(class == "midsize") %>% 
  group_by(manufacturer) %>% 
  summarise(m_cty=mean(cty)) %>% 
  arrange(-m_cty) %>% 
  head(5)
  

p_mpg

#plot

ggplot(data=p_mpg, aes(x=manufacturer, y=m_cty))+geom_point()
ggplot(data=p_mpg, aes(x=manufacturer, y=m_cty))+
  geom_point(col="red", size=5)

ggplot(data=p_mpg, aes(x=reorder(manufacturer, m_cty), y=m_cty))+
  geom_point(col="red", size=5) #정렬
ggplot(data=p_mpg, aes(x=reorder(manufacturer, -m_cty), y=m_cty))+
  geom_point(col="red", size=5) #역정렬

# plot-bar / col
ggplot(data=p_mpg, aes(x=manufacturer, y=m_cty))+geom_col()
ggplot(data=p_mpg, aes(x=reorder(manufacturer, -m_cty), y=m_cty))+geom_col()



# 2. 자동차 중에서 어떤 class가 가장 많은 지 , 자동차 종류별 빈도를 막대그래프로 표기하시오

bar_mpg <- my_mpg %>% count(class) %>% arrange(-n)

my_mpg %>% 
  group_by(class) %>% 
  summarise(count = n()) %>% 
  arrange(-count)


bar_mpg


#plot
ggplot(data=bar_mpg, aes(x=class, y=n))+geom_col()
ggplot(data=bar_mpg, aes(x=reorder(class, -n), y=n))+geom_col()


#VQ9. 상자 그림
# 하기 자동차 종류(class)의 도시연비(cty) 를 box-plot으로 비교분석하세요

tt <- unique(my_mpg$class)

tt[1]

tt[c(-4,-7)]

t_mpg <- my_mpg %>% 
  select(class, cty) %>% 
  dplyr::filter(class %in% c(tt[c(-4,-7)]))


#plot
ggplot(data= t_mpg, aes(x=class, y=cty))+geom_boxplot()  
box_p <- ggplot(data= t_mpg, aes(x=class, y=cty))+geom_boxplot()

ggsave(filename = "box_p.jpg", plot=box_p)  

# A. map (코로플레스도, choropleth map)----

# 0. packages & datasets ----
rm(list = ls())
ls()

# 1)pkg: ggiraphExtra #단계별 구분도 관련 함수 
                      # 단계별 구분도 관련 함수
                      #+ ggChorooleth(), 단계구분도 함수
  
# 2) pkg: mapproj     # 단계별 구분도 plotting 시에 필수            
# 3) pkg: maps        # 지도정보
# 4) pkg: ggplot2     # map_data()
                      #+ map_data를 data.frame으로 변환

# 5) pkg: tibble      #rownames_to_column()

options("install.lock"=FALSE)

install.packages("ggiraphExtra")
install.packages("mapproj")
install.packages("maps")
install.packages("ggplot2")
install.packages("tibble")

library(ggiraphExtra)
library(mapproj)
library(maps)
library(ggplot2)
library(tibble)

search()

?map_data()
map_data("state")
dim(map_data("state"))

# 0-2. dataset

data(package="datasets")
head(USArrests)
?USArrests

my_USArr <- USArrests
names(my_USArr)


# 1. data 전처리 (data pre-processing)----

names(USArrests)

# 1-1.
my_USArr <- rownames_to_column(my_USArr, var = 'state')
names(my_USArr)

head(my_USArr)
dim(my_USArr)

# 1-2. state 소문자로----
?tolower()
my_USArr$state <- tolower(my_USArr$state)
head(my_USArr)

# 2. 지도 준비 (map preparation)

# 2-1. 지도확인 ----
maps::map("world")
maps::map("usa")
maps::map("state")

# 2-2. 지도 data 가져오기 ----

USA_map <- map_data("state")
names(USA_map)
head(USA_map)
dim(USA_map)
str(USA_map)

# 3. 코로플레스도(단계구분도) ----

names(my_USArr) # biz data
class(my_USArr)
names(USA_map)  # map data
class(USA_map)

?ggChoropleth
ggChoropleth(data = my_USArr,
             map = USA_map,
             aes(fill=Murder,
                 map_id=state),
             title = "USA Arrest Rate(Murder)",
             color ="darkblue"
             )

# 4. 인터렉티브 map

ggChoropleth(data = my_USArr,
             map = USA_map,
             aes(fill=Murder,
                 map_id=state),
             title = "USA Arrest Rate(Murder)",
             color ="darkblue",
             interactive = T
)

# 5. HTML 파일 저장하기


# -----------------------4/1--------
v.R
# B. 인터랙티브 그래프(Interractive Graph)

# pkg
install.packages("plotly")
library(plotly)
"plotly" %in% install.packages()  # plotly설치되었는지 확인

search()

# dataset
my_mpg <- mpg
my_diamonds <- diamonds

names(my_mpg)
names(my_diamonds)

# 1. my_mpg

ggplot(data=my_mpg, aes(x=displ, y=hwy, col=drv))+
  geom_point()

mp<-ggplot(data=my_mpg, aes(x=displ, y=hwy, col=drv))+
  geom_point()

# 
?ggplotly()#plotly:: 패키지 내장데이터 
ggplotly(mp)

# 2) my_diamonds

names(my_diamonds)
str(my_diamonds)
levels(my_diamonds$cut)

ggplot(data=my_diamonds, aes(x=cut, fill=clarity))+
  geom_bar()

dp0 <- ggplot(data=my_diamonds, aes(x=cut, fill=clarity))+
  geom_bar(position = "dodge")

ggplotly(dp0)

# C. R마크다운(Markdown)

# D.데이터 수집 기본(Data Scraping Basics)

# 1-1. pkgs
install.packages("htmltab")
library(htmltab);search()

# 1-2. landing page url

url_01 <-  "https://en.wikipedia.org/wiki/List_of_most_common_surnames_in_South_America"

url_01 <- "https://en.wikipedia.org/wiki/List_of_most_common_surnames_in_North_America"

url_01

#1-3. htmltab() 함수 활용

?htmltab() #html패키지 탭에서 htmltab함수를 사용

my_sur <-htmltab(doc =url_01,
                 which = 9,
                 Encoding="UTF=8", 
                 stringAsFactors=F)
my_sur

my_sur <-htmltab(doc =url_01,
                 which = 2,
                 Encoding="UTF=8", 
                 stringAsFactors=F)
my_sur

head(my_sur)
dim(my_sur)
names(my_sur)
my_sur[,1]  # 전체에서 1번째 컬럼을 읽겠다 
str(my_sur) # 홈페이지에서 데이터를 긁어서 
# 데이터 프레임을 받아내는 작업이 htmltab함수다.

# 2-1. paks ----

install.packages(c("rvest","readtext"))
library(rvest)
library(readtext)
search()

# 2-2. 랜딩페이지 url 

url = "https://en.wikipedia.org/wiki/List_of_most_common_surnames_in_North_America"

url <- "https://en.wikipedia.org/wiki/List_of_most_common_surnames_in_North_America"

# 2-3. read_html() 크롤링이 된거야 
?read_html()

read_html(url) #웹사이트를 XML로 가지고 온 것

ss <- read_html(url)
ss

class(ss)
names(ss)
ss$node
ss$doc

# 2-4. 태그 활용 데이터 추출 찾는거가 스크랩핑 
?html_node #rvest:;

ss2 <-ss %>% 
  html_nodes("p") %>%  #XML 객체에서 관련 노드 추출
  html_text()           # 관련 태그에서 데이터 추출

ss %>% 
  html_node("p") #XML 객체를 가지고 온 것이야 p 태그를 가지고 온 것 

class(ss2) # vector로 가져왔다. 
length(ss2)     

#q11

weather_url = "https://forecast.weather.gov/MapClick.php?lat=37.7771&lon=-122.4196#.Xl0j6BNKhTY"
weather_url <- "https://forecast.weather.gov/MapClick.php?lat=37.7771&lon=-122.4196#.Xl0j6BNKhTY"

wea <- read_html(weather_url)
class(wea)
names(wea)

wea_short <- wea %>% 
  html_nodes("p") %>% 
  html_text("short_desc")

wea_short <- wea %>% 
  html_nodes(".short_desc") %>% 
  html_text()

install.packages("stringr")
library(stringr)

View(wea_short)
matrix()

#선생님
# 0. pkgs
library(rvest);search()
library(dplyr);search()
library(stringr)   # str_sub()      # 문자 자르기
library(readr)     # parse_number() #숫자만
library(data.table);search() # %like% 연산자 


# 1. Crawling
forecast <- read_html("https://forecast.weather.gov/MapClick.php?lat=37.7771&lon=-122.4196#.Xl0j6BNKhTY");forecast

# 2. Scraping 

f1 <- forecast %>% 
  html_nodes(".period-name") %>% 
  html_text();f1

f2 <- forecast %>% 
  html_nodes(".temp") %>% 
  html_text();f2

f3 <- forecast %>% 
  html_nodes(".short-desc") %>% 
  html_text();f3

# 3. data pre-processing

t_weather <- data.frame(f1, f2, f3)
class(t_weather)
head(t_weather)

# rename    dplyr::

t_weather <- rename(t_weather, day_week=f1,
                    temp_F=f2,
                    detail=f3)

dim(t_weather)
head(t_weather)

# 특정문자(문자, 숫자) 변경

st <- str_sub(t_weather$temp_F, 1,1);st
pn <- parse_number(t_weather$temp_F);pn

t_weather$temp_F <- paste(st,pn)
head(t_weather)

# 4. non Clear 날씨 정보
names(t_weather)
head(t_weather,2)

t_weather %>% 
  filter(!(detail %like% 'Clear'))


#Q12
#시계열 데이터에 대한 인터렉티브 그래프

install.packages("dygraphs")
library(dygraphs)
library(xts)
library(ggplot2)

eco <- ggplot2::economics
eco
head(eco)

#1. 실업률 시계열 dataset

?xts
xts(eco$unemploy, order.by = eco$date)
my_unemp_d <- xts(eco$unemploy, order.by = eco$date)
my_une_1000 <- xts(eco$unemploy/1000, order.by = eco$date)


class(my_unemp_d)
rownames(my_unemp_d)
dim(my_unemp_d)
head(my_unemp_d)
names(my_unemp_d)

#2. 저축률 시계열
my_ps_d <- xts(eco$psavert, order.by = eco$date)
my_ps_d

#3. 실업률 + 저축률 시계열

#name 없음
names(my_une_1000)
names(my_ps_d)

#단순컬럼결합, cbind()

cbind(my_une_1000, my_ps_d)
names(cbind(my_une_1000, my_ps_D))

#단순컬럼결합
my_eco <- cbind(my_une_1000, my_ps_d)
dim(my_eco)
head(my_eco)

#4. 시계열 인터렉티브 그래프
#+ dygraph(x)는 벡터 또는 객체
#+ dyRangeSelector() 날짜 범위 하단에

dygraph(my_une_1000)
dygraph(my_ps_d)
dygraph(my_eco)

dygraph(my_eco) %>% dyRangeSelector()


# Z검정 - 검정통계량 구하기
350/100   # 3.5
280/100   # 2.8   # 3.5 + 2.8 = 6.3
a <- sqrt(6.3);a

250-246   # 4

# 검정통계량 =
4/a       # 1.593638

z = 250-246/sqrt((350/100)+(280/100))
z = (mean_d1 - mean_d2) / sqrt((var_d1/n_d1) + (var_d2/n_d2))

#표준정규분포 (mean=0, sd=1)

#1) data 11개
par("mar")
par(mar=c(1,1,1,1))
x<- (-5:5)
y <- dnorm(x,0,1)
plot(x,y,type="l")

# 3. Test
# rm(list=ls())

z_ds <- read.csv("z_test.csv")
str(z_ds)
head(z_ds)
names(z_ds)

unique((z_ds$group))

#3-1.data pre-processing
#data grouping

zg_A <- z_ds[z_ds$group == 'A', 2:3]
zg_B <- z_ds[z_ds$group == 'B', 2:3]
zg_A
zg_B

#평균
mean(zg_A$height)
mean(zg_B$height)

#분산
var(zg_A$height)
var(zg_B$height)

#표준편차
sd(zg_A$height)
sd(zg_B$height)

length(zg_A$height)
length(zg_B$height)

#귀무: A와 B그룹의 평균의 차이가 없음 -> 기각
#대립: B그룹이 A그룹보다 평균키차이가 큼(차이가 있음) -> 채택

n_d1=length(zg_A$height)
n_d2=length(zg_B$height)

mean_d1=mean(zg_A$height)
mean_d2=mean(zg_B$height)

var_d1=var(zg_A$height)
var_d2=var(zg_B$height)

z = (mean_d1 - mean_d2) / sqrt((var_d1/n_d1) + (var_d2/n_d2))
z_abs=abs(z)
z_abs

my_pv = 1-pnorm(z_abs)
my_pv

#********************
#t검정

t.test(zg_A$height, zg_B$height,
       var.equal = T,
       alternative = "less",
       conf.level = T)


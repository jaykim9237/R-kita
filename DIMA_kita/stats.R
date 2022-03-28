# I. 기술통계량 ----

# 1. 집중경향치 (central tendency) ----

# 1) 평균값, 절사평균값

mean(my_mpg$cty)             # 16.86
mean(my_mpg$cty, trim = 0.1) # 16.61 양극단에서 10% 제외 후 낸 평균값

search()

# 2) 중간값
median(my_mpg$cty)  # 17

# 3) 최빈값 (mode)

table(my_mpg$cty)
sort(table(my_mpg$cty), decreasing = T)
max(sort(table(my_mpg$cty), decreasing = T))

#질문----
names(sort(table(my_mpg$cty), decreasing = T)[1])  # 18 : 값
max(sort(table(my_mpg$cty), decreasing = T))       # 26 : 횟수

#which : 특정값의 위치를 찾을 수 있는 함수 
which.max(table(my_mpg$cty))                       



# 2. 변산성 측정치 (dispersion) ----

# 1) 데이터의 범위 (최대, 최소 등)
min(my_mpg$cty)   # 최소: 9
max(my_mpg$cty)   # 최대: 35

# range (범위)
max(my_mpg$cty) - min(my_mpg$cty)  # 범위 : 26

# 변산성 측정치 : 자료가 흩어져 있는 정도
max(x)-min(x)

# boxplot **

?boxplot()          # graphics::
boxplot(my_mpg$cty)

options("install.lock"=FALSE)

install.packages("car")   # Boxplot 권장
car::Boxplot(my_mpg$cty)

my_mpg[222, "cty"]    # 222행, cty 열 = 35
my_mpg[213, "cty"]    # 213행, cty 열 = 33

# 2) 사분위수와 백분위수

# 사분위수 범위(3분위 수 - 1분위 수)
# IQR :  숫자 자체로 특정한 의미를 가지지 않고, 크냐 작냐의 정도로 중앙값(median)에서 얼마나 데이터가 퍼져있는지를 알아볼 수 있는 척도(measure)
IQR(my_mpg$cty)   # 5 (19-14)

# 백분위수
quantile(my_mpg$cty, probs = 0)    # 최소 min, 9
quantile(my_mpg$cty, probs = 0.25) # 1분위, 14
quantile(my_mpg$cty, probs = 0.5)  # 중간값 median, 17
quantile(my_mpg$cty, probs = 0.75) # 3분위, 19
quantile(my_mpg$cty, probs = 1)    # 최대 max, 35

# 요약 통계량
summary(my_mpg$cty)

# 3) 분산, 표준편차

var(my_mpg$cty)  # 분산: 18.11
sd(my_mpg$cty)   # 표준편차 : 4.26

sqrt(4)  # √ 
sqrt(var(my_mpg$cty))   # √ 분산 = 표준편차


# 3. 분포 대칭성 (distribution) ----

# 1) 왜도 (skewness, 좌우대칭도)
#+ sk > 0 : 꼬리가 오른쪽 (머리 좌측)
#+ sk < 0 : 꼬리가 왼쪽 (머리 우측)
#+ |3| 미만, |3| 이상이면 ??? 이상하다고 의심을 해봐야한다.

install.packages("psych")
#+ skew() 함수 (분포도 확인)
install.packages("fBasics")
#+ skewness() 함수 (분포도 확인)
#추가 패키지 : moments

library(psych)
library(fBasics)

search()

?skewness()
skewness(my_mpg$cty) #0.78 이기 때문에 꼬리가 오른쪽
skewness(my_mpg$hwy) #0.36 이기 때문에 꼬리가 오른쪽

# 2 첨도 (kurtosis, 뾰쪽한 정도)
#+ kt > 0 : nd보다 위로 뾰쪽
#+ kt < 0 : nd보다 아래로 납작
#+ |7| 미만, |7| 이상이면 ??? (재점검해야함)
#+ 위로 많이 많이 뾰족하면 어떤의미가 있을까 ? -> 아웃라이어가 많다...?  아웃라이어 : 본체에서 분리되거나 따로 분류되어 있는 물건

install.packages("psych")
library(psych)
#+ kurtosi() 함수 
install.packages("fBasics")
#+ kurtosis() 함수 

kurtosi(my_mpg$cty)
kurtosis(my_mpg$cty) # 1.43, nd뾰쪽
kurtosis(my_mpg$hwy) # 0.137, nd와 살짝 뾰쪽

kurtosis(my_mpg$cty, na.rm=T) # na 없음 

# 4. 데이터 분포도 ----

par(mar=c(1,1,1,1))
dev.off()

# 창나누기
#+ par(mfrow=c(2,2))   # 2행 2열 plot의 갯수 => 4개, 행중심 
#+ par(mfcol=c(2,2))   # 2행 2열, 열 중심  
#+ MFROW stands for number of multiple figures 

par(mfrow=c(2,2))
plot(my_mpg$cty, type="h", main="hist_mm$cty")
plot(my_mpg$cty, type="l", main="line_mm$cty")
plot(my_mpg$cty, type="p", main="point_mm$cty")

?density()
plot(density(my_mpg$cty), main="density_mm$cty") #밀도 (빈도) 함수

#### 0323 조별 퀴즈: mean()함수에서 trim parameter 는 dataset의 양끝단에서 절삭하는 비율을 의미한다.해당 파라메터의 값이 0.1 (trim = 0.1)일 때, 하기 중 어떤 내용인지 실습으로 증명 하시오.
#+ 1) 양끝단을 합하여 10% 절삭 (하 -5% + 상-5%)
#+ 2) 양끝단에서 10%씩 절삭 (하 -10% + 상-10%)

#+ 구연 답안 -> 2번 양 끝단에서 10%씩 절삭 (하 -10% + 상-10%)
zz = c(9,1,4,5,6,2,7,8,10,3) #벡터생성
sort(zz) # [1] 1  2  3  4  5  6  7  8  9 10
mean(zz, trim=0.1) #양 끝단에서 10% 절사평균한 결과는: 5.5
#+ 1과 10을 제외한 나머지 / 개수 -> 44/ 8 = 5.5

#+ 교수님 답안 :
names(my_mpg)
mean(my_mpg$cty)           # 16.859
mean(my_mpg$cty, trim=0.1) # 16.612, 10% 제거
16.859 - 16.612           # 0.247, 평균 - 절사 평균 

# boxplot
par(mfrow=c(1,1))
boxplot(my_mpg$cty)

# 2) 절삭 기준 찾기
dim(my_mpg)                                # 234 14
length(my_mpg$cty)                         # 234
length(unique(my_mpg$cty))                 # 21개 값, unique cty값
sort(unique(my_mpg$cty))                   # 9~ 35 , 정렬 
sort(unique(my_mpg$cty), decreasing = T)   # 35 ~ 9, 역정렬

table(my_mpg$cty)
sort(table(my_mpg$cty), decreasing = T)    #18(26회)~35(1회)

# 백분위수 : 9 ~ 35
quantile(my_mpg$cty, prob=0)              # 9, min
quantile(my_mpg$cty, prob=0.25)           # 14, 1Q
quantile(my_mpg$cty, prob=0.5)            # 17, median 
quantile(my_mpg$cty, prob=0.75)           # 19, 3Q
quantile(my_mpg$cty, prob=1)              # 35, max

# 양극단 5% : 5 ~ 24
quantile(my_mpg$cty, prob=0.95)           # 24, 95% 지점
quantile(my_mpg$cty, prob=0.05)           # 11, 5% 지점

# 양극단 10% : 11 ~ 21
quantile(my_mpg$cty, prob=0.9)           # 21, 90% 지점
quantile(my_mpg$cty, prob=0.1)           # 11, 5% 지점

# 3) 양극단 절삭기준 데이터의 $ 확인

# 3-1) 5% : 11 ~ 24  # 양쪽에서 5%씩 제거해서 종합 10% 제거?
#+ 안빼고 (11,24) : 6.41% => 10% *
#+ 빼고 (11,24) : 17.09% => 10%
sort(unique(my_mpg$cty))
paste(sort(unique(my_mpg$cty)), collapse = ",")

#++++ 안뺐을때:
my_mpg$cty %in% c(11,12,13,14,15,16,17,18,19,20,21,22,23,24)
table(my_mpg$cty %in% c(11,12,13,14,15,16,17,18,19,20,21,22,23,24))
# F: 15 T:219

prop.table(table(my_mpg$cty %in% c(11,12,13,14,15,16,17,18,19,20,21,22,23,24))) # F: 0.06410256   T: 0.93589744 
round(prop.table(table(my_mpg$cty %in% c(11,12,13,14,15,16,17,18,19,20,21,22,23,24)))*100,2) # F:6.41  T:93.59 

paste(round(prop.table(table(my_mpg$cty %in% c(11,12,13,14,15,16,17,18,19,20,21,22,23,24)))*100,2),"%") # F: 6.41 % T: 93.59 %       

#++++ 뺐을때:
my_mpg$cty %in% c(12,13,14,15,16,17,18,19,20,21,22,23)
table(my_mpg$cty %in% c(12,13,14,15,16,17,18,19,20,21,22,23))
# F: 40 T:194

prop.table(table(my_mpg$cty %in% c(12,13,14,15,16,17,18,19,20,21,22,23))) # F: 0.1709402 T: 0.8290598 
round(prop.table(table(my_mpg$cty %in% c(12,13,14,15,16,17,18,19,20,21,22,23)))*100,2) # F: 17.09 T: 82.91   

paste(round(prop.table(table(my_mpg$cty %in% c(12,13,14,15,16,17,18,19,20,21,22,23)))*100,2),"%")  # F: 17.09 % T: 82.91 %


# 3-2) 10% : 11 ~ 21  
#++++ 안빼고 (11,21) : 11.54% => 10%
#++++ 빼고 (11, 21) : 29.91% => 10%%
sort(unique(my_mpg$cty))
paste(sort(unique(my_mpg$cty)), collapse = ",")

#++++ 안뺐을때:
my_mpg$cty %in% c(11,12,13,14,15,16,17,18,19,20,21)
table(my_mpg$cty %in% c(11,12,13,14,15,16,17,18,19,20,21))
# F: 27 T:207

prop.table(table(my_mpg$cty %in% c(11,12,13,14,15,16,17,18,19,20,21))) # F: 0.1153846  T: 0.8846154
round(prop.table(table(my_mpg$cty %in% c(11,12,13,14,15,16,17,18,19,20,21)))*100,2) # F:11.54 T:88.46
paste(round(prop.table(table(my_mpg$cty %in% c(11,12,13,14,15,16,17,18,19,20,21)))*100,2),"%") # F: 11.54%  T: 88.46% 


#++++ 뺐을때:
my_mpg$cty %in% c(12,13,14,15,16,17,18,19,20)
table(my_mpg$cty %in% c(12,13,14,15,16,17,18,19,20))
# F: 70 T:164

prop.table(table(my_mpg$cty %in% c(12,13,14,15,16,17,18,19,20))) # F: 0.2991453  T: 0.7008547
round(prop.table(table(my_mpg$cty %in% c(12,13,14,15,16,17,18,19,20)))*100,2) # F: 29.91 T: 70.09 

paste(round(prop.table(table(my_mpg$cty %in% c(12,13,14,15,16,17,18,19,20)))*100,2),"%")  # F: 29.91% T: 70.09%

# 4) 실제 절삭된 데이터의 평균 구하기 (trim 사용 X)
#실제 평균값을 계산하여 
mean(my_mpg$cty) # 16.859
o.trim <- mean(my_mpg$cty, trim=0.1);o.trim #16.612   10%제거
16.859 - 16.612 # 0.247, 평균 - 절사 평균

o.trim

# 4-1) 양 끝단 5% 제외 후 (대상: 11~24) ----
library(dplyr);search()

my_mpg$cty
t5.cty <- my_mpg %>% filter(between(cty,11,24)) %>%
  select(cty)
t5.mean <- mean(t5.cty$cty)
t5.mean # 따라서 5% 제거 평균은 16.525 이다.

# 4-2) 양 끝단 10% 제외 후 (대상: 11~21)
t10.cty <- my_mpg %>% filter(between(cty,11,21)) %>%
  select(cty);
t10.mean <- mean(t10.cty$cty)
t10.mean # 따라서 10% 제거 평균은 16.14493이다.

# 5. 오차

# 5% 트림파라미터 값과 차이가 많이 안 난다는 것이 5%와 유사하다는 것이구나!를 알 수 있다.
paste(round((o.trim - t5.mean),2), "오차(5%)")

# 10% 
paste(round((o.trim - t10.mean),2), "오차(10%)")






###############03.28 (월)


#Q4. ss_exam을 활용하여 그래프를 그리세요
head(my_exam)

search()
install.packages("psych")
library(psych)
# 1. 모든 과목에 대한 표준편차, 분산 + 산점도
# 내가한거
sd(my_exam$database)   # 표준편차
sd(my_exam$java)   # 표준편차
sd(my_exam$japan)   # 표준편차
sd(my_exam$eng)   # 표준편차

var(my_exam$database)  # 분산
var(my_exam$java)  # 분산
var(my_exam$japan)  # 분산
var(my_exam$eng)  # 분산

par(mfrow=c(2,2))
plot(my_exam$java, type="p", main="database")
plot(my_exam$java, type="p", main="java")
plot(my_exam$japan, type="p", main="japan")
plot(my_exam$eng, type="p", main="eng")

# 2. 모든 과목에 대한 왜도 첨도 + 분포도

#왜도 내가 한거
skewness(my_exam$java)
skewness(my_exam$japan)
skewness(my_exam$eng)

#첨도 내가 한거
kurtosi(my_exam$class)

#분포도 내가 한거
plot(density(my_exam$java), main="density_java") #밀도 (빈도) 함수
plot(density(my_exam$japan), main="density_japan") #밀도 (빈도) 함수
plot(density(my_exam$eng), main="density_eng") #밀도 (빈도) 함수

#선생님 답안

#분산 var

v_ex <- my_exam %>% 
  select(everything()) %>% 
  summarise(v_db=var(database),
            v_jv=var(java),
            v_jp=var(japan),
            v_eg=var(eng))

v_ex <- round(sd_ex, 3)
v_ex

#표준편차 sd
sd_ex <- my_exam %>% 
  select(everything()) %>% 
  summarise(sd_db=sd(database),
            sd_jv=sd(java),
            sd_jp=sd(japan),
            sd_eg=sd(eng))

sd_ex <- round(sd_ex, 3)

sd_ex

#산점도
names(my_exam)
View(my_exam)

x11()
par(mar=c(1,1,1,1))
par(mfrow=c(2,2))

#점심시간 이전
plot(my_exam$database, main=paste("db_sd:",sd_ex[1], "db_var:",v_ex[1]), col="red")
plot(my_exam$java, main=paste("java_sd:",sd_ex[2], "java_var:",v_ex[2]), col="blue")
plot(my_exam$japan, main=paste("japan_sd:",sd_ex[3], "japan_var:",v_ex[3]), col="red")
plot(my_exam$eng, main=paste("eng_sd:",sd_ex[4], "eng_var:",v_ex[4]), col="blue")

#점심시간 이후
name(my_exam)

x11()
par(mar=c(1,1,1,1))
par(mfrow=c(2,2))
plot(my_exam$database, col="darkred", pch=1, cex=1, xlab="DATABASE", 
     main=paste("db_sd:",sd_ex[1], "db_var:",v_ex[1]))
points(15,mean(my_exam$database),cex=3)

plot(my_exam$java, col="red", pch=3, cex=2, xlab="JAVA", 
     main=paste("jv_sd:",sd_ex[2], "jv_var:",v_ex[2]))
points(15,mean(my_exam$java),cex=3)

plot(my_exam$java, col="blue", pch=4, cex=2, xlab="JAPAN", 
     main=paste("jv_jp:",sd_ex[3], "jp_var:",v_ex[3]))
points(15,mean(my_exam$japan),cex=3)

plot(my_exam$eng, col="blue", pch=5, cex=2, xlab="ENG", 
     main=paste("jv_e:",sd_ex[4], "e_var:",v_ex[4]))
points(15,mean(my_exam$eng),cex=3)



#분포도

library(fBasics)

sk_ex <- my_exam %>% 
  select(everything()) %>% 
  summarise(sk_db=skewness(database),
            sk_java=skewness(java),
            sk_japan=skewness(japan),
            sk_eng=skewness(eng)
  )

sk_ex <- round(sk_ex,3)
sk_ex


kt_ex <- my_exam %>% 
  select(everything()) %>% 
  summarise(kt_db=kurtosis(database),
            kt_java=kurtosis(java),
            kt_japan=kurtosis(japan),
            kt_eng=kurtosis(eng))

kt_ex <- round(kt_ex,3);kt_ex

x11();par(mfrow=c(2,2))
plot(density(my_exam$database), 
     main= paste("db_sk:", sk_ex[1]," kt:", kt_ex[1]))
plot(density(my_exam$java), 
     main= paste("java_sk:", sk_ex[2]," kt:", kt_ex[2]))
plot(density(my_exam$japan), 
     main= paste("japan_sk:", sk_ex[3]," kt:", kt_ex[3]))
plot(density(my_exam$eng), 
     main= paste("eng_sk:", sk_ex[4], " kt:", kt_ex[4]))

#4-3). 표준정규분포 ----
#+ standard normal distribution
#+ dnorm(x, mean=0, sd=1)
#+ => 특정 관측값(x)에 대한 y축의 값(확률밀도함수 값)을 return

#1)

temp <- seq(-5,5);temp #-5 ~ 5
summary(temp)

mean(temp) #0
var(temp) #11
sd(temp)  #3.316625

sqrt(var(temp)) #표준편차 = 루트(분산)
plot(temp)

#2)

xx <- seq(-5,5, length=300);xx
summary(xx)

mean(xx)
median(xx)
var(xx)
sd(xx)

plot(xx)

#3) dnorm() #(default) mean=0, sd=0

#temp
dnorm(temp)
dnorm(temp, mean=0, sd=1) #snd(표준정규분포)

all.equal(dnorm(temp), dnorm(temp, mean=0, sd=1))

#xx

dnorm(xx)
dnorm(xx, mean=0, sd=1)

# 4)분포도

par(mfrow=c(2,2))
par(mar=c(1,1,1,1))
#temp
temp
length(temp)
summary(temp)
plot(temp,main="단순 산점도")
plot(density(temp),main="밀도 추정") #추정치야 아래 x축을 보면 값이 다르다는 것을 알 수 있어
plot(dnorm(temp), type="l", main="표준정규분포?")

#+ mean=0, sd=1
#+ 실제: mean=0, sd=3.317

#기본값과 다를 때는 직접 넣어줘야하는 것
plot(dnorm(temp, mean = 0, sd=3.317), type="l", main="실제분포도?")

#xx
xx
sd(xx)
length(temp)
summary(xx)
plot(xx,main="단순 산점도")
plot(density(xx),main="밀도 추정") #추정치야 아래 x축을 보면 값이 다르다는 것을 알 수 있어
plot(dnorm(xx), type="l", main="표준정규분포?")

#+ mean=0, sd=1
#+ 실제: mean=0, sd=2.901
plot(dnorm(xx, mean = 0, sd=2.901), type="l", main="실제분포도?")

#밀도함수랑 위에 함수들이랑 x값이 다를걸? 그거 맞춰줘야해 ! 앞쪽에 xx를 넣어줘야해
plot(xx, dnorm(xx), type="l", main="xx_n(0,1)")
plot(xx, dnorm(xx, mean = 0, sd=2.901), type="l", main="xx_n(0, 2.901)")

#Q5 ----
#+ dataset: my_exam, 4개의 변수(db,java,japan,eng)
#+ 산점도, 밀도추정, 표준정규분포, n(평균,1), n(0,표준편차), 실분포도도
summary(my_exam$database)

plot(my_exam$database)
plot(density(my_exam$database))
plot(my_exam$database,dnorm(my_exam$database, mean = 0, sd=1), type="l")
plot(my_exam$database,dnorm(my_exam$database, mean = 56.133 , sd=1), type="l")
plot(my_exam$database,dnorm(my_exam$database, mean = 0 , sd=19.595), type="l")
plot(my_exam$database,dnorm(my_exam$database, mean = 56.133 , sd=19.595), type="l")


plot(my_exam$java)
plot(density(my_exam$java))
plot(my_exam$java,dnorm(my_exam$java, mean = 0, sd=1), type="l")
plot(my_exam$java,dnorm(my_exam$java, mean = 84.533 , sd=1), type="l")
plot(my_exam$java,dnorm(my_exam$java, mean = 0 , sd=12.173), type="l")
plot(my_exam$java,dnorm(my_exam$java, mean = 84.533 , sd=12.173), type="l")

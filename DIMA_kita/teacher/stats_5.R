# 통계와 확률(Statistics & Probabilities)

# I. 기술통계량 ----

# 1. 집중경향치 (central tendency)----

# 1) 평균값, 절사평균값
mean(my_mpg$cty)              # 16.86
mean(my_mpg$cty, trim = 0.1)  # 16.61 양극단에서 10% 절삭 후 평균

# 2) 중간값
median(my_mpg$cty)   # 17

# 3)최빈값(mode) ?? ----

table(my_mpg$cty)
max(table(my_mpg$cty))

sort(table(my_mpg$cty),decreasing = T)
max(sort(table(my_mpg$cty),decreasing = T))

names(sort(table(my_mpg$cty),decreasing = T)[1])  # 18 : 값
max(sort(table(my_mpg$cty),decreasing = T))       # 26 : 횟수

# 2. 변산성 측정치 (dispersion) ----

# 1) 데이터의 범위 (최대, 최소 등)
min(my_mpg$cty)    # 최소: 9
max(my_mpg$cty)    # 최대: 35

# range (범위)
max(my_mpg$cty) - min(my_mpg$cty)  # 범위: 26

# boxplot **

?boxplot()          # graphics::
boxplot(my_mpg$cty)

install.packages("car")   # Boxplot 권장
car::Boxplot(my_mpg$cty)

my_mpg[222,"cty"]   # 222행, cty열 = 35
my_mpg[213,"cty"]   # 213행, cty열 = 33

# 2) 사분위수와 백분위수

# 사분위수 범위(3분위수 - 1분위수)
IQR(my_mpg$cty)   # 5 (19-14) *

# 백분위수
quantile(my_mpg$cty, probs=0)    # min, 9
quantile(my_mpg$cty, probs=0.25) # 1분위, 14
quantile(my_mpg$cty, probs=0.5)  # 중간값(median), 17
quantile(my_mpg$cty, probs=0.75) # 3분위, 19
quantile(my_mpg$cty, probs=1)    # max, 35

# 요약 통계량
summary(my_mpg$cty)

# 3) 분산, 표준편차

var(my_mpg$cty)   # 18.11
sd(my_mpg$cty)    # 4.26

sqrt(4)
sqrt(var(my_mpg$cty))   # = 표준편차


# 3. 분포 대칭성 (distribution) ----

# 1) 왜도(skewness, 좌우대칭도)
#+ sk > 0 : 꼬리가 오른쪽(머리 좌측)
#+ sk < 0 : 꼬리가 왼쪽(머리 우측)
#+ |3| 미만, |3| 이상이면 ???

install.packages("psych")
#+ skew()
install.packages("fBasics")
#+ skewness()
# 추가 패키지: moments

library(fBasics)
?skewness()
skewness(my_mpg$cty)  # 0.78 꼬오
skewness(my_mpg$hwy)  # 0.36 꼬오

# 2) 첨도(kurtosis, 뾰족한 정도)
#+ kt > 0 : nd보다 위로 뾰족
#+ kt < 0 : nd보다 아래로 납작
#+ |7| 미만, |7| 이상이면 ???

install.packages("psych")
library(psych)
#+ kurtosi()
install.packages("fBasics")
#+ kurtosis()

kurtosi(my_mpg$cty)   # 1.43
kurtosis(my_mpg$cty)  # 1.43, nd 뾰족
kurtosis(my_mpg$hwy)  # 0.137, nd와 살짝 뾰족

kurtosis(my_mpg$cty, na.rm=T)  # na 없음

# 4. 데이터 분포도 ----           

par(mar=c(1,1,1,1))
dev.off()

# 창나누기
#+ par(mfrow=c(2,2)) # 2행 2열 plot의 갯수 => 4개, 행중심
#+ par(mfcol=c(2,2))# 2행 2열, 열중심
#+ number of Multiple Figutes (옵션: layout())

par(mfrow=c(2,2))
plot(my_mpg$cty, type="h", main="hist_mm$cty")
plot(my_mpg$cty, type="l", main="line_mm$cty")
plot(my_mpg$cty, type="p", main="point_mm$cty")

?density()
plot(density(my_mpg$cty), main="density_mm$cty")  # 밀도(빈도)함수


# 5. 표준정규분포 ----
#+ standard normal distribution
#+ dnorm(x, mean=0, sd=1)
#+ => 특정 관측값(x)에 대한 y축의 값(확률밀도함수 값)을 returns

# 1)

temp <- seq(-5,5);temp   # -5 ~ 5
summary(temp)

mean(temp)   # 0
var(temp)    # 11
sd(temp)     # 3.316625

sqrt(var(temp))  # 표준편차 = 루트(분산)
plot(temp)

# 2) 

xx <- seq(-5,5, length=300);xx
summary(xx)

mean(xx)
median(xx)
var(xx)     # 8.417(300개)  # 8.587(100개)
sd(xx)      # 2.901(300개)  # 2.930(100개)

plot(xx)

# 3) dnorm()  # (default) mean=0. sd=1

# temp
dnorm(temp)
dnorm(temp, mean=0, sd=1)  # snd (표준정규분포)

all.equal(dnorm(temp), dnorm(temp, mean=0, sd=1))

# xx

dnorm(xx)
dnorm(xx, mean=0, sd=1)

# 4) 분포도 

?density

par(mfrow=c(2,2))
par(mar=c(1,1,1,1))

# temp
temp
length(temp)
plot(temp, main="단순 산점도")
plot(density(temp), main="밀도 추정")  # 추정치
plot(temp, dnorm(temp), type="l", main="표준정규분포??")
#+ mean=0, sd=1
#+ 실제: mean=0, sd= 3.317

plot(temp,dnorm(temp, mean=0, sd=3.317), 
     type="l", main="실제분포도??")

par(mfrow=c(1,1))
dnorm(temp, mean=0, sd=3.317)

dnorm(temp)  # 표준

# xx

xx
length(xx)
summary(xx)

par(mfrow=c(2,2))
plot(xx, main="단순 산점도")
plot(density(xx), main="밀도 추정")  # 추정치
plot(dnorm(xx), type="l", main="xx_표준정규분포??")
#+ mean=0, sd=1
#+ 실제: mean=0, sd= 2.901

plot(dnorm(xx, mean=0, sd=2.901), 
     type="l", main="xx_실제분포도??")

#
plot(xx, dnorm(xx), type="l", main="xx_n(0,1)")
#+ mean=0, sd=1
#+ 실제: mean=0, sd= 2.901

plot(xx, dnorm(xx, mean=0, sd=2.901), 
     type="l", main="xx_n(0,2.901)")


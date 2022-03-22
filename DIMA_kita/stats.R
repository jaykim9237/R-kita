# I. 기술통계량 ----

# 1. 집중경향치 (central tendency) ----

# 1) 평균값, 절사평균값
mean(my_mpg$cty)             # 16.86
mean(my_mpg$cty, trim = 0.1) # 16.61 양극단에서 10% 제외 후 낸 평균값

# 2) 중간값
median(my_mpg$cty)  # 17

# 3) 최빈값 (mode)

table(my_mpg$cty)
sort(table(my_mpg$cty), decreasing = T)
max(sort(table(my_mpg$cty), decreasing = T))

names(sort(table(my_mpg$cty), decreasing = T)[1])  # 18 : 값 
max(sort(table(my_mpg$cty), decreasing = T))       # 26 : 횟수

which.max(table(my_mpg$cty))                       



# 2. 변산성 측정치 (dispersion) ----

# 1) 데이터의 범위 (최대, 최소 등)
min(my_mpg$cty)   # 최소: 9
max(my_mpg$cty)   # 최대: 35

# range (범위)
max(my_mpg$cty) - min(my_mpg$cty)  # 범위 : 26

# boxplot **

?boxplot()          # graphics::
boxplot(my_mpg$cty)

install.packages("car")   # Boxplot 권장
car::Boxplot(my_mpg$cty)

my_mpg[222, "cty"]    # 222행, cty 열 = 35
my_mpg[213, "cty"]    # 213행, cty 열 = 33

# 2) 사분위수와 백분위수

# 사분위수 범위(3분위 수 - 1분위 수)
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

# 1)왜도 (skewness, 좌우대칭도)
#+ sk > 0 : 꼬리가 오른쪽 (머리좌측)
#+ sk < 0 : 꼬리가 왼쪽 (머리 우측)
#+ |3| 미만, |3| 이상이면??

install.packages("tmvnsim")

install.packages("psych")
#+ skew()
install.packages("fBasics")
#+ skewness()

search()

library(psych)
library(fBasics)
?skewness()
skewness(my_mpg$cty) #0.78 꼬오
skewness(my_mpg$hwy) #0.36 꼬오

# 1)첨도 (kurtosis, 뾰족한 정도)
#+ kt > 0 : nd 보다 위로 뾰족
#+ kt < 0 : nd 보다 아래로 납작
#+ |7| 미만, |7| 이상이면??

install.packages("psych")
#+ kurtosis()
install.packages("fBasics")
#+ kurtosis()

kurtosis(my_mpg$cty) #1.43, nd 뾰족
kurtosis(my_mpg$hwy) #0.137, nb와 살짝 뾰족

kurtosis(my_mpg$hwy, na.rm=T) #na 없음
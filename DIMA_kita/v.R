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
#+ 상대도수 = 해당구간의 빈도/전체빈도
#+ 연속현 데이터를 다루겠다는 의미 **
#+ 막대그래프 형태


airquality
par(mfrow=c(1,2))
plot(airquality$Ozone, col="blue")
plot(airquality$Ozone, type = "h", col="blue")

#
hist(airquality$Ozone)
hist(airquality$Temp)

#ggplot
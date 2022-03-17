#R Test
#주석은 샵이야

# 0-0. 명령어 ----
#실행                : ctrl + enter
#복사                : shift + alt + 방향키
#명령어 이어tj 실행  : aaa;bbb
#콘솔창 삭제         : ctrl + l
#<-                  : alt + -
#code grouping       : alt + l
#주석처리            : ctrl + shift + c
#%>% (pipe)          : ctrl + shift + m

#1. 연산 ----
#1-1.사칙연산 ----
3+4
5-2
3*4
3/4

3+3:5-2:6/2

#거듭제곱
3**4 
3^4 #3**4

# 1-2. 비교연산 ----
3>4
3>=4
3<=4
3==4
3!=4
!(3==4) #nested 비교연산


#몫과 나머지
200 %/% 4 #몫
201 %% 4 #나머지 /의 유무에 따라 다르다

#1-3 변수 할당 ----
a=4       #함수 안에 값 비교시 사용
aa <- 5   # **
6 -> aaa
rm(a) #삭제


#2. 유용한 함수 ----

#2-1. 현재 디렉토리 ----
getwd() # 현재의 위치를 보여주는 것 word directory
        # 작업 wd 변경 --> setwd("...") 
        # -를 4개를 입력하면 인덱스 효과가 생성되 마치 캡쳐처럼...?

#2-2. 글씨 출력 ----
print("hello world")

#2-3 HELP ----

#방법 1)
?getwd

#방법2)
help(print)

#2-4 버전확인 ----
R.version
RStudio.Version()

#2-5 View() ----

View(installed.packages())

#3. R-Test ----
#3-1. install ---- 
install.packages("dplyr")
install.packages("ggplot2")

#3-2. package memory loading
search()
library(dplyr) #로딩을 올리는 명령어
library(ggplot2)

#3-3 package detaching from m ----
detach("package:ggplot2")
detach("package:dplyr")
search()


#3-4. dataset in ** package ----
data(package = "ggplot2")
mpg #모르면 ?해서 헬프를 하면 돼
?mpg

#3-5. dataset 속성 ----

#c2dhmns2trV
class(mpg)      #data object type
class(a)        #데이터의 속성이 뭔지 알 수 있게 해주는
dim()           #행과 열
head(mpg, 10)   #6이 디폴트 값이고 더 보고 싶으면 수를 넣어주면 된다.
length(mpg)     #객체의 길이
mode(mpg)       # data의 속성
names(mpg)       #컬럼의 이름
str(mpg)        #데이터의 상세 속성
tail(mpg)       #dataset의 뒤쪽 6행 조회
rownames(mpg)   #행의 이름
View(mpg)       #원자료(raw data) 조회

typeof(mpg)     #class(), mode()

#3-6. 회사별 고속도로 평균연비(내림정렬) ----
# SQL > select ... gf() from .. group by ... order by...;

library(dplyr)
search()
names(mpg)
head(mpg)
dim(mpg)

mpg %>%
  group_by(manufacturer) %>%
  summarise(m.hwy=mean(hwy)) %>%
  arrange(desc(m.hwy))

#3-7. ford사의 model별 평균-고속도로 연비(내림정렬) ----
# SQL > select ... gf() from .. where... group by ... order by...;


mpg %>%
  filter(manufacturer == "ford") %>%
  # group_by(manufacturer) %>%   --> 이렇게 되면 모델별 요청사항 해결이 되지 않은거니까
  group_by(manufacturer, model) %>%
  summarise(m.hwy=mean(hwy))


#3-8. 도심연비(cty) -배기량(displ) 의 상관관계 ----
#qplot() -->quick plot

qplot(data=mpg, x=displ, y=cty, col=displ)

#3-9 월간 소비동향, 월간 저축 동향 ----

economics
names(economics)

#월간 소비동향
?ggplot
ggplot
ggplot(data=economics,
  aes(x=date, y=pce)) + geom_line()

#월간 저축동향
ggplot(data=economics,
       aes(x=date, y=psavert)) + geom_line()


#3-10. 회귀분석(ML: 독립변수 x -> 종속변수 y) ----
#머신러닝 기법: 지도학습(정답이 주어짐)
#원인(x) -> 결과(y, 고속도로 연비 :hwy)
# y=b0 + b1x1 + b2x2...

# lm()
lm(data=mpg, hwy~displ) #lm(dataset,y~xl)
lm.mpg <-lm(data=mpg, hwy~displ)
lm.mpg

summary(lm.mpg)

#lm()_2

View(mpg)

lm.mpg2 <- lm(data=mpg, hwy~displ + drv + model * trans)
lm.mpg3 <- lm(data=mpg, hwy~displ + drv + model * trans + cty)

summary(lm.mpg) # *** 이 세개가 나왔어 의미 있는 변수들이 었다는 것이야
                # *** 변수들이 가중치 있는거야, 의미 있는 것을 찾아내는 것이 핵심, 돈인거야 
                # R-squared: 의 값 최대 : 1, 1에 가까울수록 의미 있는 데이터를 뽑아낸 것이댜.
summary(lm.mpg2)
summary(lm.mpg3)


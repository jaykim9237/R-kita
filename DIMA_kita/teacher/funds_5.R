# Fundamentals_2


# 4. data.frame ----

# 4-1. data.frame 생성 ----

# 1) dataset copy ----
#+ SQL> create table ... as select ... 
#+ as.data.frame(a)  # a가 데이터프레임이 아닐 때

search()
my_mpg <- as.data.frame(ggplot2::mpg)
my_mpg <- ggplot2::mpg

class(my_mpg);dim(my_mpg);head(my_mpg)
names(my_mpg)

# 3번째 컬럼을 제외하고 보여줘라!
head(my_mpg[-3],10)
head(my_mpg[7-10],10)

# 1~5번 컬럼을 제외하고 보여줘라!
names(head(my_mpg[c(-1:-5)],10))

# 1, 5, 11번 컬럼을 제외하고 보여줘라!
names(head(my_mpg[c(-1,-5,-11)],10))
# names(head(my_mpg[-1,-5,-11],10))  # 

# 2) key-in 방식으로 생성 ----

java <- c(77,88,56,91,100)
eng <- c(57,31,96,68,95)
japan <- c(64, 73, 61, 74, 59)

java;eng;japan

# data.frame으로
data.frame(java,eng,japan)
df_score <- data.frame(java,eng,japan)
df_score

# 앗! ban 컬럼? 놓쳤음
ban <- c("dima","scit", "trade", "scit", "dima")
ban

df_score <- data.frame(java,eng,japan,ban)
df_score

# 평균값
mean(df_score$java)
mean(df_score$eng)
mean(df_score$japan)

# 3) 번외 ----
df_score

df_score[1]
df_score[3]
df_score[1:3]

# 2번째 빼고
df_score[c(1,3)]
df_score[-2]

# 2번째만
df_score[2]
df_score[3-1]

# package 사용 한다면 (# %>% => dplyr)
library(dplyr);search()

names(my_mpg)
my_mpg[c("drv","fl")] %>% head(15)

my_mpg %>% 
  select(drv, fl) %>% 
  head(15)

# 4-2. 외부파일 불러오기 & 저장하기 ----  
  
# 4-2-1. 액셀파일 ----

install.packages("readxl") # 액셀읽기용 패키지
library(readxl)
search()

getwd()

# 읽기
?read_excel()

read_excel("f_exam.xlsx", sheet = 1, col_names = T)
df.xl <- read_excel("f_exam.xlsx", sheet = 1, col_names = T)

# 평균값
df.xl

m_eng <- mean(df.xl$eng)
m_jpt <- mean(df.xl$japan)
m_math <- mean(df.xl$math)
m_eng;m_jpt;m_math

# data.frame 으로 받기
df.jt <- data.frame(m_eng,m_jpt,m_math)
df.jt

# 파일로 다시 저장
getwd()

install.packages("writexl")  # 액셀저장용 패키지

?writexl::write_xlsx
search()

writexl::write_xlsx(df.jt,path="df.jt_mean.xlsx")

# 4-2-2. csv파일 ----
#+ comma separated value
#+ sheet 개념없음, (header =..) == read_excel(col_names=..)

# csv 읽기
?read.csv()

read.csv("dima_exam.csv", encoding = "UTF-8")
df_dima <- read.csv("dima_exam.csv", encoding = "UTF-8")
df_dima

# csv 저장
write.csv(df_dima, file="f_exam_new.csv")


# 4-3. 데이터프레임 분석 ----

# 4-3-1. 컬럼명 변경 ----

search()
df_dima

?rename     # dplyr::
# rename(dataset, new_col = old_col)

rename(df_dima, id=X.U.FEFF.id)
df_dima <- rename(df_dima, id=X.U.FEFF.id)
df_dima

# 4-3-2. 컬럼 삭제 ----

df_dima$id <- NULL
df_dima

########

read.csv("dima_exam.csv", encoding = "UTF-8")
read.csv("f_exam2.csv", encoding = "UTF-8")
dima_ex2 <- read.csv("f_exam2.csv", encoding = "UTF-8")

dima_ex2

search()
rename(dima_ex2, namdo1= X.U.FEFF.id)
dima_ex2 <- rename(dima_ex2, namdo1= X.U.FEFF.id)
dima_ex2

rename(dima_ex2,  hj = namdo1)
dima_ex2 <- rename(dima_ex2,  hj = namdo1)
dima_ex2

dima_ex2$hj <- NULL
dima_ex2


# 4-3-3. 파생변수  ----

ls()
df_score

# 1) sum, avg 파생변수 만들기 ----

# sum
df_score$sum <- df_score$java + df_score$eng + df_score$japan

df_score[-4]

# avg
df_score$avg <- round((df_score$java + df_score$eng + df_score$japan)/3,2)
df_score[-4]

# 2) ggplot2::mpg를 이용한 파생변수 만들기 ----

my_mpg <- ggplot2::mpg

# 종합연비 파생변수 : t_ch = (cty + hwy)/2

names(my_mpg)

my_mpg$t_ch <- (my_mpg$cty + my_mpg$hwy)/2
names(my_mpg)
head(my_mpg$t_ch)

# 종합연비의 평균, 히스토그램, 기술통계량

mean(my_mpg$t_ch)  # 20.15

par(mar=c(1,1,1,1))   # plot 초기화
hist(my_mpg$t_ch)

x11()                # 새창 띄우기
hist(my_mpg$t_ch)

summary(my_mpg$t_ch)

# 4-3-4. 조건 파생변수 ----
#+ test : Pass(종합연비 >= 25), Fail(종합연비 <= 24)
#+ ifelse(조건, True 일때, False 일때)         *
#+ SQL> decode()-> 오라클, case when()-> 표준

names(my_mpg)

ifelse(my_mpg$t_ch >= 25, "Pass", "Fail")
my_mpg$test <- ifelse(my_mpg$t_ch >= 25, "Pass", "Fail")

names(my_mpg)
head(my_mpg[c("t_ch","test")])

dim(my_mpg)
table(my_mpg$test)

# 4-3-5 빈도 그래프 확인 ----

my_mpg
names(my_mpg)
head(my_mpg[c(12,13)])

table(my_mpg$test)
head(my_mpg$test)

# hist(숫자) 함수 => X
ggplot2::qplot(my_mpg$test)


# 4-4. DB connection ----

# 1) package 설치
install.packages("DBI")
install.packages("rJava")
install.packages("RJDBC")
install.packages("odbc")

# 2) package loading
library(odbc)
library(DBI)
library(rJava)
library(RJDBC)
search()

# 3) 사전정보 확인
?odbcListDrivers()  # odbc::

ins.drivers <- odbcListDrivers()
dim(ins.drivers)   # 83, 3
class(ins.drivers)
names(ins.drivers)

unique(ins.drivers[1])
unique(ins.drivers[[1]])
sort(unique(ins.drivers[[1]]))

unique(ins.drivers$name)

unique((odbcListDrivers())$name)
unique((odbcListDrivers())[1])
unique((odbcListDrivers())[[1]])

# 4) package 설명
# library(RJDBC) # 해당 DB 드라이버 생성시 필요,
#+ RJDBC::JDBC()
?JDBC

# library(rJava) # rJava는 RJDBC와 강한 커플링
# library(DBI)   # dbConnect() 함수 사용
#+ DBI::dbConnect()
search()
?dbConnect

# 5) db 드라이버 생성(ojdbc8.jar)

search()

JDBC(driverClass = "oracle.jdbc.OracleDriver",
     classPath = "C:/Database/app/JWC/product/18.0.0/dbhomeXE/jdbc/lib/ojdbc8.jar")
jdbc_R <- JDBC(driverClass = "oracle.jdbc.OracleDriver",
     classPath = "C:/Database/app/JWC/product/18.0.0/dbhomeXE/jdbc/lib/ojdbc8.jar")

# 6) targetDB connection 생성
#+ ip : 10.10.17.29

??dbConnect()   # DBI::dbConnect
jdbc_R

#dm_con1 <- dbConnect(jdbc_R,"jdbc:oracle:thin:@10.10.17.29:1521:XE","hr","hr")

db_con <- dbConnect(jdbc_R,"jdbc:oracle:thin:@localhost:1521:XE","hr","hr")

# 7) Test Query
??dbGetQuery() # DBI::

#-1
q1 <- "select tname from tab"
rs <- dbGetQuery(db_con, q1)
head(rs)

#-2
q2 <- "select job_id, job_title from jobs"
rs2 <- dbGetQuery(db_con, q2)
head(rs2,10)

# 5. 데이터 처리 패키지 ----
#+ dplyr
#+ %>% : ctrl + shift + m

library(dplyr)
search()

my_exam <- read.csv("ss_exam.csv")

# 5-1. filter() ----

# 5-1-1. class == 6 인 경우
names(my_exam)
my_exam %>% filter(class == 6)
my_exam[my_exam$class == 6,]       # dplyr 사용X

# 5-1-2. class가 2와 3이 아닌 경우
my_exam %>% filter(class != 2 & class !=3)

# 5-1-3. java가 80점 이상이면서 class가 3인 경우
my_exam %>% filter(java >= 80 & class ==3)

# 5-1-4. java 또는 eng가 80점 이상이면서 class가 5인 경우
my_exam %>% filter(java >= 80 | eng >=80 & class ==5) # X
my_exam %>% filter((java >= 80 | eng >=80) & class ==5) # O

# 5-1-5. class가 1,3,5인 경우

my_exam %>% filter(class ==1 | class==3| class==5)
my_exam %>% filter(class %in%  c(1,3,5))

my_exam[조건식,]

# 5-2. select() ----

# 5-2-1. id와 database 출력
names(my_exam)
my_exam %>% select(id, database) %>% head(3)

# 5-2-2. eng만 빼고 조회
my_exam %>% select(-eng) %>% head(3)
my_exam %>% select(-eng, -java) %>% head(3)

# 5-2-3. class가 2인 학생들의 java와 database 성적확인
my_exam %>% 
  filter(class == 2) %>% 
  select(class, java, database)


# 5-3. arrange() ----

my_exam <- read.csv("ss_exam.csv")

# 5-3-1. class와 eng로 정렬(오름)

my_exam %>% 
  arrange(class, eng)

# 5-3-2. class 내림차순, eng 오름차순

my_exam %>% 
  arrange(desc(class), eng)

my_exam %>% 
  arrange(class, -eng)  # class-오름, eng-내림


my_exam %>% 
  select(1,3,5) %>% 
  arrange(-japan) %>% head(5)


# 5-4. mutate() ** ----
#+ a[조건식,열이름]의 내장함수와 비교해서 장점
#+ 1) 컬럼을 지칭할 때 dataset$ 정보 X
#+ 2) 한번에 여러개의 변수 추가 가능 (,,,,)
#+ 3) 조건 파생변수 추가 가능
#+ 4) 생성한 파생변수를 명령문이 끝나기 전 바로 사용가능 *

# 5-4-1. package & dataset
library(dplyr)
my_exam <- read.csv("ss_exam.csv")
my_exam

# 5-4-2. total(합계) 파생변수
names(my_exam)

my_exam2 <- my_exam %>% 
  mutate(total = database+java+japan+eng)

head(my_exam,2)
head(my_exam2,2)
dim(my_exam2)

# 5-4-3. avg(평균) 파생변수

my_exam %>% 
  mutate(total = database+java+japan+eng,
         avg = total/4)

my_exam3<- my_exam %>% 
  mutate(total = database+java+japan+eng,
         avg = total/4)

head(my_exam3,2)
dim(my_exam3)

# 5-4-4. result 조건 파생변수

table((my_exam %>% 
  mutate(total = database+java+japan+eng,
         avg = total/4,
         result = ifelse(avg>=70, "PASS", "FAIL")))$result)

my_exam4 <- my_exam %>% 
  mutate(total = database+java+japan+eng,
         avg = total/4,
         result = ifelse(avg>=70, "PASS", "FAIL")) %>% 
  arrange(-avg)

head(my_exam,3)
head(my_exam2,3)
head(my_exam3,3)
head(my_exam4,3)

View(my_exam4)


# 5-5. group by(), summarise(그룹함수*n개) ----

# 5-5-1.

library(dplyr)
my_exam <- read.csv("ss_exam.csv")

names(my_exam)
my_exam %>% count()     # *
my_exam %>% count(id)
my_exam %>% count(java)
my_exam %>% count(class) # *

my_exam %>% 
  group_by(class) %>% summarise(n=n()) # *

# 5-5-2.표준편차, 왜도

library(fBasics)

sd_my_ex <- my_exam %>% 
  summarise(sd(database),
            sd(java),
            sd(japan),
            sd(eng))
sd_my_ex

my_exam %>% 
  summarise(skewness(database),
            skewness(java),
            skewness(japan),
            skewness(eng))


# 5-6. bind_rows() ----
#+ SQL> union, union all

# dataset

ga <- data.frame(id=seq(10,50, by=10),
                 python=c(45,100, 56, 91, 83));ga

gb <- data.frame(id=seq(60,100, by=10),
                 python=c(58,82,72,78,67));gb
# bind_row()

bind_rows(ga, gb)
g_all <- bind_rows(ga, gb);g_all


# 5-7. join() ----

# 5-7-1.

# dataset

t1 <- data.frame(id=c(1,2,3,4,5),
           java=c(100,45,60,84,78));t1

t2 <- data.frame(id=c(1,2,3,4,5),
           python=c(77,59,91,51,70));t2

# left_join

left_join(t1, t2, by="id")
t12 <- left_join(t1, t2, by="id");t12
t12

# 5-7-2. 반별 담당자 추가가

my_exam <- read.csv("ss_exam.csv")
unique(my_exam$class)

data.frame(team=c(1:6),
           manager=c("do1","whan","sohwi","min","won","sin2"))

admin <- data.frame(team=c(1:6),
           manager=c("do1","whan","sohwi","min","won","sin2"))

admin

# my_exam, admin

names(my_exam);head(my_exam,3)
names(admin);head(admin,3)

head(left_join(admin,my_exam, by=c("team"="class")),3)
head(left_join(my_exam,admin, by=c("class"="team")),3)

my_class <- left_join(my_exam,admin, by=c("class"="team"))
head(my_class,10)



# R버전 4.1 이상에서 파이프 |> (native pipe 연산자)
search()
detach("package:dplyr")
my_mpg2[c("model","class","cost_f")] |> head(3)  # dplyr(X)

my_mpg[c(1,4)] |> head(5)  # dplyr(X)

library(dplyr)
my_mpg2[c("model","class","cost_f")] %>% head(3)

# 기타 참고

summarise(my_mpg, max_h = max(hwy))

group_by(my_mpg, manufacturer) %>% 
  summarise(min_h = min(hwy))

# 표본추출(=sample) # 머신러닝 자주 사용

?sample_n     # dplyr::
#+ sample(dataset, n개)    # n개 만큼 랜덤샘플 추출

sample_n(my_mpg,5)

set.seed(1234);sample_n(my_mpg,5)


?sample_frac  # dplyr::
#+ sample(dataset, n비율)  # n비율 만큼 랜덤샘플 추출 *

sample_frac(my_mpg,0.01)

set.seed(234);sample_frac(my_mpg,0.01)


# 5-8. 데이터 구조 변경 ----

# 0. packages & datasets

# install.packages("tidyr")
# install.packages("reshape2")

library(tidyr)
library(reshape2)
search()

# dataset
?mtcars   # datasets::

my_car <- mtcars
names(my_car);dim(my_car)
head(my_car)
rownames(my_car)

# 5-8-1. rowname -> new 컬럼 추가 ----

tolower(rownames(my_car))
toupper(rownames(my_car))

# my_car %>% 
#   mutate(rowname = tolower(rownames(my_car)))

my_car$rowname <- tolower(rownames(my_car));names(my_car)

head(my_car)
dim(my_car)

# 기존 rowname 삭제

rownames(my_car) <- NULL
head(my_car)


# 5-8-2. new dataset 생성 ----

names(my_car)

my_car <- my_car %>% 
  select(rowname, am, mpg, cyl, disp)

dim(my_car)   # 32, 5

# 5-8-3. 가로형 -> 세로형 ----

# 3-1. tidyr::gather

names(my_car); head(my_car)
dim(my_car)  # 32, 5
class(my_car)

View(my_car, "1")

dim(my_car %>% 
  gather(key="c_key", value="c_value", cyl))

View(my_car %>% 
  gather(key="c_key", value="c_value", cyl), "2")

dim(my_car %>% 
  gather(key="c_key", value="c_value", cyl, disp))

View(my_car %>% 
  gather(key="c_key", value="c_value", cyl, disp), "3")


my_car_gather <- my_car %>% 
  gather(key="c_key", value="c_value", cyl)

head(my_car_gather,2);dim(my_car_gather)
class(my_car_gather)

# 3-2. reshape2::melt

dim(my_car)
names(my_car)
head(my_car)

?melt

my_car_melt <- my_car %>% 
  melt(measure.vars = "cyl", 
       id.vars=c("rowname","am","mpg","disp"))

head(my_car_melt,2);dim(my_car_melt)
class(my_car_melt)

# 5-8-4. 세로형 -> 가로형 ----

# 4-1. tidyr::spread

head(my_car_gather);names(my_car_gather)

my_car_gather %>% 
  spread(key= "c_key", value="c_value")

my_car_spread <- my_car_gather %>% 
  spread(key= "c_key", value="c_value")

names(my_car_spread)
head(my_car_spread)
dim(my_car_spread)
class(my_car_spread)

dim(my_car);head(my_car)

# dataset 비교

all.equal(my_car, my_car_spread)  # F

# data 정렬
my_car %>% arrange(rowname)
my_car_spread %>% arrange(rowname)

all.equal((my_car %>% arrange(rowname)),
          (my_car_spread %>% arrange(rowname))) # F

# 컬럼명 정렬
names(my_car)
names(my_car_spread)

my_car %>% select(1,2,3,4,5) %>% arrange(rowname)
my_car_spread %>% select(1,2,3,5,4) %>% arrange(rowname)

all.equal((my_car %>% select(1,2,3,4,5) %>% arrange(rowname)),
          (my_car_spread %>% select(1,2,3,5,4) %>% arrange(rowname)))  # T

rownames(my_car)
rownames(my_car_spread)


# 4-2. reshape2::dcast
#+ dcast(함계보여질 컬럼 ~ 컬럼화 할 data)

my_car_melt
names(my_car_melt);dim(my_car_melt)

my_car_melt %>% 
  dcast(rowname ~ variable)

my_car_melt %>% 
  dcast(rowname+am+mpg+disp ~ variable)

my_car_dcast <- my_car_melt %>% 
  dcast(rowname+am+mpg+disp ~ variable)

dim(my_car_dcast)
names(my_car_dcast)
head(my_car_dcast, 2)
class(my_car_dcast)

# 5-8-5. reshape2::acast #세로 -> 가로 ----
#+ reshape2::acast(x1 ~ x2 ~ x3)
#+ reshape2::acast(행기준 ~ 열기준 ~ 제 3의 기준)
#+ 데이터는 기 용해되었던 key와 value 중 value
#+ return: 벡터, 행렬, 배열

# 1) dataset

?read.table()   # utils::

df_p <- read.table(header = TRUE, stringsAsFactors = F, text = "
age gender name p_type p_topping
 20  F     D소휘 R     t_포테이토
 20  M     D기도 L     t_쉬림프
 23  M     D도일 L     t_쉬림프
 25  F     D혜원 R     t_포테이토
 20  M     D우혁 L     t_고구마
 15  M     D기범 L     t_페페로니
 25  F     D현정 L     t_페페로니
 27  M     D동준 L     t_스테이크
 23  M     D준태 L     t_불고기
 29  F     D구연 L     t_포테이토
");df_p

df_p

# 2) 토핑컬럼(p_topping) 용해
library(tidyr)
search()

names(df_p)
head(df_p)

df_p %>% 
  gather(key="c_key", value="c_value", p_topping)

df_p_gather <- df_p %>% 
  gather(key="c_key", value="c_value", p_topping)

df_p_gather

# 3) 행과 열만 지정
library(reshape2);search()
names(df_p_gather)

df_p_gather %>% acast(gender~name)
class(df_p_gather %>% acast(gender~name))

# 4) 1,2,3 기준

names(df_p_gather)
class(df_p_gather %>% acast(gender~name~p_type))

# 5) 1,2,3 + 4 기준

names(df_p_gather)
df_p_gather %>% acast(gender~name~p_type+age)


# 6. 데이터 분석과 가공 ----


# 6-1. apply ----

# 6-1-1. 기본 ----

#+ apply(data, 방향, 함수, 인자)
#+ 방향: 1(행), 2(열)

a1 <- matrix(1:12, 2, 4);a1  # 열우선
a2 <- matrix(1:12, 2, 4, byrow=T);a2 # 행우선

apply(a1, 1, min)  # a1 자리는 벡터(X) *
apply(a1, 2, max)
class(apply(a1, 2, max))

# 6-1-2. 다른 함수 활용 ----

a2<- matrix(c("dima_구현","dima_동준",
              "dima_기도", "dima_기범"), 2, 2);a2
a2

# 사용자 함수 구성
# install.packages("stringr")
search()

d_sub <- function(x){
  return(stringr::str_sub(x, 6, 7))
  #+ str_sub(string,시작,끝)
}

d_sub(a2)

#*****
a2
apply(a2,1,d_sub)
apply(a2,2,d_sub)

# 6-1-3. apply testing ----

my_exam <- read.csv("ss_exam.csv");dim(my_exam)
head(my_exam)

my_exam[,-1:-2]
# Q1. 30명의 개별로 전 과목 합계와 평균
apply(my_exam[,-1:-2], 1, sum)  # 30개
apply(my_exam[,-1:-2], 1, mean) # 30개

# Q2. 4개 과목별로 합계와 평균
apply(my_exam[,-1:-2], 2, sum)   # 4개
apply(my_exam[,-1:-2], 2, mean)  # 4개

# NA처리
#+ apply(x,방향, 함수, 함수옵션): NA처리 안됨 
#+ 단, 함수옵션은 사용가능

head(my_exam)
my_exam[4,5:6] <- NA
head(my_exam)

# NA처리 후, 결과 확인(X)
apply(my_exam[,-1:-2], 1, sum) # 29개 *
apply(my_exam[,-1:-2], 1, mean) # 29개 **

apply(my_exam[,-1:-2], 2, sum)  # 2개 ***
apply(my_exam[,-1:-2], 2, mean)  # 2개 ****

# 함수옵션 사용시 결화확인(O)
apply(my_exam[,-1:-2], 1, mean, na.rm=T) # 30개
apply(my_exam[,-1:-2], 2, mean, na.rm=T)  # 4개

# 함수옵션을 사용하지 않는 apply 대안!!
rowSums(my_exam[,-1:-2], na.rm=T)  # *
rowMeans(my_exam[,-1:-2], na.rm=T) # **

colSums(my_exam[,-1:-2], na.rm=T)  # ***
colMeans(my_exam[,-1:-2], na.rm=T)  # ****

# 6-2. apply계열 함수 비교 ----
#+ apply, sapply, lapply

# 6-2-0. dataset

t_app <- matrix(c(1:9),3,3);t_app

# 사용자 정의 함수

mt <- function(x){
  return(x^2)
}

# 6-2-1. apply

t_app
apply(t_app, 2, max)
apply(t_app, 2, mt)
apply(t_app, 1, mt)
class(apply(t_app, 1, mt))   # rt: 행렬
class(apply(t_app, 2, max))  # rt: 벡터

# NA처리

t_app[2,2:3] <- NA
t_app

apply(t_app, 2, max, na.rm=T) # O
apply(t_app, 2, mt) # X

# 6-2-2. sapply

t_app <- matrix(c(1:9),3,3);t_app

sapply(t_app,max)
sapply(t_app,mt)

# 6-2-3. lapply

t_app

lapply(t_app,max)
lapply(t_app,mt)

# 6-3. tapply ----
#+ tapply(벡터, index, 함수, 함수인자)
#+ 그룹별 연산 

iris
names(iris)
unique(iris$Species)

tapply(iris$Sepal.Length, iris$Species, mean)
tapply(iris$Sepal.Length, iris$Species, sum)

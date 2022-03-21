# 4. data.frame ----

#4-1. data.frame 생성 ----


# 1) dataset copy----
#+ SQL > create table ... as select ...
#+ as.data.frame()


search()
my_mpg <- as.data.frame(ggplot2::mpg)

class(my_mpg)
dim(my_mpg)
head(my_mpg)

#3번째 컬럼을 제외하고 보여줘라!
head(my_mpg[-3],10)
head(my_mpg[7-10],10)

#1~5번 컬럼을 제외하고 보여줘라
head(my_mpg[-(1:5)],10)  #내가한 것 --여기는 c가 안들어가도 되는게 연속되었으니까 한번에 봐서 되는거야 아래 문제는 안되지
head(my_mpg[c(-1:-5)],10)  
names(head(my_mpg[c(-1:-5)],10))  

#1, 5, 11 칼럼을 제외하고 보여줘라
head(my_mpg[c(-1, -5, -11)],10)  
names(head(my_mpg[c(-1, -5, -11)],10))  
names(head(my_mpg[-1, -5, -11],10))  #c함수를 안쓰면 엉뚱한 값을 가지고 온다. 없으면 열과 행으로 이해를 하기 때문에


# 2) key-in 방식으로 생성 ----

java <- c(77, 88, 56, 91, 100)
eng <- c(57, 31, 96, 68, 95)
japan <- c(64, 73, 61, 74, 59)

java;eng;japan

# data.frame 으로
data.frame(java,eng,japan)
df_score <- data.frame(java, eng, japan)
df_score

#앗! ban 컬럼을 깜빡했다?

ban <- c("dima", "scit", "trade", "scit", "dima")
ban

df_score <- data.frame(java, eng, japan, ban)
df_score

#평균값
mean(df_score$java)
mean(df_score$eng)
mean(df_score$japan)

# 3) 번외 ----

df_score[1]
df_score[3]
df_score[1:3]
df_score[c(1,3)]

#두번째 빼고
df_score[c(1,3)]
df_score[-2]

#두번째만
df_score[2]
df_score[3-1]

#package 사용한다면
# %>% 를 사용해야한다. => dplyr에 잇움

library(dplyr)
search()

names(my_mpg)
my_mpg[c("drv", "fl")] %>%head(15)

my_mpg %>%
  select(drv, fl) %>%
  head(15) 

# 4-2 외부파일 불러오기 ----

#4-2-1 엑셀파일

install.packages("readxl")
library(readxl)
search()
  
# 읽기
?read_excel()  #엑셀 읽기용 패키지

read_excel("f_exam.xlsx", sheet = 1, col_names = T)
df.xl <- read_excel("f_exam.xlsx", sheet = 1, col_names = T)


#평균값
df.xl

m_eng <- mean(df.xl$eng)
m_jpt <- mean(df.xl$japan)
m_math <- mean(df.xl$math)

m_eng;m_jpt;m_math 


#data.frame 으로 받기
df.jt <-data.frame(m_eng,m_jpt,m_math)
df.jt

#파일로 다시 저장

getwd()

install.packages("writexl")   #엑셀 저장용 패키지


?writexl::write_xlsx
search()

writexl::write_xlsx(df.jt,path="df.jt_mean.xlsx")


# 4-2-. csv파일 ----
#+ comma separated value
#+ sheet 개념없음, (header = ..) == read_excel(col_name=..)

#csv 읽기
?read.csv()

read.csv("dima_exam.csv", encoding = "UTF-8")
df_dima <- read.csv("dima_exam.csv", encoding = "UTF-8")

df_dima

#csv 저장
write.csv(df_dima, file = "f_exam_new.csv")

# 4-3. 데이터프레임 분석 ----

#4-3-1. 컬럼명 변경 ----

search()

df_dima

?rename    #dplyr::
# rename(dataset, new_col = old_col)

rename(df_dima, id=X.U.FEFF.id) #여기 이름은 나한테는 안나왔는데
                                #, xl 에서 csv로 바꿀 때 나타난 찌꺼기 이름
                            #인코딩해서 그나마 볼만해진 애를 대체하는거지 그 때 찌꺼기 이름이 저거였어

df_dima <- rename(df_dima, id=X.U.FEFF.id)
df_dima

df_dima <- rename(df_dima, new_id = id) #바꾼거고

#4-3-2. 컬럼삭제 ----

df_dima$new_id <- NULL    # 삭제한거야
df_dima


#Q1 ----

install.packages(ggplot2)
library(ggplot2)


?mpg
my_mpg <- mpg #나는 이렇게 했는데
my_mpg <- as.data.frame(ggplot2::mpg) #구연언니 이게 맞는 듯
my_mpg <- ggplot2::mpg #선생님

#나
my_mpg
my_mpg <- rename(my_mpg, highway = hwy)
my_mpg

#선생님
names(my_mpg)
names(dplyr::rename(my_mpg, city = cty, highway = hwy))
my_mpg <- dplyr::rename(my_mpg, city = cty, highway = hwy)
names(my_mpg)

#4-3-3. 파생변수 ----
ls()
df_score

# 1) sum, avg 파생변수 만들기 ----


#sum
df_score$sum <- df_score$java +  df_score$eng + df_score$japan

df_score[-4]

#avg
df_score$avg <- round((df_score$java +  df_score$eng + df_score$japan)/3,2)


df_score

# 2) ggplot::mpg를 이용한 파생변수 만들기 ----

mu_mpg <- ggplot::mpg

# 종합연비 파생변수 : t_ch = (cty +hwy)/2

names(my_mpg)

my_mpg$t_ch <- (my_mpg$cty + my_mpg$hwy)/2

names(my_mpg)
head(my_mpg)
head(my_mpg$t_ch)

#종합연비의 평균, 히스토그램, 요약통계량

mean(my_mpg$t_ch)

par(mar=c(1,1,1,1)) #마진을 재 정의하는 것 #plot 초기화
hist(my_mpg$t_ch)

x11() #완전히 새창 띄우기
hist(my_mpg$t_ch)
summary(my_mpg$t_ch)

# 4-3-4. 조건 파생변수 ----
#+ test : Pass(종합연비 >= 25), Fail(종합연비 <= 25)
#+ ifelse(조건, True 일때, False 일때)
#+ SQL>decode() ->오라클, case when() -> 표준

names(my_mpg)

ifelse(my_mpg$t_ch >=25, "Pass", "Fail")
my_mpg$test <- ifelse(my_mpg$t_ch >=25, "Pass", "Fail")

names(my_mpg)
head(my_mpg[c("t_ch", "test")])


dim(my_mpg)
table(my_mpg$test)

#돌발 Q.종합연비가 pass된 자동차의 정보 ----
#+ 제조사, model, class

head(my_mpg)
names(my_mpg)
unique(my_mpg$manufacturer)
unique(my_mpg$class)
unique(my_mpg$model)

my_mpg[my_mpg$test == "Pass",]

pass_mpg <- my_mpg[my_mpg$test == "Pass",]

ans_mpg <- pass_mpg[c("manufacturer","model", "class")]

View(my_mpg)

write.csv(ans_mpg, file = "2022ans.csv")


plus_mpg <- pass_mpg[c("manufacturer","model", "class", "year", "trans")]
head(plus_mpg)

#Q2 ----

names(my_mpg)

my_mpg$grade <- ifelse(my_mpg$t_ch >=31,"Excelect",
                       ifelse(my_mpg$t_ch >=21, "Good",
                              ifelse(my_mpg$t_ch >=15,"Normal",
                                     "Poor")))


table(my_mpg$grade)
ggplot2::qplot(my_mpg$grade)

#R&D 퀴즈 ----
#+ 파일읽기
#+ 읽어 들인 파일 내용을 공백을 기준으로 split 하기
#+ 다시 파일로 저장하기
#+ 저장된 파일을 다시 로딩하기 

getwd()

?readLines

#txt 읽기
txt2 <- readLines("txt2.txt",  encoding = "UTF-8")

#파일내용을 공백으로 자르기  
?split

txt2 <- strsplit(txt2, split = ' ')
txt2

txt3 <- txt2

#선생님 파일저장
save(txt3, file = "ans_txt3.RData")

#변수삭제
ls()
rm(txt3)
txt3 #메모리에서 변수 

#다시로딩
load("ans_txt3.RData")
ls()

txt3

#한승 방법
unlist_txt2 <- unlist(txt2)
cat(unlist_txt2, file='nulist_txt2.txt')

#우세한 우리반 방법
#근데 이거 그냥 콘솔을 캡쳐하는거래
capture.output(txt2, "\n", file = "new_txt2.txt")

# 내가 하다가 실패
search()
install.packages("writexl")
install.packages("data.table")

#Q3----

my_midwest <- ggplot2::midwest
View(my_midwest)

class(my_midwest)
head(my_midwest)
typeof(my_midwest)

search()
install.package(dplyr)
library(dplyr)
my_midwest <- rename(my_midwest, total_p=poptotal)
my_midwest <- rename(my_midwest, black_p=popblack)

head(my_midwest)

my_midwest$per1 <- my_midwest$black_p/my_midwest$total_p
my_midwest$per2 <-  my_midwest$per1*100

View(my_midwest$per2)
hist(my_midwest$per2)

mean(my_midwest$per2)

my_avg <- mean(my_midwest$per2) #2.68%

my_midwest$quiz_avg <- ifelse(my_midwest$per2 >= my_avg, ">>=avg(2.68%)", "<avg(2.28%)")

table(my_midwest$quiz_avg)

View(my_midwest$quiz_avg)
ggplot2::qplot(my_midwest$quiz_avg) #그냥 qplot은 안되고 ggplot2::qplot로 찾아줘
hist(my_midwest$quiz_avg) # x값이 수가 아니어서 안돼
x11();hist(my_midwest$quiz_avg)

#Q. 중복된 데이터 셋

my_mpg

View(my_mpg)

duplicated(my_mpg)
class(duplicated(my_mpg))
mode(duplicated(my_mpg))
typeof(duplicated(my_mpg))

table(duplicated(my_mpg)) #중복 9개

which(duplicated(my_mpg)) #중복 된 값의 row name
rownames(my_mpg)


my_mpg[c(21 ,41 , 43, 54, 61, 68, 69, 80, 104),] # a[m행 m열]
my_mpg[which(duplicated(my_mpg)),] #바로위에 인덱스(rowname)를 나열이 아니고 which함수를 넣어서 해준거지

my_mpg[x,] ##
my_mpg[which(duplicated(my_mpg)),] 

duplicate_raw <- function(ds){
  d_raw <- ds[which(duplicated(ds)),] 
  return(d_raw)
}

duplicate_raw(my_mpg)
duplicate_raw(my_mpg$test=="pass",)

#test
a1 <- c(1,1,1,2,2,3);a1
a2 <- c(1,1,2,2,2,5);a2
a3 <- c(2,2,4,3,3,7);a3

xx <- data.frame(a1,a2,a3) 

xx
duplicate_raw(xx)

xx_raw <- duplicate_raw(xx) #함수 안에서의 <-는 임시로 넣고 뿌리는 역할일 뿐, 값을 넣어줘야해

duplicated(xx)
which(duplicated(xx))
xx[which(duplicated(xx)),]


#########################################

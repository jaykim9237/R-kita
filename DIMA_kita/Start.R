#준비운동

#0. work directory ----

getwd()
read.csv("ss_exam.csv")

#wd 변경
setwd("C:/PR/R_Works")
getwd()

read.csv("ss_exam.csv")
# + 현 파일은 자식폴더에 있음, 그래서 에러

read.csv("./DIMA_Kita/ss_exam.csv")
#상대주소로 해서 읽을 수 있다.

setwd("C:/PR/R_Works/DIMA_Kita")
#wd 변경 원래대로
getwd()
read.csv("ss_exam.csv")

#파일을 물리로 이동 #부모폴더로 (파일명: ss_exam_p.csv)
getwd()
read.csv("ss_exam_p.csv") #파일이 없음, 에러

#1. 변수 ----
#+ 변수 선언은 가급적 소문자로...(대소문자 가림)

a <-3
a

# 에러 가능하지 않은 변수
2a <-3    #숫자로 시작하는 변수는 안된다 x 
a-b <-3   # -(하이픈) 사용x 
ac@d <-3  #특수기호 사용x 
.13 <-3   #.숫자 형식 x 

#가능
.a <- 3  #.문자 형식 O
a_b <-3  #  문자중간의_(언더바) O


#1-1. 변수 선언 ----

a <-2;a
aa <- 5^10;aa
AA <-10;AA

a+aa
a*aa

#1-2. 여러개의 값을 선언할 경우(c(), seq()) ----

?c()
bb <-c(10,20,30,40,50);bb #여러개의 값을 한번에 선언할 때 bb2 <-c(10:50);bb  #c(start:end );
# 붙일 경우 어디부터 어디까지

?seq()
#seq함수는 (start, end, by= +-num)
cc1 <-seq(10, 50, by=10);cc1
cc2 <-seq(100, 30, by=-20);cc2

# 1-3. 연속값 변수 계산하기

dd  <- seq(10, 100, by=10);dd
length(dd)

ee <-seq(100, by=-5);ee
length(ee)

dd+ee

# 돌발Q #에러이ㅇ 
# 긴 변수의 길이 = 짧은 변수의 *n
d1<- c(1:10);d1
d2<-C(1:3);d2
d1+d2 

# 1-4. 문자 변수 선언 ----
h1 <-"aaa";h1;length(h1)
h2 <-"hello R~!";h2;length(h2)
h3 <-"hello R programing ~!";h3;length(h3)
h4 <- c("hello","R","programing~!");h4;length(h4)
        
#문자변수 연산??? ----
h1+h2
h2+3

        
#1-5. 반복 문자변수 선언(rep()) ----
#+ rep(data, each, times, length.out)
#+ data = data
#+ each = 각 개별 data하나하나의 반복 횟수
#+ times = 데이터 전체의 반복횟수
#+ length.out = 표현되는 전체 데이터의 사이즈 (전체박스)

?rep()
r1 <-rep(1,5);r1

r2 <-rep(1:5,3);r2

r3 = rep(1:5, each=3);r3

r4 = rep(1:5, each=10, length.out=100);r4

r5 = rep(1:5, each=2, times=3);r5

length(rep(1:5, each=2, times=3, length.out=100))

rep(1:5, each=3) #each반복횟수 
rep(1:5, each=2 , length.out=100)
rep(1:5, each=2 , length.out=100)

rep(1:5, each=3)
rep(1:5, each=2 , length.out=100)

rep(1:5)
rep(1:5, each=2)
rep(1:5, each=2 , times=3)
rep(1:5, each=2 , times=3, length.out=100)
length(rep(1:5, each=2 , times=3, length.out=100))
       
       
#1-6. 집한연산을 활용한 변수선언(중복x, 합교차=)----

set1 <- seq(10,100,by=2);set1;length(set1) #46개
set2 <- seq(30,150,by=4);set2;length(set2) #31개

#합 #59개
u_set <- union(set1, set2);u_set;length(u_set)
46+31 #59
77-59 #18

# 교 #18개
i_set <- intersect(set1, set2);i_set;length(i_set)

# 차 #28개
d_set <- setdiff(set1, set2);d_set;length(d_set)
#+set1-set2 =28개 (set1)

d_set2 <- setdiff(set2, set1);d_set2;length(d_set2)
#+ set2 - set1 = 13개 (set2)


# = 
setequal(set1, set1)
setequal(c(1,2,3), c(3,2,2,2,1,1,1,2,3)) #true

#is.element()
is.element(12, set1) #12가 set1에 있느냐? 확인하는 함수 

# 1-7. 데이터정렬(sort(), order()) ---- 

?sort()
?order()

r1 <-rep(1,5);r1;length(r1)
r2 <-rep(1:5,3);r2;length(r2) #times =3


#sort, return : data
sort(r1)
sort(r2)

#order, return :index of raw data based on sorted data
order(r1)
order(r2)

sort(r2)
order(r2)

# 돌발_Q2. 
r2[order(r2)] #r2[index] => 해당 인덱스의 data return

order(r2)
paste(order(r2), collapse=",")

r2[c(1,6,11,2,7,12,3,8,13,4,9,14,5,10,15)]
sort(r2)

#역정렬 
sort(r2[orfer(r2)], decreasing = T)

#1-8. named vector ----

?data()
search()
data(package ="datasets") # 패키지 내 dataset 확인 

islands
length(islands)


# data type 확인
mode(islands[1])
class(islands[1])
typeof(islands[1])

View(islands)

# data 조회
head(islands)

#hist() #hist(숫자)
hist(islands)

#qplot()
search()
ggplot2::qplot(islands) #메모리에 올리지 않고 사용(o)

#named vector 생성-1 -----

c2 <- c(a=1, a=10, a=1, b=1, b=1, c=5, c=6)
c2 

hist(c2)
ggplot2::qplot(c2)

#named vector 생성 -2 -----

xx <- c(1, 3, 4)
xx

names(xx) <- c ("eunji", "guhyun", "sunghwan")
xx

# 1-9. factor(범주형 데이터)---- 
#+ Categorical data <->Numerical data
#+ 1) 명목형(nominal): 크기비교 불가 (예:미국, 한국)
#+ 2) 순서형(ordinal): 분서비교 가능 (예: 대, 중, 소)


# [문법]
# factor(x, #팩터값
#       levels, #펙터 레벨, c() 활용
#       ordered #순서 여부, T | F)

# 관련 함수 
# as.factor(x) #팩터형 데이터 생성
# levels(x) #nlevels(x)
# is.factor(x)
# is.orderd(x)

#factor test 
print("======일반 데이터 ======")
aa <- c (1,1,2,2,3,4,4,4,5,5);aa

class(aa);mode(aa)
levels(aa);nlevels(aa);is.factor(aa)

print("======factor 데이터 ======")
f.aa <- as.factor(aa);f.aa
levels(f.aa);nlevels(f.aa);is.factor(f.aa)

f.aa[10]
levels(f.aa)[5]

# 1-10. 형 변환 ----

#as.****(x) 변환
#+ as.numeric(X) # X => 수치형으로 변환
#+ as.integer(X) # X => 정수형으로 변환
#+ as.double(X) # X => 실수형으로 변환
#+ numeric(double(integer)))

#+ as.character(x) # X=> 문자형으로 변환
#+ as.logical(x) # X=> 논리형으로 변환

#+ as.factor(x) #x=> 팩터형으로 변환  
#+ as.data.frame(x) #x=> data.frame형으로 변환  

# is.****(x)확인

# 1-11.data type 확인 ----
#+ class(), mode(), typeof()

#1-11-1. 숫자
#+ numeric(double(integer)))
#+R에서는 double을 기본 수치로 인식

dima_n <- 33
class(dima_n)   #n
mode(dima_n)    #n
typeof(dima_n)  #d

#1-11-2. 문자

dima_n <- "dima"; dima_c
class(dima_c)   #c
mode(dima_c)    #c
typeof(dima_c)  #c

#문자백터

dima_n <- c("d", "i", "m", "a");dima_cv
class(dima_cv)   
mode(dima_cv)    
typeof(dima_cv)  

#1-11-3. factor

d_factor <- factor(c("D", "D", "M", "A", "i", "i"));d_factor

class(d_factor)   # **
mode(d_factor)    
typeof(d_factor)  

#1-11-4. 행렬 matrix(data, 행, 열) #(기본값) byrow = F

m1 <- c(1:20);m1
matrix(m1, 2, 2) #2행, 2열
matrix(m1, 5, 4) #5행, 4열 #열먼저 key_in
#matrix(m1, 5,3) #5행 3열

matrix(m1, 5,4, byrow = T) #5행 4열 행먼저 key-in

class(mnm1) #**
mode(mm1)
typeof(mm1)

#1-11-5. 배열 array(data,dim=c(행,열,차원))
#+ 2차원 예제 
arr1 <- rep(1:100, length.out=20)
arr2 <- array(arr1, dim=c(2,10))
class(arr2) # **
mode(arr2)
typeof(arr2) # * 

arr3 <- array(arr1, dim=c(2,5,4));arr3
class(arr3) # **
mode(arr3)
typeof(arr3) # *

#1-11-6. data.frame
a1 <- c(1:5)
a2 <- c(6:10)
a1;a2

#위 백터로 data frame 만들기
a.df <- data.frame(a1,a2)
a.df

class(a.df)    # ** 객체 유형 확인 용
mode(a.df)
typeof(a.df)   # 들어가 있는 데이터의 타입 확인용으로 적합 

# 1-11-7. list
#+ list는 data type 가리지 않고 다 수용한다. 
j5 <- seq(10,100, by=5);j5

j5.list <- list(j5, "dima", a.df, arr3, mm1)
j5.list
class(j5.list)    # **
mode(j5.list)
typeof(j5.list)   # *


# 인데스 [[숫자]]
j5.list[[2]]
j5.list[2]
j5.list[[5]] #완전 안으로 들어온 것 
j5.list[5]

ls()
ls.str()

#돌발 Q.data.frame
#+ 모든 변수의 길이 = 짧은 변수의 길이 * n
a1 <- c(1:3);a1
a2 <- c(10:15);a2
a3 <- c(20:31);a3

df.temp <- data.frame(a1, a2, a3)
df.temp


#2. 함수 ----
print("함수") #인수갯수 1개, 자동개행
print(1);print(2)

#cat() 자동개행 관련 
cat("함수","a","b","\n","c","d") #개행 "\n"
cat("함수","a","b",fill=1)

sum(1,2,3)
Sys.Date()

# 2-1. 문자처리 함수(paste) ----

h1
h2
h3

h4
length(h4)
paste(h4, collapse = "+")
paste(h4, collapse = "^^;")
paste(h4, collapse = "")
length(paste(h4, collapse=""))

# 문제 
paste(h1,h2)
paste(h2,3)
length(paste(h2,3))


# 2-2. 사용자 정의 함수 ---- 
#+ 인수: 숫자 3개/ 출력: 합계, 평균 

f.dima <- function(a,b,c){
  d.sum <- sum(a,b,c)
  d.avg <- d.sum/3  
  
  #print(d.sum)
  #print(d.avg)
  #cat(d.sum, d.avg)
  
  return(list(sum = d.sum, avg = d.avg))
} 

a3 <- f.dima(10, 20, 30)

a3


#print()
f.dima(1,2,3) # ok

d.sum_avg <- f.dima(1,2,3)
d.sum_avg #not ok. 값을 두개 다 못 담음 

#cat()
f.dima(1,2,3) # ok
d.sa <- f.dima(1,2,3)
d.sa # null로 return됨. 마찬가지로 값을 다 못담는다.


# 2-3. 내장함수(built-in function) ----

# 2-3-1. dataset 로딩 및 조회 ----

read.csv("ss_exam.csv")
dima_ex <- read.csv("ss_exam.csv")

dima_ex

#dataset 속성조회
#+ cdhlmnstrV

class(dima_ex)        #data.frame
class(dima_ex$japan)  #integer
colnames(dima_ex)
dim(dima_ex)          #30행 6열 짜리
names(dima_ex)        
head(dima_ex)         #앞 6행조회
length(dima_ex)       #열개수
length(dima_ex$japan) #데이터 갯수(대상: 벡터 data.frame)
levels(dima_ex)       #범주형 데이터 관련

mode(dima_ex)           #컬럼명
mode(dima_ex$japan)     #numeric
names(dima_ex)
nrow(dima_ex)           #행 갯수
ncol(dima_ex)           #열 갯수
str(dima_ex)            #데이터 속성 + a *
summary(dima_ex)        #기술통계량 *
typeof(dima_ex)
typeof(dima_ex$japan)   #데이터 속성 *
tail(dima_ex)           #뒤 6개 행 조회
rownames(dima_ex)       #행이름
View(dima_ex)           #원자료(raw data) 조회


# 2-3-2. data selection ----
#+ 대괄호 안의 ,를 기준으로 행과 열인것을 인지한다. 
head(dima_ex)          # sample 
dim(dima_ex)
dima_ex[2,]            # 2행 조회   # aa[행, 열] -> 행 백터 
dima_ex[,3]            # 3열 조회 # 컬럼명 안나온 이유는 백터로 받아들였기 때문 -> 열 백터 
dima_ex[c(3)]          # 3열 조회 with 컬럼명 + C를 넣어야 차원의 개념으로 받아들임 
dima_ex[2,3]           # 2행 3열로 딱 한 개의 값을 구한다.

# 4열과 5열 조회 
#+ 대괄호 안의 ,가 없기 때문에 index로 인식한다. 
dima_ex[4]            # 연속 되어 있기 때문에 : 를 사용 
dima_ex[4:5]

# 2열, 6열, 1열 조회 
dima_ex[c(2,6,1)]    # 연속 되어 있지 않아서 c함수 사용 
head(dima_ex[c(2,6,1)])

# 컬럼명으로 조회 (id, java)
head(dima_ex[c("id","java")])

# 돌발Q. id가 3인 java와 eng 성적 조회?
head(dima_ex)
dima_ex[dima_ex$id ==3, c('java', 'eng')] #찐 정답 
dima_ex[3,c("java","eng")]

#java, japan 성적 조회 관련 
#+ 백터에다가 dim은 사용 못한다는것을 알 수 있다. 차원 개념에만 dim 사용 가능!
#+ FYI. dim()은 행과열을 return하는 function이다. 

head(dima_ex[,4])         # 벡터  개념 (, 가 있는게 벡터 컨셉)
head(dima_ex[c(4)])       # 차원 개념 (no ,)

dim(head(dima_ex[,4]))    # null. vector concept의 dim이라서 못나옴 (,)
dim(head(dima_ex[c(4)]))  # 6행, 1열 (no ,)

dim(dima_ex[c(4)])        #head가 없는거니까 30행 1열

#컬럼 추가 조회 
#+ 하지만 예외로 ,가 있는 백터여도 열이 2개가 되기 때문에 차원 개념으로 인식되어 c함수를 반드시 사용 
#질문----
head(dima_ex[,c(4,6)])        # 6행 2열 (,)
head(dima_ex[c(4,6)])         #???? 바로 위랑 결과가 같은데 뭐가 다른거지 c 함수를 사용했으니까 , 가 없어도 차원의 값 아닌가?


dim(head(dima_ex[,c(4,6)]))  # 6행 2열 (,)
dim(head(dima_ex[c(4,6)]))   # 6행 2열 (no , ) 차원 개념이다.

# another examples:
head(dima_ex[4,5])           #4행 5열 X. 이렇게 쓰면 안된다.
head(dima_ex[c(4,5)])        #4행 5열. 이렇게 써야 함. 

# 2-3-3. 조건부 조회 ----

# 일본어 점수 >= 90인 row 조회 
head(dima_ex)

dima_ex[dima_ex$japan >= 90,]
#+ 일본어 점수가 90점 이상인 모든것을 읽는것임을 잊지말자 (therefore, column이 아닌 row 로 조회)

# 일본어 점수가 >= 90 이고 영어 점수가 <70인 row 조회하라 
dima_ex[dima_ex$japan >= 90 & dima_ex$eng <70,]
#+ advanced 여기서 위 조건에 충족되는 id만 보고 싶으면?
# dima_ex[dima_ex$japan >= 90 & dima_ex$eng <70,"id"]

#영어가 >= 60인 id의 database와 japan 점수를 조회하라 
dima_ex[dima_ex$eng >= 60, c('id', 'database', 'japan')] 

# 2-3-4. 패키지 내의 함수 ----
#+ base::plot()        # 기본 plot()
#+ ggplot2:ggplot()    # 분석 및 개발 시 빠른 확인을 위해 사용 
#+ ggplot2::ggplot()   # 확정 보고서용으로 자주 사용 

# dataset 로딩, 변수처리
my_mpg <- ggplot2::mpg
my_mpg

my_mpg$cty #아 오케 mpg에 있는 cty 값들을 나열을 한거구나

# plot()
plot(x=my_mpg$cty) #아니 y 에 값이 왜.. 아아ㅏㅏㅏㅏㅏㅏ 인덱스가 1일 때 인덱스가 2일 때 오케ㅔㅔㅔ
plot(y=my_mpg$cty) # x는 디폴트 값이어서 꼭 나와야한다고 하네
plot(x=my_mpg$hwy)
plot(x=my_mpg$cty, y=my_mpg$hwy) #sample of 양의 상관관계 

# ggplot2::qplot()
search()
ggplot2::qplot(data=my_mpg, x=cty)
ggplot2::qplot(data=my_mpg, x=hwy)
ggplot2::qplot(data=my_mpg, x=cty, y=hwy)

# x=drv, y=hwy
?mpg
ggplot2::qplot(data=my_mpg, x=drv, y=hwy)
ggplot2::qplot(data=my_mpg, x=drv, y=hwy, geom="boxplot")
ggplot2::qplot(data=my_mpg, x=drv, y=hwy, geom="boxplot", col=drv)

#구연 돌발퀴즈 답안 
jwc_multi <- function(xx){
  for(i in 1:9) {
    if (xx > 0 && xx < 10) {
      print(paste (xx, "*", i, "=" , xx*i ))
    }
    else{ 
      print("주어진 수치가 부적합 합니다. 종료!")
      break;
    }
  }
}
# jwc_multi(xx) -> 잘못된 식인건지? error이니까? 


#질문----
# 돌발퀴즈 교수님 답안 
dima_mul <- function(xxx){
  if (is.numeric(xxx) & xxx %in% c(1:9)) {
    
       #xxx %in% c(1:9)) %in% 안에 있는지 보는 함수 T/F 
    
    for (i in 1:9) {
      a <- xxx * i
      #print(paste(xxx, "*", i, "=", a))
      cat(paste(xxx, "*", i, "=", a), fill=1)
    }
  } else {
    print("종료!")
  }
}

#DJ 답안 -1
dima_mul(1);dima_mul(10);dima_mul("bbb")
dima_mul(ccc)

jwc_multi <- function(xx){
  if(is.character(xx) == FALSE)
    for(i in 1:9) { 
      a <- xx * i
      print(paste(xx, "*", i, "=", a))
    }
  
  else{
    print("종료!")
  }
}

#DJ 답안 - 2
dima_multi <- function(xx){
  if(is.character(xx) == FALSE & xx %in% c(1:9))
    for(i in 1:9) { 
      a <- xx * i
      print(paste(xx, "*", i, "=", a))
    }
  
  else{
    print("종료!")
  }
}

# 2-4. 빈도함수 (table(), hist(), qplot())
#+ hist(숫자) // hist함수는 숫자만 적용 가능하다 
#+ Histogram 도수 분포도, 막대 그래프
#+ 함수가 어느 패키지에 소속되었는지 알고 싶으면 아래와 같이 물음표 사용
?hist() #graphics pkg

#qplot(인수) #인수는 문자나 숫자 관계없이 사용 가능하다. 
?qplot() #ggplot2 pkg

#number data
bindo <- c(1,1,1,2,2,3,4,4,4,5,5);bindo

class(bindo)
str(bindo)
typeof(bindo)
table(bindo)                  # 빈도 데이터 확인 -> 테이블 형식으로 어떤 숫자가 몇개 들어있는지 알려줌 
sum(bindo)                    # 데이터 합계 

#질문 무슨 의미가 있는 데이터지 ----
sum(table(bindo))             # 빈도의 합계 -> 빈도 데이터(횟수) 합계 * 

bindo
#질문 ----
prop(bindo)       #이거 오류나는데 왜 안되지 그리고 이거 아래 수치가 이해가 안되는데 
prop.table(bindo)             # 각 데이터별 백분율 
sum(prop.table(bindo))        # 총 백분율 = 1

prop.table(table(bindo))      # 카테고리별 백분율 * 
prop.table(table(bindo)) * 100 

#+ plot()
hist(bindo)
ggplot2::qplot(bindo)

# character data

b_num <- c("a", "a", "a", "b", "b", "c");b_num

class(b_num)
typeof(b_num)
table(b_num)
# sum(b_num) -> 문자와 숫자를 더 할 수 없어서 에러 뜸. 사용 불가 

table(b_num)                # *
# prop.table(b_num) -> error 이걸 사용하고 싶으면 아래처럼 명령한다.
prop.table(table(b_num))    # * 

?prop.table #fyi

#+ plot
#hist(b_num) -> histogram의 인수는 반드시 숫자여야 한다. 문자여서 에러 뜬것임 사용불가 
hist(table(b_num)) # 정확히 원하던 그림은 아니나 이렇게 하면 사용은 가능하다. 
ggplot2::qplot(b_num)      # *

## null / na / nan / inf ----
#+ null: 초기화 되지 않은 상음 , is.null()
#+ na: 결측치 (not available) , is.na()
#+ na와 null은 다르다 
#+ nan: 변환 불가능 (not a number)
#+ inf / -inf : 무한(infinite), R 
# R에서 다루기에는 너무 크거나 작음 

# inf/-inf 

1e+10       # 1*10의 10승 
1e+300      # 1*10의 300승 
1e+309      # 1*10d의 308승까지만 계산되고 309승부터는 inf로 찍힘 
-1e+309     #마찬가지로 사용 불가. inf로 찍힘

# nan
log(1000)
log(-1000)    # nan -> 변환이 불가능하다. 로그는 음수가 없음. 

# NULL & na -> 즉, NA > NULL
n1 <- c(1,2,3,NULL,NULL);n1 #측정조차 불가하기 때문에 카운트 안됨 
length(n1) # NULL은 길이에도 포함시키지 않는다. (초기화도 되지 않았기 때문)

n1

n2 <- c(1,2,3,NA,NA);n2 # 측정이 안될뿐이지 존재한다 
length(n2) # NA는 길이에 포함됨.

n1;n1+1;n1+NA
n1;3+n1;NULL+n1
NULL+n1  #질문 이거 값이 왜 이렇게 나오는지 궁금해 ----
n2;n2+1
n1;n1+1;n1+NA;n1+NULL
n2;n2+1;n2+NA;n2+NULL

n1
sum(n1)

n2
sum(n2) # NA를 인식하기 때문에 계산이 안됨. 결과가 NA가 나오는 것이다. 이럴때는 아래와 같이 명령한다.
sum(n2, na.rm=T) # na.rm=T 의 뜻은 NA가 있다면 열외 시키고 실행하라는 뜻이다. 

# table 옵션 ----

t1 <- c(NULL, "a", "a", NULL, "b", "c");t1
table(t1)
table(t1, useNA = 'no')
table(t1, useNA = 'ifany')
table(t1, useNA = 'always')                       # *
ggplot2::qplot(t1)

t2 <- c(NULL, "a", "a", NULL, "b", "c", NA, NA);t2
table(t2)                   # NA 무시              **
table(t2, useNA = 'no')     # NA 무시 ( 기본값 )
table(t2, useNA = 'ifany')  # NA가 있다면 보여줘라 **
table(t2, useNA = 'always') # 항상 NA를 보여줘라 
ggplot2::qplot(t2)

# 3. 리스트 ----
print("1. ===================")
x1 <- c(n=1, m=2, o=3, o=3, n=1);x1
x1
x1[5]
table(x1) # value만 불려진다. #빈도체크
hist(x1) #빈도체크 시각화 # 마찬가지로 value만 불려진다. alphabet은 named vector라는 뜻 
class(x1)
table(x1)
hist(x1)

x2 <- list(name="kkido", height=185);x2
x22 <-  list("kkido", 185);x22

x222 <- c("kkido", 185);x222

x22[1];xx[2]



View(x2)
View(x22)

x2$name
x2$height

#+ named vector 처럼 이름을 (name, height) 줘야 값이 나옴. 
#+ 따라서 리스트에 이름을 주면 하나씩 approach 가 가능하다 
x2$name
x2$height

print("2. ====================")
#+ list(element = item)
#+ list(원소 = 값) #list(key = value)

x3 <- c(x2, list(phone=NA));x3
#+ 리스트(아이템이 없는 원소만) 추가
#+ 엥 뭔소리지


class(x3)    #차원이 있는 친구들과 친함 
mode(x3)
typeof(x3)

x4 <- c(x3, list(addr="화양동"));x4
#+ 리스트에 리스트를 추가
x4$name;x4$addr
View(x4)

print("3. ===================")
#+ 리스트에 item(value)를 추가
#+ 

names(x4)
x4

class(x1) #이렇게 접근은 벡터로 접근인거지  --> 벡터의 첫번째 값 호출
x1[1]

class(x4)
x4[1] #리스트의 첫번째 값 호출 

x4[[1]]

# 1)

temp01 <- c(x4[1],"choi");temp01
temp01
class(x4[1])
class(temp01)
View(temp01)
# 기존 리스트 data에다가 vector를 추가하면 data type은 lsit가 되고 새로운 객체가 된다. 

#2) 

temp02 <- c(x4[[1]], "choi2");temp02
temp02
class(x4[[1]]) #꺼내온 데이터가 백터라서 타입이 백터임 
View(temp02)

#3) 본격적인 item 추가

x4;names(x4)
x5 <- x4;x5


x5[[1]] <- c(x5[[1]], "choi");x5
x5[[2]] <- c(x5[[2]], "178");x5
x5[[3]] <- c(x5[[3]], "2037");x5
x5[[4]] <- c(x5[[4]], "신림동");x5

x5

x5[[1]][1]  # 언박싱해서 첫번째 값, 특정 리스트 box의 첫번째
x5[[2]][2]
x5[[3]][3]

x5[1][1] #언박스 안하고 박스 통째로 x5[1]이랑 같은 것
x5[1][2] # 못알아 먹지

x5[1][[1]] # 전체 데이터를 가지고 오는거지, 해당 리스트 box의 모든 데이터
x5[2][[2]]

x[[1]][[1]]
x[[1]][[2]]
x[[1]][[3]]

#조별 회의
x5
x5[[1]][1] #백터에서 첫번쨰값
x5[1][1] #리스트에서 첫번쨰값
class(x5[1])
class(x5[[1]])
x5[[1]]


View(x4)
View(temp01)
View(temp02)


#데이터 갱신

#갱신할거니까 알맹이만 배온거지
x5[[3]][1]
x5[[3]][1] <- 6000
x5


print("4. ========================")

data(package= "datasets")
head(cars)
names(cars)
dim(cars)

my_car <- head(cars, 10)
my_car

class(x1);x1 #vector
class(x2);x2 #list
class(x3);x3 #list
class(x4);x4 #list
class(x5);x5 #list
class(my_car);my_car #data.frame

din(x2)

x6 <- c(x5, list(v1=x1, l2=x2, l3=x3, l4=x4, l5=x5, df.l=my_car))

summary(x6)
class(x6)

View(x6)

#list 방확인

x6[1]
x6[2]
x6[3]
x6[4]
x6[5]
x6[6]
x6[7]
x6[8]
x6[9]
x6[10]
#x6[11]








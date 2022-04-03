library(odbc);library(DBI)
library(rJava);library(RJDBC)
search()

jdbc_R <- JDBC(driverClass = "oracle.jdbc.OracleDriver",
               classPath = "C:/Database/oraclexe/app/oracle/product/11.2.0/server/lib/ojdbc6.jar");jdbc_R

db_con <- dbConnect(jdbc_R, "jdbc:oracle:thin:@localhost:1521:XE","hr","hr");db_con

# Query (db로부터 원자료 받아오기) ----

emp_dept <- "select * from employees e, departments d where e.department_id = d.department_id"

rs <- dbGetQuery(db_con, emp_dept)

class(rs)
dim(rs)
names(rs)
head(rs, 3)

# Data Save ----

write.csv(rs, file = "emp_dept3.csv")

# Data adjusted selection ----
library(dplyr);search()

rs %>% 
  select(11, 13, 1:2, 7:8)
names(rs)

# dataset -> 변수 저장
emp_dept1 <- rs %>% select(11, 13, 1:2, 7:8)
names()

# tapply() 활용 *
#+ tapply(벡터, index, 함수, 함수인자)

# 부서별 평균 임금
tapply(emp_dept1$SALARY,
       emp_dept1$DEPARTMENT_NAME, mean)

# 참고
d_avg_sal <- tapply(emp_dept1$SALARY,
                    emp_dept1$DEPARTMENT_NAME, mean)

class(d_avg_sal)
dim(d_avg_sal)
mode(d_avg_sal)
typeof(d_avg_sal)
d_avg_sal[[1]]
#1
customer <- 'customer'
product <- 'product'
order <- 'order' 

r_xl <- read_excel("Union_ds.xlsx")


r_xi <- r_xl <- function(x){
  return(read_excel("Union_ds.xlsx", sheet = x, col_names = T))    
}

cus <- r_xl(customer)
pro <- r_xl(product)
ord <- r_xl(order)

cus
pro
ord


#2

head(cus)
head(pro)
head(ord)

full_join(cus, ord)
temp <- full_join(pro, ord)
chart <- full_join(temp, cus)

up3 <- chart %>% 
  group_by(c_name,addr, .groups = "drop_last") %>% 
  summarise(count=n()) %>% 
  dplyr::filter(count >= 3)

up5 <- chart %>% 
  group_by(p_id,p_name,p_price, .groups = "drop_last") %>% 
  summarise(pt=n()) %>% 
  filter(pt>=5)

temptemp2 <- rbind(up3, up5)
temptemp2


#3

str(chart)
chart

#`summarise()` has grouped output by 'c_id'. You can override using the `.groups` argument. 이게 무슨 오류일까요...

#4

chart$total

how<- chart %>% 
  group_by(c_id,c_name) %>% 
  summarise(total=n())

how$p_total <- sum(chart$p_price)


#4번을 모르겠습니다. 합계를 만들어서 컬럼으로 만들어주고 싶은데 잘 모르겠습니다.
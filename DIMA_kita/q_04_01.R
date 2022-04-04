#7-1

library(readxl)
forest_example_data <- read_excel("C:/PR/R_Works/DIMA_kita/forest_example_data.xls")
forest_example_data

colnames(forest_example_data) <- c("name", "city","gubun", "area","number","stay","city_new","code","codename")
head(forest_example_data)

library(descr)
freq(forest_example_data$city, plot = T, main = 'city')

city_table <- table(forest_example_data$city)
city_table
barplot(city_table)

library(dplyr)
count(forest_example_data, city) %>% arrange(desc(n))

count(forest_example_data, city_new) %>% arrange(desc(n))
count(forest_example_data, codename) %>% arrange(desc(n))

#7-2

library(readxl)
entrance_xls <- read_xls("C:/PR/R_Works/DIMA_kita/entrance_exam.xls")
head(entrance_xls)

colnames(entrance_xls) <- c("country","JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT","NOV","DEC")

entrance_xls$country <- gsub(" ","", entrance_xls$country)
entrance_xls

entrance_xls %>% nrow()

top5_country <- entrance_xls[order(-entrance_xls$JAN),] %>% head(n=5)
top5_country

library(reshape2)
top5_melt <- melt(top5_country, id.vars = 'country', variable.name = 'mon')
head(top5_melt)

library(ggplot2)

ggplot(top5_melt, aes(x = mon, y = value, group = country)) + geom_line(aes(color = country))
ggplot(top5_melt, aes(x = mon, y = value, group = country)) + 
  geom_line(aes(color = country)) +
  ggtitle("2020년 국적별 입국 수 변화 추이") +
  scale_y_continuous(breaks = seq(0, 500000, 500000))

ggplot(top5_melt, aes(x = mon, y = value, fill = country)) + 
  geom_bar(stat = "identity", position = "dodge")


ggplot(top5_melt, aes(x = mon, y = value, fill = country)) + 
  geom_bar(stat = "identity", position = "stack")


#7-3
library(readxl)
xlsdata <- read_excel("C:/PR/R_Works/DIMA_kita/선별진료소_20220403104315.xls")
View(xlsdata)

data_raw <- xlsdata[,c(2:5)]
head(data_raw)

names(data_raw)
names(data_raw) <- c("state", "city", "name", "addr")
names(data_raw)

table(data_raw$state)
barplot(table(data_raw$state))

daejeon_data <- data_raw[data_raw$state == "대전",]
head(daejeon_data)

nrow(daejeon_data)

install.packages("ggmap")
library(ggmap)
ggmap_key <- "AIzaSyDh05C9oJ6tZfFLfh9mSYcMsZRpa_ntVp0"
register_google(ggmap_key)

daejeon_data <- mutate_geocode(data = daejeon_data, location = addr, source = 'google')
head(daejeon_data)
daejeon_map <- get_googlemap('대전', maptypw = 'roadmap', zoom = 11)
ggmap(daejeon_map) +
  geom_point(data = daejeon_data, aes(x = lon, y = lat, color = factor(name)), size = 3)

daejeon_data_marker <- data.frame(daejeon_data$lon, daejeon_data$lat)
daejeon_map <- get_googlemap('대전', maptype = 'roadmap', zoom = 11, markers = daejeon_data_marker)

ggmap(daejeon_map) +
  geom_text(data = daejeon_data, aes(x = lon, y = lat), size = 3, label = daejeon_data$name)

#7-4



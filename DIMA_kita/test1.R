print("batch start!=================")

library(dplyr)
library(ggplot2)
search()

ss <- function(){
sessionInfo()

  s_info <- sessionInfo()
  return(s_info)

}

ss()

my_mpg <- mpg

aa <- my_mpg %>% 
  select(1,5,7) %>% 
  head(5)

aa


print("batch stop!=================")
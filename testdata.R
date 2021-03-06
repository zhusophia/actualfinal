library(tidyverse)
library(tidyr)
library(dplyr)
library(rmarkdown)

titledata <- read.csv("newstitle1.csv")
removedata <- titledata %>%
  select(title, category) %>%
  slice(1:7900) %>% 
  mutate(title = strsplit(as.character(title), " ")) %>% 
  unnest(title) %>% 
  group_by(title) %>% 
  summarize(total = n()) %>% 
  arrange(desc(total)) %>% 
  slice(1:50) 

newdata <- removedata[c(4, 15, 16, 17, 21, 25, 28, 29, 30, 37),]
ggplot(newdata, mapping = aes(x = reorder(title, total), y = total))+
  geom_col(fill = "darkseagreen3")+
  theme_classic()+
  coord_flip()+
  labs(title = "Most Common Words in Fake News Headlines (Edited)", 
       subtitle = "Painfully obvious what year this is from", y = "Amount of Times it has Appeared in a Headline", x = "Word", caption = "Source: BuzzFeed News")

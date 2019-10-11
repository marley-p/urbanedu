library(tidyverse)
library(educationdata)

admit_df<-read.csv("admit.csv")
earnings_df<-read.csv("earnings.csv")
repay_df<-read.csv("repay.csv")
grad_final<-("grad.csv")

admit_df <- admit_df %>% unite(match,unitid,year,remove=FALSE)

earnings_short_df<-earnings_df %>% filter(years_after_entry==6|years_after_entry==7)
earnings_short_df <- earnings_short_df %>% unite(match,unitid,cohort_year,remove=FALSE)
earnings_short_df <- admit_df %>% right_join(earnings_short_df,by="match")

earnings_mid_df<-earnings_df%>% filter(years_after_entry==8)
earnings_mid_df <- earnings_mid_df %>% unite(match,unitid,cohort_year,remove=FALSE)
earnings_mid_df <- admit_df %>% right_join(earnings_mid_df,by="match")

earnings_long_df<-earnings_df%>% filter(years_after_entry==9|years_after_entry==10)
earnings_long_df <- earnings_long_df %>% unite(match,unitid,cohort_year,remove=FALSE)
earnings_long_df <- admit_df %>% left_join(earnings_long_df,by="match")

repay_df %>% group_by(years_since_entering_repay) %>%
  summarize(total=sum(years_since_entering_repay)/mean(years_since_entering_repay))

repay_5<-repay_df %>% filter(years_since_entering_repay==5)
repay_5<-repay_5%>% unite(match,unitid,cohort_year,remove=FALSE)
repay_5 <- admit_df %>% right_join(repay_5,by="match")
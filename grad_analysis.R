grad_math<-grad_df %>% filter(sat_math_25_pctl>0, completion_rate_150pct>0)

grad_math %>% ggplot(aes(x=sat_math_25_pctl,y=completion_rate_150pct))+
  geom_point()+
  geom_smooth(method=lm)

grad_read<-grad_df %>% filter(sat_crit_read_25_pctl>0, completion_rate_150pct>0)

grad_read %>% ggplot(aes(x=sat_crit_read_25_pctl,y=completion_rate_150pct))+
  geom_point()+
  geom_smooth(method=lm)

grad_regress <-lm(completion_rate_150pct~sat_crit_read_25_pctl+sat_writing_25_pctl+sat_math_25_pctl,data=grad_df)
summary(grad_regress)

grad_missing<-grad_df %>% filter(is.na(sat_math_25_pctl)) 

mean(grad_missing$completion_rate_150pct,na.rm=TRUE)
mean(grad_math$completion_rate_150pct,na.rm=TRUE)
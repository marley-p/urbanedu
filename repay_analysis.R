repay_5_math<-repay_5 %>% filter(sat_math_25_pctl>0, repay_rate>0)

repay_5_math %>% ggplot(aes(x=sat_math_25_pctl,y=repay_rate))+
  geom_point()+
  geom_smooth(method=lm)

repay_5_read<-repay_5 %>% filter(sat_crit_read_25_pctl>0, repay_rate>0)

repay_5_read %>% ggplot(aes(x=sat_crit_read_25_pctl,y=repay_rate))+
  geom_point()+
  geom_smooth(method=lm)

repay_regress <-lm(repay_rate~sat_crit_read_25_pctl+sat_writing_25_pctl+sat_math_25_pctl,data=repay_5)
summary(repay_regress)
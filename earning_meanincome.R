student_math<-student_df %>% filter(sat_math_25_pctl>0, faminc_med>0)

student_math %>% ggplot(aes(x=sat_math_25_pctl,y=faminc_med))+
  geom_point()+
  geom_smooth(method=lm)

student_read<-student_df %>% filter(sat_crit_read_25_pctl>0, faminc_med>0)

student_read %>% ggplot(aes(x=sat_crit_read_25_pctl,y=faminc_med))+
  geom_point()+
  geom_smooth(method=lm)

student_regress <-lm(faminc_med~sat_crit_read_25_pctl+sat_writing_25_pctl+sat_math_25_pctl,data=student_df)
summary(student_regress)

student_earnings<- student_df %>% left_join(earnings_short_df,by="match")

student_earnings_cut<- student_earnings %>% filter(sat_math_25_pctl.x>0, faminc_med>0,earnings_mean>0)

student_earning_regress <-lm(earnings_mean~faminc_med+sat_crit_read_25_pctl.x+sat_writing_25_pctl.x+sat_math_25_pctl.x,data=student_earnings_cut)
summary(student_earning_regress)

student_earning_regress <-lm(earnings_mean~faminc_med+sat_math_25_pctl.x,data=student_earnings_cut)
summary(student_earning_regress)

student_earning_regress <-lm(earnings_mean~faminc_med,data=student_earnings_cut)
summary(student_earning_regress)
library(tidyverse)

df_full<-earnings_short_df

df25<-df_full%>% filter(earnings_mean>0&sat_math_25_pctl>0)

df25 %>% ggplot(aes(x=earnings_mean,y=sat_math_25_pctl))+
  geom_point()+
  geom_smooth(method=lm)

df75<-df_full%>% filter(earnings_mean>0&sat_math_75_pctl>0)

df75 %>% ggplot(aes(x=earnings_mean,y=sat_math_75_pctl))+
  geom_point()+
  geom_smooth(method=lm)

dfcrit<-df_full%>% filter(earnings_mean>0&sat_crit_read_25_pctl>0)

dfcrit %>% ggplot(aes(x=earnings_mean,y=sat_crit_read_25_pctl))+
  geom_point()+
  geom_smooth(method=lm)
 
dfwrit <- df_full%>% filter(earnings_mean>0&sat_writing_25_pctl>0)

dfwrit %>% ggplot(aes(x=earnings_mean,y=sat_writing_25_pctl))+
  geom_point()+
  geom_smooth(method=lm)

dfclean<-df_full %>% filter_at(vars(sat_math_25_pctl,sat_crit_read_25_pctl,sat_writing_25_pctl),all_vars(.>0))

sat_earnings_regress<-lm(earnings_mean~sat_crit_read_25_pctl+sat_writing_25_pctl+sat_math_25_pctl,data=dfclean)
summary(sat_earnings_regress)

sat_math_av<-mean(df25$sat_math_25_pctl)
sat_math_sd<-sd(df25$sat_math_25_pctl)

sat_crit_av<-mean(dfcrit$sat_crit_read_25_pctl)
sat_crit_sd<-sd(dfcrit$sat_crit_read_25_pctl)

sat_writ_av<-mean(dfwrit$sat_writing_25_pctl)
sat_writ_sd<-sd(dfwrit$sat_writing_25_pctl)

df_act_math<- df_full%>% filter(earnings_mean>0&act_math_25_pctl>0)

df_act_math %>% ggplot(aes(x=earnings_mean,y=act_math_25_pctl))+
  geom_point()+
  geom_smooth(method=lm)

df_act_english<- df_full%>% filter(earnings_mean>0&act_english_25_pctl>0)

act_math_av<-mean(df_act_math$act_math_25_pctl)
act_math_sd<-sd(df_act_math$act_math_25_pctl)

act_english_av<-mean(df_act_english$act_english_25_pctl)
act_english_sd<-sd(df_act_english$act_english_25_pctl)

df_act_english %>% ggplot(aes(x=earnings_mean,y=act_english_25_pctl))+
  geom_point()+
  geom_smooth(method=lm)

act_earnings_regress<-lm(earnings_mean~act_math_25_pctl+act_english_25_pctl,data=df_act_math)
summary(act_earnings_regress)

df_standard<-df_full %>% mutate(sat_math_25_stand=(sat_math_25_pctl-sat_math_av)/sat_math_sd,
                                sat_writ_25_stand=(sat_writing_25_pctl-sat_writ_av)/sat_writ_sd,
                                sat_crit_25_stand=(sat_crit_read_25_pctl-sat_crit_av)/sat_crit_sd,
                                act_math_25_stand=(act_math_25_pctl-act_math_av)/act_math_sd,
                                act_english_25_stand=(act_english_25_pctl-act_english_av)/act_english_sd)
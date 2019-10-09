library(tidyverse)
library(devtools)
devtools::install_github("UrbanInstitute/education-data-package-r")
library(educationdata)
df<-get_education_data(level = 'college-university', 
                       source = 'ipeds', 
                       topic = 'admissions-requirements',
                       filters=list(year=1997:2008),
                       add_labels = TRUE)
df2<-get_education_data(level = 'college-university', 
                       source = 'scorecard', 
                       topic = 'earnings',
                       filters=list(year=2004:2014),
                       add_labels = TRUE)
df2<-df2 %>% filter(years_after_entry==6|years_after_entry==7)

df <- df %>% unite(match,unitid,year,remove=FALSE)

df2 <- df2 %>% unite(match,unitid,cohort_year,remove=FALSE)

df_full <- df %>% right_join(df2,by="match")



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

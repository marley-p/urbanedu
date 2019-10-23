admit_year<-admit_df %>% group_by(year) %>% 
  summarize(satmath25=mean(sat_math_25_pctl,na.rm = TRUE),
            satmath75=mean(sat_math_75_pctl,na.rm = TRUE),
            actmath25=mean(act_math_25_pctl,na.rm = TRUE),
            actmath75=mean(act_math_75_pctl,na.rm = TRUE),
            total_report=sum(sat_math_25_pctl>0,na.rm=TRUE),
            total_entry=sum(year>0))

admit_state<-admit_df %>% group_by(abb) %>%
  summarize(satmath25=mean(sat_math_25_pctl,na.rm = TRUE),
            satmath75=mean(sat_math_75_pctl,na.rm = TRUE),
            actmath25=mean(act_math_25_pctl,na.rm = TRUE),
            actmath75=mean(act_math_75_pctl,na.rm = TRUE),
            total_report=sum(sat_math_25_pctl>0,na.rm=TRUE),
            total_entry=sum(year>0))

admit_state %>% mutate(abb=reorder(abb,satmath25))%>%
  ggplot(aes(x=abb,y=satmath25)) +
  geom_col()

admit_year%>% ggplot(aes(x=year,y=satmath25)) +
  geom_col()

admit_df%>%
  ggplot(aes(x=abb,y=sat_math_25_pctl)) +
  geom_boxplot()
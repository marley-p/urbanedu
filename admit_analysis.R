admit_year<-admit_df %>% group_by(year) %>%
  summarize(satmath25=mean(sat_math_25_pctl,na.rm = TRUE),
            satmath75=mean(sat_math_75_pctl,na.rm = TRUE),
            actmath25=mean(act_math_25_pctl,na.rm = TRUE),
            actmath75=mean(act_math_75_pctl,na.rm = TRUE))

admit_state<-admit_df %>% group_by(fips) %>%
  summarize(satmath25=mean(sat_math_25_pctl,na.rm = TRUE),
            satmath75=mean(sat_math_75_pctl,na.rm = TRUE),
            actmath25=mean(act_math_25_pctl,na.rm = TRUE),
            actmath75=mean(act_math_75_pctl,na.rm = TRUE))
library(tidyverse)
library(devtools)
devtools::install_github("UrbanInstitute/education-data-package-r")
library(educationdata)

admit_df<-get_education_data(level = 'college-university', 
source = 'ipeds', 
topic = 'admissions-requirements',
filters=list(year=1997:2014),
add_labels = TRUE)

earnings_df<-get_education_data(level = 'college-university', 
source = 'scorecard', 
topic = 'earnings',
filters=list(year=2004:2014),
add_labels = TRUE)

repay_df<-get_education_data(level = 'college-university', 
                          source = 'scorecard', 
                          topic = 'repayment',
                          filters=list(year=2015:2016),
                          add_labels = TRUE)

grad_df<-get_education_data(level = 'college-university', 
                             source = 'ipeds', 
                             topic = 'grad-rates',
                             filters=list(year=2006:2016),
                             add_labels = TRUE)

grad_final<-grad_df %>%  filter(race=='Total'&sex=='Total'&subcohort=='Total')

write.csv(admit_df,"admit.csv")
write.csv(earnings_df,"earnings.csv")
write.csv(repay_df,"repay.csv")
write.csv(grad_final,"grad.csv")

df3<-df2 %>% filter(years_after_entry==6|years_after_entry==7)

df4 <- df %>% unite(match,unitid,year,remove=FALSE)

df3 <- df3 %>% unite(match,unitid,cohort_year,remove=FALSE)

df_full <- df4 %>% right_join(df3,by="match")

write.csv(df_full,"df_full.csv")

library(tidyverse)
library(devtools)
devtools::install_github("UrbanInstitute/education-data-package-r",host = "https://api.github.com")
library(educationdata)
df<-get_education_data(level = 'schools', 
                       source = 'edfacts', 
                      topic = 'assessments',
                       filters=list(year=2016,
                       grade_edfacts=9:12),
                       add_labels = TRUE)
scores<-df %>% filter(math_test_pct_prof_high>=0&math_test_pct_prof_high<=100&read_test_pct_prof_high>=0&read_test_pct_prof_high<=100)
scores %>% ggplot(aes(x=math_test_pct_prof_high,y=read_test_pct_prof_high))+
  geom_point(color="red",alpha=0.5)+
  geom_smooth(method=lm)

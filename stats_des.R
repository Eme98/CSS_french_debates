#################################
######## Stats descriptives #####
#################################

library(dplyr)
library(kableExtra)

#### Sessions

#Nbr of days = 16
table(df$date_seance)
# Nbr of sessions = 34
table(df$date_seance, df$num_seance)

### Number of speakers
###### We remove "President assemblee" because it does not really count either as 
# an intervention or an interruption as he/she regulates the debate

count = 0
parole <- df[df$orateurs_interruption == "PAROLE_GENERIQUE" & 
               df$orateurs_qualite != "President assemblee",]
count <- ifelse(parole$orateurs_id != shift(parole$orateurs_id), 1, 0)
count
table(count) #3848 different persons took the floor

count = 0
count <- ifelse(parole$orateurs_id != shift(parole$orateurs_id) & 
                  parole$gender == "F", 1, 0)
table(count)
count <- ifelse(parole$orateurs_id != shift(parole$orateurs_id) & 
                  parole$gender == "M", 1, 0)
table(count)


### Number of interruptions
parole <- df[df$orateurs_interruption == "INTERRUPTION_1_10" & 
           df$orateurs_qualite != "President assemblee",]

nrow(parole)



### Gender - who interrupts

table(df[df$orateurs_qualite != "President assemblee",]$orateurs_interruption, 
      df[df$orateurs_qualite != "President assemblee",]$gender)[1,] %>%
  prop.table() %>% round(2)

table(df[df$orateurs_qualite != "President assemblee" &  
           shift(df$orateurs_id, n = 2) != df$orateurs_id,]$orateurs_interruption, 
      df[df$orateurs_qualite != "President assemblee" & 
           shift(df$orateurs_id, n = 2) != df$orateurs_id,]$gender)[2,] %>%
  prop.table() %>% round(2)

### Gender by party

library(ggplot2)
df[df$orateurs_qualite != "President assemblee",] %>%
  ggplot( aes(x=party, fill=gender)) +
  geom_histogram( color="#e9ecef") +
  #scale_fill_manual(values=c("#69b3a2", "#404080")) +
  theme_ipsum() +
  labs(fill="")


df[df$orateurs_qualite != "President assemblee" &
     df$orateurs_interruption == "INTERRUPTION_1_10",] %>%  
  group_by(party, gender) %>%  
  summarize(orateurs_interruption = n()) %>% 
  ggplot(aes(x=party, y=orateurs_interruption, fill=gender)) + 
  geom_bar(stat='identity', position= "dodge")  +
  xlab("Party") + ylab("Count of interruptions")

df[df$orateurs_qualite != "President assemblee" &
     df$orateurs_interruption == "PAROLE_GENERIQUE",] %>%  
  group_by(party, gender) %>%  
  summarize(orateurs_interruption = n()) %>% 
  ggplot(aes(x=party, y=orateurs_interruption, fill=gender)) + 
  geom_bar(stat='identity', position= "dodge") +
  xlab("Party") + ylab("Count of generic discourse")

#### Who is interrupted ?

table(df[df$orateurs_qualite != "President assemblee",]$orateurs_interruption, 
      df[df$orateurs_qualite != "President assemblee",]$gender)[1,] %>%
  prop.table() %>% round(2)


df[df$orateurs_qualite != "President assemblee" &
     df$orateurs_interruption == "PAROLE_GENERIQUE" & 
     shift(df$orateurs_id, n=2 ) != df$orateurs_id,] %>%  
  group_by(party, gender) %>%  
  summarize(orateurs_interruption = n()) %>% 
  ggplot(aes(x=party, y=orateurs_interruption, fill=gender)) + 
  geom_bar(stat='identity', position= "dodge") +
  xlab("Party") + ylab("Count of generic discourse")



### Who interrupts who?

table(df[df$orateurs_interruption == "INTERRUPTION_1_10" & 
           df$orateurs_qualite != "President assemblee", ]$gender,
      shift(df[df$orateurs_interruption == "INTERRUPTION_1_10" & 
                 df$orateurs_qualite != "President assemblee", ]$gender) )


 # Women interrupting
table(df[df$orateurs_interruption == "INTERRUPTION_1_10" & 
           df$orateurs_qualite != "President assemblee", ]$gender,
  shift(df[df$orateurs_interruption == "INTERRUPTION_1_10" & 
             df$orateurs_qualite != "President assemblee", ]$gender) )[1,] %>% 
  prop.table() %>% round(2)

  #Men interrupting
table(df[df$orateurs_interruption == "INTERRUPTION_1_10" & 
           df$orateurs_qualite != "President assemblee", ]$gender,
      shift(df[df$orateurs_interruption == "INTERRUPTION_1_10" & 
                 df$orateurs_qualite != "President assemblee", ]$gender) )[2,] %>% 
  prop.table() %>% round(2)


####  # Time

df[df$orateurs_interruption == "INTERRUPTION_1_10" & 
     df$orateurs_qualite != "President assemblee" & shift(df$gender) == "M", ]$time_diff %>% na.omit() %>%
  mean()

df[df$orateurs_interruption == "INTERRUPTION_1_10" & 
     df$orateurs_qualite != "President assemblee" & shift(df$gender) == "F", ]$time_diff %>% na.omit() %>%
  mean()
  #1 second difference between men and women interruptions


df[df$orateurs_interruption == "INTERRUPTION_1_10" & 
     df$orateurs_qualite != "President assemblee" & shift(df$gender) == "M", ]$time_diff %>% na.omit() %>%
  mean()

df[df$orateurs_interruption == "PAROLE_GENERIQUE" & 
     df$orateurs_qualite != "President assemblee" & 
     shift(df$gender) == "F", ]$time_diff %>% na.omit() %>%
  mean()

df[df$orateurs_interruption == "PAROLE_GENERIQUE" & 
     df$orateurs_qualite != "President assemblee" & 
     shift(df$gender) == "M", ]$time_diff %>% na.omit() %>%
  mean()

shift()
#1 second difference between men and women interruptions


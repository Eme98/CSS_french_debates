###############################
########## FILE 2 #############
###############################

################
## In this file, we work with the text (texte)




### We want to extract the reactions inside the text. They provide information on which
# party reacts and how (exclamations or approbations).


library(data.table)
library(stringr)

# Get the parenthesis and what is inside

df$exclamations <- str_extract_all(df$orateurs_texte, "\\([^()]+\\)")
df$exclamations <- str_to_lower(df$exclamations)

#### In the XML files, there are two types of interruptions
# either spoken interruptions, which is what I chose to work with
# or crowd movments in italic inside an intervention -> I have to remove them
# or it will hinder the text analysis

##### I discard any text in parenthesis (which refer to crowd movment)
### I have to repeat this many times because otherwise it removes only the first comment
df$orateurs_texte_without <- str_replace(df$orateurs_texte, " \\s*\\([^\\)]+\\)", "")
df$orateurs_texte_without <- str_replace(df$orateurs_texte_without, " \\s*\\([^\\)]+\\)", "")
df$orateurs_texte_without <- str_replace(df$orateurs_texte_without, " \\s*\\([^\\)]+\\)", "")
df$orateurs_texte_without <- str_replace(df$orateurs_texte_without, " \\s*\\([^\\)]+\\)", "")
df$orateurs_texte_without <- str_replace(df$orateurs_texte_without, " \\s*\\([^\\)]+\\)", "")
df$orateurs_texte_without <- str_replace(df$orateurs_texte_without, " \\s*\\([^\\)]+\\)", "")
df$orateurs_texte_without <- str_replace(df$orateurs_texte_without, " \\s*\\([^\\)]+\\)", "")
df$orateurs_texte_without <- str_replace(df$orateurs_texte_without, " \\s*\\([^\\)]+\\)", "")
df$orateurs_texte_without <- str_replace(df$orateurs_texte_without, " \\s*\\([^\\)]+\\)", "")


##### Time difference between two speakers
df$orateurs_time <- as.numeric(df$orateurs_time)
df$orateurs_time %>% head() #check

df$time_diff = as.numeric(df$orateurs_time - shift(df$orateurs_time))
df$time_diff <- ifelse(df$time_diff < 0, NA, df$time_diff)


### Status of the president of the Assembly 
# We have to know who he/she is to further remove it
df$orateurs_qualite <- 
  ifelse(df$orateurs_nom == "Mme la présidente" | df$orateurs_nom ==  "M. le président",
         "President assemblee", df$orateurs_qualite)


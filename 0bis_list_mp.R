getwd()

## We need the party of each of the MPs
## We have access to the list of every MPs, their id and their party


library(dplyr)

list_mp <- read.csv("~/LMU/CSS/Projet/tout_assemblee/xml/Try/liste_id_parlementaires.txt", sep=";")
colnames(list_mp)
list_mp <- select(list_mp,
                  identifiant, Prenom, Nom, Groupe.politique..abrege.
                                  )

list_mp <- list_mp %>%
  rename(orateurs_id = identifiant,
         prenom = Prenom,
         nom = Nom,
         party = Groupe.politique..abrege.)
colnames(list_mp)

str(list_mp)
list_mp$orateurs_id <- as.character(list_mp$orateurs_id)

df <- left_join(df, list_mp, by = "orateurs_id")    
df <- subset(df, select = -c(prenom, nom))

rm(list_mp)

#### GENDER


### We extract the gender of each MP
### The name provides information :
## it can either be : "M. Surname Name" or "Un député" for a male MP
## it can be : "Mme Surname Name" or "Une députée" for a female MP
## sometimes a group of MPs speak -> genderless, NA


df$gender <- ifelse(str_extract(df$orateurs_nom, "M. |Un ") == "M. " |
                      str_extract(df$orateurs_nom, "M. |Un ") == "Un ", 
                    "M", 0)

df$gender <- ifelse(is.na(df$gender) == FALSE, df$gender,
                    ifelse(str_extract(df$orateurs_nom, "Mme |Une ") == "Mme " |
                             str_extract(df$orateurs_nom, "Mme |Une ") == "Une ", 
                           "F", NA))

df$gender %>% head()

### Party group
# Sometimes a MP speak, but we do not know who she/he is, but we can know her/his party
# We retrieve information after "du groupe"
df$party <- ifelse(is.na(df$party) == T, str_match(df$orateurs_nom, "(?<=du groupe ).*"),
       df$party)
df$party %>% head()

df$party <- ifelse(df$party == "Écolo-NUPES" | df$party == "Écolo - NUPES" | 
                     df$party == "Ecolo - NUPES", 
                   "Ecolo",
                   df$party)
df$party <- ifelse(df$party == "GDR-NUPES" |  df$party == "GDR - NUPES", 
                   "GDR",
                   df$party)
df$party <- ifelse(df$party == "LFI-NUPES" | df$party == "LFI – NUPES" | 
                     df$party == "LFI - NUPES", "LFI",
                   df$party)



#### Remove all objects except df

rm(list=setdiff(ls(), "df"))

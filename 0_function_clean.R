library(xml2)
library(tidyverse)

getwd()
setwd("C:/Users/emeli/Documents/LMU/CSS/Projet/tout_assemblee/xml/Try")


### We have at hands a list of files with all debates in the French Parliament
#during summer 2022.

####### FIRST STEP : construct a basic df with important info


### Check all files in file
list.files(pattern=".xml$") #

# create a list from these files
list.filenames<-list.files(pattern=".xml$")

###################################
####### function : to build a first df ###
df_list <- lapply(list.filenames, function(f){
  xml_raw <- read_xml(f)
  
  # Find the xml namespace prefix
  xml_ns(xml_raw)
  # Strip the namespace to work with the file
  xml_ns_strip(xml_raw)
  
  
  ### We remove all unusable info at the beginning of each file
  # They prevent us to work with the file
  remove_me <- xml_find_all(xml_raw, "//uid")
  xml_remove(remove_me)
  remove_me <- xml_find_all(xml_raw, "//seanceRef")
  xml_remove(remove_me)
  remove_me <- xml_find_all(xml_raw, "//sessionRef")
  xml_remove(remove_me)
  
  # Info about the date and the number of the debate (there can be multiple debate per day)
  date_seance <- xml_find_first(xml_raw, "//metadonnees//dateSeanceJour") %>% xml_text()
  date_seance
  num_seance <- xml_find_first(xml_raw, "//metadonnees//numSeanceJour") %>% xml_text()
  num_seance
  # Info about the theme of the session
  theme <- xml_find_first(xml_raw, ".//intitule") %>% xml_text()
  remove_me = xml_find_all(xml_raw, "metadonnees")
  xml_remove(remove_me)
  
  
  ### We extract nodes which refer to the person talking or to an interruption
  #find all str nodes
  nodes<-xml_find_all(xml_raw, ".//paragraphe")
  
  ## We retrieve only sentences an orator speaks or is interrupted
  ## We leave out every generic sentences such as "The assembly opens"
  nodes<-nodes[xml_attr(nodes, "code_grammaire")=="PAROLE_GENERIQUE" |
                 xml_attr(nodes, "code_grammaire")=="INTERRUPTION_1_10"]
  
  #Info about the name, the id, the quality of the orator, the text and the duration of the talk
  
  orateurs_nom <- xml_text( xml_find_all( nodes, ".//nom" ) ) #name
  orateurs_id <- xml_text( xml_find_all( nodes, ".//id" ) ) #id
  orateurs_qualite <- xml_text( xml_find_all( nodes, ".//qualite" ) ) #status
  orateurs_texte <- xml_text( xml_find_all( nodes, ".//texte" ) ) #text
  orateurs_italic <- nodes %>% xml_find_first( ".//italique") %>% xml_text() #movments of the crowd
  orateurs_time <- xml_find_all(nodes, ".//texte") %>% xml_attr("stime") #duration of the intervention
  # We know if it is an interruption of not with the "code grammaire"
  orateurs_interruption = xml_attr(nodes, "code_grammaire") #interruption or intervention
  
  # Create a df
  
  out <- data.frame(date_seance, num_seance, theme,
                           orateurs_nom, orateurs_id, orateurs_qualite, orateurs_texte,
                           orateurs_italic, orateurs_interruption,
                           orateurs_time)
  
  
})

#Bind avery df from every debate
df <- do.call(rbind, df_list)

## Check
table(df$date_seance)



# CSS_french_debates
This work is a project for a CSS lecture. The aim is to assess whether women are more interrupted than men in the French Parliament


The XML files come from the website https://data.assemblee-nationale.fr/travaux-parlementaires/debats . 
I chose to only work with the 33 debates of the summer 2022. 

The list of MPs comes from the website https://data.assemblee-nationale.fr/acteurs/deputes-en-exercice 
(file FICHIER CSV - LISTE DES DÉPUTÉS EN FORMAT EXCEL).


Note : I modified the files CRSANR5L16S2022E1N015 and CRSANR5L16S2022E1N007.
File CRSANR5L16S2022E1N015 : The lines 11472 to 11475 were removed : I removed the id 719080, which was already indicated 5 lines above. The programm could not work if an id for the same allocation is repeated twice.
File CRSANR5L16S2022E1N007 : The lines 1103 to 1107 were removed : The id 795990 appeared twice (same error as above).
These two files have now the names CRSANR5L16S2022E1N015_mod and CRSANR5L16S2022E1N007_mod


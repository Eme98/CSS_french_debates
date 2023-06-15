# Computational Social Science Project : Let me Speak! Interruption in the French Parliament

## The Project

This work is a project for a Computational Social Science lecture at the LMU. The Professor in charge of the course is [Christoph Kern (LMU)](https://www.soda.statistik.uni-muenchen.de/people/professors/kern/index.html).

The aim of the project is to assess (a) whether women are more interrupted than men during a debate at the Assemblée Nationale in France and (b) which words are used to interrupt them.

To this end, the 31 debates of the summer 2022 at the Assemblée Nationale are used. Wordclouds and Feature of Co-occurence matrices are used to compare which words are used when interrupting a man or a women.

Results :  Women are significantly less interrupted than men at the Assemblée Nationale. The interruptions are a bit shorter when addressed to a woman. Nonetheless, it seems that there are differences in how women and men interrupt. Women interrupt significantly less and with shorter sentences in average, but likely with more constructed arguments rather than only emotional sentences. This is interesting, because it means that women integrated gender stereotypes that they are more emotional than men and fight against them.


## How men adress women at the Assemblée Nationale

In this section, I present the results of how men adress women at the Assemblée Nationale during a debate. 
In the PDF file are further presented how men interrupt men and how women interrupt both genders. 

Men interrupt more often than women, even accounting for the fact that 63% of MPs are men. Interestingly, women MPs of the Party La France Insoumise (LFI) interrupt more often than other women MPs.
![interruption_party_gender](https://github.com/Eme98/CSS_french_debates/assets/68661774/afe5cc1e-39f5-4ade-89ca-0fee0eb0bedb)

Here is a wordcloud of the most used words men use to interrupt women. A common address for women is to call her ”Madame” (madam) which is more courteous than just to shout. Men do not adress their male counterparts in this manner (no presence of ”monsieur”). Another noticeable difference is the fact that men seem to prefer short sentences to women which mark quicker their opinion and use shorter sentences. 

![wd_int_m_w](https://github.com/Eme98/CSS_french_debates/assets/68661774/69bd62d0-4fa9-4783-b3ef-421501f43ce8)

This feature co-occurence matrice presents that men use shorter words and more emotional than women. They refer often to the President of the Assembly.

![foo_int_m_w](https://github.com/Eme98/CSS_french_debates/assets/68661774/5e03884b-fea4-4da3-8fb3-5bbec92caa3a)

-----


## Description of the files in the GitHub repository

| File    | Description |
| ------- | ------- |
| 0_function_clean.R | used to form the dataset |
| 1_work_txt.R | used to clean the text |
| 2_list_mp.R | used to have the party of each speaker|
| 3_stats_des.R | stats_des and plots|
| 4_wordcloud_fcm.R | Plots -  Wordclouds and Network of feature co-occurence | 
| Let_me_speak | PDF file of the article |
| stats_des_time.R  | *Descriptive statistics stating that the time variable cannot be used* |

You are invited to read the R files in the order from 0 to 4.

**In the branch can be found: 
The XML files and a list of MPs**

To run the programm, you need to load the XML files into a repository on your computer and run the R file :)
Have fun!



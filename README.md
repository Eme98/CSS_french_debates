# Computational Social Science Project : Let me Speak! Interruption in the French Parliament

## The Project

This work is a project for a Computational Social Science lecture at the LMU. The Professor in charge of the course is Christoph Kern (LMU) <https://www.soda.statistik.uni-muenchen.de/people/professors/kern/index.html>.

The aim of the project is to assess (a) whether women are more interrupted than men during a debate at the Assemblée Nationale in France and (b) which words are used to interrupt them.

To this end, the 31 debates of the summer 2022 at the Assemblée Nationale are used. Wordclouds and Feature of Co-occurence matrices are used to compare which words are used when interrupting a man or a women.

Results :  Women are significantly less interrupted than men at the Assemblée Nationale. The interruptions are a bit shorter when addressed to a woman. Nonetheless, it seems that there are differences in how women and men interrupt. Women interrupt significantly less and with shorter sentences in average, but likely with more constructed arguments rather than only emotional sentences. This is interesting, because it means that women integrated gender stereotypes that they are more emotional than men and fight against them.



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



####### INTERRUPTION TIME #######

### Here can be found some basics descriptive statistics about the time of interruption and generic discourse
### However, it seems that reported time is not a good indicator. The mean time of an interruption is quite high
# and not significantly different from a generic discourse. This should not be the case since
# interruptions sentences are really short.
# This could mean that after an interruption there is movement in the crowd or the speaker is silent
# I hence decided not to concern myself with the measure of time.

## This could be an improvement for a further work : to construct a measure of time based on the length of the sentence
# and keep out outliers.


df$orateurs_time <- as.numeric(df$orateurs_time)
df$orateurs_time %>% head()

df$time_diff = as.numeric(df$orateurs_time - shift(df$orateurs_time))
df$time_diff <- ifelse(df$time_diff < 0, NA, df$time_diff)

mean(df$time_diff)
df[df$orateurs_interruption == "INTERRUPTION_1_10" & is.na(df$time_diff) == F,]$time_diff %>% mean()
df[df$orateurs_interruption == "PAROLE_GENERIQUE" & is.na(df$time_diff) == F,]$time_diff %>% mean()

df %>% group_by(theme) %>% count(orateurs_interruption) %>% print(n = 32)

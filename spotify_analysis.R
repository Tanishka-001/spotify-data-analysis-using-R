# Install and load libraries

install.packages("tidyverse")
install.packages("janitor")

library(tidyverse)
library(janitor)

# Create plots directory

if (!dir.exists("plots")) {
  dir.create("plots")
}

# Load Spotify dataset
spotify <- read_csv("spotify-data-analysis.csv") %>%
  clean_names()

head(spotify)



# Inspect dataset
glimpse(spotify)
dim(spotify)
summary(spotify)




# Data cleaning and feature engineering

spotify_clean <- spotify %>%
  select(-x1) %>%                      # Remove unnecessary index column
  filter(!is.na(track_name)) %>%       # Remove rows with missing track names
  mutate(
    duration_min = duration_ms / 60000 # Convert duration from ms to minutes
  )

glimpse(spotify_clean)



# Top 10 Spotify genres by number of tracks
# NOTE:
# The dataset is balanced by genre (~1000 tracks per genre),
# so a frequency-based genre plot is not informative.
# Hence, this analysis was replaced by average popularity by genre.
# spotify_clean %>%
#   count(track_genre, sort = TRUE) %>%
#   slice_head(n = 10) %>%
#   ggplot(aes(reorder(track_genre, n), n, fill = track_genre)) +
#   geom_col(show.legend = FALSE) +
#   coord_flip() +
#   labs(
#     title = "Top 10 Spotify Genres",
#     x = "Genre",
#     y = "Number of Tracks"
#   ) +
#   theme_minimal()


# Top 10 genres by average popularity

spotify_clean %>%
  group_by(track_genre) %>%
  summarise(avg_popularity = mean(popularity, na.rm = TRUE)) %>%
  arrange(desc(avg_popularity)) %>%
  slice_head(n = 10) %>%
  ggplot(aes(reorder(track_genre, avg_popularity), avg_popularity, fill = track_genre)) +
  geom_col(show.legend = FALSE) +
  coord_flip() +
  labs(
    title = "Top 10 Genres by Average Popularity",
    x = "Genre",
    y = "Average Popularity"
  ) +
  theme_minimal()
ggsave("plots/top_genres_avg_popularity.png", width = 8, height = 6, dpi = 300)



# Popularity vs Danceability

#ggplot(spotify_clean, aes(x = danceability, y = popularity)) +
 # geom_point(alpha = 0.3) +
 # geom_smooth(method = "lm", se = FALSE) +
  #labs(
  ## x = "Danceability",
   # y = "Popularity"
 # ) +
  #theme_minimal()

ggplot(spotify_clean, aes(
  x = danceability,
  y = popularity,
  color = popularity
)) +
  geom_point(alpha = 0.3, size = 0.8) +
  geom_smooth(
    method = "lm",
    se = FALSE,
    color = "red",
    linewidth = 1.2
  ) +
  scale_color_viridis_c(option = "plasma") +
  labs(
    title = "Danceability vs Popularity",
    subtitle = "Color indicates popularity level",
    x = "Danceability",
    y = "Popularity",
    color = "Popularity"
  ) +
  theme_minimal()

ggsave("plots/danceability_vs_popularity.png", width = 8, height = 6, dpi = 300)



# Energy vs Popularity

ggplot(spotify_clean, aes(
  x = energy,
  y = popularity,
  color = popularity
)) +
  geom_point(alpha = 0.3, size = 0.8) +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  scale_color_viridis_c(option = "plasma") +
  labs(
    title = "Energy vs Popularity",
    subtitle = "Higher-energy tracks tend to be more popular",
    x = "Energy",
    y = "Popularity",
    color = "Popularity"
  ) +
  theme_minimal()
ggsave("plots/energy_vs_popularity.png", width = 8, height = 6, dpi = 300)



#Valency and Popularity

ggplot(spotify_clean, aes(
  x = valence,
  y = popularity,
  color = popularity
)) +
  geom_point(alpha = 0.3, size = 0.8) +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  scale_color_viridis_c(option = "inferno") +
  labs(
    title = "Valence vs Popularity",
    subtitle = "Happier tracks show a weak positive popularity trend",
    x = "Valence (Musical Positivity)",
    y = "Popularity",
    color = "Popularity"
  ) +
  theme_minimal()
ggsave("plots/valence_vs_popularity.png", width = 8, height = 6, dpi = 300)



# Select numeric audio features
audio_features <- spotify_clean %>%
  select(
    popularity,
    danceability,
    energy,
    valence,
    tempo,
    loudness,
    acousticness
  )

# Correlation matrix
cor_matrix <- cor(audio_features, use = "complete.obs")

# View correlation table
round(cor_matrix, 2)




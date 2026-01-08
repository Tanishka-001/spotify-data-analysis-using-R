# Spotify Data Analysis Using R 

## Executive Summary
This project explores how Spotify audio features relate to track popularity using exploratory data analysis (EDA). Using nearly 114,000 tracks across 125 genres, the analysis investigates whether musical characteristics such as danceability, energy, and valence meaningfully influence popularity. Results show that popularity is only weakly correlated with audio features, suggesting external factors play a larger role.

---

## Objective
- Analyze relationships between Spotify audio features and popularity  
- Compare genre-level popularity using aggregate statistics  
- Identify correlations among core audio attributes  

This project is intended as an **academic data analysis exercise** using R.

---

## Dataset

This project uses the **Spotify Tracks Dataset** sourced from Kaggle.  
It contains ~114,000 songs with audio features (popularity, danceability, energy, valence, etc.) and genre information.  
Source: https://www.kaggle.com/datasets/maharshipandya/-spotify-tracks-dataset

---

### Key Variables

- `popularity` (0–100) — track popularity, 100 = most popular  
- `danceability` (0.0–0.985) — how suitable a track is for dancing (0 = least, 1 = most)  
- `energy` (0.0–1.0) — intensity/activity of track (0 = calm, 1 = energetic)  
- `valence` (0.0–0.995) — musical positiveness (0 = sad/negative, 1 = happy/positive)  
- `tempo` (0.0–243.37 BPM) — speed of track in beats per minute  
- `loudness` (-49.53–4.53 dB) — overall loudness of track in decibels  
- `acousticness` (0.0–0.996) — confidence track is acoustic (1 = highly acoustic)  
- `track_genre` (125 unique values) — categorical variable describing genre (e.g., pop, rock, acoustic, jazz)  

---

## Methodology

### Data Preparation
- Removed redundant index column
- Cleaned column names with `janitor`
- Filtered missing track names
- Engineered `duration_min` from milliseconds

### Exploratory Analysis
- Average popularity by genre (dataset is genre-balanced)
- Scatter plots with linear trend lines:
  - Danceability vs Popularity
  - Energy vs Popularity
  - Valence vs Popularity
- Correlation matrix of numeric audio features

---

## Visualizations

### 1. Top 10 Genres by Average Popularity

![image alt](https://github.com/Tanishka-001/spotify-data-analysis-using-R/blob/283498b83d76683aec1b5312a2c00a68cffcac51/top_genres_avg_popularity.png)


### 2. Danceability vs Popularity

![image alt](https://github.com/Tanishka-001/spotify-data-analysis-using-R/blob/283498b83d76683aec1b5312a2c00a68cffcac51/danceability_vs_popularity.png)


### 3. Energy vs Popularity

![image alt](https://github.com/Tanishka-001/spotify-data-analysis-using-R/blob/283498b83d76683aec1b5312a2c00a68cffcac51/energy_vs_popularity.png)


### 4. Valence vs Popularity

![image alt](https://github.com/Tanishka-001/spotify-data-analysis-using-R/blob/283498b83d76683aec1b5312a2c00a68cffcac51/valence_vs_popularity.png)


---

## Key Findings

- Popularity has **very weak correlation** with individual audio features
- Energy and loudness show strong positive correlation (0.76)
- Acoustic tracks tend to be low-energy (−0.73 correlation)
- Musical “happiness” (valence) does not strongly influence popularity

### Selected Correlations
| Feature Pair | Correlation |
|-------------|------------|
| Energy ↔ Loudness | 0.76 |
| Energy ↔ Acousticness | -0.73 |
| Popularity ↔ Danceability | 0.04 |
| Popularity ↔ Valence | -0.04 |

---

## Interpretation
Audio characteristics alone do not explain why songs become popular. 
Popularity is likely driven by factors outside the dataset such as marketing, artist reputation, playlist exposure, and social trends. 
Audio features are better suited for recommendation and similarity systems rather than popularity prediction.

---

## Tools & Libraries
- R
- tidyverse
- janitor
- ggplot2

---

## Limitations
- Popularity influenced by external, non-audio factors
- Linear trends may oversimplify listener behavior
- No predictive modeling performed

---

## Future Work
- Genre-specific modeling
- Regression or machine learning approaches
- Integration with playlist or streaming metadata

---

## License
This project is licensed under the MIT License.


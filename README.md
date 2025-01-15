# TBEV on wings 

This project is used to link bird migration data to the locations were tickborne-encephalitis (TBEV) was found. 

## Packages

This project uses R version 4.4.2 (2024-10-31)
Platform: x86_64-pc-linux-gnu
Running under: Ubuntu 24.04.1 LTS

- cli          [* -> 3.6.3]
- dplyr        [* -> 1.1.4]
- fansi        [* -> 1.0.6]
- generics     [* -> 0.1.3]
- glue         [* -> 1.8.0]
- lifecycle    [* -> 1.0.4]
- magrittr     [* -> 2.0.3]
- pillar       [* -> 1.9.0]
- pkgconfig    [* -> 2.0.3]
- R6           [* -> 2.5.1]
- renv         [* -> 1.0.11]
- rlang        [* -> 1.1.4]
- tibble       [* -> 3.2.1]
- tidyselect   [* -> 1.2.1]
- utf8         [* -> 1.2.4]
- vctrs        [* -> 0.6.5]
- withr        [* -> 3.0.2] 

## Example

### Point data (TBEV)
points_df <- tibble(
  id = 1:3,
  lon = c(0, 1, 2),
  lat = c(0, 1, 2)
)

### Convert point data to an sf object
points_sf <- points_df %>%
  st_as_sf(coords = c("lon", "lat"), crs = 4326)

### Line data (bird data)
line_df <- tibble(
  id = 1,
  geometry = st_sfc(st_linestring(matrix(c(0, 0, 3, 3), ncol = 2, byrow = TRUE)))
)

### Convert line data to an sf object
line_sf <- st_as_sf(line_df, crs = 4326)

### Calculate distances between points and the line
distances <- st_distance(points_sf, line_sf)

### Visualize 
print(ggplot() + 
  geom_sf(points_sf, mapping = aes(geometry = geometry)) + 
  geom_sf(line_sf, mapping = aes(geometry = geometry)))

```
## Structure project
.
├── .gitignore
├── CITATION.cff
├── LICENSE
├── README.md
├── requirements.txt
├── data               <- All project data, ignored by git
│   ├── processed      <- The final, canonical data sets for modeling. (PG)
│   ├── raw            <- The original, immutable data dump. (RO)
│   └── temp           <- Intermediate data that has been transformed. (PG)
├── docs               <- Documentation notebook for users (HW)
│   ├── manuscript     <- Manuscript source, e.g., LaTeX, Markdown, etc. (HW)
│   └── reports        <- Other project reports and notebooks (e.g. Jupyter, .Rmd) (HW)
├── results
│   ├── figures        <- Figures for the manuscript or reports (PG)
│   └── output         <- Other output for the manuscript or reports (PG)
└── R                  <- Source code for this project (HW)

```

## Add a citation file
Create a citation file for your repository using [cffinit](https://citation-file-format.github.io/cff-initializer-javascript/#/)

## License

This project is licensed under the terms of the [MIT License](/LICENSE).

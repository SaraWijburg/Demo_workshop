# TBEV on wings 

This project is used to link bird migration data to the locations were tickborne-encephalitis (TBEV) was found. 

## Packages

You need the following packages: 
"raster", "terra", "ncdf4", "stars", "RPostgreSQL", "mapview",
  "data.table", "tidytable", "tidyverse", "dplyr", "readxl",
  "writexl", "httr", "jsonlite",
  "cowplot", "RColorBrewer", "broom", "dbplyr", "moments",
  "XML", "methods", "foreign",
  "lubridate", "janitor", "ggpubr", "corrplot", "Hmisc",
  "PerformanceAnalytics", "docstring",
  "classInt", "sf", "stringi", "data.table",
  "boot", "viridis", "rtrim", "ggspatial", "lintr", "styler"

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
ggplot() + 
  geom_sf(points_sf, mapping = aes(geometry = geometry)) + 
  geom_sf(line_sf, mapping = aes(geometry = geometry))

```
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

# TBEV on wings 

This project is used to link bird migration data to the locations were tickborne-encephalitis (TBEV) was found. 

## Packages

This project uses R version 4.4.2 (2024-10-31)
Platform: x86_64-pc-linux-gnu
Running under: Ubuntu 24.04.1 LTS

Matrix products: default
BLAS:   /usr/lib/x86_64-linux-gnu/openblas-pthread/libblas.so.3 
LAPACK: /usr/lib/x86_64-linux-gnu/openblas-pthread/libopenblasp-r0.3.26.so;  LAPACK version 3.12.0

locale:
 [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8     LC_MONETARY=en_US.UTF-8   
 [6] LC_MESSAGES=en_US.UTF-8    LC_PAPER=en_US.UTF-8       LC_NAME=C                  LC_ADDRESS=C               LC_TELEPHONE=C            
[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       

time zone: Etc/UTC
tzcode source: system (glibc)

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
 [1] TempPackage_1.0            styler_1.10.3              lintr_3.1.2                ggspatial_1.1.9            rtrim_2.1.1               
 [6] viridis_0.6.5              viridisLite_0.4.2          boot_1.3-31                stringi_1.8.4              classInt_0.4-10           
[11] docstring_1.0.0            PerformanceAnalytics_2.0.4 xts_0.14.1                 zoo_1.8-12                 Hmisc_5.1-1               
[16] corrplot_0.92              ggpubr_0.6.0               janitor_2.2.0              foreign_0.8-87             XML_3.99-0.17             
[21] moments_0.14.1             dbplyr_2.5.0               broom_1.0.7                RColorBrewer_1.1-3         cowplot_1.1.3             
[26] jsonlite_1.8.9             httr_1.4.7                 writexl_1.5.0              readxl_1.4.3               lubridate_1.9.4           
[31] forcats_1.0.0              stringr_1.5.1              dplyr_1.1.4                purrr_1.0.2                readr_2.1.5               
[36] tidyr_1.3.1                tibble_3.2.1               ggplot2_3.5.1              tidyverse_2.0.0            tidytable_0.11.0          
[41] data.table_1.16.4          mapview_2.11.2             RPostgreSQL_0.7-6          DBI_1.2.2                  stars_0.6-7               
[46] sf_1.0-19                  abind_1.4-8                ncdf4_1.23                 terra_1.8-5                raster_3.6-30             
[51] sp_2.1-4                   reticulate_1.40.0         

loaded via a namespace (and not attached):
 [1] wk_0.9.4           rstudioapi_0.17.1  magrittr_2.0.3     farver_2.1.2       rmarkdown_2.29     vctrs_0.6.5        base64enc_0.1-3    rstatix_0.7.2     
 [9] htmltools_0.5.8.1  s2_1.1.7           cellranger_1.1.0   Formula_1.2-5      KernSmooth_2.23-24 desc_1.4.3         htmlwidgets_1.6.4  lifecycle_1.0.4   
[17] pkgconfig_2.0.3    Matrix_1.7-1       R6_2.5.1           fastmap_1.2.0      snakecase_0.11.1   digest_0.6.37      colorspace_2.1-1   ps_1.8.1          
[25] rprojroot_2.0.4    leafem_0.2.3       pkgload_1.4.0      crosstalk_1.2.1    fansi_1.0.6        timechange_0.3.0   compiler_4.4.2     remotes_2.5.0     
[33] proxy_0.4-27       withr_3.0.2        htmlTable_2.4.2    backports_1.5.0    carData_3.0-5      pkgbuild_1.4.5     R.utils_2.12.3     ggsignif_0.6.4    
[41] leaflet_2.2.2      tools_4.4.2        units_0.8-5        nnet_7.3-19        R.oo_1.26.0        glue_1.8.0         satellite_1.0.5    quadprog_1.5-8    
[49] callr_3.7.6        R.cache_0.16.0     grid_4.4.2         checkmate_2.3.1    cluster_2.1.6      generics_0.1.3     gtable_0.3.6       tzdb_0.4.0        
[57] R.methodsS3_1.8.2  class_7.3-22       hms_1.1.3          xml2_1.3.6         car_3.1-2          utf8_1.2.4         pillar_1.9.0       lattice_0.22-6    
[65] tidyselect_1.2.1   knitr_1.49         gridExtra_2.3      stats4_4.4.2       xfun_0.49          rex_1.2.1          lazyeval_0.2.2     evaluate_1.0.1    
[73] codetools_0.2-20   cli_3.6.3          rpart_4.1.23       munsell_0.5.1      processx_3.8.4     roxygen2_7.3.2     Rcpp_1.0.13-1      png_0.1-8         
[81] parallel_4.4.2     cyclocomp_1.1.1    scales_1.3.0       e1071_1.7-16       crayon_1.5.3       rlang_1.1.4     

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

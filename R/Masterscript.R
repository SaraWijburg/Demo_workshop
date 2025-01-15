############################################################################################################
#----------------------------------------------------------------------------------------------------------#
# Masterscript TBEV
#----------------------------------------------------------------------------------------------------------#
############################################################################################################
# renv::snapshot()
# renv::restore()

# Welke packages worden gebruikt in dit script?
gebruikte_packages <- c(
  "raster", "terra", "ncdf4", "stars", "RPostgreSQL", "mapview",
  "data.table", "tidytable", "tidyverse", "dplyr", "readxl",
  "writexl", "httr", "jsonlite",
  "cowplot", "RColorBrewer", "broom", "dbplyr", "moments",
  "XML", "methods", "foreign", "renv",
  "lubridate", "janitor", "ggpubr", "corrplot", "Hmisc",
  "PerformanceAnalytics", "docstring", #https://rdrr.io/cran/docstring/src/R/docstring.R
  "classInt", "sf", "stringi", "data.table",
  "boot", "viridis", "rtrim", "ggspatial", "lintr", "styler" # lintr package gaat door je code heen om te kijken of het volgens de style correct is, styler maakt het clean
)

# Welke packages zijn al geinstallerd?
geinstalleerde_packages <- rownames(installed.packages())

# Te installeren packages
installeren_packages <- gebruikte_packages[!gebruikte_packages %in% geinstalleerde_packages]
if (length(installeren_packages) > 0) install.packages(pkgs = installeren_packages)

# Laad packages
if (!all(gebruikte_packages %in% .packages())) {
  suppressMessages(invisible(lapply(
    X              = gebruikte_packages,
    FUN            = library,
    character.only = TRUE
  )))
}


options(scipen = 999) # Remove scientific notation
select <- dplyr::select
 
# lintr::lint("R/Masterscript.R")
# styler:::style_active_file()
# source(file = "R/Script_renv.R")

#----------------------------------------------------------------------------------------------------------#
# Functions
#----------------------------------------------------------------------------------------------------------#
source(file = "R/Functions.R")

#----------------------------------------------------------------------------------------------------------#
# Simulate data
#----------------------------------------------------------------------------------------------------------#
source(file = "R/Simulate_data.R")

#----------------------------------------------------------------------------------------------------------#
# Analyses
#----------------------------------------------------------------------------------------------------------#
source(file = "R/Calculate_distance_point_to_line.R")






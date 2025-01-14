############################################################################################################
#----------------------------------------------------------------------------------------------------------#
# Masterscript TBEV
#----------------------------------------------------------------------------------------------------------#
############################################################################################################

# remotes::install_github("r-spatial/mapview")
# Welke packages worden gebruikt in dit script?
gebruikte_packages <- c(
  "raster", "terra", "ncdf4", "stars", "RPostgreSQL", "mapview", 
  "data.table", "tidytable", "tidyverse", "dplyr", "readxl", "writexl", "httr", "jsonlite", 
  "cowplot", "RColorBrewer", "broom", "dbplyr", "moments", "XML", "methods", "foreign", 
  "lubridate", "janitor", "ggpubr", "corrplot", "Hmisc", "PerformanceAnalytics", "classInt", "sf", "stringi", "data.table",
  "boot", "viridis","rtrim", "ggspatial")

# package:exactextractr

# Welke packages zijn al geinstallerd?
geinstalleerde_packages <- rownames(installed.packages())

# Te installeren packages
installeren_packages <- gebruikte_packages[!gebruikte_packages %in% geinstalleerde_packages]
if (length(installeren_packages) > 0) install.packages(pkgs = installeren_packages)

# Laad packages als ze nog niet attached zijn
# zonder messages!
if (!all(gebruikte_packages %in% .packages())) {
  suppressMessages(invisible(lapply(
    X              = gebruikte_packages,
    FUN            = library,
    character.only = TRUE)))
}

options(scipen=999) # Remove scientific notation 
select <- dplyr::select
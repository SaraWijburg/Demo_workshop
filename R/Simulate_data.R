############################################################################################################
#----------------------------------------------------------------------------------------------------------#
# Title: Simulate data 
#----------------------------------------------------------------------------------------------------------#
############################################################################################################

# Data for birds 
data_bird <- tibble(
  Ring = rep(seq(1:40), 2),
  Longitude = c(seq(1:80)),
  Latitude = c(seq(31:110)), 
  Species = rep("Turdus merula", 80),
  Date = c(rep("2023-05-18", 80)),
  Country = c(rep("Netherlands", 20), rep("Germany", 20), rep("France", 20), rep("UK", 20))) %>% 
  mutate(Date = as.Date(Date) + row_number()) 
  
# Data for TBEV 
data_tbev_coord_sf <- tibble(
  tbevID = 1:10,
  longitude = 0:9,
  latitude = c(0, 1, 2, 3.5, 4.6, 5, 6, 7, 9.8, 10),
  collection_date = c(rep("2023-05-18", 10))) %>% 
  mutate(VID = str_c("V", row_number()), 
         collection_date = as.Date(collection_date) + row_number())  %>% 
  st_as_sf(coords = c("longitude", "latitude"), crs = "EPSG:4326", remove = TRUE) %>%
  st_transform(crs = st_crs("+proj=longlat +datum=WGS84"))

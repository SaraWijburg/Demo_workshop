############################################################################################################
#----------------------------------------------------------------------------------------------------------#
# Title: Calculate distances point to line
#----------------------------------------------------------------------------------------------------------#
############################################################################################################
simulate <- FALSE
#----------------------------------------------------------------------------------------------------------#
#-------------- TBEV data 
#----------------------------------------------------------------------------------------------------------#

if(simulate){
  coordinates_tbev_org <- read_xlsx("data/raw/Terschelling_friends.xlsx")
  data_tbev_coord_df   <- coordinates_tbev_org
  
  data_tbev_coord_sf <- data_tbev_coord_df  %>% 
    select(tbevID = label, country, microfocus, collection_date, latitude, longitude) %>% 
    mutate(VID = str_c("V", row_number())) %>% 
    st_as_sf(coords = c("longitude", "latitude"), crs = "EPSG:4326", remove = TRUE) %>%
    # st_as_sf(coords = c("longitude", "latitude"), crs = "EPSG:3035", remove = TRUE) #%>% 
    st_transform(crs = st_crs("+proj=longlat +datum=WGS84"))
  # st_transform(crs = 3035)
}


#----------------------------------------------------------------------------------------------------------#
#-------------- Bird data (black bird)
#----------------------------------------------------------------------------------------------------------#


if(simulate){
  data_bird_org <- readRDS("data/raw/data_Turdus_merula_20241213_1210.RDS")
  data_bird     <- data_bird_org %>% 
    select(Ring, Species = current_name, Latitude, Longitude, Date, Distance, Country)
}

#-------------- Determine trajectories 
bird_lines_sf <- function_determine_trajectory(data = data_bird)

#-------------- Determine distance between points and lines 
tmp_distance_trans <- function_distance_point_lines(bird_lines_sf)

#-------------- Determine combinations 
tmp_distance_trans
  full_join(tmp_distance_trans, by = c("trajectoryID", "Ring"), relationship = "many-to-many") %>% 
  # filter(tbevID.x == "DZIF23_597") %>% 
  filter(tbevID.x != tbevID.y) %>% 
  filter(distance.y <= 50)





# cbind to trajectoryIDs 
# filter <500 km
# determine smallest hit
# determine which lines in which ranges
# determmine which lines match with lines and how many lines 

# ggplot() + 
#   geom_sf(data_tbev_coord_sf %>% 
#             filter(tbevID == "DZIF23_597"), mapping = aes(geometry = geometry, fill = tbevID)) + 
#   geom_sf(bird_lines_sf %>% filter(trajectoryID == 12122), mapping = aes(geometry = geometry))







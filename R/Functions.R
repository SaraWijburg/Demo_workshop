############################################################################################################
#----------------------------------------------------------------------------------------------------------#
# Title: Functions 
#----------------------------------------------------------------------------------------------------------#
############################################################################################################

# Function 1
function_determine_trajectory <- function(data, crs_code = 4326){
  #' @title Determine bird trajectory
  #' @description
    #' Using start and end coordinates determine trajectory of individual birds. In some cases
    #' start coordinates are the same as and coordinates, this means the bird has not traveled
    #' so those birds needs to be excluded. 
  
  #' @description
    #' Step 1. Determine per Ring ID the start and end coordinates of birds
  data_birds_transformed <- data %>% 
    # Turn into wide format 
    arrange(Ring, Date) %>%
    # Determine per ring start and end coordinates
    group_by(Ring) %>%
    mutate(
      start_latitude = Latitude,
      start_longitude = Longitude,
      start_date = Date,
      start_country = Country,
      end_latitude = lead(Latitude),
      end_longitude = lead(Longitude),
      end_date = lead(Date),
      end_country = lead(Country)) %>%
    ungroup %>% 
    filter(!is.na(end_latitude)) %>%
    select(Ring, Species, start_latitude, start_longitude, end_latitude, end_longitude, start_date, end_date, start_country, end_country) %>% 
    # Start coordinate cant be the same as the end coordinate
    filter(start_latitude != end_latitude) 
  
  #' @description
    #' Step 2. Create lines connecting departure and re-encounter points
  bird_lines <- st_sfc(lapply(1:nrow(data_birds_transformed), function(i) {
    st_linestring(matrix(c(data_birds_transformed$start_longitude[i], data_birds_transformed$start_latitude[i],
                           data_birds_transformed$end_longitude[i], data_birds_transformed$end_latitude[i]), 
                         # ncol = 2, byrow = TRUE))}), crs = 3035)
                         ncol = 2, byrow = TRUE))}), crs = crs_code)
  
  #' @description
    #' Step 3. Convert lines to an sf object
  bird_lines_sf <- st_sf(data_birds_transformed, geometry = bird_lines) %>% 
    select(Ring, Species, geometry) %>%
    st_transform(crs = crs_code) %>% # filter(Ring == "...3691990") %>%
    st_as_sf() %>% 
    mutate(trajectoryID = row_number()) %>%
    relocate(trajectoryID, .before = Ring)
  
}

# Function 2
function_distance_point_lines <- function(data){
  #' @title Calculate distance point to line.
  #' @description
  #' Calculate all distances from lines to the points of TBEV. 
  #' Distances is calculated in meters, and the recalculated to kilometers. 
  
  # extra check 
  if(class(data)[1] != "sf"){
    stop("Input data is not a shapefile")
  }
  
  # st_distance(points, lines)
  tmp_distance <- st_distance(data_tbev_coord_sf, data) %>% as_tibble()
  
  # Change format and recalculate the distance, only keeps lines that are within 500km 
  tmp_distance_trans <- t(tmp_distance)  %>% as_tibble() %>% 
    # from meters to kilometers 
    mutate(across(where(is.numeric), ~ . / 1000)) %>% 
    cbind(bird_lines_sf %>% select(trajectoryID, Ring) %>% 
            st_drop_geometry()) %>% 
    as_tibble() %>% 
    pivot_longer(!c(trajectoryID, Ring), names_to = "VID", values_to = "distance") %>% 
    group_by(VID) %>% 
    filter(distance <=500) %>% # under 500km
    ungroup %>% 
    left_join(data_tbev_coord_sf %>% 
                st_drop_geometry() %>% 
                select(VID, tbevID)) %>% 
    select(-VID)
  
  return(tmp_distance_trans)
}

# docstring(function_distance_point_lines)

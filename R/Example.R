points_df <- tibble(
  id = 1:3,
  lon = c(0, 1, 2),
  lat = c(0, 1, 2)
)

points_sf <- points_df %>%
  st_as_sf(coords = c("lon", "lat"), crs = 4326)

# Line data (bird data)
line_df <- tibble(
  id = 1,
  geometry = st_sfc(st_linestring(matrix(c(0, 0, 3, 3), ncol = 2, byrow = TRUE)))
)

# Convert line data to an sf object
line_sf <- st_as_sf(line_df, crs = 4326)

# Calculate distances between points and the line
distances <- st_distance(points_sf, line_sf)

ggplot() + 
  geom_sf(points_sf, mapping = aes(geometry = geometry)) + 
  geom_sf(line_sf, mapping = aes(geometry = geometry))

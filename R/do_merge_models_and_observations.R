# tar_load(indat_model1)
# tar_load(indat_observations)

do_merge_models_and_observations <- function(
    indat_model1 = indat_model1
    , 
    indat_model2 = indat_model1
    , 
    indat_observations = indat_observations
){
  xy <- st_as_sf(indat_observations, coords = c("Lon", "Lat"), crs = 4326)
  xy <- st_transform(xy, crs = "epsg:3577")
  outdat <- extract(indat_model1, xy)
  outdat2 <- cbind(st_drop_geometry(xy), outdat)
  return(outdat2)
}
# 
# plot(indat_i)
# plot(st_geometry(xy), add = T)

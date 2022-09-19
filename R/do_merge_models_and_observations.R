# tar_load(indat)
# tar_load(indat_glc_api)

do_merge_indat_map_glc <- function(
    indat_i = indat
    , 
    indat_glc_api_i = indat_glc_api
){
  xy <- st_as_sf(indat_glc_api_i, coords = c("Lon", "Lat"), crs = 4326)
  xy <- st_transform(xy, crs = "epsg:3577")
  #outdat <- extract(indat_i, xy)
  return(xy)
}
# 
# tar_load(dat_merge_indat_map_glc)
# plot(st_geometry(dat_merge_indat_map_glc))
# axis(2)
# axis(1)
# plot(indat, add = T)
# plot(st_geometry(dat_merge_indat_map_glc), add = T)

library(targets)
sapply(dir("R", pattern = ".R$",full.names=T), source)
if(!dir.exists("figures_and_tables")) dir.create("figures_and_tables")


 tar_visnetwork(targets_only = T)

## tar_make()

 #### prep test dat ####
 datadir <- "/hdd"
 infile = file.path(datadir,"projects/Car_FireSmoke_1_2/netCDF/CarFireSmoke_2020.nc")
 var_i = "pm25_pred"
 b <- raster::brick(infile, varname = var_i)
 b2 <- b[[which(getZ(b) >= as.Date("2020-01-01") & getZ(b) < as.Date("2020-01-02"))]]
 plot(b2)
outfile <- file.path(datadir, "projects/Car_FireSmoke_1_2/inbox_test/CarFireSmoke_20200101.nc")
outdir <- dirname(outfile) 
## dir.create(outdir)
## need sudo
b2@data@names <- "pm25_pred"
raster::writeRaster(b2, "data_derived/CarFireSmoke_20200101.nc", overwrite = T)
paste0("cp data_derived/CarFireSmoke_20200101.nc ",outfile)


tar_load(dat_mrg_models_and_obs)
dat_mrg_models_and_obs
with(dat_mrg_models_and_obs,plot(layer, PM25, xlim = c(0,200), ylim = c(0,200)))
abline(0,1)

## datadir <- "/hdd/287658c/DATADRIVE0" 
## datadir <- "/media/287658c/DATADRIVE0"
## datadir <- "C:/Users/287658C"
## infile_path = file.path(datadir, "projects/Car_FireSmoke_1_2/inbox/asdaf20010101.nc")
load_infile <- function(
    indir=dirname(infile_path)
    ,
    infile=basename(infile_path)
){
  
  #### variables ####
  r_nc <- ncdf4::nc_open(file.path(indir, infile))
  ## r_nc
  varlist <- names(r_nc[['var']])
  varlist
  var_i = "pm25_pred"
  print(var_i)
  b <- raster::brick(file.path(indir, infile), varname = var_i)
  ## plot(b)
  return(b)
}
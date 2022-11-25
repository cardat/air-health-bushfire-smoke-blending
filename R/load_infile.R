## datadir <- "/hdd" 
## datadir <- "/media/287658c/DATADRIVE0"
## datadir <- "C:/Users/287658C"
## infile_path = file.path(datadir, "projects/Car_FireSmoke_1_2/inbox/CSIRO_20200110_09.nc")

load_infile <- function(
    indir=dirname(infile_path)
    ,
    infile=basename(infile_path)
){
  
  #### variables ####
  r_nc <- ncdf4::nc_open(file.path(indir, infile))
  ## r_nc
  names(r_nc[['dim']])
  r_nc[['dim']]['time']
  datetime0 <- as.POSIXct(gsub("hours since ","",r_nc[['dim']]['time']$time[['units']]))
  # [1] "hours since 2020-01-01 00:00:00"
  datetime <- datetime0 + r_nc[['dim']]['time']$time[['vals']]
  # [1] 225
  varlist <- names(r_nc[['var']])
  varlist
  var_i = "PM25"
  print(var_i)
  b <- list(raster::brick(file.path(indir, infile), varname = var_i), datetime)
  ## plot(b[[1]]); title(b[[2]])
  return(b)
}
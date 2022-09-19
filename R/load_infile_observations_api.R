load_infile_glc_api <- function(
    infile = "~/cloudstor/Shared/PM25_and_PM10_daily_averages_2000_2020/data_derived/air_pollution_monitor_pm25_dly_20002020_20210922.rds"
    ,
    in_date_i = "2000-01-01"
    ,
    infile_xy = "~/cloudstor/Shared/PM25_and_PM10_daily_averages_2000_2020/data_derived/ap_regulatory_monitor_locations_pm25_20210922.csv"
){
  indat <- readRDS(infile)
  str(indat)
  outdat <- indat[date == as.Date(in_date_i)]
  xy <- fread(infile_xy)
  outdat2 <- merge(outdat, xy, by = c("state", "station"))
  return(outdat2)
}
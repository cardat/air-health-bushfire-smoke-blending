library(targets)
## library(tarchetypes)

sapply(list.files(pattern="[.]R$", path = "R/", full.names = T), source)

## datadir <- "/hdd/287658c/DATADRIVE0" 
## datadir <- "/media/287658c/DATADRIVE0"
datadir <- "C:/Users/287658C"

api_key <- readIniFile("api.ini", aslist = T)
pwd <- api_key[[1]]$pwd

list(
  tar_target(
    infile_path, 
    file.path(datadir, "projects/Car_FireSmoke_1_2/inbox/asdaf20010101.nc"),
    format = "file"
  ),
  tar_target(
    indat,
    load_infile(indir=dirname(infile_path),
                infile=basename(infile_path)
                )
  ),
  tar_target(
    indat_map,
    do_indat_map(indat)
    ),
  tar_target(
     indat_glc_api,
     load_infile_glc_api2(times_todo = paste0("2020-01-01T",sprintf("%02d",1:24),":00:00Z"))
     ),
  # tar_target(
  #   indat_glc_api,
  #   load_infile_glc_api(infile = "~/cloudstor/Shared/PM25_and_PM10_daily_averages_2000_2020/data_derived/air_pollution_monitor_pm25_dly_20002020_20210922.rds",
  #       in_date_i = "2000-01-01",
  #       infile_xy = "~/cloudstor/Shared/PM25_and_PM10_daily_averages_2000_2020/data_derived/ap_regulatory_monitor_locations_pm25_20210922.csv"
  #       )
  # ), 
  tar_target(dat_merge_indat_map_glc,
             do_merge_indat_map_glc(indat, indat_glc_api)
             )#,
  # tar_target(dat_rmse,
  #            do_rmse(dat_merge_indat_map_glc)
  #            ),
  # tar_target(dat_cams,
  #            load_cams()
  #            ),
  # tar_target(dat_mrg,
  #            do_merge(dat_cams,indat)
  #            )
)
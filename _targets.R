library(targets)
## library(tarchetypes)

sapply(list.files(pattern="[.]R$", path = "R/", full.names = T), source)

list(
  # /hdd/projects/Car_FireSmoke_1_2/
  tar_target(
    infile_path, 
    "inbox/asdaf20010101.nc",
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
    load_infile_glc_api(infile = "~/cloudstor/Shared/PM25_and_PM10_daily_averages_2000_2020/data_derived/air_pollution_monitor_pm25_dly_20002020_20210922.rds"
        ,
        in_date_i = "2000-01-01"
        ,
        infile_xy = "~/cloudstor/Shared/PM25_and_PM10_daily_averages_2000_2020/data_derived/ap_regulatory_monitor_locations_pm25_20210922.csv")
  ), 
  tar_target(dat_merge_indat_map_glc,
             do_merge_indat_map_glc(indat, indat_glc_api)
             )
)
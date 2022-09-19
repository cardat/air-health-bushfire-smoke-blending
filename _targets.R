library(targets)
## library(tarchetypes)

#### settings ####

sapply(list.files(pattern="[.]R$", path = "R/", full.names = T), source)

## datadir <- "/hdd/287658c/DATADRIVE0" 
## datadir <- "/media/287658c/DATADRIVE0"
datadir <- "C:/Users/287658C"

#### API Key ####
api_key <- readIniFile("api.ini", aslist = T)
pwd <- api_key[[1]]$pwd


#### start pipeline ####
list(
  #### model 1 ####
  tar_target(
    infile_path_model1, 
    file.path(datadir, "projects/Car_FireSmoke_1_2/inbox/asdaf20010101.nc"),
    format = "file"
  ),
  tar_target(
    indat_model1,
    load_infile(indir=dirname(infile_path_model1),
                infile=basename(infile_path_model1)
                )
  ),
  # tar_target(
  #   qc_model1_fig_map,
  #   do_indat_model1_fig_map(indat_model1)
  #   ),
  #### model 2 ####
  tar_target(
    infile_path_model2, 
    file.path(datadir, "projects/Car_FireSmoke_1_2/inbox/asdaf20010101.nc"),
    format = "file"
  ),
  tar_target(
    indat_model2,
    load_infile(indir=dirname(infile_path_model2),
                infile=basename(infile_path_model2)
    )
  ),
  # tar_target(
  #   qc_model2_fig_map,
  #   do_indat_model1_fig_map(indat_model2)
  # ),
  #### observations ####
  tar_target(
     indat_observations,
     load_infile_observations_api2(times_todo = paste0("2020-01-01T",sprintf("%02d",1:24),":00:00Z"))
     ),
  # tar_target(
  #   indat_observations,
  #   load_infile_observations_api(infile = "~/cloudstor/Shared/PM25_and_PM10_daily_averages_2000_2020/data_derived/air_pollution_monitor_pm25_dly_20002020_20210922.rds",
  #       in_date_i = "2000-01-01",
  #       infile_xy = "~/cloudstor/Shared/PM25_and_PM10_daily_averages_2000_2020/data_derived/ap_regulatory_monitor_locations_pm25_20210922.csv"
  #       )
  # ), 
  #### merge models and observations ####
  tar_target(dat_mrg_models_and_obs,
             do_merge_models_and_observations(indat_model1, 
                                              indat_model2,
                                              indat_observations)
             ),
  #### RMSE ####
  tar_target(dat_rmse,
             do_rmse(dat_mrg_models_and_obs)
             ),
  #### global offset ####
  tar_target(dat_global_offset,
             do_global_offset(dat_mrg_models_and_obs)
             ),
  #### residuals ####
  tar_target(dat_residuals,
             do_residuals(dat_mrg_models_and_obs, dat_global_offset)
             ),
  #### generate prior ####
  tar_target(dat_priors,
             do_dat_priors(dat_residuals, dat_rmse)
             ),
  #### covariance model for krige ####
  tar_target(covar_model,
             do_autofit_covar_model(dat_residuals)
  ),
  #### BME ####
  tar_target(dat_bme,
             do_bme(dat_priors, covar_model)
             ),
  #### combine BME with offset ####
  tar_target(outdat_bme,
             do_outdat_bne(dat_global_offset, dat_bme)
             )
  
)
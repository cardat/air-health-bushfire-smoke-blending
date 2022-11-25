## times_todo = paste0("2020-01-01T",sprintf("%02d",1:24),":00:00Z")

load_infile_observations_api2 <- function(times_todo){
dat_out <- list()
for(i in 1:length(times_todo)){
# i=1
time_todo <- times_todo[i]

# Query requesting data for a time - note required time format.
# If you do not provide the “time” parameter, it will return the latest reading
# This will retrieve the most recent reading in an 80-minute window prior to the given time
# Window greater than an hour is used because if we do *exactly* an hour, we may miss data that takes some time
# to acquire from eg. the NSW API
# Stations with no data reporting will not be returned.
res <- POST('https://maps.aqvx.app/smoketrack/get_all_monitor',body = list(time=time_todo, key = pwd),encode="json")

# Parse the data into a list
data <- content(res,as="parsed")

# Convert the list to a data frame
data <- rbindlist(data)
data$time <- time_todo
dat_out[[i]] <- data
}
dat_out2 <- rbindlist(dat_out)
dat_out3 <- dat_out2[,.(PM25 = mean(PM25, na.rm = T)),by=.(Name, Code, Lat, Lon)]
return(dat_out3)
}
# Plot a very dumb map
#p <- ggplot(data,aes(x=Lon,y=Lat,color=PM25)) + geom_point()
#p

# dat <- load_infile_glc_api2(times_todo)
# str(dat)
# dat$time
# with(dat[Name == "Florey",], plot(1:24, PM25, type="l"))

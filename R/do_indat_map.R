## tar_load(indat)
do_indat_model1_fig_map <- function(indat){
  png("figures_and_tables/indat_map.png", width = 1000, height = 700, res = 100)
  plot(indat)
  dev.off()
}
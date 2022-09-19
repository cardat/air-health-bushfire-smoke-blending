library(targets)
sapply(dir("R", pattern = ".R$",full.names=T), source)
if(!dir.exists("figures_and_tables")) dir.create("figures_and_tables")


 tar_visnetwork(targets_only = T)

## tar_make()

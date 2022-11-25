#! /bin/bash

# see https://statsandr.com/blog/an-efficient-way-to-install-and-load-r-packages/ 
#also https://uedufy.com/how-to-install-r-packages-from-command-line/ 
# check that targets is installed properly
#Rscript -e "install.packages('targets')"   #note library not writable

Rscript -e "targets::tar_make()" 

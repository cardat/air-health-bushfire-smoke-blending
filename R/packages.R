"Note to self there is these Available on Petrichor:
netcdf/4.8.0, netcdf/4.8.1
gdal/3.2.2, gdal/3.4.3
"

if(!require(data.table)) install.packages("data.table"); library(data.table)
if(!require(ncdf4)) install.packages("ncdf4"); library(ncdf4)
if(!require(terra)) install.packages("terra"); library(terra)
if(!require(raster)) install.packages("raster"); library(raster)
if(!require(sf)) install.packages("sf"); library(sf)
if(!require(httr)) install.packages("httr"); library(httr)
if(!require(jsonlite)) install.packages("jsonlite"); library(jsonlite)
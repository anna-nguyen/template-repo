#######################################################
# Project: Benjamin-Chung Lab Example Repo

# Description: Configuration file for whole project
#######################################################

#--------------------------------------------
# Load packages
#--------------------------------------------
# Used to keep track of package versions
renv::restore()

library(tidyverse)
library(dplyr)
library(boxr)
library(here)
library(washb)
library(glue)
library(ggplot2)

#--------------------------------------------
# Set up Box authentication
#--------------------------------------------
if(Sys.getenv("HOME") == "/Users/annanguyen") {
  local_box_path = "/Users/annanguyen/Box Sync/example_data"        
}

#--------------------------------------------
# Set up local file directories
#--------------------------------------------

res_dir = paste0(here::here(), "/results/")
fig_dir = paste0(here::here(), "/figures/")
tab_dir = paste0(here::here(), "/tables/")

#--------------------------------------------
# Load utility functions
#--------------------------------------------

util_functions = list.files(paste0(here::here(), "/0-base-functions/"), pattern = "*.R")
for (util in util_functions) {
  source(paste0(here::here(), "/0-base-functions/", util))
} 



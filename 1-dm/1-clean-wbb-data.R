#######################################################
# Project: Benjamin-Chung Lab Example Repo

# Description: Example data management/cleaning script
#######################################################

rm(list = ls())

# Configure directories, load libraries and base functions
source(paste0(here::here(), "/0-config.R"))

#--------------------------------------------
# Load data
#--------------------------------------------
example_data = readRDS(paste0(local_box_path, "/example_wash_data.RDS")) 

#--------------------------------------------
# Clean data
#--------------------------------------------
cleaned_data = example_data %>% 
  mutate(pooled_tr = ifelse(tr == "Control", "Control", "WASH Interventions"))

#--------------------------------------------
# Save cleaned data
#--------------------------------------------
saveRDS(cleaned_data, paste0(local_box_path, "/cleaned_example_wash_data.RDS")) 


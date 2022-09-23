#######################################################
# Project: Benjamin-Chung Lab Example Repo

# Description: Example analysis script to estimate 
# differences in prevalence by treatment arm
#######################################################

rm(list = ls())

# Configure directories, load libraries and base functions
source(paste0(here::here(), "/0-config.R"))

#--------------------------------------------
# Load data
#--------------------------------------------
cleaned_data = readRDS(paste0(local_box_path, "/cleaned_example_wash_data.RDS")) 

#--------------------------------------------
# Estimate diarrhea prevalence ratios
# by treatment arm
#-------------------------------------------- 

# Create a list of all treatment arms other than the control
tr_arms = unique(example_data$tr) 
tr_arms = tr_arms[tr_arms != "Control"]

generate_pr_by_tr = function(tr_arm) {
  # Filter data to only include control and specified treatment arm
  filtered_data = cleaned_data %>% filter(tr %in% c(tr_arm, "Control"), !is.na(diar7d))
  
  contrast = c("Control", tr_arm)
  tmle_output =  washb::washb_tmle(Y = filtered_data %>% pull(diar7d),
                                   tr = filtered_data$tr,
                                   id = filtered_data$block,
                                   pair = filtered_data$block,
                                   family = "binomial",
                                   contrast = contrast,
                                   print = F)
  
  pr_estimates = tmle_output$estimates$RR
  
  return(data.frame(tr = tr_arm, 
                    est = pr_estimates$psi, 
                    ci.lb = pr_estimates$CI[1], 
                    ci.ub = pr_estimates$CI[2]))
  
}

treatments_prs = lapply(tr_arms, generate_pr_by_tr) %>% bind_rows()

#--------------------------------------------
# Save results
#--------------------------------------------

saveRDS(treatments_prs, here::here(res_dir, "pr_estimates_by_tr.RDS"))

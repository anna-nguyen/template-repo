#######################################################
# Project: Benjamin-Chung Lab Example Repo

# Description: Create forest plots for PR estimates + CIs
#######################################################

rm(list = ls())

# Configure directories, load libraries and base functions
source(paste0(here::here(), "/0-config.R"))

#--------------------------------------------
# Load results
#--------------------------------------------
treatments_prs = readRDS(here::here(res_dir, "pr_estimates_by_tr.RDS"))

#--------------------------------------------
# Generate plot with point estimates and CIs
#--------------------------------------------
pr_plot = ggplot(treatments_prs, aes(x = tr, y = est, color = tr)) + 
  geom_point() + 
  geom_errorbar(aes(ymin = ci.lb, ymax = ci.ub)) + 
  coord_flip() + 
  theme_minimal() + 
  xlab("Treatment Arm") + 
  ylab("Prevalence Ratio (95% CI)") + 
  theme(legend.position = "none") + 
  ggtitle("Prevalence Ratio by Treatment Arm")

# Save plot
ggsave(here::here(fig_dir, "plt_pr_by_treatment.png"), pr_plot, 
       width = 5, height = 4)

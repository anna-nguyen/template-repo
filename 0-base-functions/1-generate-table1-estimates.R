#######################################################
# Project: Benjamin-Chung Lab Example Repo

# Description: Function to generate table 1 estimates
# with means that account for clustering
#######################################################

calculate_table1_estimates = function(data, var_name, keep_se = F) { 
  # Function to produce table 1 estimates for continuous variables
  #' @param data a data frame containing data from the 
  #' @param var_name a string, corresponding to the column name
  #' @param keep_se a boolean, TRUE if returning standard error and FALSE is returning estimates and CIs as a string
  #' @return a data frame containing estimates of means and 95% CIs for the variable

  estimates = data.frame(washb_mean(data[[var_name]], id = data$clusterid, print = F))
  
  if (keep_se) {
    estimates = estimates %>% select(Mean, Robust.SE) 
  } else {
    estimates = estimates %>% 
      modify_if(is.numeric, ~round(. , 1)) %>% 
      mutate(est = glue("{Mean} ({Lower.95.CI} - {Upper.95.CI})")) %>% 
      select(est)
    colnames(estimates) = c(var_name)
  }
  return (estimates)
}
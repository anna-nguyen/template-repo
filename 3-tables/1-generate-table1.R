#######################################################
# Project: Benjamin-Chung Lab Example Repo

# Description: Example analysis script to produce
# a descriptive table
#######################################################

rm(list = ls())

# Configure directories, load libraries and base functions
source(paste0(here::here(), "/0-config.R"))

#--------------------------------------------
# Load data
#--------------------------------------------
example_data = readRDS(paste0(local_box_path, "/example_wash_data.RDS")) %>% 
  filter(!is.na(diar7d))

#--------------------------------------------
# Generate tables
#--------------------------------------------

# Number of measurements
n = example_data %>% 
  group_by(tr) %>% 
  summarize(n_measurements = n()) %>% 
  select(-tr) %>% 
  t() %>% 
  as.data.frame() %>% 
  modify_if(is.numeric, as.character)

# Diarrhea prevalence by arm
prev_any_diarr = example_data %>% 
  group_by(tr) %>%
  summarize(n_ever_diar = sum(diar7d), 
            prev_ever_diar = mean(diar7d)*100) %>% 
  modify_if(is.numeric, ~as.character(round(. , 2))) %>% 
  mutate(ever_diar = glue("{n_ever_diar} ({prev_ever_diar}%)")) %>% 
  select(ever_diar) %>% 
  t() %>% 
  as.data.frame()

# Child age
child_demog = example_data %>% 
  group_by(tr) %>% 
  summarize(mean_age = calculate_table1_estimates(cur_data(), "ageyrs")) %>% 
  select(-tr) %>% 
  t() %>% 
  as.data.frame()

# Household wealth quartile
hh_wealth = example_data %>% 
  group_by(tr) %>% 
  summarize(n_HHwealth_quart1 = sum(HHwealth_quart == "Wealth Q1"),
            prop_HHwealth_quart1 = round(n_HHwealth_quart1 / n() * 100, 2),
            HHwealth_quart1 = glue("{n_HHwealth_quart1} ({prop_HHwealth_quart1}%)"),
            
            n_HHwealth_quart2 = sum(HHwealth_quart == "Wealth Q2"),
            prop_HHwealth_quart2 = round(n_HHwealth_quart2 / n() * 100, 2),
            HHwealth_quart2 = glue("{n_HHwealth_quart2} ({prop_HHwealth_quart2}%)"),
            
            n_HHwealth_quart3 = sum(HHwealth_quart == "Wealth Q3"),
            prop_HHwealth_quart3 = round(n_HHwealth_quart3 / n() * 100, 2),
            HHwealth_quart3 = glue("{n_HHwealth_quart3} ({prop_HHwealth_quart3}%)"),
            
            n_HHwealth_quart4 = sum(HHwealth_quart == "Wealth Q4"),
            prop_HHwealth_quart4 = round(n_HHwealth_quart4 / n() * 100, 2),
            HHwealth_quart4 = glue("{n_HHwealth_quart4} ({prop_HHwealth_quart4}%)")) %>% 
  select(HHwealth_quart1, HHwealth_quart2, HHwealth_quart3, HHwealth_quart4) %>% 
  t() %>% 
  as.data.frame()
  
#--------------------------------------------
# Build table 1
#--------------------------------------------

# Combine individual tables
table1 = bind_rows(
  n, 
  prev_any_diarr, 
  child_demog,
  hh_wealth
) 

colnames(table1) = sort(unique(example_data$tr))
table1$Variable = rownames(table1)
rownames(table1) = NULL

# Rename labels
table1 = table1 %>% 
  mutate(Variable = case_when(Variable == "n_measurements" ~ "Observations",
                              Variable == "ever_diar" ~ "Diarrhea during study period",
                              Variable == "mean_age" ~ "Age (years)",
                              Variable == "HHwealth_quart1" ~ "Household Wealth Quartile 1",
                              Variable == "HHwealth_quart2" ~ "Household Wealth Quartile 2",
                              Variable == "HHwealth_quart3" ~ "Household Wealth Quartile 3",
                              Variable == "HHwealth_quart4" ~ "Household Wealth Quartile 4",
                              T ~ Variable)) %>% 
  select(Variable, everything())

# Saves Table 1
write.csv(table1, here::here(tab_dir, "Table1.csv"))



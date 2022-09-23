#!/bin/bash

#SBATCH --job-name=run-example-repo
#SBATCH --begin=now
#SBATCH --dependency=singleton
#SBATCH --mail-type=ALL
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --mem=64G
#SBATCH --output=00-example-repo.out
#SBATCH --time=2-00:00:00

module purge 

module load R/4.0.2

cd $HOME/example-repo/
  
R CMD BATCH --no-save 1-dm/1-clean-wbb-data.R 1-dm/1-clean-wbb-data.out 
R CMD BATCH --no-save 2-analysis/1-estimate-pr-by-arm.R 2-analysis/1-estimate-pr-by-arm.out
R CMD BATCH --no-save 3-tables/1-generate-table1.R 3-tables/1-generate-table1.out 
R CMD BATCH --no-save 4-figures/1-pr-plots.R 4-figures/1-pr-plots.out
